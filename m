Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EE921D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjFfm/PB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EE921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx1y-0003uN-He
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxX-0005ZR-OA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxV-0006vJ-Ux
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxV-0006tY-Qh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBELDc5M371DDIRCGrCXO5FnpOT5UWTnl2wTWpCAp2Q=;
 b=cjFfm/PBC6kraerXZqmT1gmAbZmbYCm1zkBAN1T+F0py/QtSdGEt98+CqGVDciuXTeLX/l
 NMgyo8RFfFfG7l1y9wnL0SY/ShV5cNCoLD2JN7JZGPJjwEaJ0La/5sCOE1/2kj+Oqy8SIR
 XHRNqYn7zyiyr7TE6c6Lui0IBVC9zuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-vH3lxPP0MH2e2H7eJp2EPQ-1; Thu, 19 Dec 2019 09:39:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5744108326B;
 Thu, 19 Dec 2019 14:39:18 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6DD25DA80;
 Thu, 19 Dec 2019 14:39:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 16/18] iotests: Allow testing FUSE exports
Date: Thu, 19 Dec 2019 15:38:16 +0100
Message-Id: <20191219143818.1646168-17-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vH3lxPP0MH2e2H7eJp2EPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pretends FUSE exports are a kind of protocol.  As such, they are
always tested under the format node.  This is probably the best way to
test them, actually, because this will generate more I/O load and more
varied patterns.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check         |   6 ++
 tests/qemu-iotests/common.filter |   5 +-
 tests/qemu-iotests/common.rc     | 148 +++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 90970b0549..dcb725e4eb 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -263,6 +263,7 @@ image protocol options
     -rbd                test rbd
     -sheepdog           test sheepdog
     -nbd                test nbd
+    -fuse               test fuse
     -ssh                test ssh
     -nfs                test nfs
     -vxhs               test vxhs
@@ -375,6 +376,11 @@ testlist options
             xpand=3Dfalse
             ;;
=20
+        -fuse)
+            IMGPROTO=3Dfuse
+            xpand=3Dfalse
+            ;;
+
         -vxhs)
             IMGPROTO=3Dvxhs
             xpand=3Dfalse
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index 3f8ee3e5f7..5f48351cae 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -44,7 +44,8 @@ _filter_qom_path()
 _filter_testdir()
 {
     $SED -e "s#$TEST_DIR/#TEST_DIR/#g" \
-         -e "s#$SOCK_DIR/#SOCK_DIR/#g"
+         -e "s#$SOCK_DIR/#SOCK_DIR/#g" \
+         -e "s#SOCK_DIR/fuse-#TEST_DIR/#g"
 }
=20
 # replace occurrences of the actual IMGFMT value with IMGFMT
@@ -135,6 +136,7 @@ _filter_img_create()
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
+        -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
         -e "s# encryption=3Doff##g" \
         -e "s# cluster_size=3D[0-9]\\+##g" \
         -e "s# table_size=3D[0-9]\\+##g" \
@@ -173,6 +175,7 @@ _filter_img_info()
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
+        -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
         -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
         -e "/encrypted: yes/d" \
         -e "/cluster_size: [0-9]\\+/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 192c988401..fbd8fb7309 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -219,6 +219,9 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix"
         TEST_IMG=3D"$TEST_IMG,file.path=3D$SOCK_DIR/nbd"
+    elif [ "$IMGPROTO" =3D "fuse" ]; then
+        TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
+        TEST_IMG=3D"$DRIVER,file.filename=3D$SOCK_DIR/fuse-t.$IMGFMT"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file.p=
ath=3D$TEST_IMG_FILE"
@@ -235,6 +238,9 @@ else
     elif [ "$IMGPROTO" =3D "nbd" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         TEST_IMG=3D"nbd+unix:///?socket=3D$SOCK_DIR/nbd"
+    elif [ "$IMGPROTO" =3D "fuse" ]; then
+        TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
+        TEST_IMG=3D"$SOCK_DIR/fuse-t.$IMGFMT"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         REMOTE_TEST_DIR=3D"ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)\\=
?$TEST_DIR"
@@ -253,6 +259,9 @@ fi
 ORIG_TEST_IMG_FILE=3D$TEST_IMG_FILE
 ORIG_TEST_IMG=3D"$TEST_IMG"
=20
+FUSE_PIDS=3D()
+FUSE_EXPORTS=3D()
+
 if [ -z "$TEST_DIR" ]; then
         TEST_DIR=3D$PWD/scratch
 fi
@@ -322,6 +331,10 @@ _test_img_to_test_img_file()
             echo "$1"
             ;;
=20
+        fuse)
+            echo "$1" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DIR/#"
+            ;;
+
         nfs)
             echo "$1" | sed -e "s#nfs://127.0.0.1##"
             ;;
@@ -353,6 +366,11 @@ _make_test_img()
     local opts_param=3Dfalse
     local misc_params=3D()
=20
+    if [[ $IMGPROTO =3D=3D fuse && $TEST_IMG =3D=3D $SOCK_DIR/fuse-* ]]; t=
hen
+        # The caller may be trying to overwrite an existing image
+        _rm_test_img "$TEST_IMG"
+    fi
+
     if [ -z "$TEST_IMG_FILE" ]; then
         img_name=3D$TEST_IMG
     elif [ "$TEST_IMG_FILE" =3D "$ORIG_TEST_IMG_FILE" ]; then
