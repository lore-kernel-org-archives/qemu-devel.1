Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72378C352A4
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A0420838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izC3cVDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A0420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00j0-0000hW-EM
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j00i5-0007oM-V4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j00i4-0008JI-NU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j00i4-0008Ir-KD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=160SiUcVsBvPhbBvJZUeSzVMISGtyFZPg7v7NBTFr3s=;
 b=izC3cVDmx0rFORJB2JUF1AvhwKcB3cY/6gGDtLSDwKIdNRrYFS6L3VjTbb52SWlvOxbooM
 RD/dsPpaClouxoz0eRN1vYaxpiT+htUjzIitVsvaaU4Js3Z6YPWBeuBvMPVy6Z/kyFM3Ko
 GZ257PiK/7v3sZEWT3ubJ0Zvb6Rr0NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-8ydxX-LZMwOPQKLSyt-b4A-1; Fri, 07 Feb 2020 05:18:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9895E14E5;
 Fri,  7 Feb 2020 10:17:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1B45C241;
 Fri,  7 Feb 2020 10:17:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7A7B031E89; Fri,  7 Feb 2020 11:17:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] ui: wire up legacy -show-cursor option
Date: Fri,  7 Feb 2020 11:17:48 +0100
Message-Id: <20200207101753.25812-3-kraxel@redhat.com>
In-Reply-To: <20200207101753.25812-1-kraxel@redhat.com>
References: <20200207101753.25812-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8ydxX-LZMwOPQKLSyt-b4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set new show-cursor display option when legacy -show-cursor
is specified on the command line.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 7dcb0879c497..5419b3d68200 100644
--- a/vl.c
+++ b/vl.c
@@ -3554,6 +3554,8 @@ int main(int argc, char **argv, char **envp)
                 break;
             case QEMU_OPTION_show_cursor:
                 cursor_hide =3D 0;
+                dpy.has_show_cursor =3D true;
+                dpy.show_cursor =3D true;
                 break;
             case QEMU_OPTION_uuid:
                 if (qemu_uuid_parse(optarg, &qemu_uuid) < 0) {
--=20
2.18.1


