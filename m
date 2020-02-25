Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC791C35E08
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99A721744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb5SHJlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99A721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c6b-0006aZ-TB
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bvP-0002c1-EK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bvO-00020E-7e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bvN-0001zd-RM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6c8L9eQw051eaC/4+i0vqRJfgJb3JB+2EyTASZyViM=;
 b=fb5SHJlvHg0pukXcjT5TFqeUs0Ep3aIoxunoaPisPyTgmz5ZHGDk9kvuiENsz9GSvcvB0Z
 ciKEmhDci0hXmT5KwBfOxVimnxq2zkFq4Rayh8UeFsUJA5B0mxPqqKQlMfiqbTY4Aoz5VC
 dU5KDVkPTmYN3clhI412QXkeJMPyec8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-MJjGBozAOOWPI5MV2Fu4PA-1; Tue, 25 Feb 2020 10:15:03 -0500
X-MC-Unique: MJjGBozAOOWPI5MV2Fu4PA-1
Received: by mail-qv1-f72.google.com with SMTP id dr18so13232069qvb.14
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mLvYfpxhMKRcFnvE2egjwCdKSrBCyKI8mHWugLjsqSQ=;
 b=tgqHwjvNkuZA/FtgFbkwWkJ5nTedmz58bbZXbnQ47SuB0A/TTzAodfM5YP0iffUDo1
 75ajo7PWjrWxO05W4njJowG5OcEeJ0COdh4ElPud6L/TeiZ67mWN+7+vipX/oHqJ92Iq
 eNmuUnyK/0nRt5B4lHX4+kFxorrFahqHVXnbXqeoxvTaZEnbLpD9qCr9kxwx1x7zQhnw
 rz3DqSpCV0WY94whViWCeXBMYOSRK11SZEk+LsVMmkIUAqld1CIX2z8hWkKIAwePso1z
 QJq1zPXURRFcmkVjCVfPuKVN0HY7lK0ndXflmdnzCnI+yRXCqkJSOOdXnIOkHtbg5tRH
 j1jA==
X-Gm-Message-State: APjAAAUPCB163SUYUDuSJdGzvrfXeghdgEnJRWglwriiSSicK/iwJ8EH
 Fp1QA1ia/I3BZpmCZ2vhfz+2cOzQ9qh8CnHtp6mc+s7gL9Ik831VA43W9pE5l7wRytgQiK0/b6S
 G8z10161TT0umLmE=
X-Received: by 2002:a37:a84f:: with SMTP id r76mr9094502qke.101.1582643701996; 
 Tue, 25 Feb 2020 07:15:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcM8OayS2VzLI0ns83pmppUBHCT9tR2BS8cVl7IPH7aOIZ8CLhUU8BIA2tx5p2TC6SDckCxw==
X-Received: by 2002:a37:a84f:: with SMTP id r76mr9094469qke.101.1582643701737; 
 Tue, 25 Feb 2020 07:15:01 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 b7sm7668455qtj.78.2020.02.25.07.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:15:00 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] tests/vhost-user-bridge: move to contrib/
Message-ID: <20200225151210.647797-31-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

vhost-user-bridge is not a test. Move it to contrib/ and
add it to the tools list.

It will be built only if tools (--enable-tools) and
vhost-user (--enable-vhost-user) are enabled (both are set
by default).

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200207095412.794912-1-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure                                                     | 3 +++
 Makefile                                                      | 3 +++
 tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c | 0
 Makefile.objs                                                 | 1 +
 contrib/vhost-user-bridge/Makefile.objs                       | 1 +
 docs/devel/migration.rst                                      | 2 +-
 tests/Makefile.include                                        | 1 -
 7 files changed, 9 insertions(+), 2 deletions(-)
 rename tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c (10=
0%)
 create mode 100644 contrib/vhost-user-bridge/Makefile.objs

diff --git a/configure b/configure
index 48d6f89d57..de2b82b93c 100755
--- a/configure
+++ b/configure
@@ -6288,6 +6288,9 @@ if test "$want_tools" =3D "yes" ; then
   if [ "$curl" =3D "yes" ]; then
       tools=3D"elf2dmp\$(EXESUF) $tools"
   fi
+  if [ "$vhost_user" =3D "yes" ]; then
+      tools=3D"vhost-user-bridge\$(EXESUF) $tools"
+  fi
 fi
 if test "$softmmu" =3D yes ; then
   if test "$linux" =3D yes; then
diff --git a/Makefile b/Makefile
index aa9cc0b584..218b8259a4 100644
--- a/Makefile
+++ b/Makefile
@@ -445,6 +445,7 @@ dummy :=3D $(call unnest-vars,, \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
+                vhost-user-bridge-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -688,6 +689,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libv=
host-user.a
 =09$(call LINK, $^)
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 =09$(call LINK, $^)
+vhost-user-bridge$(EXESUF): $(vhost-user-bridge-obj-y) libvhost-user.a
+=09$(call LINK, $^)
=20
 rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/main.c
similarity index 100%
rename from tests/vhost-user-bridge.c
rename to contrib/vhost-user-bridge/main.c
diff --git a/Makefile.objs b/Makefile.objs
index 8a1cbe8000..c282ff77dd 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -107,6 +107,7 @@ vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
 vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
+vhost-user-bridge-obj-y =3D contrib/vhost-user-bridge/
 rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
 vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-bridge/Makefile.objs b/contrib/vhost-user-b=
ridge/Makefile.objs
new file mode 100644
index 0000000000..36a8d9b49a
--- /dev/null
+++ b/contrib/vhost-user-bridge/Makefile.objs
@@ -0,0 +1 @@
+vhost-user-bridge-obj-y =3D main.o
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e88918f763..d00424460e 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -807,7 +807,7 @@ The Linux kernel userfault support works on `/dev/shm` =
memory and on `hugetlbfs`
 for hugetlbfs which may be a problem in some configurations).
=20
 The vhost-user code in QEMU supports clients that have Postcopy support,
-and the `vhost-user-bridge` (in `tests/`) and the DPDK package have change=
s
+and the `vhost-user-bridge` (in `contrib/`) and the DPDK package have chan=
ges
 to support postcopy.
=20
 The client needs to open a userfaultfd and register the areas
diff --git a/tests/Makefile.include b/tests/Makefile.include
index edcbd475aa..2dc95c52c8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -588,7 +588,6 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
=20
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
=20
 SPEED =3D quick
=20
--=20
MST


