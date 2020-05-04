Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E68E20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxnpYM5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E68E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXkn-0002bw-Db
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgv-0005I0-1V
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgu-0004I0-6B
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BjE+qPatMIH8JRaVlHLK+nrshlFKwJmEw5HEwgChSI=;
 b=TxnpYM5h8PkaBF6Q2aNL1bRfwsLRi/gKOakM16p/49ivchG4mKxR8/Je/Fx0o5pzsFQEtp
 298nEHaz8piTWZbHoq8Wa4tm/wVSXkCLuL/LTeR8Qq62MLhnX+UQMDzUsaRqULPleYNK4h
 lOlpisbotH68NCPDHrjlE6oN6ZwEX4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-2qJW49hpNzahHZASnQJy5g-1; Mon, 04 May 2020 05:47:08 -0400
X-MC-Unique: 2qJW49hpNzahHZASnQJy5g-1
Received: by mail-wm1-f72.google.com with SMTP id j5so4579299wmi.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+xH2/obfEES+FKWIXC5ZKjL0sJeWRGwNhoW0/uWIJ1w=;
 b=gibpyiOJjOn7f+RobOPa0JWqu0R/3KTK6isaWL4M7xSZipaTbWEBhbMJoNeGdQ8vXp
 aJHf7KvM0xESGmI+MDJl7/LhOneNZrdEkEJkC4/3nh1KPZNqv0vYRc/PgymEd6DLh33F
 DerNsT+0DklQjVk4z6dolv0KtQLP57p8NnLkWNpeQfyGlFbjRpv5VWnuBO4UKjPmhgGg
 3PdIBJLExgybiREyGHMpftXJR2A/90gd9eIB74CkdhDTPMnO4t3UJ+Uu77UYf7THkgpO
 UU/9IlGxscSYfEmkek7imqetgHgZw0m4Y00BLIluGqeAcQDMQ5RKg2Hi9cxZq3LOOjrz
 y1zQ==
X-Gm-Message-State: AGi0Pua+qWzuO6Q8W7bmEf5moM7EFZeMDBw144//eKZ/bi/WcMUpSHhJ
 rSZz+fSdWCP4hfFIFR6cl/KRgUCQ18At1FTeSHBVYkaDVZYOYqf+JWi+lBV2MAZKH/5BakXQITO
 4L5ACtAw8js6uUhA=
X-Received: by 2002:a1c:e187:: with SMTP id
 y129mr14733609wmg.133.1588585627097; 
 Mon, 04 May 2020 02:47:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKduCzSN8JET1vXC5kL0rPakq69kLfHpWqFMvifkhX1yvkqSymuByrgkGqnBdcDs4YhcdavnQ==
X-Received: by 2002:a1c:e187:: with SMTP id
 y129mr14733587wmg.133.1588585626925; 
 Mon, 04 May 2020 02:47:06 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id r20sm12184725wmh.26.2020.05.04.02.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:47:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] block/nvme: Align block pages queue to host page size
Date: Mon,  4 May 2020 11:46:40 +0200
Message-Id: <20200504094641.4963-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504094641.4963-1-philmd@redhat.com>
References: <20200504094641.4963-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In nvme_create_queue_pair() we create a page list using
qemu_blockalign(), then map it with qemu_vfio_dma_map():

  q->prp_list_pages =3D qemu_blockalign0(bs, s->page_size * NVME_QUEUE_SIZE=
);
  r =3D qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
                        s->page_size * NVME_QUEUE_SIZE, ...);

With:

  s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));

The qemu_vfio_dma_map() documentation says "The caller need
to make sure the area is aligned to page size". While we use
multiple s->page_size as alignment, it might be not sufficient
on some hosts. Use the qemu_real_host_page_size value to be
sure the host alignment is respected.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: C=C3=A9dric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..bde0d28b39 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -627,7 +627,7 @@ static int nvme_init(BlockDriverState *bs, const char *=
device, int namespace,
=20
     s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
     s->doorbell_scale =3D (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t);
-    bs->bl.opt_mem_alignment =3D s->page_size;
+    bs->bl.opt_mem_alignment =3D MAX(qemu_real_host_page_size, s->page_siz=
e);
     timeout_ms =3D MIN(500 * ((cap >> 24) & 0xFF), 30000);
=20
     /* Reset device to get a clean state. */
--=20
2.21.3


