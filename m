Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBD020679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieWiybwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBD020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfRZ-0001q5-RY
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnfP0-0005rG-IV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:39:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnfOy-0004YJ-H5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592905175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvvPzg6JOLK4jvZRsI3+S3vvFU8oy8UebvziEn0D3kA=;
 b=ieWiybwdz0+YZrPNjNrGnCSQJHZiRAViNVxmWXh07vWabmsgZF7XH/iBuRzFRuXGjTXIhi
 jAyuUXwa6z7dKXr2VtB+bdhrwk4j+3eESuUxYSM5lGVSoKGfbcngylDyR6qZAElMV46uqQ
 V6NPnp98eI0pE6PMvy7nvik8hQJXBSo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Q0qLJdRwPFmpg3hZ-Ydj1w-1; Tue, 23 Jun 2020 05:39:33 -0400
X-MC-Unique: Q0qLJdRwPFmpg3hZ-Ydj1w-1
Received: by mail-pf1-f197.google.com with SMTP id p1so6543997pff.17
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UvvPzg6JOLK4jvZRsI3+S3vvFU8oy8UebvziEn0D3kA=;
 b=Pwzvba3cgYnRZDweFex0PaEuCv4/43i2Uez1A7ylscZy85/xZK05DWoI2VRmKGLBkK
 wpaA0aaY45AD2HmIs9rzHo8B+ln02e9Ts9vfvOJPHriO8VyWeNhmfnqNWx/jfu+r6ZK4
 U5cm8wm0NAbJCdnq87+W8H3OPjQRUodtvY4wxbVHsXvjGjL21c+QWtijB6y1H6rAwCM+
 tdTr+lBK04xlMd8HuyOYRvilliB8YEPGk69BWnIhhk9ghsCwqruTbnVLl5EC/WMZEMfC
 uRk/77O8++WewBdnlpDq+La412furyXMOJZUJr9rYY/N3vKt9c5Gq32Nh2QUtdWk3pjQ
 p15A==
X-Gm-Message-State: AOAM531sKZhpXcS9tavUGxGAZM2HfI+PsYEp8NBHvxekv8M2OxwBkmhB
 dmj9ZLYOXHA8HYyOMMFcGDAht9MsuwhQD2X3SuYpyMiwK2qZNLIE/4fkzQosds0VFvn3QcY0fS5
 kbBQ9wsAzQSzLQJ2Vcdku0/7I1jqOmJU=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr21241184pjt.166.1592905172589; 
 Tue, 23 Jun 2020 02:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF9uVRIPXi9UnQNmOR1S+z0OKau3ftRj4vQ4O3dcw55wlXep6jFXTioAwr51y7UZSY2jadZnS7sD4AgrA6ZMU=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr21241170pjt.166.1592905172383; 
 Tue, 23 Jun 2020 02:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-9-lulu@redhat.com>
 <3fab12a1-1c44-b18d-cfb8-f069190e0b2c@redhat.com>
 <CACLfguWkntyF0Syrcy=90X8jweCJFASgz7=tN4yS1CpZ+Bo7=g@mail.gmail.com>
 <cb056761-1a02-c8d3-962c-b5ed1b5a525e@redhat.com>
In-Reply-To: <cb056761-1a02-c8d3-962c-b5ed1b5a525e@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:39:21 +0800
Message-ID: <CACLfguXOA_nLH9z1z7dd6d_w+LEUYHnTYtOUXxqnTDNcRaYv0g@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] vhost: implement vhost_dev_start method
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 5:38 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/23 =E4=B8=8B=E5=8D=885:34, Cindy Lu wrote:
> > On Tue, Jun 23, 2020 at 3:21 PM Jason Wang<jasowang@redhat.com>  wrote:
> >> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
> >>> use the vhost_dev_start callback to send the status to backend
> >> I suggest to squash this into previous patch.
> >>
> > Sure will do
> >>> Signed-off-by: Cindy Lu<lulu@redhat.com>
> >>> ---
> >>>    hw/virtio/vhost.c         | 17 +++++++++++++++++
> >>>    include/hw/virtio/vhost.h |  2 ++
> >>>    2 files changed, 19 insertions(+)
> >>>
> >>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>> index 01ebe12f28..bfd7f9ce1f 100644
> >>> --- a/hw/virtio/vhost.c
> >>> +++ b/hw/virtio/vhost.c
> >>> @@ -744,6 +744,7 @@ static void vhost_iommu_region_del(MemoryListener=
 *listener,
> >>>        }
> >>>    }
> >>>
> >>> +
> >>>    static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> >>>                                        struct vhost_virtqueue *vq,
> >>>                                        unsigned idx, bool enable_log)
> >>> @@ -1661,6 +1662,11 @@ int vhost_dev_start(struct vhost_dev *hdev, Vi=
rtIODevice *vdev)
> >>>            }
> >>>        }
> >>>
> >>> +    r =3D vhost_set_start(hdev, true);
> >> I think we need a better name for this function.
> >>
> > Shall we change it to vhost_set_device_start ? Since the
> > vhost_dev_start was occupied by other function
>
>
> Or maybe just open code the vhost_set_start here since there's no other
> users.
>
> Thanks
>
Sure will do
>


