Received: from eggs.gnu.org ([2001:4830:134:3::10]:60454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRj6J-0002Lj-0t
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRj6E-0003TB-Fu
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:23:47 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484238251-8096-7-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1145c965-e1e5-025f-c88b-de0dd614fee1@twiddle.net>
Date: Thu, 12 Jan 2017 09:23:38 -0800
MIME-Version: 1.0
In-Reply-To: <1484238251-8096-7-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] target-ppc: Add xvtstdc[sp,
 dp] instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 01/12/2017 08:24 AM, Nikunj A Dadhania wrote:
> +        nan = tp##_is_any_nan(xb.fld);                      \
> +        infinity = tp##_is_infinity(xb.fld);                \
> +        sign = tp##_is_neg(xb.fld);                         \
> +        zero = denormal = 0;                                \
> +        if (tp##_is_zero_or_denormal(xb.fld)) {             \
> +            if (tp##_is_zero(xb.fld)) {                     \
> +                zero = 1;                                   \
> +            } else {                                        \
> +                denormal = 1;                               \
> +            }                                               \
> +        }                                                   \
> +                                                            \
> +        if ((extract32(dcmx, 6, 1) && nan) ||               \
> +            (extract32(dcmx, 5, 1) && infinity && !sign) || \
> +            (extract32(dcmx, 4, 1) && infinity &&  sign) || \
> +            (extract32(dcmx, 3, 1) && zero     && !sign) || \
> +            (extract32(dcmx, 3, 1) && zero     &&  sign) || \
> +            (extract32(dcmx, 1, 1) && denormal && !sign) || \
> +            (extract32(dcmx, 0, 1) && denormal &&  sign)) { \
> +            match = 1;                                      \
> +        }                                                   \

I'll note that all of these are mutually exclusive, therefore you're doing much
more work than required.

  sign = tp##_is_neg(x));
  if (tp##is_any_nan(x)) {
      match = extract32(dcmx, 6, 1);
  } else if (tp##_is_infinity(x)) {
      match = extract32(dcmx, 4 + !sign, 1);
  } else if (tp##_is_zero(x)) {
      match = extract32(dcmx, 2 + !sign, 1);
  } else if (tp##_is_zero_or_denormal(x)) {
      match = extract32(dcmx, 0 + !sign, 1);
  }

(Also, an apparent typo for your zero && sign case.)


r~
