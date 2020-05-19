Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BDC2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoaWbe3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BDC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6u0-0001f1-Ra
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rE-0005g3-2N
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6rB-0008S6-CJ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zefoBQJ3bZCdL/Z6bGZikdRcluKryyDYLAe/Y2/+1H4=;
 b=DoaWbe3o/18BZz2saxPOjsEKZvIgJ7o78/9WMkHfJqa1LXUnYkg2WiIxBvwus0TO9Zpo85
 jwsPBpnz6T3wbWBSobrNdkeFIzxY2ZsJMEYUWuQQydO4DDamaBs/R8ozZa0yAacYL7vnRN
 Qs7vs7d+02Y1DSt2e9gB94EU6MYfc64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-QrurZtoqMT2RibE32a0lZg-1; Tue, 19 May 2020 14:20:29 -0400
X-MC-Unique: QrurZtoqMT2RibE32a0lZg-1
Received: by mail-wr1-f69.google.com with SMTP id z16so185142wrq.21
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zefoBQJ3bZCdL/Z6bGZikdRcluKryyDYLAe/Y2/+1H4=;
 b=GlzftQqdQNaQsqrmxfmuyVcniLC3sRLnFFF7YBKPMDggdsNpoqvIZiAIo9ZBtZXLpt
 /bsU0aqRy6GE8YbHVvzf7/HYPx4WKEf8CkAKK+4BGcyGGjusGgQVXEOwN/IMQT0qcCMM
 /gKBHYUZKgGkXzhhwAAb8khkQV69OOqYGDCrs0Fv1S0iS6T0r5MABZrUbqit+kmQcb4T
 RFfd4UhvBYw8/9yVzGLgxjbFaK4CB/ukhVT//jYafxa9MHCDP5ty+OgXOsblmkv2yfRQ
 CBpDGzlkpeVEKKGBHPhL7gZoWyv5eKGjBNk+c6AMqCmIl/aYDopmif/671bu5PCMtgR1
 cSLA==
X-Gm-Message-State: AOAM533jsAn5tu1zIECxd6XWrfbq/JABSgdkRRchaetIAr5KehqoQV9p
 0cJ6KCHVI0JU7iZLDhMW75nA8fZ82VRqJRJ+S2jFSevZEDDW2bv4KjG/HMY2yTzVt0HajsrQfrP
 to3ePh5ykck4knog=
X-Received: by 2002:a5d:40c2:: with SMTP id b2mr174271wrq.13.1589912428237;
 Tue, 19 May 2020 11:20:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKuKFwwxKpkfVYF7Hq9AT4RB1a+mjykLQo4WK7DtzZJ3XrbRASvhdINzVRO6ma5UeZelSKSA==
X-Received: by 2002:a5d:40c2:: with SMTP id b2mr174234wrq.13.1589912427927;
 Tue, 19 May 2020 11:20:27 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a14sm500133wme.21.2020.05.19.11.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:20:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR;
 crypto: Add tls-cipher-suites
Date: Tue, 19 May 2020 20:20:19 +0200
Message-Id: <20200519182024.14638-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series has two parts:

- First we add the ability to QOM objects to produce data
  consumable by the fw_cfg device,

- Then we add the tls-cipher-suites object, and let it
  implement the FW_CFG_DATA_GENERATOR interface.

This is required by EDK2 'HTTPS Boot' feature [*] to tell
the guest which TLS ciphers it can use.

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README

Since v5:
- Complete rewrite after chatting with Daniel Berrangé
Since v4:
- Addressed Laszlo comments (see patch#1 description)
Since v3:
- Addressed Markus' comments (do not care about heap)
Since v2:
- Split of
Since v1:
- Addressed Michael and Laszlo comments.

Please review,

Phil.

v5: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04525.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04300.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02965.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html
Supersedes: <20190620122132.10075-1-philmd@redhat.com>

Philippe Mathieu-Daudé (5):
  hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
  softmmu/vl: Let -fw_cfg option take a 'blob_id' argument
  softmmu/vl: Allow -fw_cfg 'blob_id' option to set any file pathname
  crypto: Add tls-cipher-suites object
  crypto/tls-cipher-suites: Product fw_cfg consumable blob

 include/crypto/tls-cipher-suites.h |  39 ++++++++
 include/hw/nvram/fw_cfg.h          |  49 ++++++++++
 crypto/tls-cipher-suites.c         | 152 +++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c                  |  30 ++++++
 softmmu/vl.c                       |  19 +++-
 crypto/Makefile.objs               |   1 +
 6 files changed, 285 insertions(+), 5 deletions(-)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

-- 
2.21.3


