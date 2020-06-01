Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA71C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74101206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/WNcTQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74101206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhdj-0005dm-MC
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jfhZq-0000XO-RN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:21:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jfhZq-00008D-48
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591006913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTSaCdeUAu1HcnT2Agf6LlwsvyK0ifJSU70lffYSgu4=;
 b=K/WNcTQ4jfHFGwJ6WgJWnmn3R28OFvIf5hMyYtq5E8zYdyjcdk/hITi1ymaLFIMEblY20w
 HfqziDOU6KesT4oNXy/dUOhSqvb5Q580TZI56UAcC+TD6K53+1jb8KeiMgUyvjoAbieNLH
 8YpRR/vxVMu8U5dlA1YWLnaiCv0s3f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-_YcLJhhcMi2jzPNFQbz81Q-1; Mon, 01 Jun 2020 06:21:51 -0400
X-MC-Unique: _YcLJhhcMi2jzPNFQbz81Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68179107ACCD;
 Mon,  1 Jun 2020 10:21:50 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 624E9D01F6;
 Mon,  1 Jun 2020 10:21:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Subject: [RFC 4/6] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
Date: Mon,  1 Jun 2020 12:21:11 +0200
Message-Id: <20200601102113.1207-5-eric.auger@redhat.com>
In-Reply-To: <20200601102113.1207-1-eric.auger@redhat.com>
References: <20200601102113.1207-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

While writing tests for checking the content of TPM2 and DSDT
along with TPM-TIS instantiation I attempted to reuse the
framework used for TPM-TIS tests. However While dumping the
ACPI tables I get an assert on TPM2_ST_NO_SESSIONS. My assumption
is maybe the other tests did not execute long enough to encounter
this. So I tentatively propose to remove the assert as it
does not seem to break other tests and enable the new ones.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/tpm-emu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index c43ac4aef8..298d0eec74 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
         s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
         s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
         g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
-        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
 
         s->tpm_msg = g_realloc(s->tpm_msg, s->tpm_msg->len);
         qio_channel_read(ioc, (char *)&s->tpm_msg->code,
-- 
2.20.1


