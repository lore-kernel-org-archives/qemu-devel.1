Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32417C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED98205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMhBrk+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED98205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdRT-0000nm-Dx
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8i-0003Ns-25
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8g-0000Ma-NJ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8g-0000LB-Ju
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2WbGUxRvcpHQ7gMdexAnGhsQEHFWTP/K6vD/RQgKno=;
 b=BMhBrk+2jX+sUTLSkb/EIzw8VHojFXrbXkm33xgd29nqbmpS3SsPQBrxjmNbBsj1XwR66E
 ulYIVGeR47endoits+2WYqQ3LeG9m9Iy8eYk+yY9mNhhK9KjVMwjyj6VVJ+YN400J5YKfu
 QqW3WYtXFfheBQ1lxLxS0AZ9LH/by68=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-bcfQ-LX-NwmXn3xohXuGAg-1; Sun, 15 Mar 2020 19:57:48 -0400
X-MC-Unique: bcfQ-LX-NwmXn3xohXuGAg-1
Received: by mail-wm1-f72.google.com with SMTP id f207so5013084wme.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w//Vgnp6ot9C/jYoheowrZSLqS+aLSpvExQpDN5q96c=;
 b=fAqRGnjzf+Kx6MpdLKLI9wOg3YzxV7RLVcYBAAvSabPNDOhYHlGg8EyAq77/Bjn5sC
 k8uZMFmbu3m4TGVDO7Y3V+wo93mDUMJZUGvdRQu3P24jsoCdHqjJrVLTQpS396DAoKVp
 1Oj3syekTnhnb0htcxX62NsyKmbF/iyie8ryxgVcH9Zj1N9Y87AUOA4nWc2L/UR6mpW+
 0f8qWM5xtowRuVxoeZSbi7baDejdASjZbZ6rwkxXnOnvmYuVB7yfsDxvI/1ZrP//34Fl
 +w39B9QuPsQ5qebdjpyEU+0Hk+sLXQ1iH7nhsZEnxbUu2FU7UwCTObpdM+jC0dxEuqAZ
 3NiQ==
X-Gm-Message-State: ANhLgQ29LCsweQwmNQoViFWMWHQ4Ip0hPdyPoMMuJ0FKT2KCk+XQts2w
 Cp47Wt72rk9tgUN+RGE04RzN/RGrrfSGs0C7OOkZXFLvKnEP09GOxwOF+86N2OmlLTY8KDGEV4C
 1PP7KhaLSHWW0pS4=
X-Received: by 2002:adf:91c3:: with SMTP id 61mr18894554wri.384.1584316667104; 
 Sun, 15 Mar 2020 16:57:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvozUgBYnYHdagK1VgGh48/vEWTckr80zH5kHcohGGDAgJWU35TijOqYgylyCPjp9jlDmji6g==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr18894524wri.384.1584316666855; 
 Sun, 15 Mar 2020 16:57:46 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id p10sm26805399wru.4.2020.03.15.16.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] util/Makefile: Reduce the user-mode object list
Date: Mon, 16 Mar 2020 00:57:09 +0100
Message-Id: <20200315235716.28448-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These objects are not required when configured with --disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/Makefile.objs | 59 +++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index 6718a38b61..24ae2e4dfa 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,8 +1,4 @@
 util-obj-y =3D osdep.o cutils.o unicode.o qemu-timer-common.o
-util-obj-y +=3D bufferiszero.o
-util-obj-y +=3D lockcnt.o
-util-obj-y +=3D aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
-util-obj-y +=3D main-loop.o
 util-obj-$(call lnot,$(CONFIG_ATOMIC64)) +=3D atomic64.o
 util-obj-$(CONFIG_POSIX) +=3D aio-posix.o
 util-obj-$(CONFIG_POSIX) +=3D fdmon-poll.o
