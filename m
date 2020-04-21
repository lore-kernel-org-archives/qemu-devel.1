Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79590C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC81206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejNAeK7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC81206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQwIy-0001rH-BR
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 13:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jQwIE-0001RS-Rb
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jQwID-0002vH-KX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:02:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jQwIB-0002p9-EO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 13:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587488556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sd7P9j7+qRTdkSrai+v3sQLzTQm13BqzZkEdh5l0EJ8=;
 b=ejNAeK7OmMosA41HtcrV7+uaYCnCIA8YpjB8VTpRJGvw9kMXF30Ynx2vF24KcaHrKQUOzR
 J+3RD8w4kpC4TRSMYq1PzDltAjihuAOsn/dd4CuDkxreu3MCmmvwowy10ckswsXlGmNqr8
 RwdxE7gl+PELmhR9euKunCC6S2/Kwp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-hRqPObuGOOaMhYwlb7HKLA-1; Tue, 21 Apr 2020 13:02:34 -0400
X-MC-Unique: hRqPObuGOOaMhYwlb7HKLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221E38017FC;
 Tue, 21 Apr 2020 17:02:33 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04E6F19C70;
 Tue, 21 Apr 2020 17:02:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] slirp: update to fix CVE-2020-1983
Date: Tue, 21 Apr 2020 19:02:27 +0200
Message-Id: <20200421170227.843555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 11:47:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: samuel.thibault@ens-lyon.org, philmd@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an update on the stable-4.2 branch of libslirp.git:

git shortlog 55ab21c9a3..2faae0f778f81

Marc-Andr=C3=A9 Lureau (1):
      Fix use-afte-free in ip_reass() (CVE-2020-1983)

CVE-2020-1983 is actually a follow up fix for commit
126c04acbabd7ad32c2b018fe10dfac2a3bc1210 ("Fix heap overflow in
ip_reass on big packet input") which was was included in qemu
v4.1 (commit e1a4a24d262ba5ac74ea1795adb3ab1cd574c7fb "slirp: update
with CVE-2019-14378 fix").

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 55ab21c9a36..2faae0f778f 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba
+Subproject commit 2faae0f778f818fadc873308f983289df697eb93
--=20
2.26.0.106.g9fadedd637


