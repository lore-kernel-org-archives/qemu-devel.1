Received: from eggs.gnu.org ([2001:4830:134:3::10]:47907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4Pdp-0007We-La
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d4Pdk-0005Qo-Ot
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:30:17 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d4Pdk-0005Qc-Gv
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:30:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id g12so9362583wrg.2
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 03:30:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
	<1493407045-24172-2-git-send-email-cota@braap.org>
	<20170428192238.GA24988@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <33f75663-0254-0274-d451-7f081bc1acf5@twiddle.net>
Date: Sat, 29 Apr 2017 12:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170428192238.GA24988@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 + 1/2] target/aarch64: optimize
 cross-page direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 04/28/2017 09:22 PM, Emilio G. Cota wrote:
> On Fri, Apr 28, 2017 at 15:17:24 -0400, Emilio G. Cota wrote:
>> Perf numbers in next commit's log.
>>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> ---
>>   target/arm/translate-a64.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 24de30d..5b691fc 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -373,8 +373,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
>>           } else if (s->singlestep_enabled) {
>>               gen_exception_internal(EXCP_DEBUG);
>>           } else {
>> -            tcg_gen_exit_tb(0);
>> -            s->is_jmp = DISAS_TB_JUMP;
> 
> I'm not sure about removing this line though. Would it be better to leave it?
> I can't see how TB_JUMP ends up doing anything in the rest of the file.

Why not just replace this with

   s->is_jmp = DISAS_JUMP

and not emit the lookup_and_goto_ptr here at all?


r~
