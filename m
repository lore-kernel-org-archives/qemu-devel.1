Received: from eggs.gnu.org ([2001:4830:134:3::10]:36868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1extQ1-00061R-2l
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1extQ0-0002Py-DF
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:57:37 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1extQ0-0002P7-6q
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:57:36 -0400
Received: by mail-ot0-x241.google.com with SMTP id i28-v6so12346050otf.8
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 04:57:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313153458.26822-9-peter.maydell@linaro.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 11:57:14 +0000
Message-ID: <CAFEAcA-GC505pF32VCJyHy8-8cP5C+gqY6mm-iMoiZEmWqBaRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 8/9] hw/arm/bcm2836: Hardcode
 correct CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "patches@linaro.org" <patches@linaro.org>

On 13 March 2018 at 15:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> Now we have separate types for BCM2386 and BCM2387, we might as well
> just hard-code the CPU type they use rather than having it passed
> through as an object property. This then lets us put the initialization
> of the CPU object in init rather than realize.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/bcm2836.c | 22 +++++++++++++---------
>  hw/arm/raspi.c   |  2 --
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 7140257c98..12f75b55a7 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,16 +25,19 @@
>
>  struct BCM283XInfo {
>      const char *name;
> +    const char *cpu_type;
>      int clusterid;
>  };
>
>  static const BCM283XInfo bcm283x_socs[] = {
>      {
>          .name = TYPE_BCM2836,
> +        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a15"),
>          .clusterid = 0xf,
>      },
>      {
>          .name = TYPE_BCM2837,
> +        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
>          .clusterid = 0x0,
>      },
>  };

With this change we need to also add
#ifdef TARGET_AARCH64
#endif

around the entry in the array for bcm2837. Otherwise the
device-introspection tests in 'make check' will fail trying
to create the bcm2837 in qemu-system-arm, because there there
is no cortex-a53 device.

I'll just squash that into this patch...

thanks
-- PMM
