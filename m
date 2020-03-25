Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED00DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AAE2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZn0JNpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AAE2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5zQ-0007nQ-UD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tv-0006mr-UG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tu-0006Eb-Og
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH5tu-0006Dv-LE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roHxRK0CyW53DrD9unCUVNNTq7w3Riel1xOoeqTB6Fs=;
 b=QZn0JNpnbDxHptA7vAprh2JtfLDRoINa/tbGOcDPu42azbetoX7TN20G06W2gj0DLMfN73
 hKxBzTypW+yE0tFWHz+xrfwodbl5wm0g4WOPiIVjKZBBgLeAfHzWHcfWtlDBxjZ/jcI+Ly
 7ZzkiqUiNrMwfI0ZKb2wfj8KaFBnTyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-GZKzHfSSO5W-pZXVjUpoEg-1; Wed, 25 Mar 2020 09:16:52 -0400
X-MC-Unique: GZKzHfSSO5W-pZXVjUpoEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4502E107ACC4;
 Wed, 25 Mar 2020 13:16:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCB5A5C3F8;
 Wed, 25 Mar 2020 13:16:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pannengyuan@huawei.com,
 maozhongyi@cmss.chinamobile.com, vsementsov@virtuozzo.com,
 imammedo@redhat.com, philmd@redhat.com
Subject: [PULL 6/9] vl.c: fix migration failure for 3.1 and older machine types
Date: Wed, 25 Mar 2020 13:16:29 +0000
Message-Id: <20200325131632.311034-7-dgilbert@redhat.com>
In-Reply-To: <20200325131632.311034-1-dgilbert@redhat.com>
References: <20200325131632.311034-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <20200304172748.15338-1-imammedo@redhat.com>
Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 softmmu/vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 1d33a28340..814537bb42 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2801,6 +2801,9 @@ static void create_default_memdev(MachineState *ms, c=
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
2.25.1


