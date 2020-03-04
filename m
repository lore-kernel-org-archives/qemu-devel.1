Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D4BC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72998217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbpYE/aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72998217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Xp1-0003BA-JX
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 12:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j9XoP-0002je-Av
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j9XoN-0007Sl-Tt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:28:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j9XoN-0007RH-N4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583342878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fACmvQmkZuNIoscJtCfOcHGzOFDNYo96ZxSk+GGoTTs=;
 b=CbpYE/aOYojZjV0ZeIeImBtwExTFbFbHU47/b0CSXA7EtIgwP5quCsvobbFKYqGAKSHrGS
 M9RksZR1I+t20MPljAm5wKKI4r2E8L+yEsmMP8jnWJkKXhpduc1pzsYYNo1uSRz6AxLQxq
 aCOHRA2lgheaf4ixEPnm1EZyFfs06VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-l8g6CjPvOoesDK64QA0UaA-1; Wed, 04 Mar 2020 12:27:56 -0500
X-MC-Unique: l8g6CjPvOoesDK64QA0UaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD90513FE
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2020 17:27:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9A2848;
 Wed,  4 Mar 2020 17:27:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] vl.c: fix migration failure for 3.1 and older machine
 types
Date: Wed,  4 Mar 2020 12:27:48 -0500
Message-Id: <20200304172748.15338-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ldoktor@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Migration from QEMU(v4.0) fails when using 3.1 or older machine
type. For example if one attempts to migrate
QEMU-2.12 started as
  qemu-system-ppc64 -nodefaults -M pseries-2.12 -m 4096 -mem-path /tmp/
to current master, it will fail with
  qemu-system-ppc64: Unknown ramblock "ppc_spapr.ram", cannot accept migrat=
ion
  qemu-system-ppc64: error while loading state for instance 0x0 of device '=
ram'
  qemu-system-ppc64: load of migration failed: Invalid argument

Caused by 900c0ba373 commit which switches main RAM allocation to
memory backends and the fact in 3.1 and older QEMU, backends used
full[***] QOM path as memory region name instead of backend's name.
That was changed after 3.1 to use prefix-less names by default
(fa0cb34d22) for new machine types.
*** effectively makes main RAM memory region names defined by
MachineClass::default_ram_id being altered with '/objects/' prefix
and therefore migration fails as old QEMU sends prefix-less
name while new QEMU expects name with prefix when using 3.1 and
older machine types.

Fix it by forcing implicit[1] memory backend to always use
prefix-less names for its memory region by setting
  'x-use-canonical-path-for-ramblock-id'
property to false.

1) i.e. memory backend created by compat glue which maps
-m/-mem-path/-mem-prealloc/default RAM size into
appropriate backend type/options to match old CLI format.

Fixes: 900c0ba373
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
CC: ldoktor@redhat.com
CC: marcandre.lureau@redhat.com
CC: dgilbert@redhat.com
---
 softmmu/vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5549f4b619..1101b1cb41 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2800,6 +2800,9 @@ static void create_default_memdev(MachineState *ms, c=
onst char *path)
     object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
     object_property_add_child(object_get_objects_root(), mc->default_ram_i=
d,
                               obj, &error_fatal);
+    /* Ensure backend's memory region name is equal to mc->default_ram_id =
*/
+    object_property_set_bool(obj, false, "x-use-canonical-path-for-rambloc=
k-id",
+                             &error_fatal);
     user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
     object_unref(obj);
     object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-backen=
d",
--=20
2.18.1


