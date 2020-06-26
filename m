Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148EA20791
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2PZixbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148EA20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorD1-0004Y0-AN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorCD-0003Yn-5h
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:27:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jorCB-0002y6-8P
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593188838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsPEqPDH4ToqD9mzKS4gknfwwOvUmlzY+LlfZlDMoi0=;
 b=Y2PZixbXDBUCjJuCjmhEu6UiOXso+wzKl8ZJxqYQzDpKKcrqH/l5XsKLDcPc6FG42b+8Ir
 uLK/kNAJO/ugFHraxaHlKiV9xIhSmtuPNiQclDDQ49dSljfbexIbHE7XGpq8nncWPBrPQQ
 /PSUZSM3sZ/Y1nLTZy4u+sMrHEhBBmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-UbgJG4RlMgGhGoLpZrS8IA-1; Fri, 26 Jun 2020 12:27:16 -0400
X-MC-Unique: UbgJG4RlMgGhGoLpZrS8IA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB576800C64;
 Fri, 26 Jun 2020 16:27:14 +0000 (UTC)
Received: from turbo.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A5FC71668;
 Fri, 26 Jun 2020 16:27:13 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] Makefile: Compute libraries for libqemuutil.a and
 libvhost-user.a
Date: Fri, 26 Jun 2020 18:27:04 +0200
Message-Id: <20200626162706.3304357-2-dinechin@redhat.com>
In-Reply-To: <20200626162706.3304357-1-dinechin@redhat.com>
References: <20200626162706.3304357-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In util/Makefile.objs, there is a setting for dbus.o-libs.
Trying to copy-paste that to add a library for module.o that was was
not otherwise linked yields link errors on a number of binaries,
e.g. qemu-ga, with unsatisfied symbols in libqemuutil.a(module.o).
The reason is that library dependencies are not propagated to the .a
files automatically.

Adding a call to extract-libs to get the libraries for the two .a
files that are used elsewhere.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index a0092153af..b29b0eeefa 100644
--- a/Makefile
+++ b/Makefile
@@ -589,6 +589,8 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
 
+libqemuutil.a-libs += $(call extract-libs, $(util-obj-y) $(trace-obj-y) $(stub-obj-y))
+libvhost-user.a-libs += $(call extract-libs, $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y))
 libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
 libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
 
-- 
2.26.2


