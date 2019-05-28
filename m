Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F0EC04E84
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D1220883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D1220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVh1B-0006Gp-A9
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:40:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVh0G-0005pd-08
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVh0F-00043S-0R
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:39:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hVh0C-0003k2-Pz; Tue, 28 May 2019 14:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87BE2619FB;
	Tue, 28 May 2019 18:39:00 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5C2B5D9CD;
	Tue, 28 May 2019 18:38:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 14:38:57 -0400
Message-Id: <20190528183857.26167-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 28 May 2019 18:39:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] event_match: always match on None value
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
Cc: John Snow <jsnow@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before, event_match didn't always recurse if the event value was not a
dictionary, and would instead check for equality immediately.

By delaying equality checking to post-recursion, we can allow leaf
values like "5" to match "None" and take advantage of the generic
None-returns-True clause.

This makes the matching a little more obviously consistent at the
expense of being able to check for explicit None values, which is
probably not that important given what this function is used for.

Signed-off-by: John Snow <jsnow@redhat.com>
---
v2: actually let the for loop finish ... Thanks Max
---
 python/qemu/__init__.py | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index 98ed8a2e28..dbaf8a5311 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -409,27 +409,31 @@ class QEMUMachine(object):
=20
         The match criteria takes the form of a matching subdict. The eve=
nt is
         checked to be a superset of the subdict, recursively, with match=
ing
-        values whenever those values are not None.
+        values whenever the subdict values are not None.
+
+        This has a limitation that you cannot explicitly check for None =
values.
=20
         Examples, with the subdict queries on the left:
          - None matches any object.
          - {"foo": None} matches {"foo": {"bar": 1}}
-         - {"foo": {"baz": None}} does not match {"foo": {"bar": 1}}
-         - {"foo": {"baz": 2}} matches {"foo": {"bar": 1, "baz": 2}}
+         - {"foo": None} matches {"foo": 5}
+         - {"foo": {"abc": None}} does not match {"foo": {"bar": 1}}
+         - {"foo": {"rab": 2}} matches {"foo": {"bar": 1, "rab": 2}}
         """
         if match is None:
             return True
=20
-        for key in match:
-            if key in event:
-                if isinstance(event[key], dict):
+        try:
+            for key in match:
+                if key in event:
                     if not QEMUMachine.event_match(event[key], match[key=
]):
                         return False
-                elif event[key] !=3D match[key]:
+                else:
                     return False
-            else:
-                return False
-        return True
+            return True
+        except TypeError:
+            # either match or event wasn't iterable (not a dict)
+            return match =3D=3D event
=20
     def event_wait(self, name, timeout=3D60.0, match=3DNone):
         """
--=20
2.20.1


