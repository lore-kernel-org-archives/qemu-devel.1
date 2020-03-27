Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B152C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3F420748
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/+PPtZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3F420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqrH-0006Rm-Kx
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHqmM-0006yY-BR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHqmL-0005N1-37
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHqmK-0005KX-Ug
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585322412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a260PcX5ZP8azlfxdqQzYQNlsh8Xo00rhXrMyOcYqUg=;
 b=L/+PPtZgSYyQvwTKKSalNGLw2CuCskUluiKHNwkajizKbYhcGEg0CknvWfQljRy1wMrb/A
 5uIacmJ9JL3poI0yp7/C+5WUSFnHAZeA2Djh8dEJTj80YksAZUgYqM4uQPACmz3A4yiRyn
 ChKTQGoFF+YluG7W2c8U4S9VwHhnNZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-k780iwY-PeO68ffKiFTePg-1; Fri, 27 Mar 2020 11:20:10 -0400
X-MC-Unique: k780iwY-PeO68ffKiFTePg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59CB88017CE;
 Fri, 27 Mar 2020 15:20:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A03F177E5;
 Fri, 27 Mar 2020 15:20:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/6] nvme: Print 'cqid' for nvme_del_cq
Date: Fri, 27 Mar 2020 16:19:47 +0100
Message-Id: <20200327151950.11820-4-kwolf@redhat.com>
In-Reply-To: <20200327151950.11820-1-kwolf@redhat.com>
References: <20200327151950.11820-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Minwoo Im <minwoo.im.dev@gmail.com>

The given argument for this trace should be cqid, not sqid.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Message-Id: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index f78939fa9d..bf6d11b58b 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -37,7 +37,7 @@ nvme_rw(const char *verb, uint32_t blk_count, uint64_t by=
te_count, uint64_t lba)
 nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize=
, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D%"P=
RIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
 nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t siz=
e, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx64", =
cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16"=
, ien=3D%d"
 nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
-nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
+nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=3D%"PRIu16""
 nvme_identify_ctrl(void) "identify controller"
 nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
 nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRIu1=
6""
--=20
2.20.1