@@ -437,6 +455,68 @@ _make_test_img()
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi
=20
+    if [ $IMGPROTO =3D "fuse" -a -f "$img_name" ]; then
+        local export_mp
+        local pid
+        local pidfile
+        local timeout
+
+        export_mp=3D$(echo "$img_name" | sed -e "s#$TEST_DIR/#$SOCK_DIR/fu=
se-#")
+        if ! echo "$export_mp" | grep -q "^$SOCK_DIR"; then
+            echo 'Cannot use FUSE exports with images outside of TEST_DIR'=
 >&2
+            return 1
+        fi
+
+        touch "$export_mp"
+        rm -f "$SOCK_DIR/fuse-output"
+
+        # Usually, users would export formatted nodes.  But we present fus=
e as a
+        # protocol-level driver here, so we have to leave the format to th=
e
+        # client.
+        echo "{'execute': 'qmp_capabilities'}
+              {'execute': 'fuse-export-add',
+               'arguments': { 'node-name': 'export-node',
+                              'mountpoint': '$export_mp',
+                              'writable': true,
+                              'growable': true }}" | \
+        QEMU_NEED_PID=3Dy _QEMU_HANDLE=3Dfuse $QEMU -qmp stdio \
+              -M none,accel=3Dqtest -qtest null \
+              -blockdev file,node-name=3Dexport-node,filename=3D$img_name,=
discard=3Dunmap \
+              >$SOCK_DIR/fuse-output &
+
+        pidfile=3D"$QEMU_TEST_DIR/qemu-fuse.pid"
+
+        # Wait for the PID file
+        while [ ! -f "$pidfile" ]; do
+            sleep 0.5
+        done
+
+        pid=3D$(cat "$pidfile")
+        rm -f "$pidfile"
+
+        # Wait until the node is exported (i.e., both QMP commands
+        # have been completed)
+        timeout=3D10 # *0.5 s
+        while [ "$(grep -c return "$SOCK_DIR/fuse-output" 2>/dev/null)" !=
=3D 2 ]; do
+            sleep 0.5
+
+            timeout=3D$((timeout - 1))
+            if [ "$timeout" =3D 0 ]; then
+                kill -SIGTERM $pid
+                echo 'Failed to set up FUSE export:' >&2
+                cat "$SOCK_DIR/fuse-output" >&2
+                rm -f "$export_mp"
+                break
+            fi
+        done
+        rm -f "$SOCK_DIR/fuse-output"
+
+        if [ "$timeout" -gt 0 ]; then
+            FUSE_PIDS+=3D($pid)
+            FUSE_EXPORTS+=3D("$export_mp")
+        fi
+    fi
+
     # Start QNIO server on image directory for vxhs protocol
     if [ $IMGPROTO =3D "vxhs" ]; then
         eval "$QEMU_VXHS -d  $TEST_DIR > /dev/null &"
@@ -447,6 +527,63 @@ _make_test_img()
 _rm_test_img()
 {
     local img=3D$1
+
+    if [[ $IMGPROTO =3D=3D fuse && $img =3D=3D $SOCK_DIR/fuse-* ]]; then
+        # Drop a FUSE export
+        local df_output
+        local i
+        local image_file
+        local index=3D''
+        local timeout
+
+        for i in "${!FUSE_EXPORTS[@]}"; do
+            if [ "${FUSE_EXPORTS[i]}" =3D "$img" ]; then
+                index=3D$i
+                break
+            fi
+        done
+
+        if [ -z "$index" ]; then
+            # Probably gone already
+            return 0
+        fi
+
+        kill "${FUSE_PIDS[index]}"
+
+        # Wait until the mount is gone
+        timeout=3D10 # *0.5 s
+        while true; do
+            # Will show the mount point; if the mount is still there,
+            # it will be $img.
+            df_output=3D$(df -T "$img" 2>/dev/null)
+
+            # But df may also show an error ("Transpoint endpoint not
+            # connected"), so retry in such cases
+            if [ -n "$df_output" ]; then
+                if ! echo "$df_output" | grep -q "$img"; then
+                    break
+                fi
+            fi
+
+            sleep 0.5
+
+            timeout=3D$((timeout - 1))
+            if [ "$timeout" =3D 0 ]; then
+                echo 'Failed to take down FUSE export' >&2
+                return 1
+            fi
+        done
+
+        rm -f "$img"
+
+        unset "FUSE_PIDS[$index]"
+        unset "FUSE_EXPORTS[$index]"
+
+        image_file=3D$(echo "$img" | sed -e "s#$SOCK_DIR/fuse-#$TEST_DIR/#=
")
+        _rm_test_img "$image_file"
+        return
+    fi
+
     if [ "$IMGFMT" =3D "vmdk" ]; then
         # Remove all the extents for vmdk
         "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut -f 2 =
-d: \
@@ -468,6 +605,16 @@ _cleanup_test_img()
             _stop_nbd_server
             rm -f "$TEST_IMG_FILE"
             ;;
+        fuse)
+            local mp
+
+            for mp in "${FUSE_EXPORTS[@]}"; do
+                _rm_test_img "$mp"
+            done
+
+            FUSE_PIDS=3D()
+            FUSE_EXPORTS=3D()
+            ;;
         vxhs)
             if [ -f "${TEST_DIR}/qemu-vxhs.pid" ]; then
                 local QEMU_VXHS_PID
@@ -544,6 +691,7 @@ _img_info()
         sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
+            -e "s#$SOCK_DIR/fuse-#TEST_DIR/#g" \
             -e "s#$IMGFMT#IMGFMT#g" \
             -e "/^disk size:/ D" \
             -e "/actual-size/ D" | \
--=20
2.23.0


