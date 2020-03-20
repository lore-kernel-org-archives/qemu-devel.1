Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2FC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3DE20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmxIkIf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3DE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJw5-0003Sm-I4
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jFJph-0004T5-Mv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jFJpg-0002Qk-4s
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:45:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jFJpf-0002FJ-T8; Fri, 20 Mar 2020 11:45:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id g62so6865294wme.1;
 Fri, 20 Mar 2020 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a9ZpqT3RuAdAmJwiXIwXYUQ/m0aJY0SvGkCl+/cKUQA=;
 b=mmxIkIf+Ij9OAReF6lqY2t1e7iQyoWqLtKpdCYXZaI9u5D7P+Wmb5LN3itnUXZD+Ox
 hXJQ6bffPd7B1rw3x4hvTjjpIeVvKXwMKQt06q9B7MU/AydetO8JroUP7LDUf0qKbvhi
 MLU39+yTXdiXOVtfVrvazBbLB8sRerNYdBgBM1GET9H+BOSqaHMUEZjqgfVklrnP7JPk
 isXIF/0ulJP3yhnu8oS6uYBU5PInpkHWuP+veE7TIuZL0V7hfM1djXLncVuciX7UGfb7
 BKwrejkf5d6I4fBArfVWRBbU8c9EeQ3dzDmoBG5QroAfMSGw/6JgR0PFzdYb1RGwdt6Z
 lwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a9ZpqT3RuAdAmJwiXIwXYUQ/m0aJY0SvGkCl+/cKUQA=;
 b=VqxZUnQJj4noZSPrExDpU9rDn2GOS/bLN1JW+JdF8YKnC1VfJ96gkcpDSC6Kp4EO35
 YzfXnSxQ82cUtSjrn48gDd8YFYOqiyYNLNXY1mQTMjFD9WQ7zL268gUuiOg1KRJqYJ6P
 wd0eemAlC26ONz1SVjna9KjiRdmYgX+8NR/Wj0EB9zsXRdY6OI6tuSgJYjhtL2+8sUkp
 vN17H/EYs2XdDM3tVGAX9p+ngnaUb3HCkT2BWIa9VOq919iEYfmQzkvtqMSYR8R5p2xe
 cpWcRqKKA8jqNftCJf9h8BQroxcvj9iCCjufOJQ1wltSrAI549nnCOtzOwfxdvTPPGBM
 1RlA==
X-Gm-Message-State: ANhLgQ0BoRm4VVi7BJ32bDW0IDGPJz02aZ6Z/qkSkoVTx+8nJ2JF4x5d
 IDuJCt4y6BLgH5kXVx563Ec=
X-Google-Smtp-Source: ADFU+vuisHhe0bbNpnFgELlr9m7Tz0cFNDHteALyp/PUhOM9SQFqc5/6+4B7xS2g/GoJNQ+MFtlDkw==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr10655034wmk.2.1584719107203; 
 Fri, 20 Mar 2020 08:45:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l12sm8515867wrt.73.2020.03.20.08.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 08:45:06 -0700 (PDT)
Date: Fri, 20 Mar 2020 15:45:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v3] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200320154505.GD138042@stefanha-x1.localdomain>
References: <20200318200303.11322-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20200318200303.11322-1-andrzej.jakowski@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, haozhong.zhang@intel.com, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com,
 junyan.he@intel.com, kbusch@kernel.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 01:03:03PM -0700, Andrzej Jakowski wrote:
> This patch introduces support for PMR that has been defined as part of NV=
Me 1.4
> spec. User can now specify a pmrdev option that should point to HostMemor=
yBackend.
> pmrdev memory region will subsequently be exposed as PCI BAR 2 in emulate=
d NVMe
> device. Guest OS can perform mmio read and writes to the PMR region that =
will stay
> persistent across system reboot.
>=20
> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
> v2:
>  - reworked PMR to use HostMemoryBackend instead of directly mapping PMR
>    backend file into qemu [1] (Stefan)
>=20
> v1:
>  - provided support for Bit 1 from PMRWBM register instead of Bit 0 to en=
sure
>    improved performance in virtualized environment [2] (Stefan)
>=20
>  - added check if pmr size is power of two in size [3] (David)
>=20
>  - addressed cross compilation build problems reported by CI environment
>=20
> [1]: https://lore.kernel.org/qemu-devel/20200306223853.37958-1-andrzej.ja=
kowski@linux.intel.com/
> [2]: https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10=
-Ratified.pdf
> [3]: https://lore.kernel.org/qemu-devel/20200218224811.30050-1-andrzej.ja=
kowski@linux.intel.com/
> ---
> Persistent Memory Region (PMR) is a new optional feature provided in NVMe=
 1.4
