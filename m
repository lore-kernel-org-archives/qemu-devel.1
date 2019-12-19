Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7774FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414BA222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNirbZwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414BA222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv2o-0006WW-M5
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurK-0008A8-NI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurI-0000HN-TX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurI-0000FT-Ib
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQZDIc3n2Tb43fnushtjf+kc25/BGN65mq3k8eHW6+E=;
 b=DNirbZwbSllE+enwDz4IHoQIREQtKqZaHEFD7F05Goj8QROoF6sH0e3ZRoqUp0ag6K8xNw
 jJVrXtDq7G5Bw0i8dYNsE68XC9su57BQMk477DdiU41w3tyTpkA2oTWpEhtPM7ePwlVZO6
 Md+Yp2YRYTs6E+swfUlyIix0ukef9S8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-kRu0lpW7OZeNrIcl4uQ5Ig-1; Thu, 19 Dec 2019 07:24:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24A5B107ACC4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:45 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02DE160C18;
 Thu, 19 Dec 2019 12:24:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 107/132] meson: accel
Date: Thu, 19 Dec 2019 13:23:27 +0100
Message-Id: <1576758232-12439-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kRu0lpW7OZeNrIcl4uQ5Ig-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target           |  1 -
 accel/Makefile.objs       |  5 -----
 accel/kvm/Makefile.objs   |  2 --
 accel/kvm/meson.build     |  5 +++++
 accel/meson.build         |  6 ++++++
 accel/stubs/Makefile.objs |  5 -----
 accel/stubs/meson.build   |  5 +++++
 accel/tcg/Makefile.objs   |  8 --------
 accel/tcg/meson.build     | 14 ++++++++++++++
 meson.build               |  1 +
 10 files changed, 31 insertions(+), 21 deletions(-)
 delete mode 100644 accel/Makefile.objs
 delete mode 100644 accel/kvm/Makefile.objs
 create mode 100644 accel/kvm/meson.build
 create mode 100644 accel/meson.build
 delete mode 100644 accel/stubs/Makefile.objs
 create mode 100644 accel/stubs/meson.build
 delete mode 100644 accel/tcg/Makefile.objs
 create mode 100644 accel/tcg/meson.build

diff --git a/Makefile.target b/Makefile.target
index bc5a019..438d27b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -110,7 +110,6 @@ obj-y +=3D trace/
 #########################################################
 # cpu emulator library
 obj-y +=3D exec.o
-obj-y +=3D accel/
 obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-=
gvec.o
 obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
deleted file mode 100644
index 8b498d3..0000000
--- a/accel/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(CONFIG_SOFTMMU) +=3D accel.o
-obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
-obj-$(CONFIG_KVM) +=3D kvm/
-obj-$(CONFIG_TCG) +=3D tcg/
-obj-y +=3D stubs/
diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
deleted file mode 100644
index fdfa481..0000000
--- a/accel/kvm/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y +=3D kvm-all.o
-obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
diff --git a/accel/kvm/meson.build b/accel/kvm/meson.build
new file mode 100644
index 0000000..4db2388
--- /dev/null
+++ b/accel/kvm/meson.build
@@ -0,0 +1,5 @@
+kvm_ss =3D ss.source_set()
+kvm_ss.add(files('kvm-all.c'))
+kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
+
+specific_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
diff --git a/accel/meson.build b/accel/meson.build
new file mode 100644
index 0000000..c356284
--- /dev/null
+++ b/accel/meson.build
@@ -0,0 +1,6 @@
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('accel.c'))
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: files('=
qtest.c'))
+
+subdir('kvm')
+subdir('tcg')
+subdir('stubs')
diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
deleted file mode 100644
index 3894caf..0000000
--- a/accel/stubs/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
-obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
-obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
-obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
-obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
new file mode 100644
index 0000000..8456de4
--- /dev/null
+++ b/accel/stubs/meson.build
@@ -0,0 +1,5 @@
+specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
+specific_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+specific_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
deleted file mode 100644
index d381a02..0000000
--- a/accel/tcg/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
-obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
-obj-y +=3D tcg-runtime.o tcg-runtime-gvec.o
-obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
-obj-y +=3D translator.o
-
-obj-$(CONFIG_USER_ONLY) +=3D user-exec.o
-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D user-exec-stub.o
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
new file mode 100644
index 0000000..605810a
--- /dev/null
+++ b/accel/tcg/meson.build
@@ -0,0 +1,14 @@
+tcg_ss =3D ss.source_set()
+tcg_ss.add(files(
+  'cpu-exec-common.c',
+  'cpu-exec.c',
+  'tcg-runtime-gvec.c',
+  'tcg-runtime.c',
+  'translate-all.c',
+  'translator.c',
+))
+tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
+tcg_ss.add(when: 'CONFIG_SOFTMMU', if_false: files('user-exec-stub.c'))
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: files('tc=
g-all.c', 'cputlb.c'))
diff --git a/meson.build b/meson.build
index c8428c0..1c9a941 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ subdir('replay')
 subdir('hw')
 subdir('libdecnumber')
 subdir('target')
+subdir('accel')
=20
 mods =3D []
 block_mods =3D []
--=20
1.8.3.1



