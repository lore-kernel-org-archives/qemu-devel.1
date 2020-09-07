Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1810C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527EC21789
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4p4PyoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527EC21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFF3Y-0004Vl-Cn
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF21-0001o9-6k
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:09:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF1x-0007r5-9U
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599476988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwwsizA8wZLAMhtY0I3uDrT+BvYuFUdgkFyXW4YBq/M=;
 b=V4p4PyoIPA7tBtVnsSJZUW+zOiBJvHADsj4Yesd44ATNrNGMnBTnPSBCeJO+da+Eg+1I7w
 WPN46nyOS963lOFMfeLWW3YGtqQUaf/fvpO2emCwgKlJG2U0utQD2AvLQANqMNWtHVcFo+
 PrbReD6vqZQ3TwGpND0ySJWrp5uRWuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-inHlReUJOVGvbR3Kl8N4EQ-1; Mon, 07 Sep 2020 07:09:44 -0400
X-MC-Unique: inHlReUJOVGvbR3Kl8N4EQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 380191084C8A;
 Mon,  7 Sep 2020 11:09:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 411337E43C;
 Mon,  7 Sep 2020 11:09:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/64] block: Raise an error when backing file parameter is an
 empty string
Date: Mon,  7 Sep 2020 13:08:33 +0200
Message-Id: <20200907110936.261684-2-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Connor Kuehl <ckuehl@redhat.com>

Providing an empty string for the backing file parameter like so:

	qemu-img create -f qcow2 -b '' /tmp/foo

allows the flow of control to reach and subsequently fail an assert
statement because passing an empty string to

	bdrv_get_full_backing_filename_from_filename()

simply results in NULL being returned without an error being raised.

To fix this, let's check for an empty string when getting the value from
the opts list.

Reported-by: Attila Fazekas <afazekas@redhat.com>
Fixes: https://bugzilla.redhat.com/1809553
Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
Message-Id: <20200813134722.802180-1-ckuehl@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                    | 4 ++++
 tests/qemu-iotests/049     | 4 ++++
 tests/qemu-iotests/049.out | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/block.c b/block.c
index 2ba76b2c36..b204b93a2e 100644
--- a/block.c
+++ b/block.c
@@ -6119,6 +6119,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
                              "same filename as the backing file");
             goto out;
         }
+        if (backing_file[0] == '\0') {
+            error_setg(errp, "Expected backing file name, got empty string");
+            goto out;
+        }
     }
 
     backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 051a1c79e0..82b1e6c202 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -119,6 +119,10 @@ test_qemu_img create -f $IMGFMT -o compat=1.1,lazy_refcounts=on "$TEST_IMG" 64M
 test_qemu_img create -f $IMGFMT -o compat=0.10,lazy_refcounts=off "$TEST_IMG" 64M
 test_qemu_img create -f $IMGFMT -o compat=0.10,lazy_refcounts=on "$TEST_IMG" 64M
 
+echo "== Expect error when backing file name is empty string =="
+echo
+test_qemu_img create -f $IMGFMT -b '' $TEST_IMG 1M
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index a7e220830d..b1d8fd9107 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -209,4 +209,9 @@ qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=on refcount_bits=16
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
 
+== Expect error when backing file name is empty string ==
+
+qemu-img create -f qcow2 -b  TEST_DIR/t.qcow2 1M
+qemu-img: TEST_DIR/t.qcow2: Expected backing file name, got empty string
+
 *** done
-- 
2.25.4


