Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C347FC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DC9218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DC9218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIbu-0007xj-My
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZZ-0005HB-MI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZY-0005kJ-3j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:23:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZV-0005fg-2h; Fri, 05 Jul 2019 03:23:53 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 18B1ABF607;
 Fri,  5 Jul 2019 07:23:49 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:17 +0200
Message-Id: <20190705072333.17171-1-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 00/16] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
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
Cc: kwolf@redhat.com, matt.fitzpatrick@oakgatetech.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Matt Fitzpatrick's post ("[RFC,v1] Namespace Management Support") pushed
me to finally get my head out of my a** and post this series.

This is basically a follow-up to my previous series ("nvme: v1.3, sgls,
metadata and new 'ocssd' device"), but I'm not tagging it as a v2
because the patches for metadata and the ocssd device have been dropped.
Instead, this series also includes a patch that enables support for
multiple namespaces in a "proper" way by adding a new 'nvme-ns' device
model such that the "real" nvme device is composed of the 'nvme' device
model (the core controller) and multiple 'nvme-ns' devices that model
the namespaces.

All in all, the patches in this series should be less controversial, but
I know there is a lot to go through. I've kept commit 011de3d531b6
("nvme: refactor device realization") as a single commit, but I can chop
it up if any reviwers would prefer that, but the series is already at 16
patches. The refactor patch is basically just code movement.

At a glance, this series:

  - generally fixes up the device to be as close to NVMe 1.3d compliant a=
s
    possible (in terms of 'mandatory' features) by:
      - adding proper setting of the SUBNQN and VER fields
      - supporting the Abort command
      - supporting the Asynchronous Event Request command
      - supporting the Get Log Page command
      - providing reasonable stub responses to Get/Set Feature command of
        mandatory features
  - adds support for scatter gather lists (SGLs)
  - simplifies DMA/CMB mappings and support PRPs/SGLs in the CMB
  - adds support for multiple block requests per nvme request (this is
    useful for future support for metadata, OCSSD 2.0 vector requests
    and upcoming zoned namespaces)
  - adds support for multiple namespaces


Thanks to everyone who chipped in on the discussion on multiple
namespaces! You're CC'ed ;)


Klaus Birkelund Jensen (16):
  nvme: simplify namespace code
  nvme: move device parameters to separate struct
  nvme: fix lpa field
  nvme: add missing fields in identify controller
  nvme: populate the mandatory subnqn and ver fields
  nvme: support completion queue in cmb
  nvme: support Abort command
  nvme: refactor device realization
  nvme: support Asynchronous Event Request command
  nvme: support Get Log Page command
  nvme: add missing mandatory Features
  nvme: bump supported NVMe revision to 1.3d
  nvme: simplify dma/cmb mappings
  nvme: support multiple block requests per request
  nvme: support scatter gather lists
  nvme: support multiple namespaces

 block/nvme.c           |   18 +-
 hw/block/Makefile.objs |    2 +-
 hw/block/nvme-ns.c     |  139 ++++
 hw/block/nvme-ns.h     |   35 +
 hw/block/nvme.c        | 1629 ++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h        |   99 ++-
 hw/block/trace-events  |   24 +-
 include/block/nvme.h   |  130 +++-
 8 files changed, 1739 insertions(+), 337 deletions(-)
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

--=20
2.20.1


