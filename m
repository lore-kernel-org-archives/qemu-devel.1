Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19EBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0C820691
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTw8WvnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0C820691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjN1K-0004vf-UJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jjN0f-0004L9-IU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:12:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jjN0d-0005W7-Hm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591881160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4IbClzjIumNFWl19P7DhSPKK+AjqYdBfGupMhgPQA0=;
 b=jTw8WvnD4FyPrtL21Et+OKTt3l63BcAM8Wdg9NZ18xxoN0BZtV7aX8xvw4q6oCaNIUM8Z2
 8WzmY/A2JrnF2GenG8nwXmJ2yL4zwOo+PrAGJ+NymUzqliVZnGPawt1cQ5/X2bkUXS6cDh
 DXKhzBnDynDCZhBa0khFqRJNzjsTwfU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-mk3XVL76PLOarEqCho5ycg-1; Thu, 11 Jun 2020 09:12:38 -0400
X-MC-Unique: mk3XVL76PLOarEqCho5ycg-1
Received: by mail-pg1-f198.google.com with SMTP id m15so3853488pgl.15
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 06:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z4IbClzjIumNFWl19P7DhSPKK+AjqYdBfGupMhgPQA0=;
 b=Ah0UH1h4BbWIgFJ0sl2UucLC9j4E8n6w3SUDXu9xwSVyHwRg8xRWApA5Glir1Z0PKP
 pPgnb3zswgRMU/D6PAiedbMrxeMn6hHLRPYAXuzg4E7nHOE+FdIDxpE9+tygy1T9+aOT
 oVa2TLlPyYZ7E5kypE3KhWkLRe5JIaOWVf8khYzo/o7+w6DtMhfplW1vqCSn9ypkwvE1
 tUeVOspqHtKMjQlWRtjj1VFgbexzkTxvsp4ExHVFc4x74h/H44FE1FCjPVLW/KdJL4tK
 xFhr2mhzKAEA0FX+O/KDxXAz2IrObPI9DwFWGuYY7qgdImwExc25JpJnLKnd7kp/HikM
 mJlw==
X-Gm-Message-State: AOAM533gp3frRvzm8ehsp37sMelJibPhAutxifcKgRLcSrGZaiurtro/
 8HLVksHety7LhybsysyHC++LQzZCCHRHzoyrpzXclZUhvLxEDVxaR/M6UwHOtOM4e4gD92PshBe
 2d7jVC307d26JAwZxWex2vg2t+EOmKwY=
X-Received: by 2002:a63:1617:: with SMTP id w23mr6979592pgl.248.1591881157401; 
 Thu, 11 Jun 2020 06:12:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQpp+rsoahv3mC+OJP9aEwqBcnPAqyVeqkHQLWbgILMlZzWPA0K2rGS5X4dbunkv5pkUk6j6nz4e+6wK/0Dh8=
X-Received: by 2002:a63:1617:: with SMTP id w23mr6979543pgl.248.1591881157119; 
 Thu, 11 Jun 2020 06:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-2-lulu@redhat.com>
 <d5f3e088-282e-846a-6c02-fbbe3813854f@redhat.com>
In-Reply-To: <d5f3e088-282e-846a-6c02-fbbe3813854f@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 11 Jun 2020 21:12:26 +0800
Message-ID: <CACLfguUJ-2W=E_tv2mN9GHNjOTo9xO408bWU1HxgEJVhKNBzVQ@mail.gmail.com>
Subject: Re: [RFC v3 1/8] net: introduce qemu_get_peer
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 5:08 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 29/05/2020 16:06, Cindy Lu wrote:
> > This is a small function that can get the peer from given NetClientState and queue_index
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  include/net/net.h | 1 +
> >  net/net.c         | 6 ++++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 39085d9444..e7ef42d62b 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -176,6 +176,7 @@ void hmp_info_network(Monitor *mon, const QDict *qdict);
> >  void net_socket_rs_init(SocketReadState *rs,
> >                          SocketReadStateFinalize *finalize,
> >                          bool vnet_hdr);
> > +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
> >
> >  /* NIC info */
> >
> > diff --git a/net/net.c b/net/net.c
> > index 38778e831d..599fb61028 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)
> >
> >      return nic->opaque;
> >  }
>
> To be consistent with the style of the file, you should add a blank line
> here.
>
Thanks Laurent, I will fix this
> > +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
> > +{
> > +    assert(nc != NULL);
> > +    NetClientState *ncs = nc + queue_index;
> > +    return ncs->peer;
> > +}
> >
> >  static void qemu_cleanup_net_client(NetClientState *nc)
> >  {
> >
>
> Thanks,
> Laurent
>


