Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA6BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA86206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm7vGPVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA86206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd5e-0000li-BA
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2D-0003px-IS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2C-0003sF-Lb
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9XYIGI7HOjYX2BqAYx0wu+sDnz+yL5U2cNQmNKxyCM=;
 b=fm7vGPVAWBt27pmSetiJznkpIJl9dYvR+xvrh8aSggxvCkFpcABxM3jhtenIcWpizJtg/r
 p8hblBJ0Y4287OD8owFZSWfonICpDj0ATzlYxpx9aXadSSJ5XABbjb/kdzuEdCvrWDwV/t
 3PYGjkXJw3T2nBQSbNtx7HiWGk+H62Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-XDyOPtFbNLWSA9CwXzFyJQ-1; Mon, 04 May 2020 11:29:30 -0400
X-MC-Unique: XDyOPtFbNLWSA9CwXzFyJQ-1
Received: by mail-wr1-f70.google.com with SMTP id q13so2090430wrn.14
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tI1yUxIlcdhOIzObTuos8yemfQFI0fwt06hTRp539vo=;
 b=jK4ac6rQqVbICSg6MYv8hMWgf62SW/00BdhrmHtedX/GbJFsSqSzNoAmQc8d1CnaK3
 smoXl5B+WsHvKA1TtZyBXo4ANS/AGS5qAzHa5BtZfkZ8ATdtVADm25wTLKgjAvRattqB
 C0us5yUN92qOJJlY7A09kMobSjjp27LYIEAuiU8vLFTIr7ygqDtNYtA2K9VPHDHHXiVt
 +Dv9IoNhQxHMVYFN+fRjYgOEqNepvXq43v6r+1HYQEIpG8dO3CfKrPHUTbU4DC1wMwe0
 92TSl6Fbck6K7lB1KMQ8kunjk0tNCqLL+rvSwsOyYa2j5/DUmhjT6fkQ4r8YqPKmUVzy
 dZPQ==
X-Gm-Message-State: AGi0PuYszUECwshTsFT2500WOARAzEMuikSf6ATg3oev+CgQhtrLzATA
 cWfGx1c3XyGJGidd8ZGlJABh/yf0rhtdRaDXMGUuO8oPQc9HbLuSIg7Ls5LJwto6KnbAT1g1eCL
 UWZxZn62KBBbw26s=
X-Received: by 2002:adf:cd88:: with SMTP id q8mr17234779wrj.67.1588606168953; 
 Mon, 04 May 2020 08:29:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXB5v9cBYgwUOfBejThxl9wqhuCaWRUOFfQePgNSjFUhC9lxyJkxBUbyEzJ4q/VjnjYu4Vhw==
X-Received: by 2002:adf:cd88:: with SMTP id q8mr17234750wrj.67.1588606168714; 
 Mon, 04 May 2020 08:29:28 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id i129sm14838974wmi.20.2020.05.04.08.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:29:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] Makefile: Only build virtiofsd if system-mode is
 enabled
Date: Mon,  4 May 2020 17:29:11 +0200
Message-Id: <20200504152922.21365-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not build the virtiofsd helper when configured with
--disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 34275f57c9..e46b6ef5d4 100644
--- a/Makefile
+++ b/Makefile
@@ -345,7 +345,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
 vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
=20
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)=
,yyyy)
 HELPERS-y +=3D virtiofsd$(EXESUF)
 vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
 endif
--=20
2.21.3


