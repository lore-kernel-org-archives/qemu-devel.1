Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE6D2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7+AZSRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE6D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMY0O-0000ko-A7
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXyd-0007vQ-Qp
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXyc-0000l4-GI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMXyc-0000jw-A4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id w18so13522320wrt.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qlmvdpaIFBiXFkjQ4YNJNIpdNHXmflVBlBiQ+xgkJj0=;
 b=T7+AZSRtnSvrLaYYDqEhKoS7fvLUj5n7w9iNsnsupHSTZzkUE1+uEJ2iLTbcWxxuzB
 onAzwbByMj0/s3BiTeX2WAFVXD2nSWuWCspvMyGh+/wA3a5CwBFfUHqCn/h/bqbrgCsr
 38zdui/o+lKu1J+qUfi4l7O1QRNT863v+O7vuEkAV7tt6gZSjCkdv018hrKygmEbjuH1
 mo1yvleUXeXE4pg4A5UoaW29p48e2fTa7McOHJFpD8mq77F1NSpKT5QZPG1Zz8xnxa7d
 mrxdnNG49ToBy7EbX4XZYFktcBZUeX/QpG6Ua8Ii5y1rFKSfEsrYYpW11fUG+GAEdgE8
 DS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qlmvdpaIFBiXFkjQ4YNJNIpdNHXmflVBlBiQ+xgkJj0=;
 b=HD322CZtCqbyxAMoDvqRqurEjhEtUx2jROXQyoLH6C4PWMgBappezSrRVE0/e2SxiW
 IePbvdnjWWTehDkVdYeuyx8n2Dpb2aKR85It1Y7vND5IpHuIwDgfJ+5/eDRYK21hFkj8
 cMd6DKnxVPvkDusOnSMZIver8PcQEpoIsaU9Q9XOdOZIXzEGtdxEU/BtiH8+OVBfTqYZ
 DXZPAYemv6GoMHq0qK4HIwzQ5OYNo9UGMbVGTndlHijPOQ2LzmQfnYbiFx0CR5HmwxjW
 JrWBxIg9OD+EHT28XE6kzh54xhAjj4OWtVVYWDl8LqAcl/hmTmQyREXKmkChd19ZcVhr
 3uVA==
X-Gm-Message-State: APjAAAWo4WfvJ75wXe1dtp2rNRyigK3eT5dqQfA5G4zbQAd0ZAaXPReK
 0F9wekizk4qhn4nNU4rnk9yYlnJKBDE=
X-Google-Smtp-Source: APXvYqx40veOw6O3S+MEj2ss3zVGkpZxEzJgYinUBYbHlGFi3Svdi/5tQH0KtwDU8RWjZ4OA8ux0Fg==
X-Received: by 2002:a05:6000:12:: with SMTP id
 h18mr9864973wrx.161.1571665440606; 
 Mon, 21 Oct 2019 06:44:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q196sm10443689wme.23.2019.10.21.06.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 06:43:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Convert sparc devices to new ptimer API
Date: Mon, 21 Oct 2019 14:43:54 +0100
Message-Id: <20191021134357.14266-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the devices used by sparc machines to the new
ptimer API.

Currently the ptimer design uses a QEMU bottom-half as its mechanism
for calling back into the device model using the ptimer when the
timer has expired.  Unfortunately this design is fatally flawed,
because it means that there is a lag between the ptimer updating its
own state and the device callback function updating device state, and
guest accesses to device registers between the two can return
inconsistent device state. This was reported as a bug in a specific
timer device but it's a problem with the generic ptimer code:
https://bugs.launchpad.net/qemu/+bug/1777777

The updates to the individual ptimer devices are straightforward:
we need to add begin/commit calls around the various places that
modify the ptimer state, and use the new ptimer_init() function
to create the timer.

Changes v1->v2:
 * patches 2 and 3 are the old 1 and 2 and have been reviewed
 * patch 1 is new and removes a pointless NULL check; without
   this we'd probably have got Coverity errors when patch 3
   added a use of t->timer before the check for it being NULL

thanks
--PMM


MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Peter Maydell (3):
  hw/timer/slavio_timer: Remove useless check for NULL t->timer
  hw/timer/grlib_gptimer.c: Switch to transaction-based ptimer API
  hw/timer/slavio_timer.c: Switch to transaction-based ptimer API

 hw/timer/grlib_gptimer.c | 28 ++++++++++++++++++++++++----
 hw/timer/slavio_timer.c  | 32 +++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.20.1


