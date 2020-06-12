Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2695C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 02:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C983206DC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 02:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="r5rBPkWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C983206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjZ3x-0006MK-Ld
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 22:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jjZ38-0004jw-VA
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 22:04:06 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:34028)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jjZ37-0004rC-6U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 22:04:06 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id C19A6443E9;
 Fri, 12 Jun 2020 12:04:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1591927440;
 bh=5cIedYJIDnW25HPepE48iAyANy2QrrzppiFXCkgZfaA=;
 h=From:Date:Subject:To:Cc:From;
 b=r5rBPkWu7FcFok6UvjmWYiEeQBFsZyaezQJr8o6+creGaaPRBhTZ8oQ3ASL2lTi2K
 3E2On3hXhnTx8IYVZQp9zuysqu57qnpWgolSOpa+TzplpUHIOI9tYGuyLuOMpHuzsI
 XqmhrukH6TnwANWEfKjJPMKzxFHsUMQbik5oJ8jI=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id 989D93A0172; Fri, 12 Jun 2020 12:04:00 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
Date: Fri, 12 Jun 2020 10:12:37 +1000
Subject: [PATCH 0/6] audio/jack: fixes to overall jack behaviour
To: <qemu-devel@nongnu.org>
Cc: <kraxel@redhat.com>
X-Mailer: mail (GNU Mailutils 3.5)
Message-Id: <20200612020400.989D93A0172@moya.office.hostfission.com>
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 20:16:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry for the spam, resubmitted due to missing subject on this cover
letter. Seems patchew.org can't find the associated patches without it.

This patch set addresses several issues that cause inconsistent
behaviour in the guest when the sound device is stopped and started or
the JACK server stops responding on the host.

Geoffrey McRae (6):
  audio/jack: fix invalid minimum buffer size check
  audio/jack: remove unused stopped state
  audio/jack: remove invalid set of input support bool
  audio/jack: do not remove ports when finishing
  audio/jack: honour the enable state of the audio device
  audio/jack: simplify the re-init code path

 audio/jackaudio.c | 73 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.20.1


