Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42846C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04F6206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkzuLtNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04F6206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBXB-0000dh-5a
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlBTf-000651-4O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:18:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlBTc-0004ha-6D
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592313486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiS7oTry1CUr59YKhEbDIllBwYLm+5wBF1b+e88qUCE=;
 b=OkzuLtNYxEIwIBYac/JpHq8gPHZ185zabtK5SR7WLqu6JmlLu9vl2frjGVTPjhDZoItvLi
 p01TiQWrQJik8ENyuYQem23Ul0Bwbnhq9gdTdORw3s2xRJTTX5/+m7mv5YIP2EbHLWOEZV
 nfmk1JZkhLlpVKgYDuO9pyeUenvWfwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-pvGIu64cNGaRXzYFBpSf0w-1; Tue, 16 Jun 2020 09:18:02 -0400
X-MC-Unique: pvGIu64cNGaRXzYFBpSf0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C3CE919;
 Tue, 16 Jun 2020 13:18:01 +0000 (UTC)
Received: from localhost (ovpn-112-244.ams2.redhat.com [10.36.112.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71EEF19C71;
 Tue, 16 Jun 2020 13:18:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] iotests: Make _filter_img_create more active
Date: Tue, 16 Jun 2020 15:17:55 +0200
Message-Id: <20200616131756.1073438-2-mreitz@redhat.com>
In-Reply-To: <20200616131756.1073438-1-mreitz@redhat.com>
References: <20200616131756.1073438-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Right now, _filter_img_create just filters out everything that looks
format-dependent, and applies some filename filters.  That means that we
have to add another filter line every time some format gets a new
creation option.  This can be avoided by instead discarding everything
and just keeping what we know is format-independent (format, size,
backing file, encryption information[1], preallocation) or just
interesting to have in the reference output (external data file path).

Furthermore, we probably want to sort these options.  Format drivers are
not required to define them in any specific order, so the output is
effectively random (although this has never bothered us until now).  We
need a specific order for our reference outputs, though.  Unfortunately,
just using a plain "sort" would change a lot of existing reference
outputs, so we have to pre-filter the option keys to keep our existing
order (fmt, size, backing*, data, encryption info, preallocation).

[1] Actually, the only thing that is really important is whether
    encryption is enabled or not.  A patch by Maxim thus removes all
    other "encrypt.*" options from the output:
    https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00339.html
    But that patch needs to come later so we can get away with changing
    as few reference outputs in this patch here as possible.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/112.out       |   2 +-
 tests/qemu-iotests/153           |   9 ++-
 tests/qemu-iotests/common.filter | 100 +++++++++++++++++++++++--------
 3 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index ae0318cabe..182655dbf6 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -5,7 +5,7 @@ QA output created by 112
 qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 refcount_bits=-1
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index cf961d3609..11e3d28841 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -167,11 +167,10 @@ done
 
 echo
 echo "== Creating ${TEST_IMG}.[abc] ==" | _filter_testdir
-(
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
-    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
-) | _filter_img_create
+$QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" | _filter_img_create
+$QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" | _filter_img_create
+$QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" \
+    | _filter_img_create
 
 echo
 echo "== Two devices sharing the same file in backing chain =="
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 03e4f71808..f104ad7a9b 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -122,38 +122,90 @@ _filter_actual_image_size()
 # replace driver-specific options in the "Formatting..." line
 _filter_img_create()
 {
-    data_file_filter=()
-    if data_file=$(_get_data_file "$TEST_IMG"); then
-        data_file_filter=(-e "s# data_file=$data_file##")
+    # Keep QMP output unchanged
+    qmp_pre=''
+    qmp_post=''
+    to_filter=''
+
+    while read -r line; do
+        if echo "$line" | grep -q '^{.*}$'; then
+            if [ -z "$to_filter" ]; then
+                # Use $'\n' so the newline is not dropped on variable
+                # expansion
+                qmp_pre="$qmp_pre$line"$'\n'
+            else
+                qmp_post="$qmp_post$line"$'\n'
+            fi
+        else
+            to_filter="$to_filter$line"$'\n'
+        fi
+    done
+
+    readarray -td '' formatting_line < \
+        <(echo "$to_filter" | sed -e 's/, fmt=/\x0/')
+
+    filename_part=${formatting_line[0]}
+    if [ -n "${formatting_line[1]}" ]; then
+        options="fmt=${formatting_line[1]}"
+    else
+        options=''
     fi
 
-    $SED "${data_file_filter[@]}" \
+    # Set grep_data_file to '\|data_file' to keep it; make it empty
+    # to drop it.
+    # We want to drop it if it is part of the global $IMGOPTS, and we
+    # want to keep it otherwise (if the test specifically wants to
+    # test data files).
+    grep_data_file='\|data_file'
+    if _get_data_file "$TEST_IMG" > /dev/null; then
+        grep_data_file=''
+    fi
+
+    filename_filters=(
         -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
-        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
-        -e "s# encryption=off##g" \
-        -e "s# cluster_size=[0-9]\\+##g" \
-        -e "s# table_size=[0-9]\\+##g" \
-        -e "s# compat=[^ ]*##g" \
-        -e "s# compat6=\\(on\\|off\\)##g" \
-        -e "s# static=\\(on\\|off\\)##g" \
-        -e "s# zeroed_grain=\\(on\\|off\\)##g" \
-        -e "s# subformat=[^ ]*##g" \
-        -e "s# adapter_type=[^ ]*##g" \
-        -e "s# hwversion=[^ ]*##g" \
-        -e "s# lazy_refcounts=\\(on\\|off\\)##g" \
-        -e "s# block_size=[0-9]\\+##g" \
-        -e "s# block_state_zero=\\(on\\|off\\)##g" \
-        -e "s# log_size=[0-9]\\+##g" \
-        -e "s# refcount_bits=[0-9]\\+##g" \
-        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=[0-9]\\+##g" \
-        -e "s# force_size=\\(on\\|off\\)##g" \
-        -e "s# compression_type=[a-zA-Z0-9]\\+##g"
+        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
+    )
+
+    filename_part=$(echo "$filename_part" | $SED "${filename_filters[@]}")
+
+    # Break the option line before each option (preserving pre-existing
+    # line breaks by replacing them by \0 and restoring them at the end),
+    # then filter out the options we want to keep and sort them according
+    # to some order that all block drivers used at the time of writing
+    # this function.
+    options=$(
+        echo "$options" \
+        | tr '\n' '\0' \
+        | sed -e 's/\x0$//' -e 's/ \([a-z0-9_.-]*\)=/\n\1=/g' \
+        | grep -ae "^\(fmt\\|size\\|backing\\|preallocation\\|encrypt$grep_data_file\\)" \
+        | $SED "${filename_filters[@]}" \
+            -e 's/^\(fmt\)/0-\1/' \
+            -e 's/^\(size\)/1-\1/' \
+            -e 's/^\(backing\)/2-\1/' \
+            -e 's/^\(data_file\)/3-\1/' \
+            -e 's/^\(encryption\)/4-\1/' \
+            -e 's/^\(encrypt\.format\)/5-\1/' \
+            -e 's/^\(encrypt\.key-secret\)/6-\1/' \
+            -e 's/^\(encrypt\.iter-time\)/7-\1/' \
+            -e 's/^\(preallocation\)/8-\1/' \
+        | sort \
+        | $SED -e 's/^[0-9]-//' \
+        | tr '\n\0' ' \n' \
+        | $SED -e 's/^ *$//' -e 's/ *$//'
+    )
+
+    echo -n "$qmp_pre"
+    if [ -n "$options" ]; then
+        echo "$filename_part, $options"
+    elif [ -n "$filename_part" ]; then
+        echo "$filename_part"
+    fi
+    echo -n "$qmp_post"
 }
 
 _filter_img_create_size()
-- 
2.26.2


