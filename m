Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F2C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB96E20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+CFTDHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB96E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9B1-0005T8-4E
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iY9AM-0004vB-8O
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iY9AH-0004gO-DQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:40:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iY9AH-0004g8-7z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574430000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5WFJTWswLr3CllhGl9S9g70GcWuzuVbdynKAWiuxtY=;
 b=W+CFTDHnm9UWOIs1pCyKq3fgca9tdA26usLl5vsI7i7qDIG6x0hLdXf5qSWZ31uDW58pBh
 hLngcQkdzROTXlAkYVn76NGg9+KgrkjlcR/ppikybShOWzNHYMduFOlGfyGeBuT6vLeD2T
 hBc63CHu9izcY0Mw4klx6JaOcjoOANk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-qflkhhbQPcW7faPhJXc-TA-1; Fri, 22 Nov 2019 08:39:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE3EDB81;
 Fri, 22 Nov 2019 13:39:55 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85CB11084192;
 Fri, 22 Nov 2019 13:39:51 +0000 (UTC)
Date: Fri, 22 Nov 2019 14:39:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
Message-ID: <20191122143949.4880aa1b.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-7-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qflkhhbQPcW7faPhJXc-TA-1
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

> +static int s390_pv_cmd(uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc);
> +        exit(1);
> +    }
> +    return rc;
> +}
> +
> +static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd, r=
c);
> +        exit(1);
> +    }
> +    return rc;
> +}

If you do a hard exit for any rc !=3D 0 anyway, returning rc does not
sound very useful :)


