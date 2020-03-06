Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F841C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4B020656
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imMGe0P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4B020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGQM-0000Ph-3a
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAGPJ-0007mz-34
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAGPH-0003b0-1X
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:05:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAGPG-0003Ty-Qh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U7q74TWjNxbK3tgaQhfZm3ANvml13ZWcKrxUUIs/sbw=;
 b=imMGe0P28YM/NSDKMQkPyb90afWJsqgx0vQ4xE8o2f0GuVltI1Y38fDJwFaA4uyBZLvwy6
 X23f3b4erodinyVgIYAB5KKD3G65iWn/kQHhmuTRLsOUePhtky75Z+C2DTFbtVEDwXRrFt
 +WxtW2oF6zQK4VRvIZdlTb1TEZXJ/OA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-t4h0dThbP5CcidLydLsZ1g-1; Fri, 06 Mar 2020 12:05:00 -0500
X-MC-Unique: t4h0dThbP5CcidLydLsZ1g-1
Received: by mail-wr1-f71.google.com with SMTP id x14so1260407wrv.23
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CUFkzbxwIS11JDtiX5wUGCyWlbLosGGXt1JlvCGY4bk=;
 b=REwKwbOKnyemL4mEmYbxqtDDXliDfXdvS7Kvlj74mY1va99GoaVMMmhR0gOjecMWIO
 WwepG5/2dfvQ+NoxItiG+avw/dp+xzxKW6MhSqDAKT6xVJQk2EL3QOXDNiOeI7HrVAdf
 cS3gq2vpfmPIx4C/reKmtsyrLkotEOTtd436TzFG1XPahYR+mlzNXueVPQToBubKoozB
 bf4J4unLGohh84NDEqTIxRY9pBp8kZEvvt+UH5wAY2O6ZWBw+wpGYW6kVXDDpICrFx3C
 YCxzz1clFS5qGEwfARdEt0xwrirL6cAITrfB5mNyYx0ntGdlna2ad184yUyF1+7xY9wj
 CGnw==
X-Gm-Message-State: ANhLgQ2ASBSbQQ+rQTg/QyTFVJyOz8vrpYtIdomXOhYXYhZ82KPy00uD
 dbOKSrGtwRD8IVSmxjbJn0y1nMY0HkYYj2p31YS0ZoKjm0WIgs+9c1JrB4xza0lXwWKB8mNav0o
 xQYTK3tr+RfK86HQ=
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr4831269wmj.20.1583514298743; 
 Fri, 06 Mar 2020 09:04:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu6ZNSeF8kQAc+YfafxzT8Sk+vbnPk5Q1SHK1g5C8huyoO03WALrQ69c9dXP8FT4sCBTf8s1g==
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr4831255wmj.20.1583514298481; 
 Fri, 06 Mar 2020 09:04:58 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h17sm50791695wro.52.2020.03.06.09.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:04:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build-sys: Move the print-variable rule to rules.mak
Date: Fri,  6 Mar 2020 18:04:56 +0100
Message-Id: <20200306170456.21977-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the print-variable rule can only be used in the
root directory:

  $ make print-vhost-user-json-y
  vhost-user-json-y=3D contrib/vhost-user-gpu/50-qemu-gpu.json tools/virtio=
fsd/50-qemu-virtiofsd.json

  $ make -C i386-softmmu print-obj-y
  make: Entering directory 'build/i386-softmmu'
  make: *** No rule to make target 'print-obj-y'.  Stop.
  make: Leaving directory 'build/i386-softmmu'

Move it to rules.mak so we can use it from other directories:

  $ make -C i386-softmmu print-obj-y
  make: Entering directory 'build/i386-softmmu'
  obj-y=3Dqapi-introspect.o qapi-types-machine-target.o qapi-types-misc-tar=
get.o qapi-types.o qapi-visit-machine-target.o qapi-visit-misc-target.o qap=
i-visit.o qapi-events-machine-target.o qapi-events-misc-target.o qapi-event=
s.o qapi-commands-machine-target.o qapi-commands-misc-target.o qapi-command=
s.o qapi-init-commands.o
  make: Leaving directory 'build/i386-softmmu'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile  | 3 ---
 rules.mak | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9d4b224126..fdc5d29bb9 100644
--- a/Makefile
+++ b/Makefile
@@ -15,9 +15,6 @@ UNCHECKED_GOALS :=3D %clean TAGS cscope ctags dist \
     help check-help print-% \
     docker docker-% vm-help vm-test vm-build-%
=20
-print-%:
-=09@echo '$*=3D$($*)'
-
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
 # Put the all: rule here so that config-host.mak can contain dependencies.
diff --git a/rules.mak b/rules.mak
index e39b073d46..694865b63e 100644
--- a/rules.mak
+++ b/rules.mak
@@ -435,3 +435,6 @@ sentinel =3D .$(subst $(SPACE),_,$(subst /,_,$1)).senti=
nel.
 atomic =3D $(eval $1: $(call sentinel,$1) ; @:) \
          $(call sentinel,$1) : $2 ; @touch $$@ \
          $(foreach t,$1,$(if $(wildcard $t),,$(shell rm -f $(call sentinel=
,$1))))
+
+print-%:
+=09@echo '$*=3D$($*)'
--=20
2.21.1


