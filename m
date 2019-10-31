Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52539CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7372083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRCvVrQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7372083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ6H7-0005On-6m
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iQ6DD-00015d-LV
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iQ6DB-0001xh-PU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:53:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iQ6DB-0001v4-F5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572512024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdSy+kBrZyZz/ZERSLF95D3gB0uTP/50qlP1+0wcOCs=;
 b=cRCvVrQIY1uD85Bqri44oQDK406360+HEE7OgZkqyBDHrNfenGh9n5qsm1BbyRUMt9MuGe
 Na26xhGkEUhdqPdj/j6kiOS/j2jvFf6ztCbzZhLJHx1ZTWkjtl0GbeAM75XOBgsZd1fRZl
 m+kjsDKz+gjcugw5AoZNHqWTMjX0aGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-X0fifbqQPrqGVkTaaRxlFQ-1; Thu, 31 Oct 2019 04:53:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7095801E7E
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 08:53:41 +0000 (UTC)
Received: from lupin.home.kraxel.org (ovpn-116-222.ams2.redhat.com
 [10.36.116.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E370C5C21B;
 Thu, 31 Oct 2019 08:53:38 +0000 (UTC)
Received: by lupin.home.kraxel.org (Postfix, from userid 1000)
 id 7C7A66114A3E; Thu, 31 Oct 2019 09:53:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/4] tests/vm: use console_consume for netbsd
Date: Thu, 31 Oct 2019 09:53:05 +0100
Message-Id: <20191031085306.28888-4-kraxel@redhat.com>
In-Reply-To: <20191031085306.28888-1-kraxel@redhat.com>
References: <20191031085306.28888-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: X0fifbqQPrqGVkTaaRxlFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use new helper to read all pending console output,
not just a single char.  Unblocks installer boot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/netbsd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 5e04dcd9b1..d1bccccfd0 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):
         for char in list("5consdev com0\n"):
             time.sleep(0.2)
             self.console_send(char)
-            self.console_wait("")
+            self.console_consume()
         self.console_wait_send("> ", "boot\n")
=20
         self.console_wait_send("Terminal type",            "xterm\n")
--=20
2.18.1


