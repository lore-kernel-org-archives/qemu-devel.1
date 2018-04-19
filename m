Received: from eggs.gnu.org ([2001:4830:134:3::10]:53870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhenwei.pi@youruncloud.com>) id 1f8xye-0006G3-5S
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 21:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhenwei.pi@youruncloud.com>) id 1f8xya-0006Ob-8x
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 21:03:08 -0400
Received: from mail139-27.mail.alibaba.com ([198.11.139.27]:55928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhenwei.pi@youruncloud.com>)
	id 1f8xyZ-0006Mv-Rc
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 21:03:04 -0400
References: <1523864788-15800-1-git-send-email-zhenwei.pi@youruncloud.com>
	<0e4da059-da4c-64ff-65f0-068fdd68fdcd@redhat.com>
From: "Zhenwei.Pi" <zhenwei.pi@youruncloud.com>
Message-ID: <77d9f683-72c6-8c68-bdd9-463aa5eb8f0e@youruncloud.com>
Date: Thu, 19 Apr 2018 09:00:37 +0800
MIME-Version: 1.0
In-Reply-To: <0e4da059-da4c-64ff-65f0-068fdd68fdcd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qemu-progress: redirct qemu progress
 message to another file stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: pbonzini@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org

On 04/18/2018 09:06 PM, Max Reitz wrote:

> On 2018-04-16 09:46, zhenwei pi wrote:
>> currently qemu progress message only print into stdout, and other thread may
>> print some log into stdout at the same time.
>> add a new api qemu_progress_set_output to redirect progress message to
>> another file stream.
>>
>> Signed-off-by: zhenwei pi <zhenwei.pi@youruncloud.com>
>> ---
>>   include/qemu-common.h |  1 +
>>   util/qemu-progress.c  | 22 +++++++++++++++++++---
>>   2 files changed, 20 insertions(+), 3 deletions(-)
> Well, but after this patch, qemu will still only print progress to
> stdout because qemu_progress_set_output() isn't used anywhere...
>
this patch only provides the basic redirection function. if this patch
is approved, another patch (Ex, qemu convert progress in qemu-img.c)
will be send.

>> diff --git a/include/qemu-common.h b/include/qemu-common.h
>> index 8a4f63c..511e7e0 100644
>> --- a/include/qemu-common.h
>> +++ b/include/qemu-common.h
>> @@ -128,6 +128,7 @@ ssize_t qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send);
>>   void qemu_progress_init(int enabled, float min_skip);
>>   void qemu_progress_end(void);
>>   void qemu_progress_print(float delta, int max);
>> +int qemu_progress_set_output(FILE *output);
>>   const char *qemu_get_vm_name(void);
>>   
>>   #define QEMU_FILE_TYPE_BIOS   0
>> diff --git a/util/qemu-progress.c b/util/qemu-progress.c
>> index 3c2223c..dd7aa52 100644
>> --- a/util/qemu-progress.c
>> +++ b/util/qemu-progress.c
>> @@ -31,6 +31,7 @@ struct progress_state {
>>       float min_skip;
>>       void (*print)(void);
>>       void (*end)(void);
>> +    FILE *output;
>>   };
>>   
>>   static struct progress_state state;
>> @@ -43,17 +44,18 @@ static volatile sig_atomic_t print_pending;
>>    */
>>   static void progress_simple_print(void)
>>   {
>> -    printf("    (%3.2f/100%%)\r", state.current);
>> -    fflush(stdout);
>> +    fprintf(state.output, "    (%3.2f/100%%)\r", state.current);
>> +    fflush(state.output);
> Also, I'm not sure we should use \r when printing to anything but stdout.
>
> Max

qemu redirects progress message into a file, other process reads the file
and uses '\r' to split the string, and we can get the progress exactly.

>>   }
>>   
>>   static void progress_simple_end(void)
>>   {
>> -    printf("\n");
>> +    fprintf(state.output, "\n");
>>   }
>>   
>>   static void progress_simple_init(void)
>>   {
>> +    state.output = stdout;
>>       state.print = progress_simple_print;
>>       state.end = progress_simple_end;
>>   }
>> @@ -129,6 +131,20 @@ void qemu_progress_end(void)
>>   }
>>   
>>   /*
>> + * Redirect progress into another file stream.
>> + * @output is the new file stream.
>> + */
>> +int qemu_progress_set_output(FILE *output)
>> +{
>> +    if (!output) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    state.output = output;
>> +    return 0;
>> +}
>> +
>> +/*
>>    * Report progress.
>>    * @delta is how much progress we made.
>>    * If @max is zero, @delta is an absolut value of the total job done.
>>
>
