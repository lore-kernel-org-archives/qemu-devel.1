Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5998BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B38D206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9yuQdrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B38D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBSu-0001MP-9I
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQU-0004NT-S5
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQT-0001xA-4r
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2epUlGHetWOGCxGYOBU+dKoPuV3pK/Jo+k4ZyfzZBw=;
 b=N9yuQdrYan3GMU8haRgvGPB1Y29gBuiN+XZnq5UkSp5AajO1NY7ZOYnE3onZsEjn8aIdqe
 bsnwTDw37GKTmISFYC7uQmMIG7Txq+vTXcCAXPk9kC2AfW44y+fmU5k7qwC0ETo+jwzrkC
 FnbXNBD/lOOvPLlspWk+vrWj5mKexNs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-giwPZC50Mu2blkSbfosmdw-1; Fri, 22 May 2020 13:25:39 -0400
X-MC-Unique: giwPZC50Mu2blkSbfosmdw-1
Received: by mail-wm1-f70.google.com with SMTP id z5so1414579wml.6
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i2epUlGHetWOGCxGYOBU+dKoPuV3pK/Jo+k4ZyfzZBw=;
 b=LFaFc61KMT4rXKOR5le1tT9rpMrMhN6uPzQ4KpQ2Vdq9V3F8RwOhlK7Wt6n8ILemgd
 TR3qa90avbtw8SORBArkRFgQFF1CFU++Ht86fjVtMuZ2DFPMZp4Ynn0ohsqoMN5UMvDv
 LQPgNsU+NxepdFHY8zLhPEDXP7sXn38lqCjp7CGgP+yFQhnAFvE05Dv31Ax74RCLwGE4
 g9V8dNzuGgvnCWlJTbIoTHvxNFSjh2Rn4n6WuVJZKXDFZ7fswTuV2EzleAkLTmjbmxrf
 bjOZ24h1BA5wl8EEQZmhawGroriB3iH+6GdigVtw6ob/IhFfKCBmoew1YF0LpIrdc2PX
 GGcw==
X-Gm-Message-State: AOAM533GpF3UNedU8mb5TUKP9aFrb4Mbu7qRLbwPp1Ifxe499zFZXDak
 y2QXo+wMyjOD+kB3lHXuxS5pe8GPh65x7OLzS8ENfK6a6MJQzU8uuuPxuNzwKKwSnllRUtd+Sw5
 lEGByq1MnZCR6P2o=
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr14127274wmf.186.1590168337502; 
 Fri, 22 May 2020 10:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyurAZ2zxafuc7PxoxBEAK3NAAA6v+GN/WxNKZXahiPEfjQhZS0KXx3UbC69nA3aY9H5kE+oA==
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr14127254wmf.186.1590168337301; 
 Fri, 22 May 2020 10:25:37 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w82sm9942227wmg.28.2020.05.22.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/13] util/Makefile: Reduce the user-mode object list
Date: Fri, 22 May 2020 19:25:02 +0200
Message-Id: <20200522172510.25784-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These objects are not required when configured with --disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/Makefile.objs | 59 +++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index fe339c2636..cc5e37177a 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,8 +1,4 @@
 util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
-util-obj-y += bufferiszero.o
-util-obj-y += lockcnt.o
-util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
-util-obj-y += main-loop.o
 util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += fdmon-poll.o
@@ -21,31 +17,20 @@ util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
 util-obj-y += envlist.o path.o module.o
 util-obj-y += host-utils.o
-util-obj-y += bitmap.o bitops.o hbitmap.o
+util-obj-y += bitmap.o bitops.o
 util-obj-y += fifo8.o
-util-obj-y += nvdimm-utils.o
 util-obj-y += cacheinfo.o
 util-obj-y += error.o qemu-error.o
 util-obj-y += qemu-print.o
 util-obj-y += id.o
-util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
+util-obj-y += qemu-config.o notify.o
 util-obj-y += qemu-option.o qemu-progress.o
 util-obj-y += keyval.o
-util-obj-y += hexdump.o
 util-obj-y += crc32c.o
 util-obj-y += uuid.o
-util-obj-y += throttle.o
 util-obj-y += getauxval.o
-util-obj-y += readline.o
 util-obj-y += rcu.o
 util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
-util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
-util-obj-y += qemu-coroutine-sleep.o
-util-obj-y += qemu-co-shared-resource.o
-util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
-util-obj-y += buffer.o
-util-obj-y += timed-average.o
-util-obj-y += base64.o
 util-obj-y += log.o
 util-obj-y += pagesize.o
 util-obj-y += qdist.o
@@ -54,13 +39,45 @@ util-obj-y += qsp.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
-util-obj-y += iova-tree.o
-util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
-util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
-util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_POSIX) += drm.o
 util-obj-y += guest-random.o
 util-obj-$(CONFIG_GIO) += dbus.o
 dbus.o-cflags = $(GIO_CFLAGS)
 dbus.o-libs = $(GIO_LIBS)
 util-obj-$(CONFIG_USER_ONLY) += selfmap.o
+
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
+util-obj-y += aio-wait.o
+util-obj-y += aiocb.o
+util-obj-y += async.o
+util-obj-y += base64.o
+util-obj-y += buffer.o
+util-obj-y += bufferiszero.o
+util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
+util-obj-y += hexdump.o
+util-obj-y += lockcnt.o
+util-obj-y += iov.o
+util-obj-y += iova-tree.o
+util-obj-y += hbitmap.o
+util-obj-y += main-loop.o
+util-obj-y += nvdimm-utils.o
+util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
+util-obj-y += qemu-coroutine-sleep.o
+util-obj-y += qemu-co-shared-resource.o
+util-obj-y += qemu-sockets.o
+util-obj-y += qemu-timer.o
+util-obj-y += thread-pool.o
+util-obj-y += throttle.o
+util-obj-y += timed-average.o
+util-obj-y += uri.o
+
+util-obj-$(CONFIG_LINUX) += vfio-helpers.o
+util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
+util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
+util-obj-$(CONFIG_BLOCK) += readline.o
+
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
-- 
2.21.3


