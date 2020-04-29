Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8D920731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFGQuzTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8D920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh90-0003qV-Qt
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1w-0007tk-Fh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1g-0003wb-Kw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1f-0003uO-QS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dveDF7i19YrBFtpGujUfYTE4uhIXGRPm1+3EZMRFKqo=;
 b=EFGQuzTIyWns3hl3ZcKuQI9DbYdkHxbB3l1d6A7YLsieI70kv3OxdJ8vY39rYalsZq5CT9
 oMcmeZMMRQ/4NVibxkCZrXQUh0QvTZcjkUbCnnrfPD1tTv/dcbqICJ6o1TWdxY6P5vC7mF
 E1wo/HGwNGu6SkHONEE5rMziPtjMryQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-SRw8G0QAObC_u2r8A5UiVw-1; Wed, 29 Apr 2020 03:20:54 -0400
X-MC-Unique: SRw8G0QAObC_u2r8A5UiVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DF6EBFC2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C75F5D771;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2878011358CD; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] fdc: Fix fallback=auto error handling
Date: Wed, 29 Apr 2020 09:20:32 +0200
Message-Id: <20200429072048.29963-17-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fdctrl_realize_common() rejects fallback=3Dauto.  Used by devices
"isa-fdc", "sysbus-fdc", "SUNW,fdtwo".  The error handling is broken:

    $ qemu-system-x86_64 -nodefaults -device isa-fdc,fallback=3Dauto,driveA=
=3Dfd0 -drive if=3Dnone,id=3Dfd0
    **
    ERROR:/work/armbru/qemu/hw/block/fdc.c:434:pick_drive_type: assertion f=
ailed: (drv->drive !=3D FLOPPY_DRIVE_TYPE_AUTO)
    Aborted (core dumped)

Cause: fdctrl_realize_common() neglects to bail out after setting the
error.  Fix that.

Fixes: a73275dd6fc3bfda33165bebc28e0c33c20cb0a0
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200422130719.28225-7-armbru@redhat.com>
---
 hw/block/fdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 33bc9e2f92..9628cc171e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2615,6 +2615,7 @@ static void fdctrl_realize_common(DeviceState *dev, F=
DCtrl *fdctrl,
=20
     if (fdctrl->fallback =3D=3D FLOPPY_DRIVE_TYPE_AUTO) {
         error_setg(errp, "Cannot choose a fallback FDrive type of 'auto'")=
;
+        return;
     }
=20
     /* Fill 'command_to_handler' lookup table */
--=20
2.21.1


