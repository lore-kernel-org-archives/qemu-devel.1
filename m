Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CFC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B95208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLVZrBAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B95208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43mz-0005ic-NX
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j43jf-0007VW-QF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j43je-0007e9-Ro
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j43je-0007du-Nk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582035626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qpy3g9eVfUW9NxWqmvnKiDouR0As63ToNTbpIKoRPA=;
 b=FLVZrBAN4V/+p+IP6aLsqmT4mEWECdsoK5g+IHkmJjR03daU+Pk+tIKpqyG4BCQZONnfar
 6f5j8mPbCpr8sG0DJSnLqYaPg/iGfJX4sUFjK3yUNFlsYLCQD03sfVJrPyJMClKpa9HOb5
 Fl6Q42pT+K+KVMshjEMsQhYVK+5XZ2c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-UqVeka2gPmyalQGgfw7HVQ-1; Tue, 18 Feb 2020 09:20:24 -0500
Received: by mail-wm1-f69.google.com with SMTP id 7so114005wmf.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 06:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q8y9+FZ3WTW+S5NPq7Z3z1FcAzAHb2l50WLhocYFYdo=;
 b=taYpu2pfJrA0E9U2mk8PFsGq9cZH1tkwyiA5kmwNvQ2ceHihRWPPnlH45a/EunOrAD
 VrMvKPi5cM4j0IbMQdAtpUPzmro1RCUKxyrTDiJYZ1zmez8DYhlMhrkCfArfMjy8uzrQ
 7HrtMDhR+i8zHovgkrI2GYrPNoFjG50FkbJcLmk1gRv/rP7oMvWDQ4Jv7j/ulD23KTn4
 j4n8SuE0HQpLy7iltPn/sEUrDXVsN7u5vRlHUeBVueYc5P3p6VbR9kkeIYA0AeaRBKbU
 SvO1d869WZ0WbmDJK5wRlrIrt3KNMkfvYcHFIP1IapH/PoRJwEFaxlneRUvtUpSElxeu
 oOGA==
X-Gm-Message-State: APjAAAXO9la2oBDON904/6vdYbH8i1bR3M9zAUhVQKb7qQ3qUuSpCcIe
 WoGgXegpc/1lSF1G3u+EN89bp2VcVURC7HSxXkZ8Yat6s2YvN/qWIqn9rdFld0I2B8It9/SbYQW
 6k7QYKVzwkyS5MI8=
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr3552933wmd.91.1582035622885;
 Tue, 18 Feb 2020 06:20:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5fQ6Uq00YOnveQ1otQvD89OMPvOhZkhHDG3/sIcsLHHlAz5TvYekr4Yn9ltsiJLqMvNPAwA==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr3552908wmd.91.1582035622566;
 Tue, 18 Feb 2020 06:20:22 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l6sm3775204wmg.42.2020.02.18.06.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 06:20:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 2/3] .travis.yml: Build with ncurses on OSX
Date: Tue, 18 Feb 2020 15:20:17 +0100
Message-Id: <20200218142018.7224-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218142018.7224-1-philmd@redhat.com>
References: <20200218142018.7224-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: UqVeka2gPmyalQGgfw7HVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install the ncurses to extend coverage:

    $ ./configure
    [...]
    iconv support     yes
    curses support    yes
    curl support      yes

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 08ef2c011c..a2a7fd0dd1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -271,7 +271,7 @@ matrix:
=20
     - name: "OSX Xcode 10.3"
       env:
-        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu=
,m68k-softmmu,x86_64-softmmu"
+        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu=
,m68k-softmmu,x86_64-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/incl=
ude --extra-ldflags=3D-L/usr/local/opt/ncurses/lib"
       os: osx
       osx_image: xcode10.3
       compiler: clang
@@ -288,6 +288,7 @@ matrix:
             - gettext
             - glib
             - gnu-sed
+            - ncurses
             - pixman
             - python
             - snappy
--=20
2.21.1


