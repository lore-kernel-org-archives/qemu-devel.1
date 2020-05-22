Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B167C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DCC206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPiRlBjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DCC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBXv-0001rE-Da
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBR7-0006ME-Cq
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBR6-0002H4-Lo
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzyCO16+5RviPogg4wPbJiKI85apokjUkaWsspBCPSs=;
 b=FPiRlBjxYasD52+bHJsX8bvHseUYxUOivcLoPN+KeWx41ppGZImHrM67CTyfyZN/zyQfA7
 aDyXGgpi4QwtgMi+8tgjtE3CHd2fakmMvBn1KwyPHH4o2DzeqXLAHoCep0YHQnGwJAwft1
 eO+YASt01/Qew4PWf3YPlsncR4Mc7vE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-xgyA91YPMlKsREQ2YqAhmg-1; Fri, 22 May 2020 13:26:17 -0400
X-MC-Unique: xgyA91YPMlKsREQ2YqAhmg-1
Received: by mail-wr1-f72.google.com with SMTP id p2so4663908wrm.6
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xzyCO16+5RviPogg4wPbJiKI85apokjUkaWsspBCPSs=;
 b=LnfMCq5x+qKkKtFt1bzTddNRu81avNHNOqQ8ey++Lsvm7/nNkagPFf4nm+tOws8/yS
 MpOZUjn8aNWkoTaD5f3H1ZTe/BdXB2AKd1d83lFDR5A+gwjEuss0t80ZC2wERv8GZ/6b
 OFX3cPv16jUYgWaEt+O5lyPQ0LQd9VpA1yczhnEuelItXRBPRNW3xMKR4hJ4/JwIipST
 Q9jki0EC9egfS+SnuhNizSyW31H7X0dpKMYO90IhfmgbGugX4fDSXI5KAD84mFgv8xZ7
 gYg6FRopkfTBO3faJH5lpN2nEug7DE3pr+oh5jQV+XThO33GdmxF9HlmswBtCI2Q0TKk
 TPMA==
X-Gm-Message-State: AOAM53314LQ7nGu2QDov3hDUzPiVt/du71a/qk1NrDVC2NFCHecilWkj
 a5JA40hKO4373BiGFiLhqjcvRKSPpfjB7YApTvw3ViUO1aFanqy8JgSXTrhGEQRNNkfdGEm+NyC
 uFOXS5OmdY0PTo34=
X-Received: by 2002:a5d:5682:: with SMTP id f2mr4052290wrv.382.1590168376124; 
 Fri, 22 May 2020 10:26:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7XwVQFkjIva/AMLjP3gw8uCZWFWC/IKnTFQiIcY1lLZG4Q16GQSx0wMepR3SdEsRAPzQJDw==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr4052267wrv.382.1590168375908; 
 Fri, 22 May 2020 10:26:15 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c140sm10543216wmd.18.2020.05.22.10.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:26:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/13] stubs: Restrict ui/win32-kbd-hook to system-mode
Date: Fri, 22 May 2020 19:25:10 +0200
Message-Id: <20200522172510.25784-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In Makefile.objs, the ui/ directory is restricted to system-mode:

 43 ifeq ($(CONFIG_SOFTMMU),y)
 ...
 65 common-obj-y += ui/
 66 common-obj-m += ui/
 ...
 82 endif # CONFIG_SOFTMMU

Restrict the ui/ stub added in commit 2df9f5718df to only build
it for system-mode emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Volker Rümelin <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 stubs/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f54125de31..c1e43ac68f 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -23,7 +23,7 @@ stub-obj-y += sysbus.o
 stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
 stub-obj-y += vmstate.o
-stub-obj-y += win32-kbd-hook.o
+stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
 
 #######################################################################
 # code used by both qemu system emulation and qemu-img
-- 
2.21.3


