Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A700C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B371D2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmMZ79qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B371D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMl3-0004Oz-MA
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJLuS-0000yk-Q3
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJLuQ-0003Sh-Cd
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600456740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tTR/HKkz0PIKVOrnuMLG/MRAH04A7b0129glqi+cKFU=;
 b=BmMZ79qRHABnPw/6/vpVzIn6DVLc7H2bUoJwlpeN/L1oCa1RU09gB7Z+OYAmcqzk+vMu0Y
 AbyUExDgE8uVHCgWgU6wh3LGZT8RNXBa7eX+LuBJGx/3iZTDWaicwELBHUSA9VUmkqvc18
 VkQ5EYQCQ+HkDLRjHTALnfz6ORnj11U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-vIeVvc25O6SkmzswIa1aRw-1; Fri, 18 Sep 2020 15:18:56 -0400
X-MC-Unique: vIeVvc25O6SkmzswIa1aRw-1
Received: by mail-wr1-f69.google.com with SMTP id l15so2488517wro.10
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 12:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tTR/HKkz0PIKVOrnuMLG/MRAH04A7b0129glqi+cKFU=;
 b=lQj9Iqus7U6s+EwTpqlPpZ8rLyKRvhGtAo1zvXZ+pDnVzxedu6N7P/DbBhGRAktuMK
 bJNB+fq4c+b8QM5NQHdzkrNQroKRaOmQbUr8q8zkVExgSAzkwWAtg361HZLMOR9M6g7T
 yupHKpnHa05RK5J8NZpwCeTmV5dQGHI+IOXCrpplXHs5GFodS/MIRD9h8dM95MEwdk9t
 P7ei/FyBLqZkD4UF9IdpMD0TZ/gjE5gD6aJPpNOZl+J7w+n805KfjyLCe7VSIyMyALh8
 DlH275CsjEyP49vTWS62mjG8gUy3UIya6nl+K3QyxdqQyJQ+dTuHfUw45qF8bqIv/1va
 d/gw==
X-Gm-Message-State: AOAM532gzurO4Bm4XghveEAI3A1zw4tcdZF2z4wvQ1LmcZxfvlvu5RAG
 t2+3ptU8sBNot6q/kU8FMdgbWAM0C99trtn85jxUJTyXhOQfJo7k04GQkop27fTjP0ynQo5Qwxn
 vK4cuOnxyq+aRMK8=
X-Received: by 2002:adf:f88d:: with SMTP id u13mr42212978wrp.213.1600456734907; 
 Fri, 18 Sep 2020 12:18:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiLztP+3z1gIBQEREnlD7SllECH4hyI0SDGoEaN6uPooYb2G33OiRwSb5nYgEVekmDTvxHPg==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr42212962wrp.213.1600456734630; 
 Fri, 18 Sep 2020 12:18:54 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q13sm7601310wra.93.2020.09.18.12.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 12:18:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Acceptance patches for 2020-09-18
Date: Fri, 18 Sep 2020 21:18:50 +0200
Message-Id: <20200918191852.189151-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 053a4177817db307ec854356e95b5b350800a216:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' i=
nto staging (2020-09-18 16:34:26 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/acceptance-next-20200918

for you to fetch changes up to b6eea069ab3926e110b8ddf037ff7ea7b2c8c1f5:

  tests/acceptance: Skip slow quanta-gsj U-boot+Linux test (2020-09-18 19:46:=
38 +0200)

----------------------------------------------------------------
Acceptance tests queue

Get GitLab CI acceptance jobs green again.

CI jobs results:
  https://gitlab.com/philmd/qemu/-/pipelines/191795388
----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (2):
  tests/acceptance: Disable tests dependent of unreliable
    apt.armbian.com
  tests/acceptance: Skip slow quanta-gsj U-boot+Linux test

 tests/acceptance/boot_linux_console.py | 11 +++++++++++
 tests/acceptance/replay_kernel.py      |  3 +++
 2 files changed, 14 insertions(+)

--=20
2.26.2


