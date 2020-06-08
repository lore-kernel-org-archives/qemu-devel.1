Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE575C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD1120659
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGWjpmi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD1120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJ4i-00047g-Of
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jiJ31-0003Ev-AN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:46:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jiJ2y-0000nm-P1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591627602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afNG6Py78hUQ8GKmSIwrrkewvVD4TLJ2ULLXynJ56as=;
 b=YGWjpmi2Rvh3UpS2+SXxzseQgsydHyLDTkGly9ERf/VRd79Kp4fTYXQeUdxW92BTQLaN2l
 GKqZ9JpW9J0GSxKkD5YyZvYvn82t3ipyuorDVmxitXHot8oCqB8jWdBDD8HqFk0YAk0Iqu
 TLru8fbxgrbTF0FjDkD81x+pU0dlAtY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-c0zXD0N7PBOng5VPSnyKgQ-1; Mon, 08 Jun 2020 10:46:39 -0400
X-MC-Unique: c0zXD0N7PBOng5VPSnyKgQ-1
Received: by mail-pj1-f70.google.com with SMTP id nh9so11357094pjb.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=afNG6Py78hUQ8GKmSIwrrkewvVD4TLJ2ULLXynJ56as=;
 b=QHEmooEMQ4W+2Ns7Dhs1gJmKihpry/K11FNGsh7QCnTKQ/8rPsw5KJ6YctyR8M7xVZ
 Rsix8+hhu4QHnIUYGGVH9NNMuOrQkhioLuHwwVndXcIGu7jkEER585RR5xLbjmqeNZWP
 xhbFdjTNxT2U+OAuFbDis2UL3JvUPJvLoZ5+T2ofLaczEcL+6Dc0e/kW0yl36+mUeJuX
 va0DgOIVwLpmBY58Ae017arC62PoMAvyfJuEPf0awYCqlEdK3abnjG3xSHcX2cN3g6Ut
 GxGUrIY/GlULoSknZPHPkjXU5y85iI+Jm+mHm4/rwud4eERWQnH4eCsxwSaKNxPs3M67
 pHpQ==
X-Gm-Message-State: AOAM531LZZ8uL0g0zb75t3775fWZe6g9BpObJRNBFubH6F+XgzQTkYGg
 veDpWzpt4XjVOf6OJbtgc2H+vFeeouEe/aLtGkQlI5NlY0jJgdKUpw9TQ229chrb7j7MOJlEHje
 jsyhRovn9b8HosrU5n/3Ans+DhKnEYIU=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr16349756pjt.166.1591627598045; 
 Mon, 08 Jun 2020 07:46:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIw0yEpa2reYt4T47adAzKKEiKo3mNZ133OIq8eyIDTWDiqASnxxwLFiVEzmPLeQonTDejkOz6M8ArYC8Dy48=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr16349720pjt.166.1591627597765; 
 Mon, 08 Jun 2020 07:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <CAJaqyWcTDDzgV_sHza80ZoRe8a=59zvszvmgLSFhxPht=_N82g@mail.gmail.com>
 <20200604073144-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200604073144-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Jun 2020 22:46:26 +0800
Message-ID: <CACLfguUj0W-NsDs4HeB0OZgJkDF+JWcvcybUZNAGNZ0p2B=10w@mail.gmail.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, hanand@xilinx.com, Rob Miller <rob.miller@broadcom.com>,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 4, 2020 at 7:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 04, 2020 at 12:39:34PM +0200, Eugenio Perez Martin wrote:
> > > +static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_=
t *data,
> > > +                                   uint32_t offset, uint32_t size,
> > > +                                   uint32_t flags)
> > > +{
> > > +    struct vhost_vdpa_config config;
> > > +    int ret;
> > > +    if ((size > VHOST_VDPA_MAX_CONFIG_SIZE) || (data =3D=3D NULL)) {
> >
> > VHOST_VDPA_MAX_CONFIG_SIZE is currently undefined.
> >
> > If we want to maintain this as a stack allocation (as proposed in
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg701744.html) I
> > think that the best option is to decide which is the maximum value buf
> > can hold, and set it in vhost_vdpa_config.buf declaration.
>
> That depends on device features. qemu has logic to figure out
> config size based on that and set config_size accordingly.
> Why not reuse it? Sending more should be ok and extra
> data just ignored.
>
> --
> MST
>
Thanks Michael and Eugenio for your suggestion=EF=BC=8CI=E2=80=98m rewritin=
g this part


