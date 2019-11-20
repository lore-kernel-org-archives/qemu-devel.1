Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FFE22506
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9Ce1r1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FFE22506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQHZ-0007wj-KR
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXQGh-0007Su-HE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXQGf-0005it-I8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:43:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXQGf-0005ip-EV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574257416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIStGeVracx2OCaWzLOoA+Y7ESTVA1oe4YfRRp84+sA=;
 b=K9Ce1r1lHhKnI1J33qPD5bczElmWGf/MqG42md704ft3vNmfFYeX9INkMQDjokAwsQO24X
 FFpg6BEzz4mwday1yNU8eo+Ic8/ams2wDb12LyAuJA9X0he/jh53UQDvJCU88ul38PVsKf
 8lgt/2it+JqCyVtHmyFjhUSUdwfS7E0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-HJ_aD3zMMFastVxFpKRQ8w-1; Wed, 20 Nov 2019 08:43:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0133477;
 Wed, 20 Nov 2019 13:43:33 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 723A62AABC;
 Wed, 20 Nov 2019 13:43:29 +0000 (UTC)
Date: Wed, 20 Nov 2019 14:43:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
Message-ID: <20191120144327.0c9e22cb.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-7-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HJ_aD3zMMFastVxFpKRQ8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:25 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> When a guest has saved a ipib of type 5 and call diagnose308 with
> subcode 10, we have to setup the protected processing environment via
> Ultravisor calls. The calls are done by KVM and are exposed via an API.
>=20
> The following steps are necessary:
> 1. Create a VM (register it with the Ultravisor)
> 2. Create secure CPUs for all of our current cpus
> 3. Forward the secure header to the Ultravisor (has all information on
> how to decrypt the image and VM information)
> 4. Protect image pages from the host and decrypt them
> 5. Verify the image integrity
>=20
> Only after step 5 a protected VM is allowed to run.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  33 ++++++++
>  hw/s390x/ipl.h                      |   2 +
>  hw/s390x/pv.c                       | 118 ++++++++++++++++++++++++++++
>  hw/s390x/pv.h                       |  26 ++++++
>  hw/s390x/s390-virtio-ccw.c          |  45 ++++++++---
>  target/s390x/cpu_features_def.inc.h |   1 +
>  7 files changed, 216 insertions(+), 10 deletions(-)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h
>=20
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 94e57113d8..568bab9711 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -31,6 +31,7 @@ obj-y +=3D tod-qemu.o
>  obj-$(CONFIG_KVM) +=3D tod-kvm.o
>  obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>  obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o s390-mchk.o
> +obj-$(CONFIG_KVM) +=3D pv.o

As this is kvm only...

>  obj-y +=3D s390-ccw.o
>  obj-y +=3D ap-device.o
>  obj-y +=3D ap-bridge.o
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index a077926f36..50501fcd27 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -33,6 +33,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/option.h"
>  #include "exec/exec-all.h"
> +#include "pv.h"
> =20
>  #define KERN_IMAGE_START                0x010000UL
>  #define LINUX_MAGIC_ADDR                0x010008UL
> @@ -668,6 +669,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
> =20
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    int rc;
> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);
> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
> +                               ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    int i, rc;
> +    IplParameterBlock *iplb =3D s390_ipl_get_iplb_secure();
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].siz=
e),
> +                            ipib_pv->components[i].tweak_pref);

...you probably need a stub version of the pv functions as well, right?

> +        if (rc) {
> +            return rc;
> +        }
> +    }
> +    return rc;
> +}
> +
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl =3D get_ipl_device();


