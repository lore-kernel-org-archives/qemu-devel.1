Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639F2C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C22B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="RvFO/gWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C22B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGHm-0004Fp-7v
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a809679a8b237614dcd050ea1f7e72e97638c0ba@lizzy.crudebyte.com>)
 id 1jEGGh-0003Km-Hx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a809679a8b237614dcd050ea1f7e72e97638c0ba@lizzy.crudebyte.com>)
 id 1jEGGg-00005G-Ao
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:44:43 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:54081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <a809679a8b237614dcd050ea1f7e72e97638c0ba@lizzy.crudebyte.com>)
 id 1jEGGf-0003NH-Qs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=7iID3mk+2e4wEusfddIqxklPf8tGYhW55AoLvQNF9r4=; b=RvFO/
 gWXFd4LYoFfAxLKUM56lj8J6pcFkTPtgKGwBg3J2rdiOqJFYlYTfJ09+qc+rMmCLInM1Imh1TNmQu
 kvqPv14a+l1xpVxbyEB/xhGtPF4dqcGP6MFhb/UDkgT5bN65hWb2PHkyFFYtYEXfl2dXF7iX2sIw3
 zETTyvCbcNmotDOAb2QT786ciwY/WQSvSGKmmKE5YGTk4vW1i7C4YOS5IRYNUAyVoZQGn9OEhAlRs
 S6CzHDW/gQCC7nhXRAxafeHSDqxUOBXh5rlZUt1u919o8ZrOWCUCajcC0E4CheHRFgvkohGReLnlP
 qpMy+yHuOzGp+a5kURgygpjNB8C2Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 17 Mar 2020 17:38:15 +0100
Subject: [PATCH 0/1] add support for QEMU 9pfs 'multidevs' option
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org,
    Greg Kurz <groug@kaod.org>
Message-Id: <E1jEFpH-00028X-1c@lizzy.crudebyte.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU 4.2 added a new option 'multidevs' for 9pfs. The following patch adds
support for this new option to libvirt.

In short, what is this about: to distinguish files uniquely from each other
in general, numeric file IDs are typically used for comparison, which in
practice is the combination of a file's device ID and the file's inode
number. Unfortunately 9p protocol's QID field used for this purpose,
currently is too small to fit both the device ID and inode number in, which
hence is a problem if one 9pfs export contains multiple devices and may
thus lead to misbheaviours on guest (e.g. with SAMBA file servers) in that
case due to potential file ID collisions.

To mitigate this problem with 9pfs a 'multidevs' option was introduced in
QEMU 4.2 for defining how to deal with this, e.g. multidevs=remap will cause
QEMU's 9pfs implementation to remap all inodes from host side to different
inode numbers on guest side in a way that prevents file ID collisions.

NOTE: In the libvirt docs changes of this libvirt patch I simply assumed
"since 6.2.0". So the final libvirt version number would need to be adjusted
in that text if necessary.

See QEMU discussion with following Message-ID for details:
8a2ffe17fda3a86b9a5a437e1245276881f1e235.1567680121.git.qemu_oss@crudebyte.com

Christian Schoenebeck (1):
  conf: qemu 9pfs: add 'multidevs' option

 docs/formatdomain.html.in     | 47 ++++++++++++++++++++++++++++++++++-
 docs/schemas/domaincommon.rng | 10 ++++++++
 src/conf/domain_conf.c        | 30 ++++++++++++++++++++++
 src/conf/domain_conf.h        | 13 ++++++++++
 src/qemu/qemu_command.c       |  7 ++++++
 5 files changed, 106 insertions(+), 1 deletion(-)

-- 
2.20.1


