Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E377C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FD124684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYiOmV26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FD124684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuav8-0001L6-0B
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuarH-0004vg-Oa
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuarF-0003oM-V8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuarF-0003nZ-OR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/xHqG5aDvxlK3LgnSR+6VrUTOuP0qIe/I40iPzyD8I=;
 b=FYiOmV26IXpLhvvYcjf7zegaKvWaiRyohhQRE9oNiLSmU/iSglF5NlvM15ftTspShTEiIB
 74MALnGdrSOWk0L2Jl1k3LSwfIiGgsjiPGp+Zeih0gOctmUkus+nqxz+QukckWWMgJh0Qu
 DBaZaxd1NDS3Quu2icwy2ojSndqZaRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-jRPQAPmWPASmhEBiDUm2ng-1; Thu, 23 Jan 2020 06:41:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91199800D54
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:41:06 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3C9C10016E8;
 Thu, 23 Jan 2020 11:41:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 01/80] numa: remove deprecated -mem-path fallback to
 anonymous RAM
Date: Thu, 23 Jan 2020 12:37:26 +0100
Message-Id: <1579779525-20065-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jRPQAPmWPASmhEBiDUm2ng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

it has been deprecated since 4.0 by commit
 cb79224b7 (deprecate -mem-path fallback to anonymous RAM)
Deprecation period ran out and it's time to remove it
so it won't get in a way of switching to using hostmem
backend for RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC:libvir-list@redhat.com
CC: ehabkost@redhat.com
---
 hw/core/numa.c       | 18 +-----------------
 qemu-deprecated.texi |  9 ---------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 0d1b4be..840e685 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -784,24 +784,8 @@ static void allocate_system_memory_nonnuma(MemoryRegio=
n *mr, Object *owner,
 {
     if (mem_path) {
 #ifdef __linux__
-        Error *err =3D NULL;
         memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &err);
-        if (err) {
-            error_report_err(err);
-            if (mem_prealloc) {
-                exit(1);
-            }
-            warn_report("falling back to regular RAM allocation");
-            error_printf("This is deprecated. Make sure that -mem-path "
-                         " specified path has sufficient resources to allo=
cate"
-                         " -m specified RAM amount\n");
-            /* Legacy behavior: if allocation failed, fall back to
-             * regular RAM allocation.
-             */
-            mem_path =3D NULL;
-            memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &e=
rror_fatal);
-        }
+                                         mem_path, &error_fatal);
 #else
         fprintf(stderr, "-mem-path not supported on this host\n");
         exit(1);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 0968d37..982af95 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -113,15 +113,6 @@ QEMU using implicit generic or board specific splittin=
g rule.
 Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} =
(if
 it's supported by used machine type) to define mapping explictly instead.
=20
-@subsection -mem-path fallback to RAM (since 4.1)
-Currently if guest RAM allocation from file pointed by @option{mem-path}
-fails, QEMU falls back to allocating from RAM, which might result
-in unpredictable behavior since the backing file specified by the user
-is ignored. In the future, users will be responsible for making sure
-the backing storage specified with @option{-mem-path} can actually provide
-the guest RAM configured with @option{-m} and QEMU will fail to start up i=
f
-RAM allocation is unsuccessful.
-
 @subsection RISC-V -bios (since 4.1)
=20
 QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for th=
e
--=20
2.7.4


