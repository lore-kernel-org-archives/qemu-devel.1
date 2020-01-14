Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB3C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B33D24676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXnRBssP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B33D24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLu7-00007h-PF
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLip-0002eg-Hc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLil-0001ix-KH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:55:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLil-0001il-H5
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PL3njRMZwxs9uKSpCL5NJoIzl7l80qAcMLLGRwuXdY=;
 b=EXnRBssPexGp136GwJ6d57n4WVev8UTfFjxSa9gF7vBhwXavz9YRVmmDbVepmqLAhvtPVn
 8w0rUpWUiKRy9I7abArdMOkz+z6nT7ev+/3BH5qVuO6JzPSSa9PYTb8w5qx0GaZ1FEWabV
 VbrzR+gjE6OTXQEXw3quNr/RHPiyN0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-CY-nTp_YNpCGSH-nt3m7Yw-1; Tue, 14 Jan 2020 07:54:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0776189DF43;
 Tue, 14 Jan 2020 12:54:55 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF08F5D9E5;
 Tue, 14 Jan 2020 12:54:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] migration: add savevm_state_handler_remove()
Date: Tue, 14 Jan 2020 13:52:37 +0100
Message-Id: <20200114125254.4515-14-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
References: <20200114125254.4515-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CY-nTp_YNpCGSH-nt3m7Yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Scott Cheloha <cheloha@linux.vnet.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Scott Cheloha <cheloha@linux.vnet.ibm.com>

Create a function to abstract common logic needed when removing a
SaveStateEntry element from the savevm_state.handlers queue.

For now we just remove the element.  Soon it will involve additional
cleanup.

Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 59efc1981d..30d980caa2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -725,6 +725,11 @@ static void savevm_state_handler_insert(SaveStateEntry=
 *nse)
     }
 }
=20
+static void savevm_state_handler_remove(SaveStateEntry *se)
+{
+    QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
+}
+
 /* TODO: Individual devices generally have very little idea about the rest
    of the system, so instance_id should be removed/replaced.
    Meanwhile pass -1 as instance_id if you do not already have a clearly
@@ -777,7 +782,7 @@ void unregister_savevm(VMStateIf *obj, const char *idst=
r, void *opaque)
=20
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
         if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D opaque) {
-            QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
+            savevm_state_handler_remove(se);
             g_free(se->compat);
             g_free(se);
         }
@@ -841,7 +846,7 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDe=
scription *vmsd,
=20
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
         if (se->vmsd =3D=3D vmsd && se->opaque =3D=3D opaque) {
-            QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
+            savevm_state_handler_remove(se);
             g_free(se->compat);
             g_free(se);
         }
--=20
2.24.1


