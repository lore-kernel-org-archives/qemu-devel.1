Received: from eggs.gnu.org ([2001:4830:134:3::10]:40541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUwTZ-00015x-DS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUwTU-00035i-KU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:26:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUwTU-00031t-Dy
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:26:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so932497otk.8
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 08:26:04 -0800 (PST)
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-9-richard.henderson@linaro.org>
	<CAFEAcA__1C-GkRk65E+JL9Ovte7GhZhGKmP3Zcv_w=wZSqV7=A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2bed35b9-1143-de1a-4d4a-eb5ac23a7ef1@linaro.org>
Date: Thu, 6 Dec 2018 10:25:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__1C-GkRk65E+JL9Ovte7GhZhGKmP3Zcv_w=wZSqV7=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/10] target/arm: Implement the
 ARMv8.1-LOR extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/6/18 7:49 AM, Peter Maydell wrote:
>> +        uint64_t hcr = arm_hcr_el2_eff(env);
>> +        if (hcr & HCR_E2H) {
>> +            hcr &= HCR_TLOR;
>> +        } else {
>> +            hcr &= HCR_TGE | HCR_TLOR;
> This doesn't make sense to me

The logic is backward.  What I was after was

  if (hcr & HCR_E2H) {
      hcr &= HCR_TGE | HCR_TLOR;
  } else {
      hcr &= HCR_TLOR;
  }
  if (hcr == HCR_TLOR) {
      trap to el2.
  }

I.e. swap the then and else condition.  This takes care of the two rules

 -- If (SCR_EL3.NS == 1 || SCR_EL3.EEL2 == 1) && IsUsingAArch64(EL2)
    && HCR_EL2.E2H == 0 && HCR_EL2.TLOR == 1, then
    accesses at EL1 are trapped to EL2.
 -- If (SCR_EL3.NS == 1 || SCR_EL3.EEL2 == 1) && IsUsingAArch64(EL2)
    && HCR_EL2.E2H == 1 && HCR_EL2.TGE == 0 && HCR_EL2.TLOR == 1,
    then accesses at EL1 are trapped to EL2.


r~
