Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51454C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA6C2072C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjRfw+NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA6C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5sw-0006UE-8L
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5Vf-0003fh-ID
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Ve-0005Ej-BQ
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Ve-0005EO-8J
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9q2/1/1fqOdhU65sqIDbx6cBRpFU6//iIePNlnfAizE=;
 b=OjRfw+NMs41nSoMlEG/YbhP+Lz3YVrRiS7scHtqW79I5S5NjkiPQsk3HjX2dm78v/t4fgo
 CLL5sXA47C18ontdafgwQQDHyIL+EJEj8R+59O8+IHfcUTBH+jCls9Nol+bEAW8m04YHxR
 MGvbWlBs8R23qx9KulbI/88NNLKMsSk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-4qQwvfqVPNmJdX9zDKUzNA-1; Sun, 05 Jan 2020 07:59:54 -0500
Received: by mail-qk1-f197.google.com with SMTP id u10so27961759qkk.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6oUZcRx6oHUh2LroAUnKmJ6d2Eg7LapR5X4J56q3mek=;
 b=UaBF4CFjVwvEiH4/j3qFSr+ZqELKF//Dw22YkcUM5uhk77RqS5uikDKdmOs02KRd00
 FEsez2o8sD7+bF5c4n86H4z8QNNxJ4cXATq8ESpTr9+ziRsThLhz8KlxoYNo7XXaKYeY
 SuQtE2nQX5iHEMqJpNDJRvEWp6Npu7CDOjM0Fs+mKGmsxDFuW/BM8BP/bKMloOrSkKQY
 Sm9YbMCsdbZTa04yCjIivy7iFZO350ESHdwSM5ycGAmHBQ41bd3pzuhZP21OUw7K0dGH
 HVtT9ZluTrJ3xZciDmxO92OpPOzpI6egwliEuw/2vhp3gHpVqfQ0/S+5bN61mB2wBayq
 8glg==
X-Gm-Message-State: APjAAAVPofe0irk7LwMDbXY8pUroZ0gGifAsVNtEjG9WxoL3jaGGlZ+h
 uNA6CQlGctJAkEWlF5j9+FFw97Ln/OmHbSUEEYq7opsyBadZCp63D4KnmarHJ+coJv03fnCUimp
 y0UfrLHdTI+Mwrdw=
X-Received: by 2002:a05:620a:1265:: with SMTP id
 b5mr78724809qkl.172.1578229193528; 
 Sun, 05 Jan 2020 04:59:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkuvvhVbwLf/pPx09Q3HwkhYyNZksOS8UoPgk6pUpkdprImtvdLmq5f+sdetSvVYGWv1j4Eg==
X-Received: by 2002:a05:620a:1265:: with SMTP id
 b5mr78724803qkl.172.1578229193320; 
 Sun, 05 Jan 2020 04:59:53 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id u16sm19167732qku.19.2020.01.05.04.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:52 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 29/32] virtio: reset region cache when on queue deletion
Message-ID: <20200105125622.27231-30-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 4qQwvfqVPNmJdX9zDKUzNA-1
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