@@ -21,31 +17,20 @@ util-obj-$(CONFIG_WIN32) +=3D oslib-win32.o
 util-obj-$(CONFIG_WIN32) +=3D qemu-thread-win32.o
 util-obj-y +=3D envlist.o path.o module.o
 util-obj-y +=3D host-utils.o
-util-obj-y +=3D bitmap.o bitops.o hbitmap.o
+util-obj-y +=3D bitmap.o bitops.o
 util-obj-y +=3D fifo8.o
-util-obj-y +=3D nvdimm-utils.o
 util-obj-y +=3D cacheinfo.o
 util-obj-y +=3D error.o qemu-error.o
 util-obj-y +=3D qemu-print.o
 util-obj-y +=3D id.o
-util-obj-y +=3D iov.o qemu-config.o qemu-sockets.o uri.o notify.o
+util-obj-y +=3D qemu-config.o notify.o
 util-obj-y +=3D qemu-option.o qemu-progress.o
 util-obj-y +=3D keyval.o
-util-obj-y +=3D hexdump.o
 util-obj-y +=3D crc32c.o
 util-obj-y +=3D uuid.o
-util-obj-y +=3D throttle.o
 util-obj-y +=3D getauxval.o
-util-obj-y +=3D readline.o
 util-obj-y +=3D rcu.o
 util-obj-$(CONFIG_MEMBARRIER) +=3D sys_membarrier.o
-util-obj-y +=3D qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
-util-obj-y +=3D qemu-coroutine-sleep.o
-util-obj-y +=3D qemu-co-shared-resource.o
-util-obj-y +=3D coroutine-$(CONFIG_COROUTINE_BACKEND).o
-util-obj-y +=3D buffer.o
-util-obj-y +=3D timed-average.o
-util-obj-y +=3D base64.o
 util-obj-y +=3D log.o
 util-obj-y +=3D pagesize.o
 util-obj-y +=3D qdist.o
@@ -54,12 +39,44 @@ util-obj-y +=3D qsp.o
 util-obj-y +=3D range.o
 util-obj-y +=3D stats64.o
 util-obj-y +=3D systemd.o
-util-obj-y +=3D iova-tree.o
-util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
-util-obj-$(call lnot,$(CONFIG_INOTIFY1)) +=3D filemonitor-stub.o
-util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
 util-obj-$(CONFIG_POSIX) +=3D drm.o
 util-obj-y +=3D guest-random.o
 util-obj-$(CONFIG_GIO) +=3D dbus.o
 dbus.o-cflags =3D $(GIO_CFLAGS)
 dbus.o-libs =3D $(GIO_LIBS)
+
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
+util-obj-y +=3D aio-wait.o
+util-obj-y +=3D aiocb.o
+util-obj-y +=3D async.o
+util-obj-y +=3D base64.o
+util-obj-y +=3D buffer.o
+util-obj-y +=3D bufferiszero.o
+util-obj-y +=3D coroutine-$(CONFIG_COROUTINE_BACKEND).o
+util-obj-y +=3D hexdump.o
+util-obj-y +=3D lockcnt.o
+util-obj-y +=3D iov.o
+util-obj-y +=3D iova-tree.o
+util-obj-y +=3D hbitmap.o
+util-obj-y +=3D main-loop.o
+util-obj-y +=3D nvdimm-utils.o
+util-obj-y +=3D qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
+util-obj-y +=3D qemu-coroutine-sleep.o
+util-obj-y +=3D qemu-co-shared-resource.o
+util-obj-y +=3D qemu-sockets.o
+util-obj-y +=3D qemu-timer.o
+util-obj-y +=3D thread-pool.o
+util-obj-y +=3D throttle.o
+util-obj-y +=3D timed-average.o
+util-obj-y +=3D uri.o
+
+util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
+util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
+util-obj-$(call lnot,$(CONFIG_INOTIFY1)) +=3D filemonitor-stub.o
+util-obj-$(CONFIG_BLOCK) +=3D readline.o
+
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
--=20
2.21.1


