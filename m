Received: from eggs.gnu.org ([2001:4830:134:3::10]:54589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1yTy-0004Dk-Uu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1yTu-0003Bi-LQ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:38:18 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:43480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1yTu-0003BQ-DM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:38:14 -0400
Received: by mail-pf0-x230.google.com with SMTP id d2so14770933pfh.0
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:38:14 -0700 (PDT)
References: <20171010151811.19935-1-pbonzini@redhat.com>
	<CAFEAcA_=qfeuk-J-oGruTXcKiWriKo9A8a+FOn1pcbnb6kCdrg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2d9bf254-b411-2a95-6c14-13ae6826c932@linaro.org>
Date: Tue, 10 Oct 2017 10:38:10 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=qfeuk-J-oGruTXcKiWriKo9A8a+FOn1pcbnb6kCdrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nios2: define tcg_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marek Vasut <marex@denx.de>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 10/10/2017 09:49 AM, Peter Maydell wrote:
> On 10 October 2017 at 16:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> This should be done by all target and, since commit 53f6672bcf
>> ("gen-icount: use tcg_ctx.tcg_env instead of cpu_env", 2017-06-30),
>> is causing the NIOS2 target to hang.
>>
>> This is because the test for "should I exit to the main loop"
>> was being done with the correct offset to the icount decrementer,
>> but using TCG temporary 0 (the frame pointer) rather than the
>> env pointer.
>>
>> Cc: qemu-stable@nongnu.org
>> Cc: Marek Vasut <marex@denx.de>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  target/nios2/translate.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
>> index 6b0961837d..54fbe898df 100644
>> --- a/target/nios2/translate.c
>> +++ b/target/nios2/translate.c
>> @@ -948,6 +948,7 @@ void nios2_tcg_init(void)
>>      int i;
>>
>>      cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
>> +    tcg_ctx.tcg_env = cpu_env;
>>
>>      for (i = 0; i < NUM_CORE_REGS; i++) {
>>          cpu_R[i] = tcg_global_mem_new(cpu_env,
>> --
> 
> Is there somewhere we could put an assert() so we can catch this
> error for future targets rather than them just silently generating
> bad code?

Yes, I can arrange for this.

That said, probably the best change we could make is to eliminate cpu_env
entirely, and create tcg_ctx.tcg_env generically (possibly renaming this to a
standalone global variable called cpu_env, minimizing the changes within
target/*).  It is, after all, the same for every target, and there is no longer
any other TCG_AREG* value that can be used.


r~
