Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38703C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF88D24655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF88D24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBX87-0004Kx-6J
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 01:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1jBX7L-0003Sx-BS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1jBX7J-0000IX-4t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:07:46 -0400
Received: from [107.174.27.60] (port=46184 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1jBX7H-0000DK-Ev; Tue, 10 Mar 2020 01:07:44 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 609F0AE80004;
 Tue, 10 Mar 2020 01:05:59 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v8 0/3] spapr: Kill SLOF
Date: Tue, 10 Mar 2020 16:07:30 +1100
Message-Id: <20200310050733.29805-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is another attempt to implement minimalistic
Open Firmware Client Interface in QEMU.

v8 is simplified to only support -kernel/-initrd;
this does not have early boot serial output (wait until Linux
initializes the serial console).

With this, I can boot unmodified Fedora 30 via petitboot
passed via -kernel/-initrd, the command line example is in 3/3.

A useful discussion happened esrlier:
https://lore.kernel.org/qemu-devel/f881c2e7-be92-9695-6e19-2dd88cbc63c1@o=
zlabs.ru/


This is based on sha1
6776047598c2 C=C3=A9dric Le Goater "spapr/xive: use SPAPR_IRQ_IPI to defi=
ne IPI ranges exposed to the guest".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  ppc/spapr: Move GPRs setup to one place
  spapr/cas: Separate CAS handling from rebuilding the FDT
  spapr: Implement Open Firmware client interface

 hw/ppc/Makefile.objs            |    1 +
 pc-bios/vof/Makefile            |   18 +
 include/hw/ppc/spapr.h          |   26 +-
 include/hw/ppc/spapr_cpu_core.h |    4 +-
 pc-bios/vof/vof.h               |   44 ++
 hw/ppc/spapr.c                  |   69 +-
 hw/ppc/spapr_cpu_core.c         |    6 +-
 hw/ppc/spapr_hcall.c            |   73 ++-
 hw/ppc/spapr_of_client.c        | 1094 +++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c             |    2 +-
 pc-bios/vof/bootmem.c           |   13 +
 pc-bios/vof/ci.c                |  108 +++
 pc-bios/vof/libc.c              |   91 +++
 pc-bios/vof/main.c              |   22 +
 hw/ppc/trace-events             |   21 +
 pc-bios/README                  |    2 +
 pc-bios/vof.bin                 |  Bin 0 -> 3680 bytes
 pc-bios/vof/entry.S             |   51 ++
 pc-bios/vof/l.lds               |   48 ++
 19 files changed, 1649 insertions(+), 44 deletions(-)
 create mode 100644 pc-bios/vof/Makefile
 create mode 100644 pc-bios/vof/vof.h
 create mode 100644 hw/ppc/spapr_of_client.c
 create mode 100644 pc-bios/vof/bootmem.c
 create mode 100644 pc-bios/vof/ci.c
 create mode 100644 pc-bios/vof/libc.c
 create mode 100644 pc-bios/vof/main.c
 create mode 100755 pc-bios/vof.bin
 create mode 100644 pc-bios/vof/entry.S
 create mode 100644 pc-bios/vof/l.lds

--=20
2.17.1


