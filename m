Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A801C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451F120850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451F120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbtl-0000bE-Jb
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:11:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQbmH-0003OS-SZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQbmF-0002vW-Lv
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQbmF-0002uI-Gx
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F034B3092659
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 18:03:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53817608A7;
	Tue, 14 May 2019 18:03:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0B6E0113304E; Tue, 14 May 2019 20:03:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 20:03:11 +0200
Message-Id: <20190514180311.16028-7-armbru@redhat.com>
In-Reply-To: <20190514180311.16028-1-armbru@redhat.com>
References: <20190514180311.16028-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 14 May 2019 18:03:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/6] cutils: Simplify how parse_uint()
 checks for whitespace
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: thuth@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use qemu_isspace() so we don't have to cast to unsigned char.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index d682c90901..9aacc422ca 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -683,7 +683,7 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
     }
 
     /* make sure we reject negative numbers: */
-    while (isspace((unsigned char)*s)) {
+    while (qemu_isspace(*s)) {
         s++;
     }
     if (*s == '-') {
-- 
2.17.2


