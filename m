Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A643C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 19:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479BB2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 19:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479BB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEI1r-0008HN-6o
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 15:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHdB-0008Sn-P3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd7-0003zQ-5n
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd6-0003vg-Mv
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFE607FDEC
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 918295D6B2;
 Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 851821136426; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/27] qapi: Improve reporting of redefinition
Date: Sat, 28 Sep 2019 20:39:33 +0200
Message-Id: <20190928183934.12459-27-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
References: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Point to the previous definition, unless it's a built-in.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190927134639.4284-26-armbru@redhat.com>
---
 scripts/qapi/common.py                  | 5 +++++
 tests/qapi-schema/redefined-command.err | 4 +++-
 tests/qapi-schema/redefined-event.err   | 4 +++-
 tests/qapi-schema/redefined-type.err    | 4 +++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index bd834270f8..a74cd957d4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1759,6 +1759,11 @@ class QAPISchema(object):
         # because they're liable to clash in generated C.
         other_ent =3D self._entity_dict.get(ent.name)
         if other_ent:
+            if other_ent.info:
+                where =3D QAPIError(other_ent.info, None, "previous defi=
nition")
+                raise QAPISemError(
+                    ent.info,
+                    "'%s' is already defined\n%s" % (ent.name, where))
             raise QAPISemError(
                 ent.info, "%s is already defined" % other_ent.describe()=
)
         self._entity_dict[ent.name] =3D ent
diff --git a/tests/qapi-schema/redefined-command.err b/tests/qapi-schema/=
redefined-command.err
index b77a05d354..54e366bbf3 100644
--- a/tests/qapi-schema/redefined-command.err
+++ b/tests/qapi-schema/redefined-command.err
@@ -1,2 +1,4 @@
 tests/qapi-schema/redefined-command.json: In command 'foo':
-tests/qapi-schema/redefined-command.json:3: command 'foo' is already def=
ined
+tests/qapi-schema/redefined-command.json:3: 'foo' is already defined
+tests/qapi-schema/redefined-command.json: In command 'foo':
+tests/qapi-schema/redefined-command.json:2: previous definition
diff --git a/tests/qapi-schema/redefined-event.err b/tests/qapi-schema/re=
defined-event.err
index fd02d38157..606c6e4497 100644
--- a/tests/qapi-schema/redefined-event.err
+++ b/tests/qapi-schema/redefined-event.err
@@ -1,2 +1,4 @@
 tests/qapi-schema/redefined-event.json: In event 'EVENT_A':
-tests/qapi-schema/redefined-event.json:3: event 'EVENT_A' is already def=
ined
+tests/qapi-schema/redefined-event.json:3: 'EVENT_A' is already defined
+tests/qapi-schema/redefined-event.json: In event 'EVENT_A':
+tests/qapi-schema/redefined-event.json:2: previous definition
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 39f51c14ea..77786f98ae 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1,2 +1,4 @@
 tests/qapi-schema/redefined-type.json: In enum 'foo':
-tests/qapi-schema/redefined-type.json:3: struct type 'foo' is already de=
fined
+tests/qapi-schema/redefined-type.json:3: 'foo' is already defined
+tests/qapi-schema/redefined-type.json: In struct 'foo':
+tests/qapi-schema/redefined-type.json:2: previous definition
--=20
2.21.0