> specification. This patch implements initial support for it in NVMe drive=
r.
> ---
>  hw/block/nvme.c       | 117 +++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   2 +
>  hw/block/trace-events |   5 ++
>  include/block/nvme.h  | 172 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 294 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d28335cbf3..70fd09d293 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -19,10 +19,18 @@
>   *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
>   *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
>   *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
> + *              [pmrdev=3D<mem_backend_file_id>,] \
>   *              num_queues=3D<N[optional]>
>   *
>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> + *
> + * Either cmb or pmr - due to limitation in available BAR indexes.

This isn't 100% clear.  Does this mean "cmb_size_mb=3D and pmrdev=3D are
mutually exclusive due to limited availability of BARs"?  Please
rephrase.

> + * pmr_file file needs to be power of two in size.
> + * Enabling pmr emulation can be achieved by pointing to memory-backend-=
file.
> + * For example:
> + * -object memory-backend-file,id=3D<mem_id>,share=3Don,mem-path=3D<file=
_path>, \
> + *  size=3D<size> .... -device nvme,...,pmrdev=3D<mem_id>
>   */
> =20
>  #include "qemu/osdep.h"
> @@ -35,7 +43,9 @@
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include "sysemu/hostmem.h"
>  #include "sysemu/block-backend.h"
> +#include "exec/ramblock.h"
> =20
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> @@ -1141,6 +1151,26 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr off=
set, uint64_t data,
>          NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
>                         "invalid write to read only CMBSZ, ignored");
>          return;
> +    case 0xE00: /* PMRCAP */
> +        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrcap_readonly,
> +                       "invalid write to PMRCAP register, ignored");
> +        return;
> +    case 0xE04: /* TODO PMRCTL */
> +        break;
> +    case 0xE08: /* PMRSTS */
> +        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrsts_readonly,
> +                       "invalid write to PMRSTS register, ignored");
> +        return;
> +    case 0xE0C: /* PMREBS */
> +        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrebs_readonly,
> +                       "invalid write to PMREBS register, ignored");
> +        return;
> +    case 0xE10: /* PMRSWTP */
> +        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrswtp_readonly,
> +                       "invalid write to PMRSWTP register, ignored");
> +        return;
> +    case 0xE14: /* TODO PMRMSC */
> +         break;
>      default:
>          NVME_GUEST_ERR(nvme_ub_mmiowr_invalid,
>                         "invalid MMIO write,"
> @@ -1169,6 +1199,23 @@ static uint64_t nvme_mmio_read(void *opaque, hwadd=
r addr, unsigned size)
>      }
> =20
>      if (addr < sizeof(n->bar)) {
> +        /*
> +         * When PMRWBM bit 1 is set then read from
> +         * from PMRSTS should ensure prior writes
> +         * made it to persistent media
> +         */
> +        if (addr =3D=3D 0xE08 &&
> +            (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02) >> 1) {
> +            int status;
> +
> +            status =3D qemu_msync((void *)n->pmrdev->mr.ram_block->host,
> +                                n->pmrdev->size,
> +                                n->pmrdev->mr.ram_block->fd);

Please use qemu_ram_writeback() so that pmem_persist() and qemu_msync()
are used as appropriate.

Stefan

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl505QAACgkQnKSrs4Gr
c8jrYQgAjJ8evDCYOfNHqBQGU807wtTN4YUGSKASRL8tF8YpENzMXwNg1WAQ4I/l
AMlF7Q5/bPQ0ayjzKWgsjKwN/r3E+Uk+Au3xgVds4ekmPvZL2Zg10TK4IFdmsz6s
DruipaBOwDJCGsR8w52OPGEtam6lWsztZKdN1cJzD/MfLobhjnV2WWXg5uej2/xv
RlwWaGaTHA6O0svRzzGAS1FxZpNtGT8sZkagIRhol8Ad/WCO6AQM8nxWsXKe6P5Y
B9DEA5T0AbGXVcrtDM+HlV1mzidwm5OhvohL9cWAtl4rMMP6fGSAqDq0icLrv2IJ
zdsmr0WIqhp5fgLwIiVUx69hqm/kiQ==
=vzJ0
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

