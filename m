Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D785206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpHHhGzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D785206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGex-0000Z7-Pp
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGc9-00055F-Pq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGc8-0000AS-Il
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g+vMg2V1rfgEFoaemJzkxqG421sw/c8r5Bz42jn0WWw=;
 b=YpHHhGzkK2/i6XZ28n0hIbg01c0n32ZWkf+vQPlvXmx6CuxZHUzB8pQZmvoiXnWs7t6Mt9
 9qBf8CSUE9iTVTDRt0RlTy6eHcmk/o9ytthP4YE6JS7D5PueMykMlzw5avQy0e5kX+MqEn
 6+v1s5tHSVsW+Li3Ia5JSQDS7ZBaJd8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-XbeVv--iPByvrDvxlm5sLg-1; Fri, 05 Jun 2020 13:58:25 -0400
X-MC-Unique: XbeVv--iPByvrDvxlm5sLg-1
Received: by mail-wr1-f70.google.com with SMTP id f4so4068750wrp.21
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g+vMg2V1rfgEFoaemJzkxqG421sw/c8r5Bz42jn0WWw=;
 b=gYr/zs8uRWFTMNrBqUFQCWJ7A5ouFp8odTpZM8doy/du1m9cnL9DdAtEH5OKVY54ip
 k5/IiDwUrV/Bou8Rb/OxKGEP5vDJdc6A+PuvpTwIfIpm/ICD78alMtlI6zJLg4xew4ss
 4N7cTC++gTDlbbFwq7BERo+y0GS+pfGsGbhWiMvhTJ4LkIsF6ziMEzt9gvCKZ+4CQe6J
 1oZUlv0OjAlp5ueJgSumH3QmxtfdCwqpSIEP7l2kfXBeLuEAKTioduN4NNrx0LL6ALCk
 s/ZvgZ0EAYcuriM6AY1M2Jvt3vL1pSr/zh0STKw001/M4pMp0ZaEeR0yK/Fg42BFQcxC
 oV0Q==
X-Gm-Message-State: AOAM532hp6ooi/tULCQpkwXoiyXB9kd8oUyqsYRz0ndhpITQxUNXImrL
 UgKSaydaKP6tbSN0pmqac4ij7TR8c8E7oTinPz5JJToolJXBKWVSG8Q8rnXRQ3R+KiCpYHtau+O
 xLwJnLufZkQxTFy8=
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr4060936wmi.73.1591379904324; 
 Fri, 05 Jun 2020 10:58:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2fG79YBW4WQJxRE2PcfTdF5Nl9t9jbezy9MNWmyR9xYYSHtYHCl5DNUA/kNK4cJDcwleqSg==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr4060919wmi.73.1591379904057; 
 Fri, 05 Jun 2020 10:58:24 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 88sm14213018wre.45.2020.06.05.10.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:58:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/11] accel: Allow targets to use Kconfig
Date: Fri,  5 Jun 2020 19:58:10 +0200
Message-Id: <20200605175821.20926-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missing review:
- 4/11 rules.mak: Add strequal() and startswith() rules
- 5/11 rules.mak: Add base-arch() rule

This series include generic patches I took of the KVM/ARM
specific series which will follow.

- List orphan accelerators in MAINTAINERS
- Add accel/Kconfig
- Allow targets to use their how Kconfig

Since v6:
- Fixed typo 'startwith' -> 'startswith' (armbru)

Since v5:
- Fixed typo in patch #4 subject
- Added David R-b tag
- Stripped --- comments

Since v4:
- Addressed rth review comments in rules.mak

Since v3:
- Fixed base-arch() rule (rth)
- Dropped 'semihosting: Make the feature depend of TCG'

Since v2:
- Addressed Thomas review comments
- Fixed problem when including TARGET instead of BASE_TARGET

Since v1:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
- Drop HVF MAINTAINERS patch (merged elsewhere)
- Kconfig-select SEMIHOSTING (bonzini)
- Drop user-mode selection patches
- consider m68k/nios2/xtensa/riscv (pm215)
- reword Kconfig SEMIHOSTING description (pm215)
- reset some of rth R-b tags

Previous RFC for semihosting posted earlier:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg631218.html

Philippe Mathieu-Daudé (11):
  MAINTAINERS: Fix KVM path expansion glob
  MAINTAINERS: Add an 'overall' entry for accelerators
  MAINTAINERS: Add an entry for the HAX accelerator
  rules.mak: Add strequal() and startswith() rules
  rules.mak: Add base-arch() rule
  Makefile: Remove dangerous EOL trailing backslash
  Makefile: Write MINIKCONF variables as one entry per line
  accel/Kconfig: Extract accel selectors into their own config
  accel/Kconfig: Add the TCG selector
  Makefile: Allow target-specific optional Kconfig
  accel/tcg: Add stub for probe_access()

 Makefile               | 15 +++++++++----
 rules.mak              | 49 ++++++++++++++++++++++++++++++++++++++++++
 accel/stubs/tcg-stub.c |  7 ++++++
 Kconfig.host           |  7 ------
 MAINTAINERS            | 19 +++++++++++++++-
 accel/Kconfig          |  9 ++++++++
 6 files changed, 94 insertions(+), 12 deletions(-)
 create mode 100644 accel/Kconfig

-- 
2.21.3


