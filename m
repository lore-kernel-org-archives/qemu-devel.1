Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C6C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7F322314
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDkqnPMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7F322314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LkW-0003iM-Ag
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2LjT-0003FY-PR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2LjQ-0005qv-RO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:09:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2LjQ-0005oC-K9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581628147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MrXFk6rRr7enkwWEzDIwTkxGwpvTRYpjiIgji8Qzcs=;
 b=iDkqnPMKMaMHcQymgfK/rN1TWbh+9RqlMmvf4v4VHbff81uGd15CulUVZOUZDPQpheW4s0
 ieHhlLvp6WQJB3Y/xmfIpE1nNil+oMWle8UeEvJWR+lzP+qGJkBsR3JOkylaSZA0jKoMID
 KVcu8QbPRXX1RMf+EAXbT0qeNSNEtV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-sWZ2kjCTP9WDtQGE5wcqLw-1; Thu, 13 Feb 2020 16:09:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7CF13E4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 21:09:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A4C990092;
 Thu, 13 Feb 2020 21:09:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 6/8] configure: Enable test and libs for zstd
In-Reply-To: <20200211201107.GR55376@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Tue, 11 Feb 2020 20:11:07 +0000")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-7-quintela@redhat.com>
 <20200211201107.GR55376@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 22:08:59 +0100
Message-ID: <87k14qjitw.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sWZ2kjCTP9WDtQGE5wcqLw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Jan 29, 2020 at 12:56:53PM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  configure | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>
> This is adding a new 3rd party library to QEMU that we've not previously
> built and so isn't included in any of our CI platforms.

Ok.

Learning how one does that.

> This commit should be updating at least some of our CI platforms to
> request the libzstd library installation to get CI coverage for the
> latest patches in this series.

> Probably the docker files,

I added it in all debian/centos/fedora files that zlib-dev or xen-dev

> the VM installs for FreeBSD at least,

A fast google finds that library is called "zstd" and that it includes
the includes (put intended)

tests/vm/freebsd

Once there, include it in fedora

> travis and

I added it to .travis.yml

> gitlab CI.

gitlab-ci.yml (just when we compile x86_64-softmmu)

I have something like this, but net real clue how to test that I haven't
broken anything:

commit 59d8694dfcfc3d5ef36bc72a5c02bedaa3a6a6ec
Author: Juan Quintela <quintela@redhat.com>
Date:   Thu Feb 13 22:06:16 2020 +0100

    Use zstd packages
   =20
    Signed-off-by: Juan Quintela <quintela@redhat.com>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c15e394f09..72f8b8aa51 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -21,6 +21,7 @@ build-system2:
  script:
  - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-d=
ev
       libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
+      libzstd-dev
  - mkdir build
  - cd build
  - ../configure --enable-werror --target-list=3D"tricore-softmmu unicore32=
-softmmu
diff --git a/.travis.yml b/.travis.yml
index 5887055951..dd17301f3b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -48,6 +48,7 @@ addons:
       - libusb-1.0-0-dev
       - libvdeplug-dev
       - libvte-2.91-dev
+      - libzstd-dev
       - sparse
       - uuid-dev
       - gcovr
diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerf=
iles/centos7.docker
index 562d65be9e..cdd72de7eb 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -33,6 +33,7 @@ ENV PACKAGES \
     tar \
     vte-devel \
     xen-devel \
-    zlib-devel
+    zlib-devel \
+    libzstd-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/dock=
er/dockerfiles/fedora-i386-cross.docker
index 9106cf9ebe..cd16cd1bfa 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -7,7 +7,8 @@ ENV PACKAGES \
     gnutls-devel.i686 \
     nettle-devel.i686 \
     pixman-devel.i686 \
-    zlib-devel.i686
+    zlib-devel.i686 \
+    libzstd-devel.i686
=20
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 987a3c170a..a6522228c0 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -92,7 +92,8 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
-    zlib-devel
+    zlib-devel \
+    libzstd-devel
 ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
=20
 RUN dnf install -y $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfi=
les/ubuntu.docker
index 4177f33691..b6c7b41ddd 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -58,6 +58,7 @@ ENV PACKAGES flex bison \
     libvdeplug-dev \
     libvte-2.91-dev \
     libxen-dev \
+    libzstd-dev \
     make \
     python3-yaml \
     python3-sphinx \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dock=
erfiles/ubuntu1804.docker
index 0766f94cf4..1efedeef99 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -44,6 +44,7 @@ ENV PACKAGES flex bison \
     libvdeplug-dev \
     libvte-2.91-dev \
     libxen-dev \
+    libzstd-dev \
     make \
     python3-yaml \
     python3-sphinx \
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 4d7d6049f4..4843b4175e 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -53,7 +53,10 @@ class FedoraVM(basevm.BaseVM):
         # libs: audio
         '"pkgconfig(libpulse)"',
         '"pkgconfig(alsa)"',
-    ]
+
+        # libs: migration
+        '"pkgconfig(libzstd)"',
+]
=20
     BUILD_SCRIPT =3D """
         set -e;
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index fb54334696..86770878b6 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -55,6 +55,9 @@ class FreeBSDVM(basevm.BaseVM):
         # libs: opengl
         "libepoxy",
         "mesa-libs",
+
+        # libs: migration
+        "zstd",
     ]
=20
     BUILD_SCRIPT =3D """
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c5069a45f4..55590f4601 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -49,6 +49,9 @@ class NetBSDVM(basevm.BaseVM):
         "SDL2",
         "gtk3+",
         "libxkbcommon",
+
+        # libs: migration
+        "zstd",
     ]
=20
     BUILD_SCRIPT =3D """
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 22cd9513dd..ab6abbedab 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -51,6 +51,9 @@ class OpenBSDVM(basevm.BaseVM):
         "sdl2",
         "gtk+3",
         "libxkbcommon",
+
+        # libs: migration
+        "zstd",
     ]
=20
     BUILD_SCRIPT =3D """


