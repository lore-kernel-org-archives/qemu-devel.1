Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA8AC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4E720731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDDZIFkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4E720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioPY3-0008BL-W6
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ioPXS-0007kE-C1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ioPXQ-0005Q7-KV
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:23:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ioPXQ-0005NW-4q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578306187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hw6J5kZsWwhKgHxF+6JBLQJaNpezIbMZrGhIquo7Y/k=;
 b=PDDZIFkWw1lFao20AcMOmMAlluxwwNnB31iOOvsBIdZDbDrCOrE1rFn2uURlLrJUE2Ce9K
 Cxuuo2QhTIHjIn7jXCfx3gIIHptxihcfPVFRpdrlWlXvaX7t6ar4VixLUd8NNKMZulCUOu
 iWZLmkaH9kH23/dpKlWl6+Tn17/W8/c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Su3frtxuMQm-it3Y91x52g-1; Mon, 06 Jan 2020 05:23:03 -0500
Received: by mail-qv1-f71.google.com with SMTP id dw11so10851885qvb.16
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 02:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8r1zHEtFdL7OBAM8CXmsr+82h7zOHA5y7+KsVEF2Eeo=;
 b=ma67rOjgmCoW54iMEyvn0gMCEWJdaYqrgKP+3B76SgQSyWK2rsigbKWIV1mw9WGbn6
 zZSaDXpeH1vXgMMhdPuHLG1id1x23mEOZzumF8kz+ByWGg7N2CYqPk1qLR4M/Px9sqMp
 3HydYyNHci2pg7Ub/C9stwRymSYJIpjJqPbSsYKakPVOKiZ9C/X6ThV4Rn3GlyRvgCMD
 f4C0LmSoHv8UClWht1xkEM1dCnE0hybJxhbaf0UPpg0vaGq3p7PAO0q2HrUPs1x9oTxO
 XwDxfwQlwcak72vZE/0wvvGLJ6aatveoZ0A4HjwSUNUaCGl+6KpOCR6ri9mRamku6dBF
 xEKw==
X-Gm-Message-State: APjAAAWabxFBxTD4beSsYXr7WdOPxGJnWatPccOsr3FemTCtin1j5UE1
 zXhuf5cNnFPeFgF+6lJ4hgrvVzhdwHncUA27dUbO5lWQ0dR4MdFhi3E77eC0L2ENsHs/8u/+wA4
 O+D9ptGjb3VieM0g=
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr71610914qth.85.1578306183404; 
 Mon, 06 Jan 2020 02:23:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJ942GFhmz8xCu0tLuVlLPM7n86y1l9zd/50cEBUKjXji7u9zYMBsPJGr/i2/UH1nIe59/6A==
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr71610902qth.85.1578306183200; 
 Mon, 06 Jan 2020 02:23:03 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id l35sm21685128qtl.12.2020.01.06.02.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 02:23:01 -0800 (PST)
Date: Mon, 6 Jan 2020 05:22:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH for-5.0 v2 0/9] q35: CPU hotplug with secure boot, part 1+2
Message-ID: <20200106052210-mutt-send-email-mst@kernel.org>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
 <20200106111020.68e746da@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200106111020.68e746da@redhat.com>
X-MC-Unique: Su3frtxuMQm-it3Y91x52g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: lersek@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 11:10:20AM +0100, Igor Mammedov wrote:
> On Mon,  9 Dec 2019 14:08:53 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > ChangeLog:
> >   * since v1:
> >       - include "hw: add compat machines for 5.0" to provide
> >         compat context for 4.2 machine types
> >       - add comment that SMRAM at SMBASE is QEMU hack
> >         and why it was used
> >       - split command data 2 into a separate patch
> >           "acpi: cpuhp: introduce 'Command data 2' field"
> >       - rewrite enabling/detecting modern CPU hotplug interface
> >         to use existing CPHP_GET_NEXT_CPU_WITH_EVENT_CMD and
> >         squash it into "acpi: cpuhp: spec: add typical usecases" patch
> >       - "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command"
> >         modulo 'Command data 2' being moved out into separate patch,
> >         rewrite commit message to explain better why new command is nee=
ded.
> >  =20
> >=20
> > Series consists of 2 parts: 1st is lockable SMRAM at SMBASE
> > and the 2nd better documents interface and adds means to
> > enumerate APIC IDs for possible CPUs.
> >=20
> > 1st part [1-2/9]:
> >  In order to support CPU hotplug in secure boot mode,
> >  UEFI firmware needs to relocate SMI handler of hotplugged CPU,
> >  in a way that won't allow ring 0 user to break in priveleged
> >  SMM mode that firmware maintains during runtime.
> >  Used approach allows to hide RAM at default SMBASE to make it
> >  accessible only to SMM mode, which lets us to make sure that
> >  SMI handler installed by firmware can not be hijacked by
> >  unpriveleged user (similar to TSEG behavior).=20
> >=20
> > 2nd part:
> >  mostly fixes and extra documentation on how to detect and use
> >  modern CPU hotplug interface (MMIO block).
> >  So firmware could reuse it for enumerating possible CPUs and
> >  detecting hotplugged CPU(s). It also adds support for
> >  CPHP_GET_CPU_ID_CMD command [7/8], which should allow firmware
> >  to fetch APIC IDs for possible CPUs which is necessary for
> >  initializing internal structures for possible CPUs on boot.
>=20
> ping,
>=20
> Michael,
> could you merge series via your tree?
>=20
> (PS: series still applies fine to today's master)


I'm still waiting for Peter to apply my previous pull.
Will queue after that, thanks!

> >=20
> > CC: mst@redhat.com
> > CC: pbonzini@redhat.com
> > CC: lersek@redhat.com
> > CC: philmd@redhat.com
> >=20
> >=20
> > Cornelia Huck (1):
> >   hw: add compat machines for 5.0
> >=20
> > Igor Mammedov (8):
> >   q35: implement 128K SMRAM at default SMBASE address
> >   tests: q35: MCH: add default SMBASE SMRAM lock test
> >   acpi: cpuhp: spec: clarify 'CPU selector' register usage and
> >     endianness
> >   acpi: cpuhp: spec: fix 'Command data' description
> >   acpi: cpuhp: spec: clarify store into 'Command data' when 'Command
> >     field' =3D=3D 0
> >   acpi: cpuhp: introduce 'Command data 2' field
> >   acpi: cpuhp: spec: add typical usecases
> >   acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
> >=20
> >  include/hw/boards.h             |   3 ++
> >  include/hw/i386/pc.h            |   3 ++
> >  include/hw/pci-host/q35.h       |  10 ++++
> >  docs/specs/acpi_cpu_hotplug.txt |  89 +++++++++++++++++++++++++++-----=
--
> >  hw/acpi/cpu.c                   |  18 +++++++
> >  hw/acpi/trace-events            |   1 +
> >  hw/arm/virt.c                   |   7 ++-
> >  hw/core/machine.c               |   3 ++
> >  hw/i386/pc.c                    |   5 ++
> >  hw/i386/pc_piix.c               |  14 +++++-
> >  hw/i386/pc_q35.c                |  13 ++++-
> >  hw/pci-host/q35.c               |  84 +++++++++++++++++++++++++++++---
> >  hw/ppc/spapr.c                  |  15 +++++-
> >  hw/s390x/s390-virtio-ccw.c      |  14 +++++-
> >  tests/q35-test.c                | 105 ++++++++++++++++++++++++++++++++=
++++++++
> >  15 files changed, 354 insertions(+), 30 deletions(-)
> >=20


