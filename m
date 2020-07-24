Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99968C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BF920737
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C5PGevUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BF920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyny2-0004WD-K1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 23:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuM-0007FY-Bc; Thu, 23 Jul 2020 22:58:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60169 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuJ-00060E-AU; Thu, 23 Jul 2020 22:58:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlv1BKjz9sRN; Fri, 24 Jul 2020 12:57:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559467;
 bh=g66FwVz1r6nGsK6XJ5UcsyTZuDIgWFh7d1+V/6AC+0I=;
 h=From:To:Cc:Subject:Date:From;
 b=C5PGevUJgzVOgAIu9G1YJhVIdy5YZzXT+TIXBMNYd8rze8zDPZv1/8gf29OGzcCak
 ATvVaZzSVokHz9AhNsJE1rtRAYtsBidm6G0Lzm0Tm4MbDJ8y+aiBC7OIzzEzqzEBN8
 qbj5gC930eEbwMu5xJee3GuQS/SvIHYplFgh53EY=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 00/10] Generalize memory encryption models
Date: Fri, 24 Jul 2020 12:57:34 +1000
Message-Id: <20200724025744.69644-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:57:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A number of hardware platforms are implementing mechanisms whereby the=0D
hypervisor does not have unfettered access to guest memory, in order=0D
to mitigate the security impact of a compromised hypervisor.=0D
=0D
AMD's SEV implements this with in-cpu memory encryption, and Intel has=0D
its own memory encryption mechanism.  POWER has an upcoming mechanism=0D
to accomplish this in a different way, using a new memory protection=0D
level plus a small trusted ultravisor.  s390 also has a protected=0D
execution environment.=0D
=0D
The current code (committed or draft) for these features has each=0D
platform's version configured entirely differently.  That doesn't seem=0D
ideal for users, or particularly for management layers.=0D
=0D
AMD SEV introduces a notionally generic machine option=0D
"machine-encryption", but it doesn't actually cover any cases other=0D
than SEV.=0D
=0D
This series is a proposal to at least partially unify configuration=0D
for these mechanisms, by renaming and generalizing AMD's=0D
"memory-encryption" property.  It is replaced by a=0D
"host-trust-limitation" property pointing to a platform specific=0D
object which configures and manages the specific details.=0D
=0D
Please apply.=0D
=0D
Changes since v3:=0D
 * Rebased=0D
 * Added first cut at handling of s390 protected virtualization=0D
Changes since RFCv2:=0D
 * Rebased=0D
 * Removed preliminary SEV cleanups (they've been merged)=0D
 * Changed name to "host trust limitation"=0D
 * Added migration blocker to the PEF code (based on SEV's version)=0D
Changes since RFCv1:=0D
 * Rebased=0D
 * Fixed some errors pointed out by Dave Gilbert=0D
=0D
David Gibson (10):=0D
  host trust limitation: Introduce new host trust limitation interface=0D
  host trust limitation: Handle memory encryption via interface=0D
  host trust limitation: Move side effect out of=0D
    machine_set_memory_encryption()=0D
  host trust limitation: Rework the "memory-encryption" property=0D
  host trust limitation: Decouple kvm_memcrypt_*() helpers from KVM=0D
  host trust limitation: Add Error ** to HostTrustLimitation::kvm_init=0D
  spapr: Add PEF based host trust limitation=0D
  spapr: PEF: block migration=0D
  host trust limitation: Alter virtio default properties for protected=0D
    guests=0D
  s390: Recognize host-trust-limitation option=0D
=0D
 accel/kvm/kvm-all.c                  |  40 ++------=0D
 accel/kvm/sev-stub.c                 |   7 +-=0D
 accel/stubs/kvm-stub.c               |  10 --=0D
 backends/Makefile.objs               |   2 +=0D
 backends/host-trust-limitation.c     |  29 ++++++=0D
 hw/core/machine.c                    |  61 +++++++++--=0D
 hw/i386/pc_sysfw.c                   |   6 +-=0D
 hw/s390x/pv.c                        |  61 +++++++++++=0D
 include/exec/host-trust-limitation.h |  72 +++++++++++++=0D
 include/hw/boards.h                  |   2 +-=0D
 include/qemu/typedefs.h              |   1 +=0D
 include/sysemu/kvm.h                 |  17 ---=0D
 include/sysemu/sev.h                 |   4 +-=0D
 target/i386/sev.c                    | 148 ++++++++++++---------------=0D
 target/ppc/Makefile.objs             |   2 +-=0D
 target/ppc/pef.c                     |  89 ++++++++++++++++=0D
 16 files changed, 387 insertions(+), 164 deletions(-)=0D
 create mode 100644 backends/host-trust-limitation.c=0D
 create mode 100644 include/exec/host-trust-limitation.h=0D
 create mode 100644 target/ppc/pef.c=0D
=0D
-- =0D
2.26.2=0D
=0D

