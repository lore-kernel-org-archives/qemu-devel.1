Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2039C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0AB206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK2kExuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0AB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPp3G-0007Qj-32
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPp1D-0005lm-6g
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPp1A-0007Fm-Td
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tD0RbHXO8qeiYR+9HbT8vdwMzUHwkUETl4BgnGpbddA=;
 b=XK2kExuk3lITNvVdWWP9sS9MdxuUVf9a0I6hPOSog8mGXPREzb4QhkzGzyyaC43nuEPQiJ
 N17CW7HnhgUzU7diXEpEcKfHHn52aJIq0qTSYvrdUrt2oxa2RkQuCR/Q6uVOgx9BcAaZaQ
 /dnNVLbVJc6x4nZCBff8E6kpMgrTNfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-cvVAgRGNMNaUL0SuzvxEOw-1; Tue, 06 Oct 2020 11:36:40 -0400
X-MC-Unique: cvVAgRGNMNaUL0SuzvxEOw-1
Received: by mail-wm1-f71.google.com with SMTP id 21so1254753wma.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 08:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tD0RbHXO8qeiYR+9HbT8vdwMzUHwkUETl4BgnGpbddA=;
 b=GZ0tkTUpL6DirrT5/ghtXBoFKrqIGY84S84GC1u2eScH5xcm3To0k3RCFzIgEJJRPf
 ojrFGGNgfXPVVq6pNO+ttQk2NP9nYCKb2Ti+OQ6vs0o/Swt0rTO3HgqhahTHDgZP7opU
 1oq7R6XHPc2ngBiwmOYgzd+tyIZlnnTsQKSseu9zuR0eY38SUSqdwhkUosgjxYusFj2T
 vVGn1/mgxAXne3fCUPSkwsf7FIAAZU0qIsWD7TlAxO/v/OamBoWsl7gC3o7bAnAEvWdi
 doY7z6zfopUoYcA0RQdcmoORa8Sm6D0/MbtBbNau8aCTmJjclPEaYV+3bPYJDsv0uch6
 aEzw==
X-Gm-Message-State: AOAM5329Eqaf440q2IPt1zg/za9E8fGEpqwEum5UbLfNNpIdZkP/GRuV
 7igurR2hpK7wW1qMjqU+22B7xHR60YITSeOGH5Fioa8qnIzJ/8Z1Td6ayRabbynlBcz3FIjzKxJ
 pZ2cpCezul4ZC5as=
X-Received: by 2002:adf:94e6:: with SMTP id 93mr5402384wrr.190.1601998598807; 
 Tue, 06 Oct 2020 08:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNSiVRjq4gWwpRTMUnUp/XwEXnxVJmYJwbWjENXSB9FpgxfErsK0CmCuqaFc6Qc0OWecgoIg==
X-Received: by 2002:adf:94e6:: with SMTP id 93mr5402365wrr.190.1601998598610; 
 Tue, 06 Oct 2020 08:36:38 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x6sm4820356wmb.17.2020.10.06.08.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 08:36:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] qom: Fix missing interface in qemu-storage-daemon
Date: Tue,  6 Oct 2020 17:36:35 +0200
Message-Id: <20201006153636.2383248-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempt to fix the issue reported by Kevin.

Since v2:
- Rename function (lersek)

Since RFC(v1):
- Keep it local to hw/nvram (danpb)
- Based on Meson cleanup

Based-on: <20201006125602.2311423-1-philmd@redhat.com>

Base is available in the Git repository at:

  https://gitlab.com/philmd/qemu.git branches/meson_libraries_consistency

Philippe Mathieu-Daudé (1):
  hw/nvram: Always register FW_CFG_DATA_GENERATOR_INTERFACE

 hw/nvram/fw_cfg-interface.c | 15 +++++++++++++++
 hw/nvram/fw_cfg.c           |  7 -------
 MAINTAINERS                 |  2 +-
 hw/nvram/meson.build        |  3 +++
 4 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-interface.c

-- 
2.26.2


