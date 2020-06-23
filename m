Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF72C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D58020738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNor2j/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D58020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf4l-0001Nb-Tm
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf3s-0008Ci-2N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:17:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf3q-0000Wy-En
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOSO/gYF80FcLOgiHhshw9QgwgKemXBNF5rJppO3im4=;
 b=fNor2j/l1x/z1gtHQApNIbI5a4vDgByTmea9Hq35HBcgbp2sUC/UUpqyNGJmaMruATU+ki
 +9R91HB2L/T1xJMtQ8t3MDv8hEqK/0TxCDPUQQ03W4S0pFO5plMmBwPY3mpWO4MHS8WmNO
 kmg3Eb1tNOi8tX9sACz4EVjYWczblbU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-Ru7FsULBM6-1lCmSuUfYPA-1; Tue, 23 Jun 2020 05:17:42 -0400
X-MC-Unique: Ru7FsULBM6-1lCmSuUfYPA-1
Received: by mail-pg1-f197.google.com with SMTP id y12so12317195pgi.20
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QOSO/gYF80FcLOgiHhshw9QgwgKemXBNF5rJppO3im4=;
 b=BK2P5WLJxzvKcafj6/0lsP3eYC2mCktGw1Lo+jlRaRAWF/SR8b4xYT9MNVwgTeouJo
 9LtR1bEFMX951rOBEmRwfAaz+TKR/+VanXzhJhpxl7+V0q/h97zXVDCGv7wcW/ohBsDD
 Q/bd4FHnbW7yUs3yAqfpAhXm2mveDQKqfovEHnHjp3kMjrEB58K0vNFG7mWNSPXIkN9p
 mvBb76vQ0zy7lEnzMI2AvyReV3rMHu5k+rtjpkyFEw3N8ovgrf+aRFH7hVtWR2E+kxIt
 5RqPD5G9N7MQEJ4NL4y+G2R3IUJCyhP2x9u6V6dEutV+Yy69xvF5HAvqpJrVssJWPCvv
 ivmw==
X-Gm-Message-State: AOAM532Mlb8Z59WE8li1o/NIYSx8VboPgUi/vto1GIZ/3Li90pflNzGE
 5dRVQwYJOL2deRdXTYKOzpzW1C/MAyzGmM0T+3uoSsmKOGWmRGp1KFlcb30D7jOqiCzl7C81jH6
 dZhdxyld2O+jwPg8HYvtHTzG18XXSLxM=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr21170654pjt.166.1592903861581; 
 Tue, 23 Jun 2020 02:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO6S0ODqasuVK6CfuxJOnm3BBA8IGHkYDW46ZfGRttTRzSQdDd9SKMSoJo0hqRq9l4X0nqNlqwRDF4jW1UaJw=
X-Received: by 2002:a17:90a:c283:: with SMTP id
 f3mr21170612pjt.166.1592903861311; 
 Tue, 23 Jun 2020 02:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-2-lulu@redhat.com>
 <eae4f76b-99d5-d51e-e214-93078948040c@redhat.com>
In-Reply-To: <eae4f76b-99d5-d51e-e214-93078948040c@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:17:30 +0800
Message-ID: <CACLfguUi1oJ52AOC-Ppi0WgwjE-egow5tgcmOky21xgBDN_6rA@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] net: introduce qemu_get_peer
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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

On Tue, Jun 23, 2020 at 3:10 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
> > This is a small function that can get the peer
> > from given NetClientState and queue_index
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   include/net/net.h | 1 +
> >   net/net.c         | 6 ++++++
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 39085d9444..e7ef42d62b 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -176,6 +176,7 @@ void hmp_info_network(Monitor *mon, const QDict *qd=
ict);
> >   void net_socket_rs_init(SocketReadState *rs,
> >                           SocketReadStateFinalize *finalize,
> >                           bool vnet_hdr);
> > +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
> >
> >   /* NIC info */
> >
> > diff --git a/net/net.c b/net/net.c
> > index 38778e831d..599fb61028 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)
> >
> >       return nic->opaque;
> >   }
>
>
> newline please.
>
> Thanks
>
will add  this
>
> > +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
> > +{
> > +    assert(nc !=3D NULL);
> > +    NetClientState *ncs =3D nc + queue_index;
> > +    return ncs->peer;
> > +}
> >
> >   static void qemu_cleanup_net_client(NetClientState *nc)
> >   {
>


