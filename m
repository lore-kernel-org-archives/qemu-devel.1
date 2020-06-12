Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BBC20691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRUdgZ/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BBC20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl6y-0007s4-EF
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl27-0006Sc-TK
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl26-0001QP-9H
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i525bms7gqVVwpF2fPgVg2EaF8HaC1eOaVMCjQtCrsc=;
 b=VRUdgZ/S8+7Rc7+UPBpQFEJOtprDM25goi3eRRwbu2sw0Qc6lMHkweJ8QU+eELmsVyXakY
 AH8N4HL+bQ4k+RF7tnahfeK7Akk4LPh184l0Ujm4RnWgZulMmHf2M7OCdI6LuztNOJJI3j
 a9kJh+zF2g7AiEchUUvdlwYxXIkzxK4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-zhmBKMwNN-aToIxBO1t0NQ-1; Fri, 12 Jun 2020 10:51:47 -0400
X-MC-Unique: zhmBKMwNN-aToIxBO1t0NQ-1
Received: by mail-wm1-f69.google.com with SMTP id 14so2515144wmi.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i525bms7gqVVwpF2fPgVg2EaF8HaC1eOaVMCjQtCrsc=;
 b=JkJ/6a9E+x50SUWLr/x+1IW26lfAfoRZ6IRbUeQ6THY4+yoEcAiLxQAriURhYHw2KL
 O0XryidKGhoIWg/VtszcqOfdFn3TNA4UXa9mY0sE4ywqIbNu3FVm1JaVoevNvOMD2W+p
 BjVAUQb0/biXycONsyMsZSmeeSvvw3Mxnnh4dEfXsNxQyK/WL/bk6YKCeTty2e14QivH
 ML8DyoMRHDxb5ZJLj0lSGnNj6+gqmDVBv0xxGFMOBCrbwljvADKK9KUGYHVzR8SOKL2g
 F9sSjw437SbJK7gzvRLrPrWVJe96iGrNj0kqiYvYf0F8W5gnjFf8axIU3wBmNegVy13s
 UQXQ==
X-Gm-Message-State: AOAM532+fFYqOxnhpyyrxqqRdEtf5bjOeLfH+2kkfbnUQbf19x3l/UhD
 sGOxvWUn0q8edBFfn0R+wsdmT9KZ2M5i2d4fH+um+AZJbbFpKeFCxlOnhNxDmQbSbgJjub6IOYL
 QWjs7XxnGUJBQVRc=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr14579521wro.146.1591973506546; 
 Fri, 12 Jun 2020 07:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDFmlycbv7zP4AvmREggXcVcaIbtb3vGSvUl1amEK1TwlPCLglGdLKXIRdAKy/x7dnr0ggYg==
X-Received: by 2002:adf:f30d:: with SMTP id i13mr14579509wro.146.1591973506376; 
 Fri, 12 Jun 2020 07:51:46 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id s5sm9019681wme.37.2020.06.12.07.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:45 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 19/58] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
Message-ID: <20200612141917.9446-20-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

bios-tables-test executes SeaBIOS. Indeed FW is needed to
fetch tables from QEMU and put them into the guest RAM. Also
the FW patches cross table pointers. At some point, SeaBIOS
ends up calling the TPM2_CC_HierarchyControl command with
TPM2_ST_SESSIONS tag, most probably steming from
tpm_set_failure/tpm20_hierarchycontrol SeaBIOS call path.
This causes an assert() in the qtest tpm emulation code.

As the goal here is not to boot SeaBIOS completely but just
let it grab the ACPI tables and consolidate them, let's just
remove the assert().

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20200609125409.24179-4-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/tpm-emu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index c43ac4aef8..298d0eec74 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
         s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
         s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
         g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
-        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
 
         s->tpm_msg = g_realloc(s->tpm_msg, s->tpm_msg->len);
         qio_channel_read(ioc, (char *)&s->tpm_msg->code,
-- 
MST


