Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9954BC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BE820714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5TwD8tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BE820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1unL-0001we-HG
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uj4-0001qo-2F
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uj2-0004fT-1O
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uj1-0004fC-UJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4em2DWXVVe2v8rApkmWa0UnHCuFrOGU+HzyQvRV6mpo=;
 b=f5TwD8trW4uTXgsfzRf/QYUfLkaWbSCE6m2GnbWppXF0bwrftg70JIH64Z4Uv2JcYCNyVK
 tVYLP0BT27uqhrNGRMmjEhLNZ+679+WgcnURC1nvO2TTeQkQE11nBSZKfM9g5EAblSyrzR
 /Uask+QAL2PwFE2uO/vd+y0Mg/FgFds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-PqpM9eJzMhCGOYoKNTZAiQ-1; Wed, 12 Feb 2020 11:18:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E058218CA24F;
 Wed, 12 Feb 2020 16:18:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 999E490761;
 Wed, 12 Feb 2020 16:18:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 243C431EB6; Wed, 12 Feb 2020 17:18:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] ui: deprecate legacy -show-cursor option
Date: Wed, 12 Feb 2020 17:18:34 +0100
Message-Id: <20200212161835.28576-10-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
References: <20200212161835.28576-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PqpM9eJzMhCGOYoKNTZAiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 vl.c                 | 2 ++
 qemu-deprecated.texi | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/vl.c b/vl.c
index 62efcd15c0bf..001be469c2e9 100644
--- a/vl.c
+++ b/vl.c
@@ -3562,6 +3562,8 @@ int main(int argc, char **argv, char **envp)
                 no_shutdown =3D 1;
                 break;
             case QEMU_OPTION_show_cursor:
+                warn_report("The -show-cursor option is deprecated, "
+                            "use -display {sdl,gtk},show-cursor=3Don inste=
ad");
                 dpy.has_show_cursor =3D true;
                 dpy.show_cursor =3D true;
                 break;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 017b750ca8e2..0671c26c806e 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -148,6 +148,11 @@ QEMU 5.0 introduced an alternative syntax to specify t=
he size of the translation
 block cache, @option{-accel tcg,tb-size=3D}.  The new syntax deprecates th=
e
 previously available @option{-tb-size} option.
=20
+@subsection -show-cursor option (since 5.0)
+
+Use @option{-display sdl,show-cursor=3Don} or
+ @option{-display gtk,show-cursor=3Don} instead.
+
 @section QEMU Machine Protocol (QMP) commands
=20
 @subsection change (since 2.5.0)
--=20
2.18.2


