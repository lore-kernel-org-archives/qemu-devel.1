Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F38C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514F120735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NCRZvpfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514F120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4t6-0008Vw-88
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kS4Ya-0006I7-Qc
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:36:32 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:15328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kS4YV-00035q-Qv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1907; q=dns/txt; s=iport;
 t=1602534987; x=1603744587;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=alGQUjsE4wQMn1ISSevC74/L8wkgmTQvinTpePdFCW4=;
 b=NCRZvpfPcnqZKTfqM3oS/+Gm8ICG11jBfVn+9cJkslIjle3yG+Uv+I+/
 6LnVazzopfb2GO3pb+6h9t2DWhUu28UC9WXD/9YHoiT7Nu36EWu/hoMnM
 KMFg/hvCvXCgA3BadEf2wStE0rebZAQAEqNNL9tAGV+yB0zzS+T74/umA I=;
X-IPAS-Result: =?us-ascii?q?A0BcBQDbvIRf/4sNJK1ghQJwVQEyLJZZmyQLAQEBDQEBG?=
 =?us-ascii?q?A0KBAEBhAZEghgCJTgTAgMBAQEDAgMBAQEBBQEBAQIBBgRthVwMhXUFMQFGg?=
 =?us-ascii?q?Qk1AYM4AYJ8D6Z2giiEOwELAQcDDy+FMgaBOIg3hH8bggCBEYJbc4JcBAEWh?=
 =?us-ascii?q?z0EkwkBh2eBbZsCgnKDFYVsiw+GSg8igxWKCJQdkyKKcZU0AgQGBQIVgWsjg?=
 =?us-ascii?q?VdNIxWDJU8ZDZckhWIhAzACNQIGCgEBAwmOSAEB?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,367,1596499200"; d="scan'208";a="553497794"
Received: from alln-core-6.cisco.com ([173.36.13.139])
 by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 12 Oct 2020 20:36:24 +0000
Received: from kamensky-p53s.cisco.com ([10.24.37.191]) (authenticated bits=0)
 by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 09CKaGHP032678
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 12 Oct 2020 20:36:23 GMT
From: Victor Kamensky <kamensky@cisco.com>
To: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Khem Raj <raj.khem@gmail.com>
Subject: [PATCH 0/1] mips: add 34Kf-64tlb fictitious cpu type like 34Kf but
 with 64 TLBs
Date: Mon, 12 Oct 2020 13:36:12 -0700
Message-Id: <20201012203613.85823-1-kamensky@cisco.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kamensky@cisco.com
X-Outbound-SMTP-Client: 10.24.37.191, [10.24.37.191]
X-Outbound-Node: alln-core-6.cisco.com
Received-SPF: pass client-ip=173.37.142.90; envelope-from=kamensky@cisco.com;
 helo=alln-iport-3.cisco.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:36:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Qenu MIPS guys,

Could you please review and, if possible, accept a simple patch, following
this cover letter, that introduces new fictitious 34Kf-64tlb MIPS cpu
model. It is exact copy of 34Kf MIPS cpu model only the number of TLBs is
bumped up from 16 to 64.

This change and use of 34Kf-64tlb model brings up performance of
running non-trivial Linux user-land load under qemu-system-mips by
40% or more.

Yocto Project uses qemu-system-mips 34Kf cpu model, as recommended
by [1], to run 32bit MIPS CI loop. It was observed that in this
case CI test execution time was almost twice longer [2] than 64bit MIPS
variant that runs under MIPS64R2-generic model. It was
investigated [3] and concluded that the difference in number of TLBs
16 in 34Kf case vs 64 in MIPS64R2-generic is responsible for most of
CI real time execution diffrence. Because with 16 TLBs linux user-land
trashes TLB more and it needs to execute more instructions in TLB
refill handler calls, as result it runs much longer.

Proposed fix that Yocto Project adopted locally already as private
patch is to create and use 34Kf-64tlb cpu model, that is the same as
34Kf but with bigger number of TLBs.

Yocto Project would appreciate very much if this change can
be accepted by qemu project. It would reduce burden of porting
forward private patch. Other users of qemu-system-mips could
benefit from the change and new model as well.

Thanks,
Victor

[1] https://www.qemu.org/docs/master/system/target-mips.html#preferred-cpu-models-for-mips-hosts

[2] https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992

[3] https://lists.openembedded.org/g/openembedded-core/message/143099

Victor Kamensky (1):
  mips: add 34Kf-64tlb fictitious cpu type like 34Kf but with 64 TLBs

 target/mips/translate_init.c.inc | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

-- 
2.25.4


