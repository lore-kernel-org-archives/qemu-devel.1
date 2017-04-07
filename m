Received: from eggs.gnu.org ([2001:4830:134:3::10]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbTg-0000S4-RI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbTd-00068O-MQ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:31:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-4-f4bug@amsat.org>
	<149021773050.3910.449421368071627004@loki>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3bdae1a-2a7d-57d2-bf3c-80b05130e530@amsat.org>
Date: Fri, 7 Apr 2017 18:31:24 -0300
MIME-Version: 1.0
In-Reply-To: <149021773050.3910.449421368071627004@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RESEND 3/3] qga: fix compiler warnings
 (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Hi Michael,

On 03/22/2017 06:22 PM, Michael Roth wrote:
> Quoting Philippe Mathieu-Daudé (2017-03-22 15:48:44)
>> static code analyzer complain:
>>
>> qga/commands-posix.c:2127:9: warning: Null pointer passed as an argument to a 'nonnull' parameter
>>         closedir(dp);
>>         ^~~~~~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qga/commands-posix.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 73d93eb5ce..8028141534 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -2122,9 +2122,11 @@ static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
>>           * we think this VM does not support online/offline memory block,
>>           * any other solution?
>>           */
>> -        if (!dp && errno == ENOENT) {
>> -            result->response =
>> -                GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
>> +        if (!dp) {
>> +            if (errno == ENOENT) {
>> +                result->response =
>> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
>> +            }
>>              goto out1;
>>          }
>
> I think this should be:
>
>     if (!dp) {
>         if (errno == ENOENT) {
>             result->response =
>                 GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
>         } else {
>             result->response =
>                 GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>         }
>         goto out1;
>     }
>
> otherwise we might set result->error_code while still indicating
> success for the operation. That wasn't handled properly before your
> patch either, it's just more apparent now.

Indeed, I'll resend it in 2 patches It seems easier to me to understand.

>
>>          closedir(dp);
>> --
>> 2.11.0
>>
>
>
