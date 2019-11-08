Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF09FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79211214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwNfxoCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79211214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5Hu-0004E3-QL
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT5FE-0000Xl-RI
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT5FD-0000pN-Mq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:28:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT5FD-0000o9-Je
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573223291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/RURPPC+PX0XGwf6Gei0vsDMgKrYkulMKMaEFtT6vg=;
 b=hwNfxoCG20qK2+ccJEc8HDAQ0TmEqniqAm2sU6NgvM9SAYMXVoPxg59l3v0NGfm9LHpoXD
 vtbld74f0vG+AZ16E5j8LttXO27SKyOs8Sg+FITjmgA5XURFmbS55rzN5EKIJ6yEp/IVkr
 /fnLaXyZb94U6B6iZ1b0/Vcdkj89d3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-zuoahBc_MPycoNJQw0dZ0A-1; Fri, 08 Nov 2019 09:28:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC49800C72;
 Fri,  8 Nov 2019 14:28:06 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2590F10631CE;
 Fri,  8 Nov 2019 14:27:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH 3/3] trace: Forbid dynamic field width in event format
Date: Fri,  8 Nov 2019 15:26:13 +0100
Message-Id: <20191108142613.26649-4-philmd@redhat.com>
In-Reply-To: <20191108142613.26649-1-philmd@redhat.com>
References: <20191108142613.26649-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: zuoahBc_MPycoNJQw0dZ0A-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since not all trace backends support dynamic field width in
format (dtrace via stap does not), forbid them.

Add a check to refuse field width in new formats:

  $ make
  [...]
    GEN     hw/block/trace.h
  Traceback (most recent call last):
    File "scripts/tracetool.py", line 152, in <module>
      main(sys.argv)
    File "scripts/tracetool.py", line 143, in main
      events.extend(tracetool.read_events(fh, arg))
    File "scripts/tracetool/__init__.py", line 371, in read_events
      event =3D Event.build(line)
    File "scripts/tracetool/__init__.py", line 285, in build
      raise ValueError("Event format must not contain field width '%*'")
  ValueError: Error at hw/block/trace-events:11: Event format must not cont=
ain field width '%*'

Reported-by: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/tracetool/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 44c118bc2a..e239be602b 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -206,6 +206,7 @@ class Event(object):
                       "\s*"
                       "(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
                       "\s*")
+    _DFWRE =3D re.compile(".*(%0?\*).*")
=20
     _VALID_PROPS =3D set(["disable", "tcg", "tcg-trans", "tcg-exec", "vcpu=
"])
=20
@@ -280,6 +281,8 @@ class Event(object):
         if fmt.endswith(r'\n"'):
             raise ValueError("Event format must not end with a newline "
                              "character")
+        if Event._DFWRE.match(fmt):
+            raise ValueError("Event format must not contain field width '%=
*'")
=20
         if len(fmt_trans) > 0:
             fmt =3D [fmt_trans, fmt]
--=20
2.21.0


