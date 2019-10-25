Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C6ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7432084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNq95hHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7432084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2RC-0000eV-Co
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iO27e-0004xl-G8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iO27c-00043s-O3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:07:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iO27c-00043k-K1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572019648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KveTrEY2PYZqXZICipBAQRcEI4wbdQiduaTHLrzZMeM=;
 b=YNq95hHpyozUaXEe5+a2nEmgip+TTAR22waedM+7myZrsVuRfbS9Jo/mOBpQTnEMXMIG3w
 8My8XH1k9p0AN4KxZ4ZYJ8/yDU8RZgVNr10uhIg+yvBUPKIhype/hrr69ePTQfDI6jzPp1
 ZSGITbeqFNed9YiqrVtDTxOcsBn835k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-J32qlknnOqqGlmAvz85IDg-1; Fri, 25 Oct 2019 12:07:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A65821800E00;
 Fri, 25 Oct 2019 16:07:23 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4B531001B2D;
 Fri, 25 Oct 2019 16:07:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/15] tests/qemu-iotests: enable testing with aio options
Date: Fri, 25 Oct 2019 18:04:43 +0200
Message-Id: <20191025160444.31632-15-stefanha@redhat.com>
In-Reply-To: <20191025160444.31632-1-stefanha@redhat.com>
References: <20191025160444.31632-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: J32qlknnOqqGlmAvz85IDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/check      | 15 ++++++++++++++-
 tests/qemu-iotests/common.rc  | 14 ++++++++++++++
 tests/qemu-iotests/iotests.py | 12 ++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 588c453a94..150fb71cf9 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -132,6 +132,7 @@ sortme=3Dfalse
 expunge=3Dtrue
 have_test_arg=3Dfalse
 cachemode=3Dfalse
+aiomode=3Dfalse
=20
 tmp=3D"${TEST_DIR}"/$$
 rm -f $tmp.list $tmp.tmp $tmp.sed
@@ -141,6 +142,7 @@ export IMGFMT_GENERIC=3Dtrue
 export IMGPROTO=3Dfile
 export IMGOPTS=3D""
 export CACHEMODE=3D"writeback"
+export AIOMODE=3D"threads"
 export QEMU_IO_OPTIONS=3D""
 export QEMU_IO_OPTIONS_NO_FMT=3D""
 export CACHEMODE_IS_DEFAULT=3Dtrue
@@ -225,6 +227,11 @@ s/ .*//p
         CACHEMODE_IS_DEFAULT=3Dfalse
         cachemode=3Dfalse
         continue
+    elif $aiomode
+    then
+        AIOMODE=3D"$r"
+        aiomode=3Dfalse
+        continue
     fi
=20
     xpand=3Dtrue
@@ -269,6 +276,7 @@ other options
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
     -c mode             cache mode
+    -i mode             AIO mode
     -makecheck          pretty print output for make check
=20
 testlist options
@@ -433,10 +441,13 @@ testlist options
             cachemode=3Dtrue
             xpand=3Dfalse
             ;;
+        -i)
+            aiomode=3Dtrue
+            xpand=3Dfalse
+            ;;
         -T)        # deprecated timestamp option
             xpand=3Dfalse
             ;;
-
         -v)
             verbose=3Dtrue
             xpand=3Dfalse
@@ -515,6 +526,8 @@ done
=20
 # Set qemu-io cache mode with $CACHEMODE we have
 QEMU_IO_OPTIONS=3D"$QEMU_IO_OPTIONS --cache $CACHEMODE"
+# Set qemu-io aio mode with $AIOMODE we have
+QEMU_IO_OPTIONS=3D"$QEMU_IO_OPTIONS --aio $AIOMODE"
=20
 QEMU_IO_OPTIONS_NO_FMT=3D"$QEMU_IO_OPTIONS"
 if [ "$IMGOPTSSYNTAX" !=3D "true" ]; then
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 12b4751848..13f934f79b 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -576,6 +576,20 @@ _default_cache_mode()
         return
     fi
 }
+_supported_aio_modes()
+{
+    for mode; do
+        if [ "$mode" =3D "$AIOMODE" ]; then
+            return
+        fi
+    done
+    _notrun "not suitable for aio mode: $AIOMODE"
+}
+_default_aio_mode()
+{
+    AIOMODE=3D"$1"
+    QEMU_IO=3D"$QEMU_IO --aio $1"
+}
=20
 _unsupported_imgopts()
 {
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 693fde155a..0d4ef6b3e6 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -59,6 +59,7 @@ imgproto =3D os.environ.get('IMGPROTO', 'file')
 test_dir =3D os.environ.get('TEST_DIR')
 output_dir =3D os.environ.get('OUTPUT_DIR', '.')
 cachemode =3D os.environ.get('CACHEMODE')
+aiomode =3D os.environ.get('AIOMODE')
 qemu_default_machine =3D os.environ.get('QEMU_DEFAULT_MACHINE')
=20
 socket_scm_helper =3D os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_help=
er')
@@ -483,6 +484,7 @@ class VM(qtest.QEMUQtestMachine):
             options.append('file=3D%s' % path)
             options.append('format=3D%s' % format)
             options.append('cache=3D%s' % cachemode)
+            options.append('aio=3D%s' % aiomode)
=20
         if opts:
             options.append(opts)
@@ -888,6 +890,10 @@ def verify_cache_mode(supported_cache_modes=3D[]):
     if supported_cache_modes and (cachemode not in supported_cache_modes):
         notrun('not suitable for this cache mode: %s' % cachemode)
=20
+def verify_aio_mode(supported_aio_modes=3D[]):
+    if supported_aio_modes and (aiomode not in supported_aio_modes):
+        notrun('not suitable for this aio mode: %s' % aiomode)
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
=20
@@ -945,8 +951,9 @@ def execute_unittest(output, verbosity, debug):
=20
 def execute_test(test_function=3DNone,
                  supported_fmts=3D[], supported_oses=3D['linux'],
-                 supported_cache_modes=3D[], unsupported_fmts=3D[],
-                 supported_protocols=3D[], unsupported_protocols=3D[]):
+                 supported_cache_modes=3D[], supported_aio_modes=3D{},
+                 unsupported_fmts=3D[], supported_protocols=3D[],
+                 unsupported_protocols=3D[]):
     """Run either unittest or script-style tests."""
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
@@ -963,6 +970,7 @@ def execute_test(test_function=3DNone,
     verify_protocol(supported_protocols, unsupported_protocols)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
+    verify_aio_mode(supported_aio_modes)
=20
     if debug:
         output =3D sys.stdout
--=20
2.21.0


