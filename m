Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE51C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAEA208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZB9pA+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAEA208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios7Q-0000AA-4g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorll-0000Dw-D1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlk-0005pz-3j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22511
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlk-0005ph-0V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9q2/1/1fqOdhU65sqIDbx6cBRpFU6//iIePNlnfAizE=;
 b=FZB9pA+L9vx+j3z7oqQz/23ayP6p9QrMcGpR7QfzoP1hof+TfnIj3XFwey5rEc0+p/fPhz
 1MQCddgrY8OX+svNYKXRKGIZ25pc4oSA+UfOU4Fdq/Z9j2BzuiWWFTg8whwjY9J6K0g/Vh
 p0kYTNHptvh5axDfg7SU6OkthJwdVw4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-eNt4qTNUPkuT-noPvjDTKQ-1; Tue, 07 Jan 2020 11:31:46 -0500
Received: by mail-qk1-f198.google.com with SMTP id c202so153499qkg.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6oUZcRx6oHUh2LroAUnKmJ6d2Eg7LapR5X4J56q3mek=;
 b=tRAu0e4J2ylB4C9n4cn9fSuJ40Wsx+yGUYsdDBbGCXf2LnkotB2Q2oUD0ILw3YEl9+
 fmFk2TSpH4ihQ2UGT4pkET/e1NdRG4jcKARmEYpxOrhD6HjvNfZnLQ0rr6J2z/qOzDdY
 Pyr3AuFXsnlMBIm2HtLJKZXR/mBZuzOIf2J6m4iRE6F7YuvIm6utoX/9muLMwQMtop+0
 XkZfQ/Y3exQYsU0ICs9m+TR8uqTBkrQjUsYlubsR0S4pL/Tds9YmdMNq8ETtcDtddHY/
 w8wFw7/zsRBZ5aMXB1CnslTWytFgQ+TPjuh1yaNm1Lc1GTdVKvkwL+sV+L7OK1FqX0Td
 79kw==
X-Gm-Message-State: APjAAAW2BeGOlVKLT9Bfta4K5yaKoy3Fp0VxOmK4ZxMYE+K9m4q+HNna
 d3ib87cw+Qi1Qfw4GZsgPbZgHSKdnxQsuvBAni4mfJ87wOfVyvw7Kb7VfE3jhV6bbVmVnBnRvf+
 45eE26/qI1ncMt18=
X-Received: by 2002:ad4:5429:: with SMTP id g9mr238612qvt.134.1578414705311;
 Tue, 07 Jan 2020 08:31:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqycIedPO/XbkLmXwdC3GRhqeryefbBc9k2Iip/xyAIWnnLN0jr2EGsuUgI/jvtGLrP72306Og==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr238590qvt.134.1578414705090;
 Tue, 07 Jan 2020 08:31:45 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id s20sm18909qkg.131.2020.01.07.08.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:44 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 29/32] virtio: reset region cache when on queue deletion
Message-ID: <20200107162850.411448-30-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: eNt4qTNUPkuT-noPvjDTKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
Fix leak of region reference that prevents complete
device deletion on hot unplug.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20191226043649.14481-2-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 95d8ff8508..7b861e0ca0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2344,6 +2344,7 @@ void virtio_delete_queue(VirtQueue *vq)
     vq->handle_aio_output =3D NULL;
     g_free(vq->used_elems);
     vq->used_elems =3D NULL;
+    virtio_virtqueue_reset_region_cache(vq);
 }
=20
 void virtio_del_queue(VirtIODevice *vdev, int n)
--=20
MST


