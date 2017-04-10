Received: from eggs.gnu.org ([2001:4830:134:3::10]:43253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxZmg-0006fX-Ol
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxZmf-0000sv-UA
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:55:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxZmf-0000s5-Nc
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:55:09 -0400
Received: by mail-wr0-x22d.google.com with SMTP id z109so9459115wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 06:55:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <809ae021-06ce-00d4-73ec-6fe3e6142c45@amsat.org>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-7-git-send-email-peter.maydell@linaro.org>
	<809ae021-06ce-00d4-73ec-6fe3e6142c45@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 14:54:47 +0100
Message-ID: <CAFEAcA-FmzsnNUNa_yPvQ+y_LnTXzd7RRsPdhaLbyrutsPstFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/7] arm: Implement M profile
 exception return properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 10 April 2017 at 14:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 04/10/2017 07:39 AM, Peter Maydell wrote:

>> +    /* Is the new PC value in the magic range indicating exception
>> return? */
>> +    tcg_gen_brcondi_i32(TCG_COND_GEU, cpu_R[15], 0xff000000,
>> excret_label);
>
>
> Idea for a GSoC: branch prediction hints!
>
> tcg_gen_brcondi_i32(TCG_COND_GEU | TCG_COND_UNLIKELY, ...

Isn't the advice for modern CPUs to just trust the branch
predictor?

>> @@ -11092,9 +11137,10 @@ static void disas_thumb_insn(CPUARMState *env,
>> DisasContext *s)
>>                      tmp2 =3D tcg_temp_new_i32();
>>                      tcg_gen_movi_i32(tmp2, val);
>>                      store_reg(s, 14, tmp2);
>> +                    gen_bx(s, tmp);
>> +                } else {
>> +                    gen_bx_excret(s, tmp);
>
>
> This change was not easy to understand, can you add a one line comment?

Sure, but what did you have in mind? Maybe
    /* Only bx can be an exception-return, not blx */
?

>>                  }
>> -                /* already thumb, no need to check */
>> -                gen_bx(s, tmp);
>>                  break;
>>              }
>>              break;
>> @@ -11989,7 +12035,14 @@ void gen_intermediate_code(CPUARMState *env,
>> TranslationBlock *tb)
>>         instruction was a conditional branch or trap, and the PC has
>>         already been written.  */
>>      gen_set_condexec(dc);
>> -    if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
>> +    if (dc->is_jmp =3D=3D DISAS_BX_EXCRET) {
>> +        /* Exception return branches need some special case code at the
>> +         * end of the TB, which is complex enough that it has to
>> +         * handle the single-step vs not and the condition-failed
>> +         * insn codepath itself.
>> +         */
>> +        gen_bx_excret_final_code(dc);
>> +    } else if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
>>          /* Unconditional and "condition passed" instruction codepath. *=
/
>>          switch (dc->is_jmp) {
>>          case DISAS_SWI:
>>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

thanks
-- PMM
