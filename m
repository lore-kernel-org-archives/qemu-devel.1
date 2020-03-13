Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1191C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C12C206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYvSgVC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C12C206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpJH-0006nG-I5
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBb-0000CW-P4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBa-0003Tv-Bh
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBa-0003SW-34
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgDberYaZDed20sm6tRRJ30h81E1DyL3M/u30/cftuw=;
 b=QYvSgVC4i9C16PK41rSbmKX1I7AI2CevaTwauULW1Zoz+6Lm7xsFkBPNvbmPFlu4YVJulC
 wO4r5ozCtYznCqxzpAoQ9zjCxamq8QsXAp0nHlkSEkPIvN7ilLvp20GQ5MX25eor1WjoXy
 vAQdenILRpj9nctpEdvTSzWxnW/Ej+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312--oaMDIgZNWCCohZj9yvPDA-1; Fri, 13 Mar 2020 14:37:28 -0400
X-MC-Unique: -oaMDIgZNWCCohZj9yvPDA-1
Received: by mail-wm1-f69.google.com with SMTP id s15so1719914wmc.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RC71PykOebGOXBV3Avk2avLieaYMFi0EYKRjpxiFXHU=;
 b=FUVgfIB0s0fbN50aAbMrMR1UX4GkZ962SOayWvNLqUo+/T7MxaB+hGyweIcRrI5x9Q
 w852tSbHDHReKUoNIWlfMB6Bhq7EY/xfbJiyGCRhP/bKnEuoDawTiO2jVFXz/zKGi+W2
 7cC4bNRYjNX3JN00G7pTX4rGKZZw2sPSXh3HzdQpHK57c0tsrGqOXyq0tt8P+/IK7yJ3
 Mpkvi0VYqk9fuFte2fvBclGObqNB5hwNpg+KVpCT/bVaH6WHNY2JBiv6hL29w0QQn3Hq
 SdQ9yR8l2b5jaGT2SPup8Xhx9+07+lJ14QdurZM2HdgztwFLFy5XhomK6Ws/XGnIntYA
 311w==
X-Gm-Message-State: ANhLgQ13unAQIS/3tibnlTNWf9luTbthJVs5+tr2pfaa8fzaOjNOzPaG
 yVgOEUfnOzyX8BU+FeNvyLGxTRMPxRA/0mK5RJfJ2+FdbJO39GEumfxUhwk+zKjyz0NUspoS4rx
 kZMTDh+JnXADUl8g=
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr18665480wrm.305.1584124646870; 
 Fri, 13 Mar 2020 11:37:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vujjgTFOCuWjS1sUnHVe14BjCxdTIeVV/2vuhZ1FIR92L6DidbJ7VLByJXmZrt1QAbjPTocEA==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr18665462wrm.305.1584124646657; 
 Fri, 13 Mar 2020 11:37:26 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w81sm17726166wmg.19.2020.03.13.11.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/14] util/Makefile: Reduce the user-mode object list
Date: Fri, 13 Mar 2020 19:36:44 +0100
Message-Id: <20200313183652.10258-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These stubs are not required when configured with --disable-system.

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


