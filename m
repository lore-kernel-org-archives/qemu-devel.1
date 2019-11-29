Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF13C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B66207FA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B27fB5/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B66207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZ1B-0005Ne-9l
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 00:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaYv5-0002jQ-Rx
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaYuv-0002x5-CW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:34:17 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaYuv-0002Lr-0w; Fri, 29 Nov 2019 00:34:09 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PNTz4HYxz9sPv; Fri, 29 Nov 2019 16:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575005639;
 bh=0HM60uAYu+yKL7iLi6nzmDD9IX9aj5HEoBJPQL/u0sw=;
 h=From:To:Cc:Subject:Date:From;
 b=B27fB5/qKVH+dZlrwh8cU0TxTPGkHFtz1qk9XWyTkstEQiTR8JVDZQMRqS4GnHUNu
 xcDWkG4QLCSfmVt4VRIarqiCKkmmOU0XPzSo7n2vIuePgCu94H1HObiwi73jZOlY5D
 dNf2lBeYQoLql7R4Gi5skyYK3VwZ7Gq88CPrVebg=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org
Subject: [for-5.0 0/4] spapr: Improvements to CAS feature negotiation
Date: Fri, 29 Nov 2019 16:33:52 +1100
Message-Id: <20191129053356.232413-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains several cleanups to the handling of the
ibm,client-architecture-support firmware call used for boot time
feature negotiation between the guest OS and the firmware &
hypervisor.

Mostly it's just internal polish, but one significant user visible
change is that we no longer generate an extra CAS reboot to switch
between XICS and XIVE interrupt modes (by far the most common cause of
CAS reboots in practice).

David Gibson (4):
  spapr: Don't trigger a CAS reboot for XICS/XIVE mode changeover
  spapr: Improve handling of fdt buffer size
  spapr: Fold h_cas_compose_response() into
    h_client_architecture_support()
  spapr: Simplify ovec diff

 hw/ppc/spapr.c              | 92 +++----------------------------------
 hw/ppc/spapr_hcall.c        | 90 +++++++++++++++++++++++++-----------
 hw/ppc/spapr_ovec.c         | 30 ++++--------
 include/hw/ppc/spapr.h      |  4 +-
 include/hw/ppc/spapr_ovec.h |  4 +-
 5 files changed, 83 insertions(+), 137 deletions(-)

--=20
2.23.0


