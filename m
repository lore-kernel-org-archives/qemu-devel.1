Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F4EC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90D5206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPBuMTW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90D5206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThAx-00072T-PU
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1x-0007tp-R0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003xd-C9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1g-0003ur-7P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuKMz2cunkuyvgsHrtA6mHRQurhlf+Q6ZpdMc5OyeVA=;
 b=YPBuMTW12EnWYveR326vcqxkUUOw4frNJbAtyhAipiuA0hgFz5JL6whaTMw2e4O+Mnfxbt
 9gurWbor2RBwrMN0b2Sq0sbQH2yv2DuyF1tAnNRAHqhKp6IUTJyzEvcYv19xLPoYOp81kT
 0wqxC3oboz2YgAv5ig0GfGr4fNLkklE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-PhhyA91fOTm_1kO8hKGi9g-1; Wed, 29 Apr 2020 03:20:55 -0400
X-MC-Unique: PhhyA91fOTm_1kO8hKGi9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB9DFBFC5;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75ED25D779;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BA1911358D0; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] xen/pt: Fix flawed conversion to realize()
Date: Wed, 29 Apr 2020 09:20:35 +0200
Message-Id: <20200429072048.29963-20-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The conversion of xen_pt_initfn() to xen_pt_realize() blindly replaced
XEN_PT_ERR() by error_setg().  Several error conditions that did not
fail xen_pt_initfn() now fail xen_pt_realize().  Unsurprisingly, the
cleanup on these errors looks highly suspicious.

Revert the inappropriate replacements.

Fixes: 5a11d0f7549e24a10e178a9dc8ff5e698031d9a6
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20200422130719.28225-10-armbru@redhat.com>
---
 hw/xen/xen_pt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index b91082cb8b..81d5ad8da7 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -858,8 +858,8 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
=20
     rc =3D xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
     if (rc < 0) {
-        error_setg_errno(errp, errno, "Mapping machine irq %u to"
-                         " pirq %i failed", machine_irq, pirq);
+        XEN_PT_ERR(d, "Mapping machine irq %u to pirq %i failed, (err: %d)=
\n",
+                   machine_irq, pirq, errno);
=20
         /* Disable PCI intx assertion (turn on bit10 of devctl) */
         cmd |=3D PCI_COMMAND_INTX_DISABLE;
@@ -880,8 +880,8 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
                                        PCI_SLOT(d->devfn),
                                        e_intx);
         if (rc < 0) {
-            error_setg_errno(errp, errno, "Binding of interrupt %u failed"=
,
-                             e_intx);
+            XEN_PT_ERR(d, "Binding of interrupt %i failed! (err: %d)\n",
+                       e_intx, errno);
=20
             /* Disable PCI intx assertion (turn on bit10 of devctl) */
             cmd |=3D PCI_COMMAND_INTX_DISABLE;
@@ -889,8 +889,8 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
=20
             if (xen_pt_mapped_machine_irq[machine_irq] =3D=3D 0) {
                 if (xc_physdev_unmap_pirq(xen_xc, xen_domid, machine_irq))=
 {
-                    error_setg_errno(errp, errno, "Unmapping of machine"
-                            " interrupt %u failed", machine_irq);
+                    XEN_PT_ERR(d, "Unmapping of machine interrupt %i faile=
d!"
+                               " (err: %d)\n", machine_irq, errno);
                 }
             }
             s->machine_irq =3D 0;
--=20
2.21.1


