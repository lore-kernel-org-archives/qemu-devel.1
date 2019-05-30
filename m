Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10711C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE356255AF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE356255AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWFcV-0006MV-4h
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 03:37:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWFYL-0002pw-4N
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWFYK-0001Xx-8o
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:32:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWFYH-0001Uq-2d; Thu, 30 May 2019 03:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 962F73079B93;
	Thu, 30 May 2019 07:32:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-119.ams2.redhat.com
	[10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CBF75D704;
	Thu, 30 May 2019 07:32:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 30 May 2019 09:32:05 +0200
Message-Id: <20190530073205.5293-7-kwolf@redhat.com>
In-Reply-To: <20190530073205.5293-1-kwolf@redhat.com>
References: <20190530073205.5293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 30 May 2019 07:32:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 6/6] file-posix: Add dynamic-auto-read-only
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

In commit 23dece19da4 ('file-posix: Make auto-read-only dynamic') ,
auto-read-only=3Don changed its behaviour in file-posix for the 4.0
release. This change cannot be detected through the usual mechanisms
like schema introspection. Add a new feature flag to the schema to
allow libvirt to detect the presence of the new behaviour.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..e820e7dfb0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2843,6 +2843,15 @@
 #                         file is large, do not use in production.
 #                         (default: off) (since: 3.0)
 #
+# Features:
+# @dynamic-auto-read-only: If present, enabled auto-read-only means that=
 the
+#                          driver will open the image read-only at first=
,
+#                          dynamically reopen the image file read-write =
when
+#                          the first writer is attached to the node and =
reopen
+#                          read-only when the last writer is detached. T=
his
+#                          allows to give QEMU write permissions only on=
 demand
+#                          when an operation actually needs write access=
.
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsFile',
@@ -2852,7 +2861,9 @@
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


