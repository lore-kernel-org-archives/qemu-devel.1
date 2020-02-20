Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D599C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096C7206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ev0u4fSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096C7206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lfB-0003cW-5h
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXT-0005p9-C8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXS-0005Tb-A2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXS-0005TM-5v
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVwVVeCugJs7pFiHvYs+kcICDXTPSCqBYYCEtvte3CI=;
 b=ev0u4fSYVUKmNRoJ8NvKdcw3O0r671WtNM6ZzRv8/729K0rp+x5Zc8/mXn9rE1GYA5eXnx
 JmKk1yS83SKVg5wi8QXsSc40PkpeNs66FQI0oPbhLhC714omVqAeI1kAQra/wYqrEroZHo
 S1frQDdgXnoZyidDSMJtsxwzKV5dgbQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-2gMKBlwcPoSX8GiqKNPZUQ-1; Thu, 20 Feb 2020 08:06:44 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so1725714wrw.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UKC5US0FVl1pIv+lPWy76t1kr1KKdCp1Se8AoBMs7qQ=;
 b=i1RaU8MMHUDGuzn6U7bSvnCnhiXR9ZY4zBeZM0rmUTD3lVaHZAGxoXQoIE2x9FmLlH
 Tbj9ve3tglXcKIjjlQ6uzNhs0xWs9ySR8kBCUGWRfSbS9H73RuWaYz8Kb3A8MqeyBUFp
 ZYWp9whpiBfCfpSzmSnT98NQ2J/Yv4lNypPeTx/D9VQyo13gG9sbFYm/QTzX6QeQqQbE
 n/JyXCegf9dO2zv+1uP9vDKPbZ8rY+1tuR/Kq+LvadiM55cW5FKHc12Geq0rhz5H0nIi
 XbJY/bk6AilLxVKta+eYWejsFM5EO2uU+We0ManasTb7UXy6Vp04c3gc5tyUDQEm49Nt
 xWqA==
X-Gm-Message-State: APjAAAXTQMmwHmvTAGbV0O/eBnUhER8BnAgp4bEmViY43ZKKldHKa/qn
 OkId4jpZggyqwETEfbHE8dQEtdNIZW6pjkGQmrgalpt0MRuOnoRtS7+cwTc5TlLffhJFr+iQDkp
 asU6kna18Jpi+/VU=
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr43731109wrs.423.1582204002760; 
 Thu, 20 Feb 2020 05:06:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqHc8xSBLutdUhIzf/cdvh5+i6wOt8LjaLS6C9c63Yasey84Mhi4F8A6DvfBLGaafXEkCiSQ==
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr43731080wrs.423.1582204002528; 
 Thu, 20 Feb 2020 05:06:42 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 13/20] hw/virtio: Let virtqueue_map_iovec() use a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:41 +0100
Message-Id: <20200220130548.29974-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 2gMKBlwcPoSX8GiqKNPZUQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/virtio/virtio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2c5410e981..9d06dbe3ef 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1293,7 +1293,7 @@ static void virtqueue_undo_map_desc(unsigned int out_=
num, unsigned int in_num,
=20
 static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
                                 hwaddr *addr, unsigned int num_sg,
-                                int is_write)
+                                bool is_write)
 {
     unsigned int i;
     hwaddr len;
@@ -1317,8 +1317,9 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, s=
truct iovec *sg,
=20
 void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
 {
-    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, 1)=
;
-    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num,=
 0);
+    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, tr=
ue);
+    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num,
+                                                                        fa=
lse);
 }
=20
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned=
 in_num)
--=20
2.21.1


