Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67DBC76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935B32084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJE+zQmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935B32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1horAn-0007bM-Ls
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8U-00065A-Sh
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8T-00088g-LX
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8T-00088N-Ey
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id h19so25664324wme.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CvisqMqCgktfbG7D7mGm20gBvrSkT0GKy3tcYKFSGT4=;
 b=jJE+zQmrTqMiagwWgm8Djh9E/IlRskjc2TCv4LLSHPHb0rV+g9Hlo0Hq5ma/ilM520
 CGXFlSyg7c9gjqVbUIR/4FI1jydzkfqIM1uoJZCuLDVwGiqgMEAMUrC3RajeUDoGdB8s
 B9Y91eEojg3eQPBohIe8xNSB5psu5FxG1GTHmeAsWYOLyu2yVEDCZkt5KK4uYz1Meutu
 i4qxRrWis5wAs01ljLRCFYsLlHqs/zqA+vovdQD6BL+ln6iXJH2+x4F7f4sTs0VMz24C
 T6M3ckADIzDh5LsuRI0fJwBuPPdbFBy37M49krTBPxkCsGIi4oWocI6WXVK7cN7JPXL7
 vT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CvisqMqCgktfbG7D7mGm20gBvrSkT0GKy3tcYKFSGT4=;
 b=Xx/zH7cMMWPTwfUZM0AH4BooJmGvGxCUp5/SpnQ1xPhj202OB576cPi088PT8kaszF
 V9ghVkhw3ThvqRglwZXY+hOqjNEpi9MrcozpIk6bGWR00WjT1nxxYYDriFyZ6OZsQhY9
 OE3KBBt/BhQ9NAb2wsuaq9occEHKrbT7xZbJOLlrx81k6eBrnB2U9zCHFnLDko5i5HUG
 980gOCY1tRsRQyZFpBZxpx0vw8F/cZrxxralL3mv+rGkxkGsV/6II975wWMT1RMcq332
 K+8WFgDChOg3KRQvK2rr8TtgTKrYo5DOaFCIKVfxrAZRiffhO9VGv44HJ+OJfl1ocgFT
 HZDg==
X-Gm-Message-State: APjAAAXNeQ6cReYPQJlRdUWGJkNBWANAZTndEKW7JitNbTuxMPq6Xpp4
 1UiPoCHF6kdnt/vQrnQVOwkeiFzpR7M=
X-Google-Smtp-Source: APXvYqz2sL8pfratX9X1MZN5NaAwN6k+T9Y25BYTWkgz30OZR0aO7GuSHXSDlzAAPVVMApPaLkIsGQ==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr53885997wmg.152.1563635936322; 
 Sat, 20 Jul 2019 08:18:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:41 +0200
Message-Id: <20190720151846.7450-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 07/12] test-bitmap: add test for bitmap_set
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Add a test for bitmap_set. There are three cases:

  * Both start and end is BITS_PER_LONG aligned
  * Only start is BITS_PER_LONG aligned
  * Only end is BITS_PER_LONG aligned

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190718010456.4234-3-richardw.yang@linux.intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index cb7c5e4..18aa584 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -59,12 +59,67 @@ static void check_bitmap_copy_with_offset(void)
     g_free(bmap3);
 }
 
+typedef void (*bmap_set_func)(unsigned long *map, long i, long len);
+static void bitmap_set_case(bmap_set_func set_func)
+{
+    unsigned long *bmap;
+    int offset;
+
+    bmap = bitmap_new(BMAP_SIZE);
+
+    /* Both Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG] */
+    set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG);
+    g_assert_cmpuint(bmap[1], ==, -1ul);
+    g_assert_cmpuint(bmap[2], ==, -1ul);
+    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG), ==, BITS_PER_LONG);
+    g_assert_cmpint(find_next_zero_bit(bmap, 3 * BITS_PER_LONG, BITS_PER_LONG),
+                    ==, 3 * BITS_PER_LONG);
+
+    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
+        bitmap_clear(bmap, 0, BMAP_SIZE);
+        /* End Aligned, set bits [BITS_PER_LONG - offset, 3*BITS_PER_LONG] */
+        set_func(bmap, BITS_PER_LONG - offset, 2 * BITS_PER_LONG + offset);
+        g_assert_cmpuint(bmap[1], ==, -1ul);
+        g_assert_cmpuint(bmap[2], ==, -1ul);
+        g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
+                        ==, BITS_PER_LONG - offset);
+        g_assert_cmpint(find_next_zero_bit(bmap,
+                                           3 * BITS_PER_LONG,
+                                           BITS_PER_LONG - offset),
+                        ==, 3 * BITS_PER_LONG);
+    }
+
+    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
+        bitmap_clear(bmap, 0, BMAP_SIZE);
+        /* Start Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG + offset] */
+        set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG + offset);
+        g_assert_cmpuint(bmap[1], ==, -1ul);
+        g_assert_cmpuint(bmap[2], ==, -1ul);
+        g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
+                        ==, BITS_PER_LONG);
+        g_assert_cmpint(find_next_zero_bit(bmap,
+                                           3 * BITS_PER_LONG + offset,
+                                           BITS_PER_LONG),
+                        ==, 3 * BITS_PER_LONG + offset);
+    }
+
+    g_free(bmap);
+}
+
+static void check_bitmap_set(void)
+{
+    bitmap_set_case(bitmap_set);
+    bitmap_set_case(bitmap_set_atomic);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     g_test_add_func("/bitmap/bitmap_copy_with_offset",
                     check_bitmap_copy_with_offset);
+    g_test_add_func("/bitmap/bitmap_set",
+                    check_bitmap_set);
 
     g_test_run();
 
-- 
1.8.3.1



