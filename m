Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 22:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171642070A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ12boiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171642070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwYOd-0004Km-Bi
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 17:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwYNy-0003Uq-6P
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 17:59:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwYNv-0007Rd-GT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 17:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595023153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9yv5JHNdz/5xPo0tJaeR3nhouG+c33TFFAKleHI8y4=;
 b=HQ12boiIFdDG/5RU7dzqar3enprrSHekvApNCF1HV9spRXPZmkLfvRZ3PuHm2Zn0Dyo0q3
 ewK46fhr+F1tZkv0KL11VULiGpoDQG04G2Kc/VM89w38TU45VjQwV+YZSgvRdUtAFeEgE/
 t8lHDCE/2CNI1PyHPGQYR/w7PBDlJ50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-h_mXtBpzNxC-4L7L4nCMEQ-1; Fri, 17 Jul 2020 17:59:11 -0400
X-MC-Unique: h_mXtBpzNxC-4L7L4nCMEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7210E8014D7
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 21:59:10 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01E2519D61;
 Fri, 17 Jul 2020 21:59:09 +0000 (UTC)
Date: Fri, 17 Jul 2020 15:59:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2] hw/vfio: Move some target-independent devices
 to common-objs
Message-ID: <20200717155907.159a302c@x1.home>
In-Reply-To: <20200715131322.28767-1-philmd@redhat.com>
References: <20200715131322.28767-1-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 17:59:13
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 15:13:22 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> These devices do not depend on the target CPU configuration
> (32 or 64-bit, big / little endian). Move them to common-obj
> to compile them once for all the targets.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/vfio/Makefile.objs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index 9bb1c09e84..f663a800b1 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,8 +1,9 @@
>  obj-y +=3D common.o spapr.o
> -obj-$(CONFIG_VFIO_PCI) +=3D pci.o pci-quirks.o display.o
> +obj-$(CONFIG_VFIO_PCI) +=3D pci.o pci-quirks.o
>  obj-$(CONFIG_VFIO_CCW) +=3D ccw.o
>  obj-$(CONFIG_VFIO_PLATFORM) +=3D platform.o
> -obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
> -obj-$(CONFIG_VFIO_AMD_XGBE) +=3D amd-xgbe.o
>  obj-$(CONFIG_VFIO_AP) +=3D ap.o
> -obj-$(CONFIG_VFIO_IGD) +=3D igd.o
> +common-obj-$(CONFIG_VFIO_PCI) +=3D display.o
> +common-obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
> +common-obj-$(CONFIG_VFIO_AMD_XGBE) +=3D amd-xgbe.o
> +common-obj-$(CONFIG_VFIO_IGD) +=3D igd.o

What thing, or lack of thing, are you looking for in these files that
aren't in the others?  For instance if igd.o is common, but pci-quirks.o
is not, where igd.o is just a quirk that got split out of pci-quirks.o
so that we could more easily compile it out, it feels like we might be
stumbling into cases where adding or removing code that would shift
objects into or out of the common-obj target.  I don't know how to
maintain that.  Thanks,

Alex


