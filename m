Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF2C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E4620726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5OE/HNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E4620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vrs-0001CL-Dw
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpR-0004Va-14
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpP-0006t8-N2
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpP-0006se-I5
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKCvw87FK3WA1PhTVY1qk6PUyru/LVUw3GX+gJcKCI0=;
 b=g5OE/HNLwwrgSANQXyiwy2aK0+WVxtQmP/Joa6ZaIl0a0176NGbCHHq6jzcm7bvzKmxt54
 mkdYhBkzqH5tjREpQBUixMXeS910xq0dtNlVK4VQQg1mH8OxImJnkhtSj7uNr5WCD1PFjJ
 7J8gGHacAjXXmty+3semwGzWZDlWCXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-ucRWTcwhNtaEo5a42sdHTQ-1; Sat, 15 Feb 2020 06:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158BB800D4E;
 Sat, 15 Feb 2020 11:41:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8AD790522;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58D0A113636A; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] qapi: Delete all the "foo: dropped in n.n" notes
Date: Sat, 15 Feb 2020 12:41:33 +0100
Message-Id: <20200215114133.15097-19-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ucRWTcwhNtaEo5a42sdHTQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

A handful of QAPI doc comments include lines like
"ppcemb: dropped in 3.1". The doc comment parser will just
put these into whatever the preceding section was; sometimes
that's "Notes", and sometimes it's some random other section,
as with "NetClientDriver" where the "'dump': dropped in 2.12"
line ends up in the "Since:" section.

This tends to render wrongly, more so in the upcoming rST
generator, but sometimes even in the Texinfo, as in the case
of QKeyCode:
   ac_bookmarks
       since 2.10 altgr, altgr_r: dropped in 2.10

Since commit 3264ffced3 (v4.2.0), we have a better place to tell
users about deprecated and deleted functionality --
qemu-deprecated.texi.  These "dropped in" remarks all predate it, and
other feature drops of that vintage are not documented anywhere, so
moving these to qemu-deprecated.texi makes little sense.  Drop them
instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200213175647.17628-19-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 2 --
 qapi/net.json     | 4 ----
 qapi/ui.json      | 1 -
 3 files changed, 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 704b2b0fe3..6c11e3cf3a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -20,8 +20,6 @@
 #        prefix to produce the corresponding QEMU executable name. This
 #        is true even for "qemu-system-x86_64".
 #
-# ppcemb: dropped in 3.1
-#
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
diff --git a/qapi/net.json b/qapi/net.json
index 80dcf0df06..1cb9a7d782 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -446,8 +446,6 @@
 # Available netdev drivers.
 #
 # Since: 2.7
-#
-# 'dump': dropped in 2.12
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
@@ -493,8 +491,6 @@
 # @opts: device type specific properties (legacy)
 #
 # Since: 1.2
-#
-# 'vlan': dropped in 3.0
 ##
 { 'struct': 'NetLegacy',
   'data': {
diff --git a/qapi/ui.json b/qapi/ui.json
index 89126da395..e16e98a060 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -779,7 +779,6 @@
 # @ac_forward: since 2.10
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
-# altgr, altgr_r: dropped in 2.10
 #
 # @muhenkan: since 2.12
 # @katakanahiragana: since 2.12
--=20
2.21.1


