Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B179BC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8196920722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoB+RpOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8196920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53tT-0000fs-ND
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j53sQ-0008Cr-QB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j53sO-0001B5-JP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:41:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48091
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j53sN-00016G-T5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582274494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TX2bKGmaoFX1kB0Vs23BSK7K2oJcCGlc8FxuCCpPBNM=;
 b=XoB+RpOmVnovaFaXCSajDLv5PkzhrP9+UX4Lk3OzEqm6bWaKzrJK7tdHGCfpTcc0SMOSgN
 WGk4IGHdwTRLYl2CdsfEK0sNZReEEObJQ+mqeocJQoS2pY82xMx4sSiTtfXIRelnLXhOks
 rTwNFVusOEDwuZ5lTr2JLlnWBVD89yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-7fL0ULPGP-G8hP98qjPlqQ-1; Fri, 21 Feb 2020 03:41:32 -0500
X-MC-Unique: 7fL0ULPGP-G8hP98qjPlqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCDF78010CA;
 Fri, 21 Feb 2020 08:41:28 +0000 (UTC)
Received: from gondolin (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF76E26FAA;
 Fri, 21 Feb 2020 08:41:09 +0000 (UTC)
Date: Fri, 21 Feb 2020 09:41:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3 19/20] Let cpu_[physical]_memory() calls pass a
 boolean 'is_write' argument
Message-ID: <20200221094107.7e855499.cohuck@redhat.com>
In-Reply-To: <20200220130548.29974-20-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-20-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 14:05:47 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Use an explicit boolean type.
>=20
> This commit was produced with the included Coccinelle script
> scripts/coccinelle/exec_rw_const.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  scripts/coccinelle/exec_rw_const.cocci | 14 ++++++++++++++
>  include/exec/cpu-common.h              |  4 ++--
>  hw/display/exynos4210_fimd.c           |  3 ++-
>  hw/display/milkymist-tmu2.c            |  8 ++++----
>  hw/display/omap_dss.c                  |  2 +-
>  hw/display/ramfb.c                     |  2 +-
>  hw/misc/pc-testdev.c                   |  2 +-
>  hw/nvram/spapr_nvram.c                 |  4 ++--
>  hw/ppc/ppc440_uc.c                     |  6 ++++--
>  hw/ppc/spapr_hcall.c                   |  4 ++--
>  hw/s390x/ipl.c                         |  2 +-
>  hw/s390x/s390-pci-bus.c                |  2 +-
>  hw/s390x/virtio-ccw.c                  |  2 +-
>  hw/xen/xen_pt_graphics.c               |  2 +-
>  target/i386/hax-all.c                  |  4 ++--
>  target/s390x/excp_helper.c             |  2 +-
>  target/s390x/helper.c                  |  6 +++---
>  17 files changed, 43 insertions(+), 26 deletions(-)
>=20

> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 7773499d7f..0817874b48 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -626,7 +626,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      uint8_t *addr;
>      uint64_t len =3D 4096;
> =20
> -    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, 1);
> +    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, true);
>      if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
>          error_report("Cannot set QEMU IPL parameters");
>          return;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 7c6a2b3c63..ed8be124da 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -641,7 +641,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8=
_t to_be_set)
>      hwaddr len =3D 1;
>      uint8_t *ind_addr;
> =20
> -    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, 1);
> +    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
>          s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
>          return -1;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 13f57e7b67..50cf95b781 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -790,7 +790,7 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, u=
int64_t ind_loc,
>      hwaddr len =3D 1;
>      uint8_t *ind_addr;
> =20
> -    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, 1);
> +    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
>          error_report("%s(%x.%x.%04x): unable to access indicator",
>                       __func__, sch->cssid, sch->ssid, sch->schid);

> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 1e9d6f20c1..3b58d10df3 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -393,7 +393,7 @@ static int mchk_store_vregs(CPUS390XState *env, uint6=
4_t mcesao)
>      MchkExtSaveArea *sa;
>      int i;
> =20
> -    sa =3D cpu_physical_memory_map(mcesao, &len, 1);
> +    sa =3D cpu_physical_memory_map(mcesao, &len, true);
>      if (!sa) {
>          return -EFAULT;
>      }
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index a3a49164e4..b810ad431e 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -151,7 +151,7 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
>      LowCore *lowcore;
>      hwaddr len =3D sizeof(LowCore);
> =20
> -    lowcore =3D cpu_physical_memory_map(env->psa, &len, 1);
> +    lowcore =3D cpu_physical_memory_map(env->psa, &len, true);
> =20
>      if (len < sizeof(LowCore)) {
>          cpu_abort(env_cpu(env), "Could not map lowcore\n");
> @@ -246,7 +246,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool=
 store_arch)
>      hwaddr len =3D sizeof(*sa);
>      int i;
> =20
> -    sa =3D cpu_physical_memory_map(addr, &len, 1);
> +    sa =3D cpu_physical_memory_map(addr, &len, true);
>      if (!sa) {
>          return -EFAULT;
>      }
> @@ -298,7 +298,7 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr,=
 hwaddr len)
>      hwaddr save =3D len;
>      int i;
> =20
> -    sa =3D cpu_physical_memory_map(addr, &save, 1);
> +    sa =3D cpu_physical_memory_map(addr, &save, true);
>      if (!sa) {
>          return -EFAULT;
>      }

s390 parts
Acked-by: Cornelia Huck <cohuck@redhat.com>


