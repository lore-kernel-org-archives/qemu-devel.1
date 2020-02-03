Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B585AC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819D520721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrwNR77d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819D520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZk4-0004oS-L9
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfc-0005Qt-29
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfa-0000oX-6Q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfZ-0000oM-Vf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id t23so15396079wmi.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BTxU6Fiqmoc74O9Rj/dlmNa+Tb6oghsZroKvVzF5wsE=;
 b=jrwNR77dzGmOtUV778jwPDRRmFQfPGIYlkElNM9M54TUyFmAI+HcZcyk6Cy88o4mdd
 8Y3gU819FKorqyyQ8g4iJl3s8HyL0UFcQYC1UfSf1rNF7XmpmaYnFLR//5O+CYFTL94G
 ILkS+BpO+qTtFd222odT+X/CIpyP2yXJ91/Qafeq25QQUgzPQideOdJlGBplIhWZcuL1
 yywJvI/WNOTFr9wx6fALQgOVp5UUYg/AVNgw0zaDEyDkdw21O4Prq2dZkyo/UQdoOxDs
 eD75zldxAMYScAYhTSk/q16PA0terUIOYvVLXG8ziJfRL8HfDl9NFLISZXJ0hr/v+IC7
 FktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BTxU6Fiqmoc74O9Rj/dlmNa+Tb6oghsZroKvVzF5wsE=;
 b=oNYsx6Pkge4r6Uj54NCwOXXKL8SMUO6oB+HaD4cnu+B33CPO/kf1NAwX1EZiZlGhe+
 G79nAnnTkiprgjR7Q7BBrSIn4PegygJXrAlvn8CFTSatm+cpbJYEwapL+3MpPmnFlPdD
 ybWq8uV40t/6lU49K1sERLdDroFrXgqHvJgrkPLHkJF1tojkPdEoteis0N0RaHnTaZNe
 mXDcBFficFX91mSZqN6HspmawGolG5QmMcHnYszWKg3twNki4XBAJHDh+MS1HzeCUk6p
 r5vdQxsj6Hm/tsSksQnW6A1RZWbvY5D0pHHYs1WpwM+Wn1RM1XmcQzP1rzS6GBU+YPin
 KE8w==
X-Gm-Message-State: APjAAAUfyR+T431+iCxLiOFdwPyX6HHAGWaTl4DK7hdDaoJdXZs3QpMv
 LCQXNf7MDs6SZpAo3YA77eU3ZesCWw/Y5g==
X-Google-Smtp-Source: APXvYqzyp4SvJTpcLbCu6xJAFAeWyIvkk/TcmJvixr3P0SyebF+f15xcoEwdDGDDq3526MrMY2LhKA==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr27904026wmc.162.1580728412321; 
 Mon, 03 Feb 2020 03:13:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] qemu-img-cmds.hx: Remove texinfo document fragments
Date: Mon,  3 Feb 2020 11:13:16 +0000
Message-Id: <20200203111318.23378-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
References: <20200203111318.23378-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now the qemu-img documentation has been converted to rST, we can
remove the texinfo document fragments from qemu-img-cmds.hx, as
they are no longer used.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200124162606.8787-7-peter.maydell@linaro.org
---
 qemu-img-cmds.hx | 56 +++---------------------------------------------
 1 file changed, 3 insertions(+), 53 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 850fd9d4fe7..3fd836ca909 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -1,143 +1,93 @@
 HXCOMM Keep the list of subcommands sorted by name.
 HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
+HXCOMM Text between SRST and ERST are copied to rST version and
 HXCOMM discarded from C version
 HXCOMM DEF(command, callback, arg_string) is used to construct
 HXCOMM command structures and help message.
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C
 
-HXCOMM When amending the TEXI sections, please remember to copy the usage
+HXCOMM When amending the rST sections, please remember to copy the usage
 HXCOMM over to the per-command sections in qemu-img.texi.
 
-STEXI
-@table @option
-ETEXI
-
 DEF("amend", img_amend,
     "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
-STEXI
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
-ETEXI
 SRST
 .. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT] [-t CACHE] -o OPTIONS FILENAME
 ERST
 
 DEF("bench", img_bench,
     "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
-STEXI
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-i @var{aio}] [-w] [-U] @var{filename}
-ETEXI
 SRST
 .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-i AIO] [-w] [-U] FILENAME
 ERST
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
-STEXI
-@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
-ETEXI
 SRST
 .. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--output=OFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME
 ERST
 
 DEF("commit", img_commit,
     "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
-STEXI
-@item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
-ETEXI
 SRST
 .. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
 ERST
 
 DEF("compare", img_compare,
     "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2")
-STEXI
-@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
-ETEXI
 SRST
 .. option:: compare [--object OBJECTDEF] [--image-opts] [-f FMT] [-F FMT] [-T SRC_CACHE] [-p] [-q] [-s] [-U] FILENAME1 FILENAME2
 ERST
 
 DEF("convert", img_convert,
     "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
-STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_filename}
-ETEXI
 SRST
 .. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 ERST
 
 DEF("create", img_create,
     "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
-STEXI
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
-ETEXI
 SRST
 .. option:: create [--object OBJECTDEF] [-q] [-f FMT] [-b BACKING_FILE] [-F BACKING_FMT] [-u] [-o OPTIONS] FILENAME [SIZE]
 ERST
 
 DEF("dd", img_dd,
     "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
-STEXI
-@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
-ETEXI
 SRST
 .. option:: dd [--image-opts] [-U] [-f FMT] [-O OUTPUT_FMT] [bs=BLOCK_SIZE] [count=BLOCKS] [skip=BLOCKS] if=INPUT of=OUTPUT
 ERST
 
 DEF("info", img_info,
     "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename")
-STEXI
-@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
-ETEXI
 SRST
 .. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [-U] FILENAME
 ERST
 
 DEF("map", img_map,
     "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename")
-STEXI
-@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
-ETEXI
 SRST
 .. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
 ERST
 
 DEF("measure", img_measure,
 "measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
-STEXI
-@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
-ETEXI
 SRST
 .. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
 ERST
 
 DEF("snapshot", img_snapshot,
     "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
-STEXI
-@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
-ETEXI
 SRST
 .. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
 ERST
 
 DEF("rebase", img_rebase,
     "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
-STEXI
-@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
-ETEXI
 SRST
 .. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
 ERST
 
 DEF("resize", img_resize,
     "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocation=prealloc] [-q] [--shrink] filename [+ | -]size")
-STEXI
-@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
-ETEXI
 SRST
 .. option:: resize [--object OBJECTDEF] [--image-opts] [-f FMT] [--preallocation=PREALLOC] [-q] [--shrink] FILENAME [+ | -]SIZE
 ERST
-
-STEXI
-@end table
-ETEXI
-- 
2.20.1


