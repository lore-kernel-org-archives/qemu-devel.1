Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50304221F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7aZfOzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50304221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFf8-0003Lc-AN
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kaFeH-0002sQ-9T
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kaFeE-0008NT-7c
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604484246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRXeG1Qh2/Dw8KSDThSFS17XFtND6Nn3OPIgbKhtInc=;
 b=J7aZfOzjynKI7ZkaC6XZbs95YyIhC16qLDMCIpsdEwLBj0CxcEDEC16wLmO9C0LPq82czL
 VFaFbuLXb8QVxMeS+zhQq5hCbGhIylFuLL4GCqPU00Qc2AiD+qEqkTeem1kWn08W7Nu++d
 uUfZhLXWu+gs5iNWxL7t/A6n/+m+mi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-KZCmWdvLPc-yyJREetU5fA-1; Wed, 04 Nov 2020 05:04:02 -0500
X-MC-Unique: KZCmWdvLPc-yyJREetU5fA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08B281882FAB;
 Wed,  4 Nov 2020 10:04:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16B841002C2B;
 Wed,  4 Nov 2020 10:03:59 +0000 (UTC)
Date: Wed, 4 Nov 2020 11:03:57 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 48/48] hw/timer/armv7m_systick: Rewrite to use ptimers
Message-ID: <20201104100357.7t4nnwqot6ahprrh@kamzik.brq.redhat.com>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
 <20201027114438.17662-49-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201027114438.17662-49-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 11:44:38AM +0000, Peter Maydell wrote:
> The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
> clear-on-write counter. Our current implementation has various
> bugs and dubious workarounds in it (for instance see
> https://bugs.launchpad.net/qemu/+bug/1872237).
> 
> We have an implementation of a simple decrementing counter
> and we put a lot of effort into making sure it handles the
> interesting corner cases (like "spend a cycle at 0 before
> reloading") -- ptimer.
> 
> Rewrite the systick timer to use a ptimer rather than
> a raw QEMU timer.
> 
> Unfortunately this is a migration compatibility break,
> which will affect all M-profile boards.
> 
> Among other bugs, this fixes
> https://bugs.launchpad.net/qemu/+bug/1872237 :
> now writes to SYST_CVR when the timer is enabled correctly
> do nothing; when the timer is enabled via SYST_CSR.ENABLE,
> the ptimer code will (because of POLICY_NO_IMMEDIATE_RELOAD)
> arrange that after one timer tick the counter is reloaded
> from SYST_RVR and then counts down from there, as the
> architecture requires.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Message-id: 20201015151829.14656-3-peter.maydell@linaro.org
> ---
>  include/hw/timer/armv7m_systick.h |   3 +-
>  hw/timer/armv7m_systick.c         | 124 +++++++++++++-----------------
>  2 files changed, 54 insertions(+), 73 deletions(-)
>

Do we also need something like the diff below now?


diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fdf4464b9484..7d5d89e1acf9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -291,6 +291,7 @@ config ZYNQ
 
 config ARM_V7M
     bool
+    select PTIMER
 
 config ALLWINNER_A10
     bool


Thanks,
drew


