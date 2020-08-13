Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE81C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3862B20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1cOKc9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3862B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Dad-0000d7-Hv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 09:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1k6DZp-00005L-Ag
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 09:47:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22152
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1k6DZn-00058a-J8
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597326446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SCEn4+IdHMyTKYAjnshfZmdKeKd/yp8C48f3DkoJEPk=;
 b=P1cOKc9bEori0I/wP9/ZZvHmSsDl+mf1BnL/SBHCUo1KX0IFyncUrvLtH9NB0sk+fruhAO
 oIHclNEYd+6zAmJAebhJm5JCsdzG2dR7Q9h1hZZn/uTBUeJx+JZNFOxIlEUe1WFlwrA2mN
 dDAJlplLVggWe4ie0ajvDJO0kCbxCyY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-GBrjeix6O-GoMxmIq_JToQ-1; Thu, 13 Aug 2020 09:47:25 -0400
X-MC-Unique: GBrjeix6O-GoMxmIq_JToQ-1
Received: by mail-qk1-f200.google.com with SMTP id v22so3933678qkg.15
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 06:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SCEn4+IdHMyTKYAjnshfZmdKeKd/yp8C48f3DkoJEPk=;
 b=qupgqiog8QV03H+cjK4NfMrHxR/lkUn02zk6lD0YkcG4mHYzKoDI5rDr+atSwXN/7J
 +f68ScTqhnFmn12nDkiLv9q22InNoS5WVjh4B8lX2cLhlQRhv3RuQRzfJREG7gS+lqto
 pPEmNYkIBHx7fttWPzVl7uA6vLQeHXEZ8gd/Q4ABfr4Ubhs/5rkielmB3WCWSUv8euAI
 gP9bMGHXs73EwkG0ryV/Byq3+huBPC4xfuPcNyDNRb9ETHU7r9qxxEc27IC3UzXaos0L
 UxDeIdUnd5oEdnywmtZ9jBcZFJieSPhWydVc2Droy9O85XUajSm+Tntv1qgZ1QuS5M9R
 XjZA==
X-Gm-Message-State: AOAM530zJt9GSrh7MrKXLM1HJZUjxmAAsMY7Jt3j5jiGP3zrijy/3U6h
 5c3M99ppa7CxTw9PNtkbFMAdmdfq57GlNsMpHoq56DFTh/fqWWJpYZqrAaCJjeUzZfU9NcR3Mz7
 tw+tje0nsV+U7P5Y=
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr5192464qtt.42.1597326444317;
 Thu, 13 Aug 2020 06:47:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFgpkoLMm8sfDHnX97HJgiRyxArZafiCZwCH+f/ua6Nsx/eb/sUGWc76kfPc+fWOU2F6Y+hA==
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr5192449qtt.42.1597326444107;
 Thu, 13 Aug 2020 06:47:24 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id o21sm5276614qkk.94.2020.08.13.06.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 06:47:23 -0700 (PDT)
From: Connor Kuehl <ckuehl@redhat.com>
To: kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v3] block: Raise an error when backing file parameter is an
 empty string
Date: Thu, 13 Aug 2020 08:47:22 -0500
Message-Id: <20200813134722.802180-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 08:00:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
v3:
  - Moved test case into 049 instead of taking up
    298.

v2:
  - Removed 4 spaces to resolve pylint warning
  - Updated format to be 'iotests.imgfmt' instead
    of hardcoding 'qcow2'
  - Use temporary file instead of '/tmp/foo'
  - Give a size parameter to qemu-img
  - Run test for qcow2, qcow, qed and *not* raw

 block.c                    | 4 ++++
 tests/qemu-iotests/049     | 4 ++++
 tests/qemu-iotests/049.out | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/block.c b/block.c
index d9ac0e07eb..1f72275b87 100644
--- a/block.c
+++ b/block.c
@@ -6117,6 +6117,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
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
index 4c21dc70a5..61ee90b10e 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -209,4 +209,9 @@ qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 compression_type=zlib size=67108864 compat=0.10 lazy_refcounts=on refcount_bits=16
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
 
+== Expect error when backing file name is empty string ==
+
+qemu-img create -f qcow2 -b  TEST_DIR/t.qcow2 1M
+qemu-img: TEST_DIR/t.qcow2: Expected backing file name, got empty string
+
 *** done
-- 
2.25.4


