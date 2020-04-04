Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A33C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FE2206E9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5PsSbyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FE2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhrZ-0003P2-0E
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKhqZ-00024n-CO
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKhqY-00032W-9f
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKhqY-00031s-44
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586003061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7wjwW4kktbArsvMvX1086jM6kTZmn7Iq2jjE58VOA4=;
 b=a5PsSbyYnw6JDCcBIv2HaIJYpd6g1QuAdS1YV25Lz8c3l3q6Qm/HYYTi6yIJkOQAFLl5HR
 uQImNtN3Dz7bRRwKZPMNX1FW/gDTOP+ecltuMK1Ik5wPoU8fxMPlpSV74mKi/PzNeCpKaz
 //HeBmny4kuS39tCA1ayaqOMb0+Wykc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-TkGJ7AS1NduzlbHmanlxCA-1; Sat, 04 Apr 2020 08:24:19 -0400
X-MC-Unique: TkGJ7AS1NduzlbHmanlxCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C4E61005513;
 Sat,  4 Apr 2020 12:24:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D942E96B7B;
 Sat,  4 Apr 2020 12:24:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 628A811358AF; Sat,  4 Apr 2020 14:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] qga/commands-posix: fix use after free of local_err
Date: Sat,  4 Apr 2020 14:24:16 +0200
Message-Id: <20200404122416.1837-4-armbru@redhat.com>
In-Reply-To: <20200404122416.1837-1-armbru@redhat.com>
References: <20200404122416.1837-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

local_err is used several times in guest_suspend(). Setting non-NULL
local_err will crash, so let's zero it after freeing. Also fix possible
leak of local_err in final if().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200324153630.11882-7-vsementsov@virtuozzo.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 93474ff770..cc69b82704 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1773,6 +1773,7 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)
     }
=20
     error_free(local_err);
+    local_err =3D NULL;
=20
     if (pmutils_supports_mode(mode, &local_err)) {
         mode_supported =3D true;
@@ -1784,6 +1785,7 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)
     }
=20
     error_free(local_err);
+    local_err =3D NULL;
=20
     if (linux_sys_state_supports_mode(mode, &local_err)) {
         mode_supported =3D true;
@@ -1791,6 +1793,7 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)
     }
=20
     if (!mode_supported) {
+        error_free(local_err);
         error_setg(errp,
                    "the requested suspend mode is not supported by the gue=
st");
     } else {
--=20
2.21.1


