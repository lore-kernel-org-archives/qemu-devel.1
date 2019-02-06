Received: from eggs.gnu.org ([209.51.188.92]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grHRF-0006xQ-6k
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grHRE-00045Y-Hs
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:16:05 -0500
Received: from chuckie.co.uk ([82.165.15.123]:40150
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grHRE-00044z-BV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:16:04 -0500
References: <20190104223116.14037-1-richard.henderson@linaro.org>
	<d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
	<362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
	<6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
	<935af9ba-3fd8-ebd8-4f70-5050351d89d5@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d5383a6e-d772-ae4b-8a94-608d0947009c@ilande.co.uk>
Date: Wed, 6 Feb 2019 07:15:55 +0000
MIME-Version: 1.0
In-Reply-To: <935af9ba-3fd8-ebd8-4f70-5050351d89d5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>

On 06/02/2019 03:37, Richard Henderson wrote:

> On 2/5/19 9:29 PM, Mark Cave-Ayland wrote:
>> The only minor question I had with the patchset in its current form is whether to use
>> the new VsrD() macro for vscr_sat, or whether we don't really care enough?
> 
> Given the comment
> 
>   /* Which bit we set is completely arbitrary, but clear the rest.  */
> 
> I don't think VsrD is helpful.

Okay, I can leave that for now.

> In "target/ppc: Split out VSCR_SAT to a vector field":
> 
>       ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
> +     /* Non-zero if and only if VSCR_SAT should be set.  */
> +     ppc_vsr_t vscr_sat;
> 
> Better to add the QEMU_ALIGNED(16) to vscr_sat as well.  Yes, it will already
> happen to be aligned by placement, but this is also a bit documentation.

I've added this to my latest branch.

> In "target/ppc: convert vadd*s and vsub*s to vector operations":
> 
>           if (sat) {                                                      \
> -             set_vscr_sat(env);                                          \
> +             vscr_sat->u32[0] = 1;                                       \
>           }                                                               \
> 
> Changed in error?

It looks like this was in the original patch, presumably because GEN_VXFORM_SAT
doesn't include the env parameter which was present in GEN_VXFORM_ENV. Should the env
parameter be added to GEN_VXFORM_SAT?

Howard has also pointed out that he's still spotted some corruption in his tests, so
I will do a bit more investigation and report back.


ATB,

Mark.
