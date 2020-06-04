Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A722A2065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VhGOYhHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A722A2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjdG-0000wa-Qe
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaD-0004yN-R2
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: from ozlabs.org ([203.11.71.1]:45271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaB-0000ms-Q6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6C0C7Pz9sSg; Thu,  4 Jun 2020 16:42:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252947;
 bh=IUFMoEbkcs8o6aiX40egsNr2FfcrirDbeyetkgE7SVM=;
 h=From:To:Cc:Subject:Date:From;
 b=VhGOYhHgSI2buOMRy8gV2fCllPdg0yDXqCWtWQw9boI2+v2coQZVNMVXAafg9062Z
 z9i1ZTsX5eyy9mOBSQJBWpOPBPdeXW1240geDjpRLgSeHii7bMMrdxGryrM+XgxO9C
 uq8KKBGeYjjzsjBEOj8LUacA5kT7sC5hcAVRPul4=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/9] AMD SEV: Cleanup state handling
Date: Thu,  4 Jun 2020 16:42:10 +1000
Message-Id: <20200604064219.436242-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 brijesh.singh@amd.com, dgilbert@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series has an assortment of cleanups to the AMD SEV memory=0D
encryption code.  Amongst other things it:=0D
  * Removes the confusion between struct SEVState and enum SevState=0D
  * Reduces use of global variables=0D
  * Unifies some ad-hoc structures with an existing QOM object=0D
=0D
I made these changes along the way to building a framework for common=0D
handling of mechanisms for protecting guests from compromised hosts=0D
(such as AMD SEV, IBM's PEF and others).  However, I think the changes=0D
make sense on their own, so I'm sending them for inclusion now, while=0D
finishing the polish on the rest of those patches.=0D
=0D
Please apply.=0D
=0D
David Gibson (9):=0D
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
=0D
 target/i386/sev.c      | 257 +++++++++++++++++++++++------------------=0D
 target/i386/sev_i386.h |  49 --------=0D
 2 files changed, 143 insertions(+), 163 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

