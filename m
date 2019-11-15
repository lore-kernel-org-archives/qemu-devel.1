Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD073C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A29206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJClVCXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A29206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVg4d-0003lr-0p
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 13:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iVg1X-0000hW-N0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iVg1W-00025d-Ly
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:08:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iVg1W-00024Z-Hn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573841326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbxKVyX7c5DGLj0LBTUQMVlsCIRvYGzBP6qnF3v3a0s=;
 b=OJClVCXddUvuuTbOMaQprK9XgC5JMg1sMa92Kg+pAtX7r9ccM640nQ5UDWks4w8YYvmgTA
 bbHqGf/0BmeA8Q9TUXxI3wmtq9ULdSrHX/tMJXtIJdUUoJMfqVvA9f1HmmT48wGMMgXM2b
 Ylwpcvkasp+XkJL2BHM2/RsWHQHl6z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-9UrTNzNHOBuHeDveEh2rEw-1; Fri, 15 Nov 2019 13:08:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC2718B5F68;
 Fri, 15 Nov 2019 18:08:40 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 675EF60557;
 Fri, 15 Nov 2019 18:08:39 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] python/qemu: accel: Add tcg_available() method
Date: Fri, 15 Nov 2019 13:08:29 -0500
Message-Id: <20191115180829.10275-5-wainersm@redhat.com>
In-Reply-To: <20191115180829.10275-1-wainersm@redhat.com>
References: <20191115180829.10275-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9UrTNzNHOBuHeDveEh2rEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a method to check if the tcg accelerator is enabled
in the QEMU binary.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 python/qemu/accel.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 1978fbee4e..513904d46d 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -69,3 +69,11 @@ def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
     if qemu_bin and "kvm" not in list_accel(qemu_bin):
         return False
     return True
+
+def tcg_available(qemu_bin):
+    """
+    Check if TCG is available.
+
+    @param qemu_bin (str): path to the QEMU binary
+    """
+    return 'tcg' in list_accel(qemu_bin)
--=20
2.18.1


