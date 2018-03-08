Received: from eggs.gnu.org ([2001:4830:134:3::10]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eu0sn-0003lz-NE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eu0sm-0004Bm-Sh
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:07:17 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eu0sm-0004BW-Nc
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:07:16 -0500
Received: by mail-oi0-x244.google.com with SMTP id c18so5152186oiy.9
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 11:07:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-11-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-11-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 19:06:55 +0000
Message-ID: <CAFEAcA8grbFO7E0yoci_dwr2xnH8ujS8cJnpNxGdz=JOged=Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 10/14] hw/arm/smmuv3: Abort on vfio or
 vhost case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> At the moment, the SMMUv3 does not support notification on
> TLB invalidation. So let's abort as soon as such notifier gets
> enabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 384393f..5efe933 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1074,12 +1074,23 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
>      dc->realize = smmu_realize;
>  }
>
> +static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> +                                       IOMMUNotifierFlag old,
> +                                       IOMMUNotifierFlag new)
> +{
> +    if (old == IOMMU_NOTIFIER_NONE) {
> +        error_setg(&error_fatal,
> +                   "SMMUV3: vhost and vfio notifiers not yet supported");
> +    }
> +}

Is this triggerable by the guest, or by the user on the command
line, or only by a bug in the board or other QEMU code?

thanks
-- PMM
