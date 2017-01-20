Received: from eggs.gnu.org ([2001:4830:134:3::10]:59269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUXf5-0001wo-BI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUXf4-0003p6-5D
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:47:19 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:34449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUXf3-0003oc-Tc
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:47:18 -0500
Received: by mail-vk0-x230.google.com with SMTP id r136so49820853vke.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 03:47:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170120113606.GB21081@in.ibm.com>
References: <1484903866-17940-1-git-send-email-bharata@linux.vnet.ibm.com>
	<CAFEAcA97fSC6DoaF41ifh-L5S1XYfJmG+3a_Njw3UJ=sULk6ig@mail.gmail.com>
	<20170120113606.GB21081@in.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 11:46:56 +0000
Message-ID: <CAFEAcA88GQG8qcC88wEAuTNUvydeyymeX4qi5HJrZ59XB4VMsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v1] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 20 January 2017 at 11:36, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> On Fri, Jan 20, 2017 at 10:28:22AM +0000, Peter Maydell wrote:
>> This isn't sufficient, because it won't do the right thing
>> in the code which is picking between "round to infinity" and
>> "round to largest/smallest representable number". That's
>> phrased differently from the Float128 code but it's still
>> there:
>>
>>             return packFloat64( zSign, 0x7FF, - ( roundIncrement == 0 ));
>>
>> will generate a result with an all-zeros mantissa for
>> roundIncrement == 0 (ie go to infinity) and an all-ones
>> mantissa otherwise (ie go to largest-representable).
>> That works for the existing cases but it doesn't work
>> for round_to_odd.
>
> Based on my understanding of your and Richard's clarification, we
> shouldn't overflow to infinity in round-to-odd mode. Like I did for 128 bit
> case where we return the max possible value in the similar situation, I
> suppose we should explicitly take care of returning max 64bit value here
> for round-to-odd case ?

I would suggest something like
  bool overflow_to_inf = roundingMode != float_round_to_odd &&
      roundIncrement != 0;

  float_raise(float_flag_overflow | float_flag_inexact, status);
  return packFloat64(zSign, 0x7FF, -(!overflow_to_inf));

as the contents of the if() {} body for overflow detected.

thanks
-- PMM
