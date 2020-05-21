Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671AFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3493C20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qJ8yxNE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3493C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcEP-0007Qb-B5
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7F-0002tf-25; Wed, 20 May 2020 23:43:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7C-0003Tm-JI; Wed, 20 May 2020 23:43:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SFnr2hwtz9sT8; Thu, 21 May 2020 13:43:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590032592;
 bh=JOC3I9CAO1gQokfZDDYIv1xerDCdFlfSPYuz9CpkVxs=;
 h=From:To:Cc:Subject:Date:From;
 b=qJ8yxNE6f8YCYFwiyEHO0m+5ZcldYuz3Yy6SWwKSMVH/7lYKGxCFkdPpd5Vjt5sQf
 iV4zdJmIgzgl7zVJcVNRlRD6uR0UOaljqzbJUXitmnUdEGEKnY3/3e/7WeC1wajSom
 Tj6pDUL/3gxd/QqPZUQcug5qXVBPTgNBrTAn7gDQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, frankja@linux.ibm.com,
 dgilbert@redhat.com, pair@us.ibm.com
Subject: [RFC v2 00/18] Refactor configuration of guest memory protection
Date: Thu, 21 May 2020 13:42:46 +1000
Message-Id: <20200521034304.340040-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
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
"guest-memory-protection" property pointing to a platform specific=0D
object which configures and manages the specific details.=0D
=0D
For now this series covers just AMD SEV and POWER PEF.  I'm hoping it=0D
can be extended to cover the Intel and s390 mechanisms as well,=0D
though.=0D
=0D
Note: I'm using the term "guest memory protection" throughout to refer=0D
to mechanisms like this.  I don't particular like the term, it's both=0D
long and not really precise.  If someone can think of a succinct way=0D
of saying "a means of protecting guest memory from a possibly=0D
compromised hypervisor", I'd be grateful for the suggestion.=0D
=0D
Changes since v1:=0D
 * Rebased=0D
 * Fixed some errors pointed out by Dave Gilbert=0D
=0D
David Gibson (18):=0D
  target/i386: sev: Remove unused QSevGuestInfoClass=0D
  target/i386: sev: Move local structure definitions into .c file=0D
  target/i386: sev: Rename QSevGuestInfo=0D
  target/i386: sev: Embed SEVState in SevGuestState=0D
  target/i386: sev: Partial cleanup to sev_state global=0D
  target/i386: sev: Remove redundant cbitpos and reduced_phys_bits=0D
    fields=0D
  target/i386: sev: Remove redundant policy field=0D
  target/i386: sev: Remove redundant handle field=0D
  target/i386: sev: Unify SEVState and SevGuestState=0D
  guest memory protection: Add guest memory protection interface=0D
  guest memory protection: Handle memory encrption via interface=0D
  guest memory protection: Perform KVM init via interface=0D
  guest memory protection: Move side effect out of=0D
    machine_set_memory_encryption()=0D
  guest memory protection: Rework the "memory-encryption" property=0D
  guest memory protection: Decouple kvm_memcrypt_*() helpers from KVM=0D
  guest memory protection: Add Error ** to=0D
    GuestMemoryProtection::kvm_init=0D
  spapr: Added PEF based guest memory protection=0D
  guest memory protection: Alter virtio default properties for protected=0D
    guests=0D
=0D
 accel/kvm/kvm-all.c                    |  40 +--=0D
 accel/kvm/sev-stub.c                   |   5 -=0D
 accel/stubs/kvm-stub.c                 |  10 -=0D
 backends/Makefile.objs                 |   2 +=0D
 backends/guest-memory-protection.c     |  29 ++=0D
 hw/core/machine.c                      |  61 ++++-=0D
 hw/i386/pc_sysfw.c                     |   6 +-=0D
 include/exec/guest-memory-protection.h |  77 ++++++=0D
 include/hw/boards.h                    |   4 +-=0D
 include/sysemu/kvm.h                   |  17 --=0D
 include/sysemu/sev.h                   |   6 +-=0D
 target/i386/sev.c                      | 351 +++++++++++++------------=0D
 target/i386/sev_i386.h                 |  49 ----=0D
 target/ppc/Makefile.objs               |   2 +-=0D
 target/ppc/pef.c                       |  81 ++++++=0D
 15 files changed, 441 insertions(+), 299 deletions(-)=0D
 create mode 100644 backends/guest-memory-protection.c=0D
 create mode 100644 include/exec/guest-memory-protection.h=0D
 create mode 100644 target/ppc/pef.c=0D
=0D
-- =0D
2.26.2=0D
=0D

