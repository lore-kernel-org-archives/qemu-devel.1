Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F23CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1724720704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ+JAySo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1724720704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1pr-0000WR-9t
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mm-0002bk-2N
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mk-0002sp-BT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1mk-0002qM-5Y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:18 -0500
Received: by mail-wr1-x42f.google.com with SMTP id j42so2664573wrj.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YF+2ATjXHISPE7K09rBXUt1UUGl3PdwL5/J+X4aqnNs=;
 b=KJ+JAySorBoBbZPK/56fjF+3Wg+qkPWRfKNUM4WAIHT0tX+/DVtOz/yp3R4/lZGJhL
 h7ua3gktDKwMXz3icF/1I0ensAskFn30wtT4CfaW8tMT0AeztSSRd8SBq5RxAKANDwDr
 R8xLeHRWymAyLrA4LgXTmK5qN7L2s7z6xht9UAVxu8nxyvDMGo/uYZlnfBdgc4eYLkWQ
 17ju212eA1mJ2UFv41XpMDONyzsbO6mUoF4IFWTdnU5YZrpY3xwuwxyj53JQrvCGK6A2
 ghDCe8rtP6mFtYKZArPUbnZH8utC+VW/pSESvdImcwoMc+hj8gKVDDRb5RVW5J4UxWCa
 j8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YF+2ATjXHISPE7K09rBXUt1UUGl3PdwL5/J+X4aqnNs=;
 b=aGOfyE73gS1BQAyFDjQGZ7LYMWB4mp8RuQfCbGwXWWmOwa2Jro9UScOgl8+8xf+2R2
 UuWSvBX5uYA5LwDKiOVQ8QIDnm+ab9BnTr3uiAWHlGBVuCtnwbfRcAQ7mhYxumJhSLEu
 vKWB0Rzwm6tErL9rovvzw1vJYvO02J6z0hbCxbF6gWpA0xOggTy60goxGnPiubQfKjKx
 h0T0ZG5FrIJExT+O/1Ko/b0ZBG5ApnDoabYRB3eadgI/IgzqMAa7gXKGoLnqdVgP78br
 GY9qJHZVPvMdsCF7l+nPIH9yXWCzWUaAVALzrqS2D6+6a12HvnG9J1ocMMjU1twsy8Wa
 E1SQ==
X-Gm-Message-State: APjAAAUs81Q6rgzUMMvv1/qdaNh55n8WDha24IxNdjEFOOHTy4NE/bXC
 3Ag9O6rl59kj9rYbzjwaG0jvYev2KinwUg==
X-Google-Smtp-Source: APXvYqzp48481YsRuoRh7FjpSBvmFNHQbIft/Tq1qpMd49WZJx/jI/JK4NIcZh+cvsy8pOrY2PBgGQ==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr5152963wrv.316.1579883175350; 
 Fri, 24 Jan 2020 08:26:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q3sm7054998wmj.38.2020.01.24.08.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:26:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] qemu-img-cmds.hx: Add rST documentation fragments
Date: Fri, 24 Jan 2020 16:26:02 +0000
Message-Id: <20200124162606.8787-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
References: <20200124162606.8787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the rST versions of the documentation fragments.
Once we've converted qemu-img.texi to rST we can delete
the texi fragments; for the moment we leave them in place.

(Commit created with the aid of emacs query-replace-regexp
from "@var{\([^}]*\)}" to "\,(upcase \1))".)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 qemu-img-cmds.hx | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1c93e6d1855..0c8b210b3c3 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -18,84 +18,125 @@ DEF("amend", img_amend,
 STEXI
 @item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 ETEXI
+SRST
+.. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [-t CACHE] -o OPTIONS FILENAME
+ERST
 
 DEF("bench", img_bench,
     "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 STEXI
 @item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
 ETEXI
-
+SRST
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
+ERST
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
 STEXI
 @item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
 ETEXI
+SRST
+.. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--output=OFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME
+ERST
 
 DEF("commit", img_commit,
     "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
 STEXI
 @item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
 ETEXI
+SRST
+.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
+ERST
 
 DEF("compare", img_compare,
     "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2")
 STEXI
 @item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
 ETEXI
+SRST
+.. option:: compare [--object OBJECTDEF] [--image-opts] [-f FMT] [-F FMT] [-T SRC_CACHE] [-p] [-q] [-s] [-U] FILENAME1 FILENAME2
+ERST
 
 DEF("convert", img_convert,
     "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
 STEXI
 @item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
+SRST
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+ERST
 
 DEF("create", img_create,
     "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
 STEXI
 @item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
 ETEXI
+SRST
+.. option:: create [--object OBJECTDEF] [-q] [-f FMT] [-b BACKING_FILE] [-F BACKING_FMT] [-u] [-o OPTIONS] FILENAME [SIZE]
+ERST
 
 DEF("dd", img_dd,
     "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
 STEXI
 @item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 ETEXI
+SRST
+.. option:: dd [--image-opts] [-U] [-f FMT] [-O OUTPUT_FMT] [bs=BLOCK_SIZE] [count=BLOCKS] [skip=BLOCKS] if=INPUT of=OUTPUT
+ERST
 
 DEF("info", img_info,
     "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename")
 STEXI
 @item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
 ETEXI
+SRST
+.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [-U] FILENAME
+ERST
 
 DEF("map", img_map,
     "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename")
 STEXI
 @item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
 ETEXI
+SRST
+.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
+ERST
 
 DEF("measure", img_measure,
 "measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
 STEXI
 @item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
 ETEXI
+SRST
+.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
+ERST
 
 DEF("snapshot", img_snapshot,
     "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
 STEXI
 @item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
 ETEXI
+SRST
+.. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
+ERST
 
 DEF("rebase", img_rebase,
     "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
 STEXI
 @item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
 ETEXI
+SRST
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+ERST
 
 DEF("resize", img_resize,
     "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocation=prealloc] [-q] [--shrink] filename [+ | -]size")
 STEXI
 @item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 ETEXI
+SRST
+.. option:: resize [--object OBJECTDEF] [--image-opts] [-f FMT] [--preallocation=PREALLOC] [-q] [--shrink] FILENAME [+ | -]SIZE
+ERST
 
 STEXI
 @end table
-- 
2.20.1


