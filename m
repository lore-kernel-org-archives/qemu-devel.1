Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5B8C04AB7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6868520879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcII-0007zi-Ju
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:36:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcGU-0006Op-0W
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcGT-0000Qs-2W
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQcGS-0000Pt-SK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A65430833DF;
	Tue, 14 May 2019 18:35:00 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
	[10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2B5A608AB;
	Tue, 14 May 2019 18:34:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
	ehabkost@redhat.com, richardw.yang@linux.intel.com,
	yury-kotov@yandex-team.ru, chen.zhang@intel.com
Date: Tue, 14 May 2019 19:34:39 +0100
Message-Id: <20190514183454.12758-2-dgilbert@redhat.com>
In-Reply-To: <20190514183454.12758-1-dgilbert@redhat.com>
References: <20190514183454.12758-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 14 May 2019 18:35:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/16] migration: comment VMSTATE_UNUSED*()
 properly
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

From: Peter Xu <peterx@redhat.com>

It is error prone to use VMSTATE_UNUSED*() sometimes especially when
the size of the migration stream of the field is not the same as the
size of the structure (boolean is one example).  Comment it well so
people will be aware of this when people want to use it.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190329095713.14177-1-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a668ec75b8..9224370ed5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1035,6 +1035,20 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_BUFFER_UNSAFE(_field, _state, _version, _size)        \
     VMSTATE_BUFFER_UNSAFE_INFO(_field, _state, _version, vmstate_info_bu=
ffer, _size)
=20
+/*
+ * These VMSTATE_UNUSED*() macros can be used to fill in the holes
+ * when some of the vmstate fields are obsolete to be compatible with
+ * migrations between new/old binaries.
+ *
+ * CAUTION: when using any of the VMSTATE_UNUSED*() macros please be
+ * sure that the size passed in is the size that was actually *sent*
+ * rather than the size of the *structure*.  One example is the
+ * boolean type - the size of the structure can vary depending on the
+ * definition of boolean, however the size we actually sent is always
+ * 1 byte (please refer to implementation of VMSTATE_BOOL_V and
+ * vmstate_info_bool).  So here we should always pass in size=3D=3D1
+ * rather than size=3D=3Dsizeof(bool).
+ */
 #define VMSTATE_UNUSED_V(_v, _size)                                   \
     VMSTATE_UNUSED_BUFFER(NULL, _v, _size)
=20
--=20
2.21.0


