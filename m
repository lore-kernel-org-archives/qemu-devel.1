Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E3AC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43812178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKgTRDVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43812178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSl3J-0007Qq-6q
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSknK-0003fz-P3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSknI-0005sH-IH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:38:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSknI-0005s3-Er
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmvXUS7ixWiJePJc7E9WRwPPa9NWTE+NSkkZoP/0Uiw=;
 b=PKgTRDVG8bdMGFN+Ld+gVim8rA/zD1V2rX+wm0ElrKLAsRz/6P0cVfxHSS7bo2YCBOrrmN
 DROBwnNjI+v8AzCRG966bwzNadvktx98quFpexZaMsVaxsdFXrxBklM5+nt1Ll7OhX/dbZ
 mMcKtIOlPvxKkpz4M2baK9Za20c2EHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-C9pQ6CtDNIudiaCDiU2LLQ-1; Thu, 07 Nov 2019 11:37:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC1B91800D6B;
 Thu,  7 Nov 2019 16:37:57 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2615D6A0;
 Thu,  7 Nov 2019 16:37:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 22/22] iotests: Allow check -o data_file
Date: Thu,  7 Nov 2019 17:37:08 +0100
Message-Id: <20191107163708.833192-23-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: C9pQ6CtDNIudiaCDiU2LLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The problem with allowing the data_file option is that you want to use a
different data file per image used in the test.  Therefore, we need to
allow patterns like -o data_file=3D'$TEST_IMG.data_file'.

Then, we need to filter it out from qemu-img map, qemu-img create, and
remove the data file in _rm_test_img.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/common.filter | 23 +++++++++++++++++++++--
 tests/qemu-iotests/common.rc     | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index 8a0169f19a..6902f9d94b 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -122,7 +122,13 @@ _filter_actual_image_size()
 # replace driver-specific options in the "Formatting..." line
 _filter_img_create()
 {
-    $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
+    data_file_filter=3D()
+    if data_file=3D$(_get_data_file "$TEST_IMG"); then
+        data_file_filter=3D(-e "s# data_file=3D$data_file##")
+    fi
+
+    $SED "${data_file_filter[@]}" \
+        -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
@@ -207,9 +213,22 @@ _filter_img_info()
 # human and json output
 _filter_qemu_img_map()
 {
+    # Assuming the data_file value in $IMGOPTS contains a '$TEST_IMG',
+    # create a filter that replaces the data file name by $TEST_IMG.
+    # Example:
+    #   In $IMGOPTS: 'data_file=3D$TEST_IMG.data_file'
+    #   Then data_file_pattern =3D=3D '\(.*\).data_file'
+    #   And  data_file_filter  =3D=3D -e 's#\(.*\).data_file#\1#
+    data_file_filter=3D()
+    if data_file_pattern=3D$(_get_data_file '\\(.*\\)'); then
+        data_file_filter=3D(-e "s#$data_file_pattern#\\1#")
+    fi
+
     $SED -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
         -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
-        -e 's/Mapped to *//' | _filter_testdir | _filter_imgfmt
+        -e 's/Mapped to *//' \
+        "${data_file_filter[@]}" \
+        | _filter_testdir | _filter_imgfmt
 }
=20
 _filter_nbd()
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index a623485f96..a07a10a305 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -297,6 +297,20 @@ _stop_nbd_server()
     fi
 }
=20
+# Gets the data_file value from IMGOPTS and replaces the '$TEST_IMG'
+# pattern by '$1'
+# Caution: The replacement is done with sed, so $1 must be escaped
+#          properly.  (The delimiter is '#'.)
+_get_data_file()
+{
+    if ! echo "$IMGOPTS" | grep -q 'data_file=3D'; then
+        return 1
+    fi
+
+    echo "$IMGOPTS" | sed -e 's/.*data_file=3D\([^,]*\).*/\1/' \
+                    | sed -e "s#\\\$TEST_IMG#$1#"
+}
+
 _make_test_img()
 {
     # extra qemu-img options can be added by tests
@@ -317,7 +331,8 @@ _make_test_img()
     fi
=20
     if [ -n "$IMGOPTS" ]; then
-        optstr=3D$(_optstr_add "$optstr" "$IMGOPTS")
+        imgopts_expanded=3D$(echo "$IMGOPTS" | sed -e "s#\\\$TEST_IMG#$img=
_name#")
+        optstr=3D$(_optstr_add "$optstr" "$imgopts_expanded")
     fi
     if [ -n "$IMGKEYSECRET" ]; then
         object_options=3D"--object secret,id=3Dkeysec0,data=3D$IMGKEYSECRE=
T"
@@ -396,6 +411,11 @@ _rm_test_img()
         # Remove all the extents for vmdk
         "$QEMU_IMG" info "$img" 2>/dev/null | grep 'filename:' | cut -f 2 =
-d: \
             | xargs -I {} rm -f "{}"
+    elif [ "$IMGFMT" =3D "qcow2" ]; then
+        # Remove external data file
+        if data_file=3D$(_get_data_file "$img"); then
+            rm -f "$data_file"
+        fi
     fi
     rm -f "$img"
 }
--=20
2.23.0


