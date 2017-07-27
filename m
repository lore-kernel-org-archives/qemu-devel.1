Received: from eggs.gnu.org ([2001:4830:134:3::10]:46725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1daquK-0004Wk-7Q
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1daquH-0005ds-Jp
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:05:24 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1daquH-0005bS-DN
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:05:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id y206so2271731wmd.5
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 15:05:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-5-f4bug@amsat.org>
	<87d18pudy9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a21e44f-b313-8214-0c04-0b161b68236f@redhat.com>
Date: Fri, 28 Jul 2017 00:05:15 +0200
MIME-Version: 1.0
In-Reply-To: <87d18pudy9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 04/35] ivshmem: fix incorrect
 error handling in ivshmem_recv_msg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 25/07/2017 10:18, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> If qemu_chr_fe_read_all() returns -EINTR the do {} statement continues and the
>> n accumulator used to complete reads upto sizeof(msg) is decremented by 4 (the
>> value of EINTR on Linux).
>> To avoid that, use simpler if() statements and continue if EINTR occured.
>>
>> hw/misc/ivshmem.c:650:14: warning: Loss of sign in implicit conversion
>>     } while (n < sizeof(msg));
>>              ^
>>
> 
> Let's add "Screwed up in commit 3a55fc0f, v2.6.0."
> 
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> get_maintainer.pl: No maintainers found!
>>
>>  hw/misc/ivshmem.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
>> index a58f9ee579..47a015f072 100644
>> --- a/hw/misc/ivshmem.c
>> +++ b/hw/misc/ivshmem.c
>> @@ -642,7 +642,10 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int *pfd, Error **errp)
>>      do {
>>          ret = qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n,
>>                                     sizeof(msg) - n);
>> -        if (ret < 0 && ret != -EINTR) {
>> +        if (ret < 0) {
>> +            if (ret == -EINTR) {
>> +                continue;
>> +            }
>>              error_setg_errno(errp, -ret, "read from server failed");
>>              return INT64_MIN;
>>          }
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Paolo, you taking this through your miscellaneous queue would save me
> (and possibly Peter) a bit of work.  Only if you have something queued
> already.  Let me know.

Fair enough, I'll pick this up.

Paolo
