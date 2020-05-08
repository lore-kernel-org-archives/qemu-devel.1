Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D360C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E8924974
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bokr645P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E8924974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2LY-0001hC-0v
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2K5-0008CR-4i
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:41:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2K4-0007kE-5A
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mImBtO/yl3EWMcnfVpmStZhszGEtXG+arJx2PuLGp1A=;
 b=Bokr645P7QUBx99q5Yc9n7xDXWLuGHqvCh9DHCqpMvaBjxNcf3mhud4WTyyX0uL6p0d7SA
 u301ywkgF2GzbfhfwqXOuUS5S42AO2IzTpFcSom//fGZZfg2jydC9lhQfPqfK8a3ZkfbHu
 td7F8rPEQFfhL0EoXTtn6xM6GquD1sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-RHRRwZhcMweOAuIOEt2JZg-1; Fri, 08 May 2020 08:41:44 -0400
X-MC-Unique: RHRRwZhcMweOAuIOEt2JZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B3880183C;
 Fri,  8 May 2020 12:41:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8CB319167;
 Fri,  8 May 2020 12:41:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/30] iotests: handle tmpfs
Date: Fri,  8 May 2020 14:41:06 +0200
Message-Id: <20200508124135.252565-2-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Some tests requires O_DIRECT, or want it by default. Introduce smarter
O_DIRECT handling:

- Check O_DIRECT in common.rc, if it is requested by selected
cache-mode.

- Support second fall-through argument in _default_cache_mode

Inspired-by: Max's 23e1d054112cec1e
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200430124713.3067-2-vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/091       |  2 +-
 tests/qemu-iotests/common.rc | 37 ++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index d2a2aca347..68fbfd777b 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -46,8 +46,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-_default_cache_mode none
 _supported_cache_modes writethrough none writeback
+_default_cache_mode none writeback
=20
 size=3D1G
=20
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index bf3b9fdea0..ba912555ca 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -673,11 +673,44 @@ _supported_cache_modes()
     _notrun "not suitable for cache mode: $CACHEMODE"
 }
=20
+# Check whether the filesystem supports O_DIRECT
+_check_o_direct()
+{
+    $QEMU_IMG create -f raw "$TEST_IMG".test_o_direct 1M > /dev/null
+    out=3D$($QEMU_IO -f raw -t none -c quit "$TEST_IMG".test_o_direct 2>&1=
)
+    rm -f "$TEST_IMG".test_o_direct
+
+    [[ "$out" !=3D *"O_DIRECT"* ]]
+}
+
+_require_o_direct()
+{
+    if ! _check_o_direct; then
+        _notrun "file system on $TEST_DIR does not support O_DIRECT"
+    fi
+}
+
+_check_cache_mode()
+{
+    if [ $CACHEMODE =3D=3D "none" ] || [ $CACHEMODE =3D=3D "directsync" ];=
 then
+        _require_o_direct
+    fi
+}
+
+_check_cache_mode
+
+# $1 - cache mode to use by default
+# $2 - (optional) cache mode to use by default if O_DIRECT is not supporte=
d
 _default_cache_mode()
 {
     if $CACHEMODE_IS_DEFAULT; then
-        CACHEMODE=3D"$1"
-        QEMU_IO=3D"$QEMU_IO --cache $1"
+        if [ -z "$2" ] || _check_o_direct; then
+            CACHEMODE=3D"$1"
+        else
+            CACHEMODE=3D"$2"
+        fi
+        QEMU_IO=3D"$QEMU_IO --cache $CACHEMODE"
+        _check_cache_mode
         return
     fi
 }
--=20
2.25.3


