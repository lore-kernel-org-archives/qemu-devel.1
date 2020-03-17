Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DAC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCDD20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaxxeB6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCDD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4Ox-000833-Lx
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE4Nm-0006bO-0t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE4Nk-0000Qm-Sz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:13 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE4Nh-0008Mc-UG; Tue, 17 Mar 2020 01:03:10 -0400
Received: by mail-pj1-x1041.google.com with SMTP id np9so2841823pjb.4;
 Mon, 16 Mar 2020 22:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L93AIua+E4VlrTK56r4lLI1nlwbf++6T6nKZNGo78Ig=;
 b=gaxxeB6xfyLxlDNje+3fCvqHDSdOtVVy3fvmlRov+60vBa0DsaDWAn/yPEG7eakU+o
 v1HlXNBeZDuEsWaSAYHqqP5MFEmexDzUvofJybvxmkmI8aB3n7U3J0PxtBtsdHVb0NfP
 aHtaEnCccOKb/RTc7rYcE9mF+s0E4VEL26PZM21WJkJJ+FLRLUB99gFemgdqadzj4KAt
 wsEJssNG1wT7MjHbphCc40YZ5LHrPQMI24MVdTs9xWpNu03OoAAfOdr8NCFlWnhz6VVB
 G84b8kphFVdq/mIhFHoD+Wxq8CbCwBm4UvqUZ4Ru6/njbPsW22cs+b08W3B+EStdLEaw
 LbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L93AIua+E4VlrTK56r4lLI1nlwbf++6T6nKZNGo78Ig=;
 b=aowyz9XFJYPBbq3n93KuOpFKxZbEQCgymbSxxnc5fBym5+++NlT6IFH+DEHpTUYRAb
 9rdipwntMwCQ+r3i6nm8su8CbpqYR/5Ur9Pg+FKiX6O1fLS2zpkv+Ooq0fJqSzUk6vHX
 oZxgwldJXbzQNANacmfzA8DHBiuxtIiEaXDM/raVgoUN0VyvsEXlwxLvuid0E6+mOkJs
 aImNbfbGbhsIg0h+eFe7Xqg01KKYoiwmiqU4Wzkp1f/gzLiYwmNnPolxMfa/B+wx8FQY
 lGO29Ki63p+UJ/nsVjxtdwz1ossUVQJr3TfzST4vPE18mG5NE1AwXutb4VQSsb+jI3En
 rM9w==
X-Gm-Message-State: ANhLgQ0uAjegg9OA2xUEzkdqHL8VlNL56i/Mr5uT/hmuBBy6mwMK1Hl1
 hH7rSu6fjBEKrsVeA/XLiH8nxNgv
X-Google-Smtp-Source: ADFU+vvxD34VE/3IKn+vyk0ROcMsuWBYvYWt0uwMczEieMYJw+0hl6Rbtx4dfisGuOHkubgzK9SHsw==
X-Received: by 2002:a17:902:eed1:: with SMTP id
 h17mr2545062plb.135.1584421388374; 
 Mon, 16 Mar 2020 22:03:08 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id k67sm994803pga.91.2020.03.16.22.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:03:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 0/5] FWNMI follow up patches
Date: Tue, 17 Mar 2020 15:02:10 +1000
Message-Id: <20200317050215.159334-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a bunch of other patches remaining  after the last round,
for some less critical issues. Take these before or after the 5.0
freeze as you like.

Patch 1 is the main thing I think should be considered as a fix:
without it, non-FWNMI guests under KVM see behaviour change with
the FWNMI feature. I kept it out of the "must have" round because
Linux has long been FWNMI capable (I don't know state of FreeBSD
though), and because I have not tested under KVM with hardware
MCE injection.

2-3 are hopefully quite harmless comments and messages.

Patch 4 helps the guest stay up under some QoS corner cases.
Lastly is a machine check injection monitor command which helps
test things, it may not be ready for merge but it's useful for
the series.

Patch 5 is monitor command to inject MCEs, it's a bit janky
but it works to test qemu and guests.

Nicholas Piggin (5):
  ppc/spapr: KVM FWNMI should not be enabled until guest requests it
  ppc/spapr: Improve FWNMI machine check delivery corner case comments
  ppc/spapr: Add FWNMI machine check delivery warnings
  ppc/spapr: Don't kill the guest if a recovered FWNMI machine check
    delivery fails
  target/ppc: Implement simple monitor mce injection

 hmp-commands.hx        | 20 +++++++++++++++++++-
 hw/ppc/spapr.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_caps.c    |  5 +++--
 hw/ppc/spapr_events.c  | 40 +++++++++++++++++++++++++++++-----------
 hw/ppc/spapr_rtas.c    | 11 +++++++++++
 include/hw/ppc/spapr.h |  3 +++
 target/ppc/cpu.h       |  3 +++
 target/ppc/kvm.c       |  7 +++++++
 target/ppc/kvm_ppc.h   |  6 ++++++
 target/ppc/monitor.c   | 26 ++++++++++++++++++++++++++
 10 files changed, 149 insertions(+), 14 deletions(-)

-- 
2.23.0


