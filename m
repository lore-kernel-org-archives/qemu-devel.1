Received: from eggs.gnu.org ([2001:4830:134:3::10]:51260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSCuT-0006WH-7Z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSCgx-0002ag-U8
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:08:43 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSCgx-0002Zq-HA
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:08:39 -0500
Received: by mail-pf1-x431.google.com with SMTP id q1so282208pfi.5
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 19:08:39 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<aa41323b013a6c77e28d487d49026df36d60e4c5.1543352682.git.alistair.francis@wdc.com>
	<ea1df40c-ce6c-16a0-4256-298f32748c6c@linaro.org>
	<CAKmqyKMDJuX=eqbfG2ZLjmVJySf9SGGK2bdhmV6jS_jODGUkTA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2f6eb76f-ce2a-fc32-4270-957734c132ac@linaro.org>
Date: Wed, 28 Nov 2018 19:08:35 -0800
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMDJuX=eqbfG2ZLjmVJySf9SGGK2bdhmV6jS_jODGUkTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 14/24] riscv: tcg-target: Add branch and
 jump instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On 11/28/18 5:06 PM, Alistair Francis wrote:
> On Wed, Nov 28, 2018 at 12:15 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/27/18 1:08 PM, Alistair Francis wrote:
>>> +static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
>>> +{
>>> +    ptrdiff_t offset = tcg_pcrel_diff(s, target);
>>> +
>>> +    if (offset == sextract64(offset, 0, 26)) {
>>> +        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
>>> +    } else {
>>> +        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
>>> +        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_TMP0, 0);
>>> +    }
>>> +}
>>> +
>>> +static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
>>> +{
>>> +    TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
>>> +    ptrdiff_t offset = tcg_pcrel_diff(s, arg);
>>> +    if (offset == sextract64(offset, 1, 20) << 1) {
>>
>> s/20/26/
>>
>> Seems like there ought to be more shared code between tcg_out_call_int and
>> tcg_out_goto_long, really.
> 
> I think tcg_out_goto_long can just be removed and replaced with
> tcg_out_call() right?

Yes, tcg_out_goto_long(s, dest) = tcg_out_call_int(s, dest, true).


r~
