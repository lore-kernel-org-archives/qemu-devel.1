Received: from eggs.gnu.org ([2001:4830:134:3::10]:45154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqj3K-0005Dg-Pq
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqj3J-0003hn-Mu
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:24:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
	<20170322135846.GB15423@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <62cb8cc9-c982-8dab-e5e2-3bb7a660fe59@amsat.org>
Date: Wed, 22 Mar 2017 13:23:51 -0300
MIME-Version: 1.0
In-Reply-To: <20170322135846.GB15423@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9?] block/file-posix.c:
 Fix unused variable warning on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, patches@linaro.org

On 03/22/2017 10:58 AM, Jeff Cody wrote:
> On Mon, Mar 20, 2017 at 06:33:04PM +0000, Peter Maydell wrote:
>> On OpenBSD none of the ioctls probe_logical_blocksize() tries
>> exist, so the variable sector_size is unused. Refactor the
>> code to avoid this (and reduce the duplicated code).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> The alternative would be to move the variable so it was
>> local to a code block inside each #ifdef, but this seemed
>> a bit nicer anyway.
>>
>> Tentatively tagged 'for-2.9' just because this is the only
>> warning in the OpenBSD build, but I don't insist on it.
>>
>> I've opted to retain the existing behaviour of "try every
>> ioctl available and use the last one that works" rather
>> than "stop as soon as something worked".
>>
>> ---
>>  block/file-posix.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 53febd3..b980d23 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -219,28 +219,28 @@ static int probe_logical_blocksize(int fd, unsigned int *sector_size_p)
>>  {
>>      unsigned int sector_size;
>>      bool success = false;
>> +    int i;
>>
>>      errno = ENOTSUP;
>> -
>> -    /* Try a few ioctls to get the right size */
>> +    unsigned long ioctl_list[] = {

this can be `const` but not a bit win.

>>  #ifdef BLKSSZGET
>> -    if (ioctl(fd, BLKSSZGET, &sector_size) >= 0) {
>> -        *sector_size_p = sector_size;
>> -        success = true;
>> -    }
>> +        BLKSSZGET,
>>  #endif
>>  #ifdef DKIOCGETBLOCKSIZE
>> -    if (ioctl(fd, DKIOCGETBLOCKSIZE, &sector_size) >= 0) {
>> -        *sector_size_p = sector_size;
>> -        success = true;
>> -    }
>> +        DKIOCGETBLOCKSIZE,
>>  #endif
>>  #ifdef DIOCGSECTORSIZE
>> -    if (ioctl(fd, DIOCGSECTORSIZE, &sector_size) >= 0) {
>> -        *sector_size_p = sector_size;
>> -        success = true;
>> -    }
>> +        DIOCGSECTORSIZE,
>>  #endif
>> +    };
>> +
>> +    /* Try a few ioctls to get the right size */
>> +    for (i = 0; i < ARRAY_SIZE(ioctl_list); i++) {
>> +        if (ioctl(fd, ioctl_list[i], &sector_size) >= 0) {
>> +            *sector_size_p = sector_size;
>> +            success = true;
>> +        }
>> +    }
>>
>>      return success ? 0 : -errno;
>>  }
>> --
>> 2.7.4
>>
>>
>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
