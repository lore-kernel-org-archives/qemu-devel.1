Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34B4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBBE20752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dk64Qy/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBBE20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcHM-0001C9-MS
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6u-0006lA-EK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6t-0006jX-DR
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2N91cBk7aeGymYBjy55YvlROyXKTbkYAlJPKLwnfG8w=;
 b=dk64Qy/ta2LX1drYv0VfA9JxyLf0DONPbsF4+h780/6mJYAp3xp9uZWyr+vxkUJi94bkS1
 ZuIG9ROgO9TuOWGFFiZMfAwphMDTX6oEJDcy5jHgVIeQ6TFubwSPS4Iqy7hvV6EKYMWS4I
 OaVs1eD0zzxVDgg3nCNlO00nP7nyWiY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-4-HxNC7mNiiQ8hlVYDJZmg-1; Mon, 04 May 2020 10:30:16 -0400
X-MC-Unique: 4-HxNC7mNiiQ8hlVYDJZmg-1
Received: by mail-wr1-f70.google.com with SMTP id y4so5804473wrt.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KDde8SgK/ldUN87GHz4uiNYcfNlAns6jsj/DZnuAhTk=;
 b=NZx5WXZ8qtAyt22Ueyvz7eJ234iAtTgUYPPbqYWOQKwwvxi2nZPWdlEA1t87BoTF2W
 OHK0ILOScYSYiRvnpxO+Ky8zhsGNdoCa8vbOlVDIxJc6Mw8K4QMaxtF8kHoa8/7zzMWL
 vAYgG9YCZ2q00P92rumGxjYFbYE5/h5BWdLvJaSNNOxaB7RgQG9Ce4ninIRR45U0RlP5
 b3ODNhw3W8G1UrpDOVdUdI2irYJC5/uR+cX/DvajfAxMSo2mucqRORbWrstrY9zwY61N
 Vgiqf+Xw83HarSG49MNZYMwFiLdi2bccdxiTS8LsqEjgGB0DUASF+HusowZ2/Ebkt/bu
 fJoQ==
X-Gm-Message-State: AGi0Pub5Zl/I1rMuE+PSPhAlF9xtFLyCdDQRC+2TIFfV+QNVvPaopwct
 ZXajqEtgEhuBf0t/v8tisPkQb86nPK3HiIDLxo5MglEuuXLilM+K6sd4Uf5sLp3FsxvBb34Kw7t
 g2S2/3eTa8IzClrQ=
X-Received: by 2002:adf:82ac:: with SMTP id 41mr17130008wrc.110.1588602615388; 
 Mon, 04 May 2020 07:30:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJwPeQgmiX3K49346YelqjkIrD+bKwChmOK44nTHVuoqJI9rKf4p7R/Y2tAHDXO/SL8StM91A==
X-Received: by 2002:adf:82ac:: with SMTP id 41mr17129986wrc.110.1588602615146; 
 Mon, 04 May 2020 07:30:15 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 i129sm14553865wmi.20.2020.05.04.07.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:14 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/29] acpi: unit-test: Update WAET ACPI Table expected binaries
Message-ID: <20200504142814.157589-26-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

This is done according to step (6) in the process described at
tests/qtest/bios-tables-test.c.

Expected WAET.dsl:

[000h 0000   4]                    Signature : "WAET"    [Windows ACPI Emul=
ated Devices Table]
[004h 0004   4]                 Table Length : 00000028
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 88
[00Ah 0010   6]                       Oem ID : "BOCHS "
[010h 0016   8]                 Oem Table ID : "BXPCWAET"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "BXPC"
[020h 0032   4]        Asl Compiler Revision : 00000001

[024h 0036   4]        Flags (decoded below) : 00000002
                        RTC needs no INT ack : 0
                     PM timer, one read only : 1

Raw Table Data: Length 40 (0x28)

  0000: 57 41 45 54 28 00 00 00 01 88 42 4F 43 48 53 20  // WAET(.....BOCHS
  0010: 42 58 50 43 57 41 45 54 01 00 00 00 42 58 50 43  // BXPCWAET....BXP=
C
  0020: 01 00 00 00 02 00 00 00                          // ........

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200313145009.144820-4-liran.alon@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/pc/WAET                     | Bin 0 -> 40 bytes
 tests/data/acpi/q35/WAET                    | Bin 0 -> 40 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index b269a1e3e5..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/WAET",
-"tests/data/acpi/q35/WAET",
diff --git a/tests/data/acpi/pc/WAET b/tests/data/acpi/pc/WAET
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c2240f58dff6b2f765386b5a2e5=
06fda4800be3e 100644
GIT binary patch
literal 40
mcmWG{bPds9U|?YEaPoKd2v%^42yhMuiZKGkKx`1r1jGQWX$JuS

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/WAET b/tests/data/acpi/q35/WAET
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c2240f58dff6b2f765386b5a2e5=
06fda4800be3e 100644
GIT binary patch
literal 40
mcmWG{bPds9U|?YEaPoKd2v%^42yhMuiZKGkKx`1r1jGQWX$JuS

literal 0
HcmV?d00001

--=20
MST


