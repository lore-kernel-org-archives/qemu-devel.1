Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925BCC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659B720879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659B720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVSq-000262-Kv
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:41:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO2-0007MD-AD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO1-0000VV-9W
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDVNu-0000Q9-Du; Mon, 08 Apr 2019 10:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F859859FB;
	Mon,  8 Apr 2019 14:36:29 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE2F717DD4;
	Mon,  8 Apr 2019 14:36:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 16:35:43 +0200
Message-Id: <20190408143543.3982-5-kwolf@redhat.com>
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 08 Apr 2019 14:36:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408143543.-Q8YUjaFnD_VfByVgfQ22mPpvxgRiDt01aJ5NW88ark@z>

In commit 23dece19da4 ('file-posix: Make auto-read-only dynamic') ,
auto-read-only=3Don changed its behaviour in file-posix for the 4.0
release. This change cannot be detected through the usual mechanisms
like schema introspection. Add a new feature flag to the schema to
allow libvirt to detect the presence of the new behaviour.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..4f96d5846b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2843,6 +2843,13 @@
 #                         file is large, do not use in production.
 #                         (default: off) (since: 3.0)
 #
+# If the feature 'dynamic-auto-read-only' is present, enabled auto-read-=
only
+# means that the driver will open the image read-only at first, dynamica=
lly
+# reopen the image file read-write when the first writer is attached to =
the
+# node and reopen read-only when the last writer is detached. This allow=
s to
+# give QEMU write permissions only on demand when an operation actually =
needs
+# write access.
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsFile',
@@ -2852,7 +2859,9 @@
             '*aio': 'BlockdevAioOptions',
 	    '*drop-cache': {'type': 'bool',
 	                    'if': 'defined(CONFIG_LINUX)'},
-            '*x-check-cache-dropped': 'bool' } }
+            '*x-check-cache-dropped': 'bool' },
+  'features': [ { 'name': 'dynamic-auto-read-only',
+                  'if': 'defined(CONFIG_POSIX)' } ] }
=20
 ##
 # @BlockdevOptionsNull:
--=20
2.20.1


