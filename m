Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80590205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZlp7Fvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80590205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpQf-00012N-2v
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoQp-0004k3-LV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoQl-0007Tn-4J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoQj-0007Kd-S2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGB0w0+AWtPU6SqFVhC9+mkd/ega3R3KD3mHlnW2xE8=;
 b=GZlp7FvxecHVvcX7UAAqxhlNju+vumbQqpla7QcBuHuRoG7/lssg3mKWWFLfd+HSwbA1uQ
 7CACjl/42rLmU+cjfNsG/0ss4XPgy8uum2IXmTjYg5lRpubRVUAZG4F136iVZRT9xpAdIo
 GYQAkSZ+bvsCOGsQ+mSp3h2BSvahis0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-atCDE3dXNz6dflEHS0CiRg-1; Mon, 16 Mar 2020 08:01:10 -0400
X-MC-Unique: atCDE3dXNz6dflEHS0CiRg-1
Received: by mail-wr1-f69.google.com with SMTP id v6so8841743wrg.22
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XSBUjC7Gy69HU6BGzBeIyFgwGf/p+AZ0Uc+PDLHUf1o=;
 b=iNT1wrY62YSfrgJQiHq0wWOo+koJSnr8pwbFhALhom88VWp7BoOBJOW78KAyriWpZL
 nu92sLbdTuGcYUSGQ2OqFHsfuGvxJh3sz9is5HMTzzKIbBEwIMsnJylN/6D7NLiIUkFI
 jnSy84EA7hfripA96s8dhh5iOIdxrk91fPhTLdSpNuJJAq/IE6fq6FOT439+6jLRfjGU
 9KoLTYtHRekLx4ZJeOJMiazc4u+aAr5yJb5jqR11IUGQWaxMguqRVUJfK+qwBZpbemXN
 vHqDT6Q1qJR9FeLhqOBqvKDYXVywWZ/buyqf9w3RZsNqjGYR4Y0qhCmYq2TWBkO98I+T
 9JHw==
X-Gm-Message-State: ANhLgQ1nivYIdkhLQw7y+MFqS4tPuEov5KXLcnl47EXdvzAkbS9QmBIa
 CR/tEzQOAMAjhuhfW4YKStpyRHUwW9oQhlKYvPAUyZVqRDPaAkHh1k2mWft1LRVlAjUuPbdMcIj
 I/DS+D2mYWPZTVls=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr9412004wrr.279.1584360069557; 
 Mon, 16 Mar 2020 05:01:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtg/lnAAKkyAiGUsuDPuhLImL32CuSWe9L388s0qooyZatUFAEL1tHqtdjl32yRQY6qvCvTcQ==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr9411976wrr.279.1584360069350; 
 Mon, 16 Mar 2020 05:01:09 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id i8sm13407605wrw.55.2020.03.16.05.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] MAINTAINERS: Add an entry for the HAX accelerator
Date: Mon, 16 Mar 2020 13:00:41 +0100
Message-Id: <20200316120049.11225-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
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
Cc: Vincent Palatin <vpalatin@chromium.org>, Yu Ning <yu.ning@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Hang Yuan <hang.yuan@intel.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 David Chou <david.j.chou@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Colin Xu <colin.xu@intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tao Wu <lepton@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Vincent Palatin <vpalatin@chromium.org>
Cc: Yu Ning <yu.ning@intel.com>
Cc: Tao Wu <lepton@google.com>
Cc: haxm-team@intel.com
Cc: Colin Xu <colin.xu@intel.com>
Cc: Hang Yuan <hang.yuan@intel.com>
Cc: David Chou <david.j.chou@intel.com>
Cc: Wenchao Wang <wenchao.wang@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08d9556ab2..7ec42a18f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -414,6 +414,12 @@ S: Maintained
 F: include/sysemu/accel.h
 F: accel/stubs/Makefile.objs
=20
+HAX Accelerator
+S: Orphan
+F: accel/stubs/hax-stub.c
+F: target/i386/hax-all.c
+F: include/sysemu/hax.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
--=20
2.21.1


