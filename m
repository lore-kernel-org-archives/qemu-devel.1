Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9pyi-000552-F7
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9pyf-0005pX-8N
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:10:32 -0400
Received: from smtp.citrix.com ([66.165.176.89]:30730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9pyf-0005nU-1o
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:10:29 -0400
References: <20171031160902.6874-1-ross.lagerwall@citrix.com>
	<20171101100451.GC9289@redhat.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <15f69db6-2671-9031-1bd6-a6a0f1f2dd50@citrix.com>
Date: Wed, 1 Nov 2017 10:10:24 +0000
MIME-Version: 1.0
In-Reply-To: <20171101100451.GC9289@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] io: Fix QIOChannelFile when creating and
 opening read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On 11/01/2017 10:04 AM, Daniel P. Berrange wrote:
> On Tue, Oct 31, 2017 at 04:09:02PM +0000, Ross Lagerwall wrote:
>> The code wrongly passes the mode to open() only if O_WRONLY is set.
>> Instead, the mode should be passed when O_CREAT is set (or O_TMPFILE on
>> Linux). Fix this by always passing the mode since open() will correctly
>> ignore the mode if it is not needed. Add a testcase which exercises this
>> bug.
>>
>> While at it, add /dev/fdset/ support to QIOChannelFile by calling
>> qemu_open() instead open(). There is a subtle semantic change since
>> qemu_open() automatically sets O_CLOEXEC, but this doesn't affect any of
>> the users of the function.
> 
> Can you split the use of qemu_open() into a separate patch - its bad pratice
> to mix two different functional changes in one patch. Also as Marc-Andre
> mentions, we would need qemu_close() here too I think.

OK, sure, I will split into two patches and call qemu_close().

> 
>>
>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>> ---
>>   include/io/channel-file.h    |  2 +-
>>   io/channel-file.c            |  6 +-----
>>   tests/test-io-channel-file.c | 27 +++++++++++++++++++++++++++
>>   3 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/io/channel-file.h b/include/io/channel-file.h
>> index 79245f1..ebfe54e 100644
>> --- a/include/io/channel-file.h
>> +++ b/include/io/channel-file.h
>> @@ -73,7 +73,7 @@ qio_channel_file_new_fd(int fd);
>>    * qio_channel_file_new_path:
>>    * @path: the file path
>>    * @flags: the open flags (O_RDONLY|O_WRONLY|O_RDWR, etc)
>> - * @mode: the file creation mode if O_WRONLY is set in @flags
>> + * @mode: the file creation mode if O_CREAT is set in @flags
>>    * @errp: pointer to initialized error object
>>    *
>>    * Create a new IO channel object for a file represented
>> diff --git a/io/channel-file.c b/io/channel-file.c
>> index b383273..ae8fb62 100644
>> --- a/io/channel-file.c
>> +++ b/io/channel-file.c
>> @@ -50,11 +50,7 @@ qio_channel_file_new_path(const char *path,
>>   
>>       ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
>>   
>> -    if (flags & O_WRONLY) {
>> -        ioc->fd = open(path, flags, mode);
>> -    } else {
>> -        ioc->fd = open(path, flags);
>> -    }
>> +    ioc->fd = qemu_open(path, flags, mode);
>>       if (ioc->fd < 0) {
>>           object_unref(OBJECT(ioc));
>>           error_setg_errno(errp, errno,
>> diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
>> index 6bfede6..0c7303d 100644
>> --- a/tests/test-io-channel-file.c
>> +++ b/tests/test-io-channel-file.c
>> @@ -50,6 +50,32 @@ static void test_io_channel_file(void)
>>       object_unref(OBJECT(dst));
>>   }
>>   
>> +static void test_io_channel_file_rdwr(void)
>> +{
>> +    QIOChannel *src, *dst;
>> +    QIOChannelTest *test;
>> +
>> +#define TEST_FILE "tests/test-io-channel-file.txt"
>> +    unlink(TEST_FILE);
>> +    src = QIO_CHANNEL(qio_channel_file_new_path(
>> +                          TEST_FILE,
>> +                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY, 0600,
>> +                          &error_abort));
>> +    dst = QIO_CHANNEL(qio_channel_file_new_path(
>> +                          TEST_FILE,
>> +                          O_RDONLY | O_BINARY, 0,
>> +                          &error_abort));
>> +
>> +    test = qio_channel_test_new();
>> +    qio_channel_test_run_writer(test, src);
>> +    qio_channel_test_run_reader(test, dst);
>> +    qio_channel_test_validate(test);
> 
> Since we're specifically fixing a problem with mode, it would be good to
> check the mode of the created file to show that its applied - ideally the
> test would fail with previous code in this way.

At least with glibc, the test does fail with the previous code because 
it aborts if O_CREAT is present in flags without the mode. But I can add 
a check anyway.

Regards,
-- 
Ross Lagerwall
