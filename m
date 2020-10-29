Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D44C5517A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9A22076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mrd0jjip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9A22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4p1-0003th-Ru
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY4kq-0007uz-UO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY4kW-00081M-85
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603965698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LD7wpZ+hNWemzOHfmRclT7534RCAnP02ENTm9t4WgpA=;
 b=Mrd0jjipItZLRx35FYv9CbBbmh5F0+UokUWKUqc7WtAuv00hB8UPauwWndfGSl2z6JLlt+
 HiRFP79DvY9/hIDzuZBMNXHAw1VVrz9vacTIDCYuW2SNbkddAnEkpjnl820rfIm8CCdxoC
 /4GCEd03K3jSjMOjSqEoYgsCIz12lrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152--b1sx1WQOCq8FJ6di8NZ1w-1; Thu, 29 Oct 2020 06:01:36 -0400
X-MC-Unique: -b1sx1WQOCq8FJ6di8NZ1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07A4F18CBC4D;
 Thu, 29 Oct 2020 10:01:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-62.ams2.redhat.com
 [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2A1E10013C1;
 Thu, 29 Oct 2020 10:01:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] io: Don't use '#' flag of printf format
Date: Thu, 29 Oct 2020 10:01:18 +0000
Message-Id: <20201029100119.30696-5-berrange@redhat.com>
In-Reply-To: <20201029100119.30696-1-berrange@redhat.com>
References: <20201029100119.30696-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 AlexChen <alex.chen@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: AlexChen <alex.chen@huawei.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: AlexChen <alex.chen@huawei.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index bb545fa327..03c1f7cb62 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -746,7 +746,7 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
             opcode != QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE &&
             opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PING &&
             opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PONG) {
-            error_setg(errp, "unsupported opcode: %#04x; only binary, close, "
+            error_setg(errp, "unsupported opcode: 0x%04x; only binary, close, "
                        "ping, and pong websocket frames are supported", opcode);
             qio_channel_websock_write_close(
                 ioc, QIO_CHANNEL_WEBSOCK_STATUS_INVALID_DATA ,
-- 
2.28.0


