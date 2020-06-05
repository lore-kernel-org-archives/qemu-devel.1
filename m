Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA74207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULJYZlGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA74207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6y8-0002ke-1X
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xP-0001aX-0A
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xN-0004uE-W6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kzQ2XLsOyf4iMsxSVCnnDwKiGVUnP3zEcfX0ALZZdkA=;
 b=ULJYZlGphXLfsnkQZbuzvIXVHmm5KNv1IbaumMN2k2UQTajnrgDPmGznYbLDcoeQOfWMO0
 1nRqLR+9ggD2hCB57G8AN0hFfHGXB35b3v+jFGCKIHjmSHQIkp4YmLT7v0R4HmSyHLR0fb
 61PpNatBmLgP6OG0nSp6aN85v0EXlCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-GFcuZLRzOeKjmRIZ-aWu0Q-1; Fri, 05 Jun 2020 03:39:57 -0400
X-MC-Unique: GFcuZLRzOeKjmRIZ-aWu0Q-1
Received: by mail-wm1-f69.google.com with SMTP id p24so2697566wmc.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kzQ2XLsOyf4iMsxSVCnnDwKiGVUnP3zEcfX0ALZZdkA=;
 b=MYX+7J1ZAoUIG58YzjUaS+0YcZpwzgI9TU3UTuhKAizffG+JlQlM/2NKgleGlu9fS/
 BGWl2B2x4kAhso57G/u7uC8nBGpFfydTM0GExP5Al/8iOCSsAbLWN56PFo8+P6nhYD/r
 Hs3Lm9aIK03xwxN5MUZseQVHMT+1SsamuZHQ/dzpy6yuxfKlsUz5UAitbeG+UJgMMwug
 sGetj7A2AcHU658GX+5DtLU+/XCsRv3fI9MAS3Zowq1UJpq72/UPNZZ/7QSCE3v1N8y+
 /cJB2oUk7F9kZHWa3EeliXefVNJzGvy4smUkAlaFxkmht19juts+4XdSJhXS5FacT0p6
 /Nzg==
X-Gm-Message-State: AOAM533zpF+cs7xBOekqNLc0njRKgicN5LYFWd6WiF/k2m0jfWaCJVwN
 ACHL5ooqh8Pei5i9WutT2jnKTyA0a3Ka2lYKCiFYEPl0pj5p0T2dizVmiBGz9OKrAfvdk4kxXrs
 jZYn44TNxPsnpIpE=
X-Received: by 2002:a5d:6cc1:: with SMTP id c1mr8561593wrc.144.1591342796063; 
 Fri, 05 Jun 2020 00:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGjWxNcaK2hn+IikrKebUYVEzflltIdgOdzBeF+BgTfVZv1mjf+Et+h25VD/8r2HzUD3+7pQ==
X-Received: by 2002:a5d:6cc1:: with SMTP id c1mr8561577wrc.144.1591342795828; 
 Fri, 05 Jun 2020 00:39:55 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o20sm11512822wra.29.2020.06.05.00.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:39:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/11] accel: Allow targets to use Kconfig
Date: Fri,  5 Jun 2020 09:39:42 +0200
Message-Id: <20200605073953.19268-1-philmd@redhat.com>
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
- 4/11 rules.mak: Add strequal() and startwith() and rules
- 5/11 rules.mak: Add base-arch() rule

This series include generic patches I took of the KVM/ARM
specific series which will follow.

- List orphan accelerators in MAINTAINERS
- Add accel/Kconfig
- Allow targets to use their how Kconfig

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
  rules.mak: Add strequal() and startwith() and rules
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


