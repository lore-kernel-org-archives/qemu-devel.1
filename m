Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LONGWORDS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996BB206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnZlOlAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996BB206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxLV-00083S-RC
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH3-0002Vx-Ou
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH1-0000fV-Pg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxH1-0000Yt-J8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uCy/at11WUsP92Tsm1LcEPN7d0Z7sh7F8Nakmm3N20=;
 b=BnZlOlAWg2pW4929MCu+hCD6vi+AMkbfwg3JUVsB0mmCEA2Ao4btogh82sf9GMPW7utFSR
 +0/GNjCqSx8wrCviXaUmRtNz75qabmIRwZzfFACgbjMKWw1ySTZmJAfZX3gPfPSjabDeRa
 Ihng9OaiJM94DuL054iPHbsNSQty67M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-rvGdDK7PPGWGZZiRfxRNXg-1; Mon, 16 Mar 2020 17:27:42 -0400
X-MC-Unique: rvGdDK7PPGWGZZiRfxRNXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2D2107ACC7;
 Mon, 16 Mar 2020 21:27:41 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47D8819756;
 Mon, 16 Mar 2020 21:27:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/61] configure: add configure option avx512f_opt
Date: Mon, 16 Mar 2020 22:26:32 +0100
Message-Id: <1584394048-44994-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

If it is enabled, config-host.mak will have CONFIG_AVX512F_OPT defined.

AVX512F instruction set is available since Intel Skylake, and can be enable=
d in
compiling with -mavx512f.
More info:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-i=
nstruction-set-extensions-programming-reference.pdf

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/configure b/configure
index eb49bb6..1a82683 100755
--- a/configure
+++ b/configure
@@ -1421,6 +1421,11 @@ for opt do
   ;;
   --enable-avx2) avx2_opt=3D"yes"
   ;;
+  --disable-avx512f) avx512f_opt=3D"no"
+  ;;
+  --enable-avx512f) avx512f_opt=3D"yes"
+  ;;
+
   --enable-glusterfs) glusterfs=3D"yes"
   ;;
   --disable-virtio-blk-data-plane|--enable-virtio-blk-data-plane)
@@ -1857,6 +1862,7 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   avx2            AVX2 optimization support
+  avx512f         AVX512F optimization support
   replication     replication support
   opengl          opengl support
   virglrenderer   virgl rendering support
@@ -5574,6 +5580,36 @@ EOF
   fi
 fi
=20
+##########################################
+# avx512f optimization requirement check
+#
+# There is no point enabling this if cpuid.h is not usable,
+# since we won't be able to select the new routines.
+# by default, it is turned off.
+# if user explicitly want to enable it, check environment
+
+if test "$cpuid_h" =3D "yes" && test "$avx512f_opt" =3D "yes"; then
+  cat > $TMPC << EOF
+#pragma GCC push_options
+#pragma GCC target("avx512f")
+#include <cpuid.h>
+#include <immintrin.h>
+static int bar(void *a) {
+    __m512i x =3D *(__m512i *)a;
+    return _mm512_test_epi64_mask(x, x);
+}
+int main(int argc, char *argv[])
+{
+=09return bar(argv[0]);
+}
+EOF
+  if ! compile_object "" ; then
+    avx512f_opt=3D"no"
+  fi
+else
+  avx512f_opt=3D"no"
+fi
+
 ########################################
 # check if __[u]int128_t is usable.
=20
@@ -6717,6 +6753,7 @@ echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
+echo "avx512f optimization $avx512f_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "bochs support     $bochs"
@@ -7268,6 +7305,10 @@ if test "$avx2_opt" =3D "yes" ; then
   echo "CONFIG_AVX2_OPT=3Dy" >> $config_host_mak
 fi
=20
+if test "$avx512f_opt" =3D "yes" ; then
+  echo "CONFIG_AVX512F_OPT=3Dy" >> $config_host_mak
+fi
+
 if test "$lzo" =3D "yes" ; then
   echo "CONFIG_LZO=3Dy" >> $config_host_mak
 fi
--=20
1.8.3.1



