Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58280C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D8C21775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTSFl0z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D8C21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8obq-0001VP-9R
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j8oak-0000Uy-5q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j8oah-0005XS-Lg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:10:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46553
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j8oah-0005XC-He
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583169050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=annyok8WO70mONURXhUOM3wABUHy6q32T5X45oWq5GI=;
 b=RTSFl0z0/ILhMUBHxXmE+hXOguoSnrbu+womZlMIrSsZvN3oUvaXfYENuh3USrMMO+UFmY
 kQIujR7c9U0v1+TlJ2BHdulyvyLWtZnFYjTeaCD/EeDD1NOeF+KP7wqytVZIUIr1B5Ir4g
 27q7j8qdnjIWQZ9JboMzHVLvanbNFl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-VVU7d8nHMEeuj54BNc3tfQ-1; Mon, 02 Mar 2020 12:10:33 -0500
X-MC-Unique: VVU7d8nHMEeuj54BNc3tfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DD0F802560;
 Mon,  2 Mar 2020 17:10:32 +0000 (UTC)
Received: from localhost (ovpn-126-231.rdu2.redhat.com [10.10.126.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8F2A73865;
 Mon,  2 Mar 2020 17:10:28 +0000 (UTC)
Date: Mon, 2 Mar 2020 12:10:27 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH v4 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Message-ID: <20200302171027.GH4440@habkost.net>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
 <3d63b5ea-2da8-499e-c617-c25a7d87106e@gmx.com>
 <b26b1c03-cb2b-9c8b-4796-24b3b296a103@gmx.com>
 <48851271-4a15-f207-ba17-335d9c9a7302@gmx.com>
MIME-Version: 1.0
In-Reply-To: <48851271-4a15-f207-ba17-335d9c9a7302@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, slp@redhat.com, qemu-devel@nongnu.org,
 jmcneill@invisible.ca, pbonzini@redhat.com, philmd@redhat.com, max@m00nbsd.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kamil, Maxime,

I haven't managed to reserve time to review this, sorry for that.
I hope others can chime in before I do.

Would any of you be willing to be included as maintainer of the
new code on MAINTAINERS?


On Mon, Mar 02, 2020 at 06:02:18PM +0100, Kamil Rytarowski wrote:
> Ping?
>=20
> On 24.02.2020 16:17, Kamil Rytarowski wrote:
> > Ping?
> >
> > On 17.02.2020 10:07, Kamil Rytarowski wrote:
> >> Ping?
> >>
> >> On 06.02.2020 22:32, Kamil Rytarowski wrote:
> >>> Hello QEMU Community!
> >>>
> >>> Over the past year the NetBSD team has been working hard on a new use=
r-mode API
> >>> for our hypervisor that will be released as part of the upcoming NetB=
SD 9.0.
> >>> This new API adds user-mode capabilities to create and manage virtual=
 machines,
> >>> configure memory mappings for guest machines, and create and control =
execution
> >>> of virtual processors.
> >>>
> >>> With this new API we are now able to bring our hypervisor to the QEMU
> >>> community! The following patches implement the NetBSD Virtual Machine=
 Monitor
> >>> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
> >>>
> >>> When compiling QEMU for x86_64 passing the --enable-nvmm flag will co=
mpile the
> >>> accelerator for use. At runtime using the '-accel nvmm' should see a
> >>> significant performance improvement over emulation, much like when us=
ing 'hax'
> >>> on NetBSD.
> >>>
> >>> The documentation for this new API is visible at https://man.netbsd.o=
rg under
> >>> the libnvmm(3) and nvmm(4) pages.
> >>>
> >>> NVMM was designed and implemented by Maxime Villard.
> >>>
> >>> Thank you for your feedback.
> >>>
> >>> Refrences:
> >>> https://m00nbsd.net/4e0798b7f2620c965d0dd9d6a7a2f296.html
> >>>
> >>> Test plan:
> >>>
> >>> 1. Download a NetBSD 9.0 pre-release snapshot:
> >>> http://nycdn.netbsd.org/pub/NetBSD-daily/netbsd-9/latest/images/NetBS=
D-9.0_RC1-amd64.iso
> >>>
> >>> 2. Install it natively on a not too old x86_64 hardware (Intel or AMD=
).
> >>>
> >>> There is no support for nested virtualization in NVMM.
> >>>
> >>> 3. Setup the system.
> >>>
> >>>  export PKG_PATH=3Dhttp://www.ki.nu/pkgsrc/packages/current/NetBSD-9.=
0_RC1/All
> >>>  pkg_add git gmake python37 glib2 bison pkgconf pixman
> >>>
> >>> Install mozilla-rootcerts and follow post-install instructions.
> >>>
> >>>  pkg_add mozilla-rootcerts
> >>>
> >>> More information: https://wiki.qemu.org/Hosts/BSD#NetBSD
> >>>
> >>> 4. Build qemu
> >>>
> >>>  mkdir build
> >>>  cd build
> >>>  ../configure --python=3Dpython3.7
> >>>  gmake
> >>>  gmake check
> >>>
> >>> 5. Test
> >>>
> >>>  qemu -accel nvmm ...
> >>>
> >>>
> >>> History:
> >>> v3 -> v4:
> >>>  - Correct build warning by adding a missing include
> >>>  - Do not set R8-R16 registers unless TARGET_X86_64
> >>> v2 -> v3:
> >>>  - Register nvmm in targetos NetBSD check
> >>>  - Stop including hw/boards.h
> >>>  - Rephrase old code comments (remove XXX)
> >>> v1 -> v2:
> >>>  - Included the testing plan as requested by Philippe Mathieu-Daude
> >>>  - Formatting nit fix in qemu-options.hx
> >>>  - Document NVMM in the accel section of qemu-options.hx
> >>>
> >>> Maxime Villard (4):
> >>>   Add the NVMM vcpu API
> >>>   Add the NetBSD Virtual Machine Monitor accelerator.
> >>>   Introduce the NVMM impl
> >>>   Add the NVMM acceleration enlightenments
> >>>
> >>>  accel/stubs/Makefile.objs |    1 +
> >>>  accel/stubs/nvmm-stub.c   |   43 ++
> >>>  configure                 |   37 ++
> >>>  cpus.c                    |   58 ++
> >>>  include/sysemu/hw_accel.h |   14 +
> >>>  include/sysemu/nvmm.h     |   35 ++
> >>>  qemu-options.hx           |   16 +-
> >>>  target/i386/Makefile.objs |    1 +
> >>>  target/i386/helper.c      |    2 +-
> >>>  target/i386/nvmm-all.c    | 1226 +++++++++++++++++++++++++++++++++++=
++
> >>>  10 files changed, 1424 insertions(+), 9 deletions(-)
> >>>  create mode 100644 accel/stubs/nvmm-stub.c
> >>>  create mode 100644 include/sysemu/nvmm.h
> >>>  create mode 100644 target/i386/nvmm-all.c
> >>>
> >>> --
> >>> 2.25.0
> >>>
> >>>
> >>
> >
>=20

--=20
Eduardo


