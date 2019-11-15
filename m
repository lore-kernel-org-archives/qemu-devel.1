Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD102C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF562073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cd6e2128"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF562073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbP8-0005fs-Lj
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iVbNw-0004Ns-9m
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iVbNv-0004O9-CL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:36 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iVbNv-0004Nu-7N
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:35 -0500
Received: by mail-pf1-x444.google.com with SMTP id b19so6673833pfd.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=diXnF1IPkkxinXlGIqTBKK6HjgFjUcsfRfseHjAG8V0=;
 b=cd6e2128QvkQXDsV9YD8foQDT+InMB8+/EC8yNh5eodUOIOk46ov2fxlrC+Rga724A
 0eMaAEnLcc18PQIqTYUj8DLuT3btXEuJHiFbHurp/AV4jQfzlOKNRtg8i0YNbGewu8Ne
 SGk4KzfftSfi19UBpr1BV17IZsj7/U1d89Ua400q+aY4kVO5DAvConKmWLgQN+BZEnxS
 jpsYNtbfC0lymsaj2ku5k9nozilZLoiQMsivwAPpvFHvo684hOr8UW4bte5mN/VbR8Hr
 bbElEXLyo+edAk0n7m71zOM7dt/ilwtKT+vMH1gGtSBi+qUDDmnqb38ZvxCpVxYMQQw8
 2VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=diXnF1IPkkxinXlGIqTBKK6HjgFjUcsfRfseHjAG8V0=;
 b=MWXHgV8y1c9yF1NnFf5zm3cUBpzX934xKpyCI/zxgNJi5imlZkZRkrRh0IyInSxoCy
 BJyuNNCgj5LwT2giGeZLicLYgQr+vExa+6rJvH34X+r4nXOV02fjeYWLmDPyIG4YqQtf
 HIkrR9VXlonAPnEWguJXBIiCJGlYp1ddTe+GG0G3esJAYx/aPQy/sItrTeBJJuRh0z/5
 F7i44vwJrflwS4oWdOoF4b5CR9lfzjR1xLwVj8zM1nkusaTFhoOMPoMcOfO7GtxO6lS8
 q8WGlodHCqtOMQcrDkEmbSpPoGa9HHHeNxgHz0+Gu94SiIIuqpsDr2w4WfI+Bl3qfBEl
 wQdA==
X-Gm-Message-State: APjAAAVQKPfn6UVJBg7O8oda7bsWmzcLA5xh3U2Gg5pxYWx4u0Zz7Lju
 cTrDEIAQYZE4PON36mOqdvxtYO8NIS0=
X-Google-Smtp-Source: APXvYqzYh86OPnfKTXwOx5xsSrZjjdf7vDEALFp2r2B5zizglkngToqonsr+KnJhwEWDWc2OGc+jKQ==
X-Received: by 2002:a63:201b:: with SMTP id g27mr14642133pgg.56.1573823493901; 
 Fri, 15 Nov 2019 05:11:33 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id w138sm12007249pfc.68.2019.11.15.05.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 05:11:33 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] Fix double free issue in qemu_set_log_filename().
Date: Fri, 15 Nov 2019 08:10:35 -0500
Message-Id: <20191115131040.2834-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115131040.2834-1-robert.foley@linaro.org>
References: <20191115131040.2834-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After freeing the logfilename, we set logfilename to NULL, in case of an
error which returns without setting logfilename.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v2
    - moved this change to the beginning of the patch series.
---
v1
    - This is new in the patch v1.
---
 util/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/log.c b/util/log.c
index 1ca13059ee..4316fe74ee 100644
--- a/util/log.c
+++ b/util/log.c
@@ -113,6 +113,7 @@ void qemu_set_log_filename(const char *filename, Error **errp)
 {
     char *pidstr;
     g_free(logfilename);
+    logfilename = NULL;
 
     pidstr = strstr(filename, "%");
     if (pidstr) {
-- 
2.17.1


