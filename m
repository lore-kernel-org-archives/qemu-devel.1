Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC3FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8059320674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrRSp9Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8059320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgP66-00032p-Mg
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgP5L-0002I6-21
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:49:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jgP5K-0007yg-7U
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591174157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UkMfkR5L3zKXDOI8Ih7KsopInsPVYAk64g1qymY/kw=;
 b=TrRSp9Zs94kM9ZN1SxRKw/prrbUTAXX1HgURSpS86xSEf8C3GXUeUMpwVZ0j8o+s9kPPSE
 aQN1DZLYbbR8l1cW+NZMVSsNl15B3mDagTAT+aql3GtTvLPQmV/DF6Ts3LBnTKi23J5uvm
 4meT0nj9mpyU72pxanKJwzPqFN1spuM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-k7g2V98RMZuwqrG3yFhHMw-1; Wed, 03 Jun 2020 04:49:15 -0400
X-MC-Unique: k7g2V98RMZuwqrG3yFhHMw-1
Received: by mail-pg1-f198.google.com with SMTP id 22so1749378pgf.13
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 01:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7UkMfkR5L3zKXDOI8Ih7KsopInsPVYAk64g1qymY/kw=;
 b=R9CCqPpDkfAcWR7Z3cfv7oAzS6srfYemRDrm+952hYNTywPO+qQLEnNEc1M1Gdi6R4
 Z132jLUHbsvoo156zS7+WCJHFEY8nXhIoiO7/FNJ4FUrmMZP7dWOigIiID0gT+gS59tK
 IX4O6dhvE8AEdaTCCTx7mMwwG9fz0kPBdKDgFpiEVCNWad8LlLNvgtAMJYnf5Q87cKZ0
 o+98mPLsAhs/mmogJ5Fc9K1lHHMg8kHTPVe4WN6nMDXEBN3wh6AmvxyyNaH30EB6nSsY
 UuWVljVT3YrMOmnazBx0V35C+Ern+xvXhfIAp/+X83iwwS/axV/0E9K2Ab/So6XxSOFd
 4oog==
X-Gm-Message-State: AOAM533kNqnau9qQ8N7a6ANdegeeW90oQtWWdk9JKwjX14xKuTi/bedi
 iDx5C2IJCzQKGLEUqFryoofpIeBSENg9B1ftRzrX78Me7ejE2E3JYrEF/zVdx0GMvBFid8ZRD/0
 xTtZiNxE2XUgHwGA4zDJDkWlgSP3GLRQ=
X-Received: by 2002:a62:3545:: with SMTP id c66mr8531434pfa.223.1591174154028; 
 Wed, 03 Jun 2020 01:49:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbWSm1sDsoM6HybQoOqKy/EsLsr7vn/TIwxM317ZIwtbbU1AleuP5rEuBMcPH5o0W+NHgXRiJwDCJC/Axu42g=
X-Received: by 2002:a62:3545:: with SMTP id c66mr8531398pfa.223.1591174153795; 
 Wed, 03 Jun 2020 01:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-9-lulu@redhat.com>
 <4ae425c2-6b5f-5f64-9e26-f20b8f52f996@redhat.com>
 <CACLfguUeYjAaknk+GEM9K6myUdCqXtxn=OEGYO4h3pqOUm9NxA@mail.gmail.com>
 <6ac66cf2-30d3-d87c-9ca5-0785f05984ad@redhat.com>
In-Reply-To: <6ac66cf2-30d3-d87c-9ca5-0785f05984ad@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 3 Jun 2020 16:49:03 +0800
Message-ID: <CACLfguUpFOW4CgMu=B6jOs6-eO56+JtPE-Xd+jGmNW2+Kh_ibw@mail.gmail.com>
Subject: Re: [RFC v3 8/8] vhost-vdpa: introduce vhost-vdpa net client
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,


On Wed, Jun 3, 2020 at 4:43 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/3 =E4=B8=8B=E5=8D=884:19, Cindy Lu wrote:
> >>> +static void vhost_vdpa_cleanup(NetClientState *nc)
> >>> +{
> >>> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> >>> +
> >>> +    if (s->vhost_net) {
> >>> +        vhost_net_cleanup(s->vhost_net);
> >>> +        g_free(s->vhost_net);
> >>> +        s->vhost_net =3D NULL;
> >>> +    }
> >>> +
> >>> +    qemu_purge_queued_packets(nc);
> >> Why this is needed?
> >>
> >> Thanks
> >>
> > This is to clean the packet in the queue while the vdpa remove,  I
> > will double check this part
>
>
> Note we don't have a software backup driver for qemu currently (we
> probably need one in the future).
>
> So we can't fallback into userspace which means the packet can not be
> queued by qemu.
>
Got it, Thanks Jason, I will remove this part

> Thanks
>


