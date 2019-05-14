Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410CA20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410CA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcL4-00024k-GN
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:39:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcGZ-0006TG-DN
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcGY-0000ax-Fc
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQcGY-0000aN-A2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A4D7300C22E;
	Tue, 14 May 2019 18:35:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
	[10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1AB6B67668;
	Tue, 14 May 2019 18:35:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
	ehabkost@redhat.com, richardw.yang@linux.intel.com,
	yury-kotov@yandex-team.ru, chen.zhang@intel.com
Date: Tue, 14 May 2019 19:34:42 +0100
Message-Id: <20190514183454.12758-5-dgilbert@redhat.com>
In-Reply-To: <20190514183454.12758-1-dgilbert@redhat.com>
References: <20190514183454.12758-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 14 May 2019 18:35:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/16] vmstate: check subsection_found is enough
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

subsection_found is true implies vmdesc is not NULL.

This patch remove the additional check on vmdesc and rename
subsection_found to vmdesc_has_subsections to make it more self-explain.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Message-Id: <20190403011016.12549-1-richardw.yang@linux.intel.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/vmstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e2bbb7b5f7..1305d1a528 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -496,7 +496,7 @@ static int vmstate_subsection_save(QEMUFile *f, const=
 VMStateDescription *vmsd,
                                    void *opaque, QJSON *vmdesc)
 {
     const VMStateDescription **sub =3D vmsd->subsections;
-    bool subsection_found =3D false;
+    bool vmdesc_has_subsections =3D false;
     int ret =3D 0;
=20
     trace_vmstate_subsection_save_top(vmsd->name);
@@ -508,9 +508,9 @@ static int vmstate_subsection_save(QEMUFile *f, const=
 VMStateDescription *vmsd,
             trace_vmstate_subsection_save_loop(vmsd->name, vmsdsub->name=
);
             if (vmdesc) {
                 /* Only create subsection array when we have any */
-                if (!subsection_found) {
+                if (!vmdesc_has_subsections) {
                     json_start_array(vmdesc, "subsections");
-                    subsection_found =3D true;
+                    vmdesc_has_subsections =3D true;
                 }
=20
                 json_start_object(vmdesc, NULL);
@@ -533,7 +533,7 @@ static int vmstate_subsection_save(QEMUFile *f, const=
 VMStateDescription *vmsd,
         sub++;
     }
=20
-    if (vmdesc && subsection_found) {
+    if (vmdesc_has_subsections) {
         json_end_array(vmdesc);
     }
=20
--=20
2.21.0


