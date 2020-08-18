Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C473C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B903E2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2c1S17c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B903E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k85BL-0003LK-Va
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k85AP-000290-CA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:12:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k85AL-0003b3-FU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597770770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97kp2reQr78sEoPv9g+RREPtPW34YT035IITW7b1mg0=;
 b=C2c1S17cMtydUH0AJCJDHYyiEyfOxY378nZ69Qh9Y2AQdV0poF7wLLyiMQ+Y1UvkttgTrK
 1RY+yseSRXiLY7suqbaZeqZZV7cqo+GEGoAmcd3OzuaLzZ09epXVAdXmkJJLQSYCO2ytkY
 IE0divkAb9ejuuXFuc5Cjk2z4Im13Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-lyANfMKlMlCU4w0d5sRjfA-1; Tue, 18 Aug 2020 13:12:49 -0400
X-MC-Unique: lyANfMKlMlCU4w0d5sRjfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2089A807332;
 Tue, 18 Aug 2020 17:12:47 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04A985D9DC;
 Tue, 18 Aug 2020 17:12:39 +0000 (UTC)
Date: Tue, 18 Aug 2020 11:12:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] util/vfio-helpers: Report error on
 unsupported host architectures
Message-ID: <20200818111239.2f9b510c@x1.home>
In-Reply-To: <20200818164509.736367-3-philmd@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
 <20200818164509.736367-3-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Drew Jones <drjones@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 18:45:06 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The vfio-helpers implementation expects a TYPEv1 IOMMU, see
> qemu_vfio_init_pci:
>=20
>   263     if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU=
)) {
>   264         error_setg_errno(errp, errno, "VFIO IOMMU check failed");
>=20
> Thus POWER SPAPR IOMMU is obviously not supported.
>=20
> The implementation only cares about host page size alignment
> (usually 4KB on X86), not the IOMMU one, which is be problematic
> on Aarch64, when 64MB page size is used. So Aarch64 is not
> supported neither.
>=20
> Report an error when the host architecture is different than X86:
>=20
>  $ qemu-system-aarch64 \
>     -drive file=3Dnvme://0001:01:00.0/1,if=3Dnone,id=3Ddrive0 \
>     -device virtio-blk-pci,drive=3Ddrive0
>   qemu-system-aarch64: -drive file=3Dnvme://0001:01:00.0/1,if=3Dnone,id=
=3Ddrive0: QEMU VFIO utility is not supported on this architecture
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Drew Jones <drjones@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---
>  util/vfio-helpers.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index e399e330e26..60017936e3e 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -420,14 +420,38 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
>      qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
>  }
> =20
> +/**
> + * Return if the host architecture is supported.
> + *
> + * aarch64: IOMMU page alignment not respected
> + * ppc64:   SPAPR IOMMU window not configured
> + * x86-64:  Only architecture validated
> + * other:   Untested
> + */
> +static bool qemu_vfio_arch_supported(void)
> +{
> +    bool supported =3D false;
> +
> +#if defined(HOST_X86_64)
> +    supported =3D true;
> +#endif
> +
> +    return supported;
> +}

Why does this need to be hard coded to specific architectures rather
than probing for type1 IOMMU support and looking at the iova_pgsizes
from VFIO_IOMMU_GET_INFO to see if there's a compatible size?  It
requires us to get a bit deeper into the device initialization, but we
should still be able to unwind out of the device realize.  Otherwise
we're throwing out aarch64 running of 4KB for no reason, right?  Thanks,

Alex


>  /**
>   * Open a PCI device, e.g. "0000:00:01.0".
>   */
>  QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
>  {
>      int r;
> -    QEMUVFIOState *s =3D g_new0(QEMUVFIOState, 1);
> +    QEMUVFIOState *s;
> =20
> +    if (!qemu_vfio_arch_supported()) {
> +        error_setg(errp,
> +                   "QEMU VFIO utility is not supported on this architect=
ure");
> +        return NULL;
> +    }
> +    s =3D g_new0(QEMUVFIOState, 1);
>      r =3D qemu_vfio_init_pci(s, device, errp);
>      if (r) {
>          g_free(s);


