Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1350C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6314206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXxoeuIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6314206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhfw-0008K2-Vm
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jfha1-0000h5-GS
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:22:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jfhZz-00009I-93
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591006922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5L0MRr3nljfevsNXbHik94B5eMH7O70Nw6KsCOeKxs=;
 b=BXxoeuIg+YJIVnZhOvQDm3/tR0+nEkOE7zwwm57e4u5l82ECnfFXFzHo6zbYk+wf92UZoC
 tf5d/c+LIggzYuKUeRsgzQQcywVDi6iL/TMg7yHKaHAsFO38/D156BmXJjiiIAyGcCqGiN
 3bnev4O7Nl94zZzeStm43zevZ52yUME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-9g74DpKqPkaL-wRq21epKw-1; Mon, 01 Jun 2020 06:22:01 -0400
X-MC-Unique: 9g74DpKqPkaL-wRq21epKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB28618A0724;
 Mon,  1 Jun 2020 10:21:59 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2084CD01E1;
 Mon,  1 Jun 2020 10:21:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Subject: [RFC 6/6] bios-tables-test: Generate reference tables for Q35/TPM-TIS
Date: Mon,  1 Jun 2020 12:21:13 +0200
Message-Id: <20200601102113.1207-7-eric.auger@redhat.com>
In-Reply-To: <20200601102113.1207-1-eric.auger@redhat.com>
References: <20200601102113.1207-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:35:47
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TPM2, DSDT tables were generated using
tests/data/acpi/rebuild-expected-aml.sh

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/q35/DSDT.tis                | Bin 0 -> 8468 bytes
 tests/data/acpi/q35/TPM2.tis                | Bin 0 -> 76 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a2a45d1d31..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.tis",
-"tests/data/acpi/q35/TPM2.tis",
diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..34a3c915d27cab5d09190a0441e9511db0c147f2 100644
GIT binary patch
literal 8468
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/TPM2.tis b/tests/data/acpi/q35/TPM2.tis
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7878a6e79a6a406d99ca1f5e9a528eb392b8d793 100644
GIT binary patch
literal 76
wcmWFu@HO&bU|?V=a`Jcf2v%^42yhMoiZKGkKx`0=4A_u4U^Ym_e|8WP0Iiz{0RR91

literal 0
HcmV?d00001

-- 
2.20.1


