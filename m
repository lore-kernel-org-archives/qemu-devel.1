Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA2BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA87F206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eimv+yZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA87F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic0rS-0001FU-Ok
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 00:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ic0pX-0000KJ-Cy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ic0pU-0005sE-Vg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:34:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ic0pU-0005rI-8Q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575351269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wr76N0Bf905JGOQsD3W8jt7t4g9ePDfJJdeQOvWHD2M=;
 b=Eimv+yZuN9IpQf2R1LUS2BmfmbYfSa18FEYVs+lzLcmNfYsjSL4XotZQjMUlNXQJ73stMB
 7ukkxbKd6wmPWjfnd37AsXOfOy7GkzO1OxLl+Gc/Gw7Qh9dHO42eAQ9GTjJF7hXKLhuy2t
 gxco5glsf6iRzADtBOboqJ1517CWyh4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-37ryJyyHNq-3SleZLDtZQQ-1; Tue, 03 Dec 2019 00:34:22 -0500
Received: by mail-qt1-f198.google.com with SMTP id e2so1645051qtq.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 21:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vtq9fxufgMUgseKR7zGjZ5TKB058jYwm+E/vY/XNdeI=;
 b=nyMbEQloK3BPYyWpdG+rAxLK2DOIQW7d4zJbrIfzpZMuLbSpQnbih69S1pzYox8Be0
 SmTT72V2Cs9qJ0vm+iTlTnFsiY6KJHlAzo3kJBdvDdTP4a4W1OdpxzqTKnSK4dCxG+ud
 lUAL+q+Mx7ZFXhF7Ahb2Uzp6Zg0Xm9AM6VCydB+QUocjtveVmjVkZfV5lDUT9phJYb0J
 Q/4GDTpWFGvhR2REcokurHqk6GfdQ7tnyp+JaWUdZwN7inVoqxEyu1RvigcZ/+SnPvZR
 n5bxTy2i55cDaeUXJ8aKZyyQe+WtXmmHptu6rCVUDEioT6FMwTOluWAJR/oKZJ8uL4pc
 421A==
X-Gm-Message-State: APjAAAXq/CRWQwCKwweRhq74IaRSJSwQF8BFc+xCEDmLZWIKOIqpUXbc
 CcbuHWfviSor9jPbuT8xrPM1bk5/17tLJ0ij9Gev9WxPWG+WeoURoO9c6FHta4INbp/9YNyn8aF
 dQouw57r0l5FURXQ=
X-Received: by 2002:a37:4288:: with SMTP id p130mr3363773qka.116.1575351262144; 
 Mon, 02 Dec 2019 21:34:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZJr2bTkUixaarOd1mLeJy/e5qT9YD+UBQiQSwl3fgyOsqSuofAntCE5z7BhXjLXzt7W5xcg==
X-Received: by 2002:a37:4288:: with SMTP id p130mr3363758qka.116.1575351261861; 
 Mon, 02 Dec 2019 21:34:21 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id d13sm1140545qkk.136.2019.12.02.21.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 21:34:20 -0800 (PST)
Date: Tue, 3 Dec 2019 00:34:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH] virtio-balloon: fix memory leak while attach
 virtio-balloon device
Message-ID: <20191203003223-mutt-send-email-mst@kernel.org>
References: <1575337459-34864-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1575337459-34864-1-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: 37ryJyyHNq-3SleZLDtZQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 09:44:19AM +0800, pannengyuan@huawei.com wrote:
> From: PanNengyuan <pannengyuan@huawei.com>
>=20
> ivq/dvq/svq/free_page_vq is forgot to cleanup in
> virtio_balloon_device_unrealize, the memory leak stack is as follow:
>=20
> Direct leak of 14336 byte(s) in 2 object(s) allocated from:
>     #0 0x7f99fd9d8560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>     #1 0x7f99fcb20015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
>     #2 0x557d90638437 in virtio_add_queue /mnt/sdb/qemu-4.2.0-rc0/hw/virt=
io/virtio.c:2327
>     #3 0x557d9064401d in virtio_balloon_device_realize /mnt/sdb/qemu-4.2.=
0-rc0/hw/virtio/virtio-balloon.c:793
>     #4 0x557d906356f7 in virtio_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw=
/virtio/virtio.c:3504
>     #5 0x557d9073f081 in device_set_realized /mnt/sdb/qemu-4.2.0-rc0/hw/c=
ore/qdev.c:876
>     #6 0x557d908b1f4d in property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/ob=
ject.c:2080
>     #7 0x557d908b655e in object_property_set_qobject /mnt/sdb/qemu-4.2.0-=
rc0/qom/qom-qobject.c:26
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> ---
>  hw/virtio/virtio-balloon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 40b04f5..5329c65 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -831,6 +831,13 @@ static void virtio_balloon_device_unrealize(DeviceSt=
ate *dev, Error **errp)
>      }
>      balloon_stats_destroy_timer(s);
>      qemu_remove_balloon_handler(s);
> +
> +    virtio_del_queue(vdev, 0);
> +    virtio_del_queue(vdev, 1);
> +    virtio_del_queue(vdev, 2);
> +    if (s->free_page_vq) {
> +        virtio_del_queue(vdev, 3);
> +    }
>      virtio_cleanup(vdev);
>  }

Hmm ok, but how about just doing it through a vq pointer then?
Seems cleaner. E.g. use patch below and add your on top
using the new virtio_delete_queue?

-->
virtio: add ability to delete vq through a pointer

Devices tend to maintain vq pointers, allow deleting them like this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c32a815303..e18756d50d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int que=
ue_size,
=20
 void virtio_del_queue(VirtIODevice *vdev, int n);
=20
+void virtio_delete_queue(VirtQueue *vq);
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..31dd140990 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2330,17 +2330,22 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int=
 queue_size,
     return &vdev->vq[i];
 }
=20
+void virtio_delete_queue(VirtQueue *vq)
+{
+    vq->vring.num =3D 0;
+    vq->vring.num_default =3D 0;
+    vq->handle_output =3D NULL;
+    vq->handle_aio_output =3D NULL;
+    g_free(vq->used_elems);
+}
+
 void virtio_del_queue(VirtIODevice *vdev, int n)
 {
     if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
         abort();
     }
=20
-    vdev->vq[n].vring.num =3D 0;
-    vdev->vq[n].vring.num_default =3D 0;
-    vdev->vq[n].handle_output =3D NULL;
-    vdev->vq[n].handle_aio_output =3D NULL;
-    g_free(vdev->vq[n].used_elems);
+    virtio_delete_queue(&vdev->vq[n]);
 }
=20
 static void virtio_set_isr(VirtIODevice *vdev, int value)


