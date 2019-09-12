Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5209C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5AF2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5AF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Pk5-0006av-9V
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUP-0006fJ-Lm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUN-0002jl-Sa
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUN-0002jQ-L9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3B70308FB9A;
 Thu, 12 Sep 2019 13:50:22 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A02B05D717;
 Thu, 12 Sep 2019 13:50:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:49:56 +0100
Message-Id: <20190912135006.14820-3-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 12 Sep 2019 13:50:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/12] migration: cleanup check on ops in
 savevm.handlers iterations
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

From: Wei Yang <richardw.yang@linux.intel.com>

During migration, there are several places to iterate on
savevm.handlers. And on each iteration, we need to check its ops and
related callbacks before invoke it.

Generally, ops is the first element to check, and it is only necessary
to check it once.

This patch clean all the related part in savevm.c to check ops only once
in those iterations.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Message-Id: <20190819032804.8579-1-richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4a86128ac4..35426d1db8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1100,7 +1100,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
+        if (se->ops->is_active) {
             if (!se->ops->is_active(se->opaque)) {
                 continue;
             }
@@ -1131,7 +1131,7 @@ int qemu_savevm_state_resume_prepare(MigrationState=
 *s)
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
+        if (se->ops->is_active) {
             if (!se->ops->is_active(se->opaque)) {
                 continue;
             }
@@ -1227,7 +1227,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *=
f)
         if (!se->ops || !se->ops->save_live_complete_postcopy) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
+        if (se->ops->is_active) {
             if (!se->ops->is_active(se->opaque)) {
                 continue;
             }
@@ -1264,7 +1264,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEM=
UFile *f, bool in_postcopy)
             continue;
         }
=20
-        if (se->ops && se->ops->is_active) {
+        if (se->ops->is_active) {
             if (!se->ops->is_active(se->opaque)) {
                 continue;
             }
@@ -1413,7 +1413,7 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_=
t threshold_size,
         if (!se->ops || !se->ops->save_live_pending) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
+        if (se->ops->is_active) {
             if (!se->ops->is_active(se->opaque)) {
                 continue;
             }
@@ -2334,7 +2334,7 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
         if (!se->ops || !se->ops->load_setup) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
+        if (se->ops->is_active) {
             if (!se->ops->is_active(se->opaque)) {
                 continue;
             }
--=20
2.21.0


