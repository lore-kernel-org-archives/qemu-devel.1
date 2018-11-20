Received: from eggs.gnu.org ([2001:4830:134:3::10]:55892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gOzyy-0007JA-2y
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gOzyu-0004ve-Rq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:58:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gOzyu-0004u8-Ij
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:57:56 -0500
Received: by mail-wm1-x344.google.com with SMTP id c126so1010699wmh.0
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 22:57:56 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<ccb312eb986d846b1b0aa0be062833e5ae1bb5f4.1542321076.git.alistair.francis@wdc.com>
	<687076b9-a5ca-2821-3e24-8b08363f1b5c@linaro.org>
	<CAKmqyKPsnX+RR1A6BTdXZ4-WFix5o9OKpXLyffe8Y_erZ=kYDA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a014bf77-e797-fe7a-cff6-7f7a4d3d0f18@linaro.org>
Date: Tue, 20 Nov 2018 07:57:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPsnX+RR1A6BTdXZ4-WFix5o9OKpXLyffe8Y_erZ=kYDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 17/23] riscv: tcg-target: Add direct load
 and store instructions
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

On 11/20/18 12:06 AM, Alistair Francis wrote:
> On Fri, Nov 16, 2018 at 9:10 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/15/18 11:36 PM, Alistair Francis wrote:
>>> +    tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
>>
>> Should avoid this when guest_base == 0, which happens fairly regularly for a
>> 64-bit guest.
>>
>>> +        /* Prefer to load from offset 0 first, but allow for overlap.  */
>>> +        if (TCG_TARGET_REG_BITS == 64) {
>>> +            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
>>> +        } else {
>>> +            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
>>> +            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
>>> +        }
>>
>> Comment sounds like two lines of code that's missing.
> 
> I can't figure out what this comment should be for. Why would we want
> to prefer loading with an offset 0?

Perhaps to help the memory controler; perhaps no reason at all.
But "allow for overlap" suggests

  } else if (lo != base) {
      tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
      tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
  } else {
      tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
      tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
  }


r~
