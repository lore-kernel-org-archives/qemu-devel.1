Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C3A20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lbpz57rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C3A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdEE-00008G-0X
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2m-0004tp-4N
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2l-000453-A6
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1y68tSMd7GHh+zg/0ObvfZVux+/GWTFhhxzdBf7Eqg=;
 b=Lbpz57rMK36EdkQUQPGz9j/4IPevZAuMenbMHzS/bQ8Y60+w7PhySR2fO9uq7cdB9HnhC2
 chN3H+0bbdc/APq7sZMci1swBNQuUN8neKl85OEdewWLZKjKLpMlgOIoibMbmUWHM86MXa
 N2zVwQWF/75sflIwemayP/O+ZzuibWI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-VJ7LfwT5PmS_4qVXNWxrIw-1; Mon, 04 May 2020 11:30:05 -0400
X-MC-Unique: VJ7LfwT5PmS_4qVXNWxrIw-1
Received: by mail-wm1-f70.google.com with SMTP id n17so3701681wmi.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YNPGUt+XVjuWBOuW4Jb8vVwTVbsUuMXWCCmym4ZUFC0=;
 b=mGYJDWz/Vp1008hMA0hBmVkaiBdcTI3sY92FtJEmWRAGCyBP2A1z0LwiHMbLgyDfOo
 eSR3RTPLpgfNrIeOSQndw1VxHojEF7CuRdHB6Ye64F62a7YpDJWxNQhSPE0C7HYTHWwm
 HTZF3AwtzAdJvW6SxMwF92CS4rjtYKeUFpkbUAJE4RFmAbrGEUP98V4kjJD5wbeJ7j0f
 noatOJjQ/aCcLi5u2rTaY4/YofxWPykZ3hUMbjGou3sUo8/M9IcnhqBkTVZW6rJrSnVT
 fsqkWj3W04EwYiMvRunMLYMLZG0nINNf5JCBlrV4MLiaVGvmjeqrmgLM1+ZS/z1WG5fP
 x7rw==
X-Gm-Message-State: AGi0PubxHSrYPFVkpPwMinvD6fHjR27kmAkhLIO7BKdrWqbN8AKSk6cJ
 lKHk6R3dqjDVuhM4X/n1DL3HUZUneHW3yPlktKC8E6wLlB2v/kPp/oYehJDKhqExfzrJfw2eLuF
 CyTZsNbA2iLp0808=
X-Received: by 2002:a5d:4092:: with SMTP id o18mr19706357wrp.227.1588606203346; 
 Mon, 04 May 2020 08:30:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypInjUOxX2jKxirAze76WfFjfMC15k/Kv3N9pOHz2KJiR8nTXoBJrwU87jPMHlBSpO3bEcdHRw==
X-Received: by 2002:a5d:4092:: with SMTP id o18mr19706340wrp.227.1588606203145; 
 Mon, 04 May 2020 08:30:03 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 32sm18198202wrg.19.2020.05.04.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:30:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/12] exec: Assert CPU migration is not used on user-only
 build
Date: Mon,  4 May 2020 17:29:18 +0200
Message-Id: <20200504152922.21365-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 2874bb5088..3a39ffb1eb 100644
--- a/exec.c
+++ b/exec.c
@@ -946,7 +946,9 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
=20
     qemu_plugin_vcpu_init_hook(cpu);
=20
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    assert(cc->vmsd =3D=3D NULL);
+#else /* !CONFIG_USER_ONLY */
     if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
     }
--=20
2.21.3


