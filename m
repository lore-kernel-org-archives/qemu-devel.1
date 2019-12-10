Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6271CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9752053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTwJLSAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9752053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecX8-0005O9-8Z
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iecWR-0004rX-Qq
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iecWQ-0007gL-MU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:13:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iecWQ-0007fv-J6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575972818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wCO3GuM2moFcAks0xXtIp9Oxy/EmVQGKpZZV5ENJBE=;
 b=YTwJLSAdcbADMtYbi5ZrlRnn2VvuDELoP7YoYUwkfF1LZ288LTOSIHNuEDZmyQpaNNBOpq
 CB4W1nEB3rwaARCwMMudJ8bpOPLzegikTyEk7SA1/MtsdYMbYarc2rQ7zD8hmaWm3enTea
 3aZg3UeXxQWS+fw5A1qW+lBm2liR2nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Sv9F--SmMlq1LqAvEJt_rA-1; Tue, 10 Dec 2019 05:13:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D31107ACC4;
 Tue, 10 Dec 2019 10:13:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5004760561;
 Tue, 10 Dec 2019 10:13:26 +0000 (UTC)
Date: Tue, 10 Dec 2019 11:13:23 +0100
From: Andrew Jones <drjones@redhat.com>
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu topology
 support
Message-ID: <20191210101323.q7dn2f3pkx3ya5s4@kamzik.brq.redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED3405A26F@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED3405A26F@dggemm526-mbx.china.huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Sv9F--SmMlq1LqAvEJt_rA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "wei@redhat.com" <wei@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 huangdaode <huangdaode@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 02:14:09AM +0000, Zengtao (B) wrote:
> Hi Andrew:
>=20
> Any update for this patch series? I have met the same issue, and if the=
=20
> topology guessed by linux MPIDR conflicts with qemu specified numa, it
> will failed to boot (sched domain initialization will fall into deadloop)=
.

Hi Zeng,

This has been on my TODO list a long time, but it keeps getting preempted.
We need to start by giving userspace control over the MPIDRs, including
when KVM is in use. The earliest I can return to this will be mid/late
January. If you'd like to jump in on it now, then feel free.

Thanks,
drew

>=20
> Thanks.
>=20
> > -----Original Message-----
> > From: Qemu-devel
> > [mailto:qemu-devel-bounces+incoming=3Dpatchwork.ozlabs.org@nongnu.or
> > g] On Behalf Of Andrew Jones
> > Sent: Thursday, July 05, 2018 4:49 AM
> > To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> > Cc: wei@redhat.com; peter.maydell@linaro.org; eric.auger@redhat.com;
> > imammedo@redhat.com
> > Subject: [Qemu-devel] [RFC PATCH 0/6] hw/arm/virt: Introduce cpu
> > topology support
> >=20
> > This series provides support for booting mach-virt machines with
> > non-flat cpu topology, i.e. enabling the extended options of the
> > '-smp' command line parameter (sockets,cores,threads). Both DT and
> > ACPI description generators are added. We only apply the new feature
> > to 3.1 and later machine types, as the change is guest visible, even
> > when no command line change is made. This is because the basic
> > '-smp <N>' parameter makes the assumption that <N> refers to the
> > number of sockets, but when no topology description is provided,
> > Linux will use the MPIDR to guess. Neither the MPIDR exposed to
> > the guest when running with KVM nor TCG currently provides socket
> > information, leaving Linux to assume all processing elements are
> > cores in the same socket. For example, before this series '-smp 4'
> > would show up in the guest as
> >=20
> >  CPU(s):                4
> >  On-line CPU(s) list:   0-3
> >  Thread(s) per core:    1
> >  Core(s) per socket:    4
> >  Socket(s):             1
> >=20
> > and after it shows up as
> >=20
> >  CPU(s):                4
> >  On-line CPU(s) list:   0-3
> >  Thread(s) per core:    1
> >  Core(s) per socket:    1
> >  Socket(s):             4
> >=20
> > It's not expected that this should be a problem, but it's worth
> > considering. The only way to avoid the silent change is for QEMU to
> > provide boards a way to override the default '-smp' parsing function.
> > Otherwise, if a user wants to avoid a guest visible change, but still
> > use a 3.1 or later mach-virt machine type, then they must ensure the
> > command line specifies a single socket, e.g. '-smp sockets=3D1,cores=3D=
4'
> >=20
> > Thanks,
> > drew
> >=20
> >=20
> > Andrew Jones (6):
> >   hw/arm/virt: Add virt-3.1 machine type
> >   device_tree: add qemu_fdt_add_path
> >   hw/arm/virt: DT: add cpu-map
> >   hw/arm/virt-acpi-build: distinguish possible and present cpus
> >   virt-acpi-build: add PPTT table
> >   hw/arm/virt: cpu topology: don't allow threads
> >=20
> >  device_tree.c                | 24 +++++++++++++
> >  hw/acpi/aml-build.c          | 50 ++++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c     | 25 ++++++++++---
> >  hw/arm/virt.c                | 69
> > +++++++++++++++++++++++++++++++++---
> >  include/hw/acpi/aml-build.h  |  2 ++
> >  include/hw/arm/virt.h        |  1 +
> >  include/sysemu/device_tree.h |  1 +
> >  7 files changed, 162 insertions(+), 10 deletions(-)


