Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0311FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C147820724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4U1wnpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C147820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf9Z-0006D6-2G
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf8k-0005n7-Bw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:22:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf8h-0003J7-Ur
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592904167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgRLP0OMi7QecPv5hWhx5khk2YacWc528rUnADbo08w=;
 b=a4U1wnpxX04EQR84bmANb9Zz9f8EO4Kk1/NGTL79D3Ri+DYfNs/xuOva8zNerYxM6Ev2An
 nkxw1QrVRu7VkQipPFV1jTUW8EJv0VOdH+nYo2EgGRvP5vt85ccbGU6y7I0W82xeX70nSt
 15sEVWGLkByd6Sg41eIS43SVaiHQVsM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-6kZvsm_vNA-5Hf85NThj8Q-1; Tue, 23 Jun 2020 05:22:43 -0400
X-MC-Unique: 6kZvsm_vNA-5Hf85NThj8Q-1
Received: by mail-pj1-f72.google.com with SMTP id j19so1307994pjn.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AgRLP0OMi7QecPv5hWhx5khk2YacWc528rUnADbo08w=;
 b=RkUqSMnRoOebrd+//nRtqW5XHuJ3GCFXf942raeEHXZ+yiomPrYxlfZHXXEDwoRY3A
 pY/9QLShiCJOFmmOAjU/j7qkuM0rNHuFwdgBj35GpS1kaZO34SzTo/qKHw7m+PnnodcC
 3hI79cLTJUn6EqiCILwMjoRVw9o4DTZnsJYdKd26TbcKQJK3xxlg3b+gO35OizZFtynN
 KnUuoQPI2sV4AkgTdVPVJGP4XZehi0/I1R6hUdGT/IRNfLYr5RGlUFr0D5i9oQfwZ6di
 nM4VucISoJJx/NyhGkTaMQ+AwKx4z4E1uve/Sj5+wJSjzlR3se596o2zQtzz2DLXWaZV
 lLgQ==
X-Gm-Message-State: AOAM531m8vsFhhjyG2Gg63O0eBf8NJN4nAdQxtu0oYU80MxJsS4of84N
 Wl9/maN01kYkjWExgwBI6ANTfYDDHiQS/Wb3OkYVi5VtmLkGH4tSObj3lNlThG1pQRozKeIUqEl
 7ugUqGhAP740Wyh1t3nx5nNp6jptaj/k=
X-Received: by 2002:a17:90a:250b:: with SMTP id
 j11mr23493337pje.194.1592904162520; 
 Tue, 23 Jun 2020 02:22:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcAWo30vq4BrBZvk4SRFFWRaKdKI61ti0gi+2URDWYJxVNqLOCX8EfJxI1+rKSaSRvDceKOPQya2WIrZe0gkg=
X-Received: by 2002:a17:90a:250b:: with SMTP id
 j11mr23493286pje.194.1592904162263; 
 Tue, 23 Jun 2020 02:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-7-lulu@redhat.com>
 <ed300b1f-6448-0051-1a00-983c4c474d61@redhat.com>
In-Reply-To: <ed300b1f-6448-0051-1a00-983c4c474d61@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:22:31 +0800
Message-ID: <CACLfguVwMcSnD4-ztn5TjMUq71dZwu=hpZajFB1Gn3ibFdch8Q@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] vhsot_net: introduce set_config & get_config
 function
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

On Tue, Jun 23, 2020 at 3:18 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
> > This patch introduces set_config & get_config  method which allows
>
>
> One space is sufficient between get_config and method.
>
>
> > vhost_net set/get the config to backend
>
>
> Typo in the subject.
>
>
thanks jason, I will correct this
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/net/vhost_net.c      | 11 +++++++++++
> >   include/net/vhost_net.h |  5 +++++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 4096d64aaf..04cc3db264 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
>
> Is there any reason that making this net specific? I guess it could be
> used by other vhost devices as well.
>
> Thanks
>
Thanks jason I will correct this
>
> > @@ -111,6 +111,17 @@ uint64_t vhost_net_get_features(struct vhost_net *=
net, uint64_t features)
> >               features);
> >   }
> >
> > +int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
> > +                         uint32_t config_len)
> > +{
> > +    return vhost_dev_get_config(&net->dev, config, config_len);
> > +}
> > +int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
> > +                         uint32_t offset, uint32_t size, uint32_t flag=
s)
> > +{
> > +    return vhost_dev_set_config(&net->dev, data, offset, size, flags);
> > +}
> > +
> >   void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
> >   {
> >       net->dev.acked_features =3D net->dev.backend_features;
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 77e47398c4..abfb0e8e68 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -27,6 +27,11 @@ void vhost_net_cleanup(VHostNetState *net);
> >
> >   uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features=
);
> >   void vhost_net_ack_features(VHostNetState *net, uint64_t features);
> > +int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
> > +                         uint32_t config_len);
> > +
> > +int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
> > +                         uint32_t offset, uint32_t size, uint32_t flag=
s);
> >
> >   bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
> >   void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
>


