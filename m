Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F19C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF894207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNnV3LJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF894207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKPl-000116-Ts
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieKP5-0000Tm-As
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieKP3-00035v-T0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:52:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieKP3-00035Z-PX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575903169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iq86KGxLR6UTYXmMeKI1ArfzDy3UjI2qkFgCjrf2gXY=;
 b=GNnV3LJHlvcY+zLk0DvcJCGJ1GL+EfNxUJEuhy5PbEej3CTZhYNG9Q5IKEF+Tou5wnqegD
 FWzOtlJ7nzEbqSUwtu6IKE0uEoIj+hg1PipqwVJS72XNhtiNJNNR1uEGZwPB8u6TZHsdCV
 hwSmriGLTioyIgXYaKZ0Pyqn7fRHROU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-MQfb8sPxN6yLSrYgTqbD9Q-1; Mon, 09 Dec 2019 09:52:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA285800D4E;
 Mon,  9 Dec 2019 14:52:44 +0000 (UTC)
Received: from thuth.com (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D3EC10372C0;
 Mon,  9 Dec 2019 14:52:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Greg Kurz <groug@kaod.org>,
	qemu-devel@nongnu.org
Subject: [PATCH] virtfs: Remove the deprecated "-virtfs_synth" option
Date: Mon,  9 Dec 2019 15:52:40 +0100
Message-Id: <20191209145240.9271-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MQfb8sPxN6yLSrYgTqbD9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's been marked as deprecated since QEMU v4.1, time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-deprecated.texi |  5 -----
 qemu-options.hx      | 10 ----------
 vl.c                 | 23 -----------------------
 3 files changed, 38 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2f9efb45ba..3745334e80 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -84,11 +84,6 @@ error in the future.
 The @code{-realtime mlock=3Don|off} argument has been replaced by the
 @code{-overcommit mem-lock=3Don|off} argument.
=20
-@subsection -virtfs_synth (since 4.1)
-
-The ``-virtfs_synth'' argument is now deprecated. Please use ``-fsdev synt=
h''
-and ``-device virtio-9p-...'' instead.
-
 @subsection -numa node,mem=3D@var{size} (since 4.1)
=20
 The parameter @option{mem} of @option{-numa node} is used to assign a part=
 of
diff --git a/qemu-options.hx b/qemu-options.hx
index 65c9473b73..4cf7751ade 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1468,16 +1468,6 @@ would still return entries from other devices).
 @end table
 ETEXI
=20
-DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
-    "-virtfs_synth Create synthetic file system image\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -virtfs_synth
-@findex -virtfs_synth
-Create synthetic file system image. Note that this option is now deprecate=
d.
-Please use @code{-fsdev synth} and @code{-device virtio-9p-...} instead.
-ETEXI
-
 DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
     "-iscsi [user=3Duser][,password=3Dpassword]\n"
     "       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
diff --git a/vl.c b/vl.c
index 6a65a64bfd..c0904b365b 100644
--- a/vl.c
+++ b/vl.c
@@ -3374,29 +3374,6 @@ int main(int argc, char **argv, char **envp)
                              qemu_opt_get(opts, "mount_tag"), &error_abort=
);
                 break;
             }
-            case QEMU_OPTION_virtfs_synth: {
-                QemuOpts *fsdev;
-                QemuOpts *device;
-
-                warn_report("'-virtfs_synth' is deprecated, please use "
-                             "'-fsdev synth' and '-device virtio-9p-...' "
-                            "instead");
-
-                fsdev =3D qemu_opts_create(qemu_find_opts("fsdev"), "v_syn=
th",
-                                         1, NULL);
-                if (!fsdev) {
-                    error_report("duplicate option: %s", "virtfs_synth");
-                    exit(1);
-                }
-                qemu_opt_set(fsdev, "fsdriver", "synth", &error_abort);
-
-                device =3D qemu_opts_create(qemu_find_opts("device"), NULL=
, 0,
-                                          &error_abort);
-                qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abo=
rt);
-                qemu_opt_set(device, "fsdev", "v_synth", &error_abort);
-                qemu_opt_set(device, "mount_tag", "v_synth", &error_abort)=
;
-                break;
-            }
             case QEMU_OPTION_serial:
                 add_device_config(DEV_SERIAL, optarg);
                 default_serial =3D 0;
--=20
2.18.1


