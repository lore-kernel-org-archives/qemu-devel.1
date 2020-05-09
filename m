Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21EC47254
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 06:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD5224957
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 06:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKgRVykI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5224957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXJLP-0007VW-I6
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 02:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJKZ-0006f5-5F
 for qemu-devel@nongnu.org; Sat, 09 May 2020 02:51:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJKY-00032t-Bv
 for qemu-devel@nongnu.org; Sat, 09 May 2020 02:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589007085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1sjEZTEowiZ6l4eAtMHcTikuTJxJzvHjD2pSKAxUfc=;
 b=AKgRVykIr0VFpSZIYBUx+DvIhm/6UoW+PvtHRUV9j+ALk1ZbR2WEgdaZgEBQ9KCyESmWCR
 a1zGAK+ZIteYL8+wPtKW84ExLoXvK1FNHjfPj2SS/vBzvGEWT27+uWUgwyqx9QIcv8Xm3p
 MCgazSMdUlIHY3RvWspPiSqk3mRBsFo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-CPY7bNTzNk6evI_ctaAmCg-1; Sat, 09 May 2020 02:51:23 -0400
X-MC-Unique: CPY7bNTzNk6evI_ctaAmCg-1
Received: by mail-pl1-f197.google.com with SMTP id y7so3412053plp.8
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 23:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u1sjEZTEowiZ6l4eAtMHcTikuTJxJzvHjD2pSKAxUfc=;
 b=bbBx/L23TS3AwwAPAoAuLHGyNvsxNHan/MVzs25IJqz3Ge06/J7n4jmMQGcEC9NVtj
 Abv2bY5xKzGYkW+CGXTVdkf3q2/ZtBXHdq1Y5biAyYTwoYMDsujcAbgdZ7htnQIfJqP3
 SjRGSnABeVOaBBCXIJ0n4IARMiz9gjxlQkk7vKOyGaDBAQ1dnIcnlrcm8nhPb1yPwXyM
 aMpQ2oryf4ofqVgOqY5xiQkwhzMVFYaglOLdrlumwNMqYpeT0Wc43WFSS8/pZX/+Dh9l
 UtHChAEqzmdp8Gl31N0el2T//xOL73pJM3KUsFlmJA0sOBI5XOU+OZwKW7a2ZH436B7c
 FGdw==
X-Gm-Message-State: AGi0PuakRBCUXgXAm9rh8HvCEjNpHWJTlFtrzgQ5GxFoArl/R2gImoi7
 BF5Qdw3/ibGl+Jpc68jgTgXlJohiE9cuSH5CRlN6gRc/1gx/wDUL59ofaENleIi4WHrQoVMZLg8
 cL/wsrxB1vz3hQ8EpCow88Hd7JFLoSSc=
X-Received: by 2002:a62:a106:: with SMTP id b6mr6382281pff.23.1589007082235;
 Fri, 08 May 2020 23:51:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypL+bmXzADfpoLd3xgZu0BSIhFweAHwp6ht+gGqcjMC+nexufzmRU4WP5v6lzfqVmIe5UNmFOSjUBjZouqSPNjg=
X-Received: by 2002:a62:a106:: with SMTP id b6mr6382247pff.23.1589007082001;
 Fri, 08 May 2020 23:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-9-lulu@redhat.com>
 <73454f11-d3f7-a19f-da2e-901424053026@redhat.com>
In-Reply-To: <73454f11-d3f7-a19f-da2e-901424053026@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 14:51:10 +0800
Message-ID: <CACLfguX3rgzQ-4ZVoTbr-ZLtYge6XnEw=SUPP4756MX0MkDTQA@mail.gmail.com>
Subject: Re: [RFC v2 8/9] vhost_net: set vq ready during start if necessary
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 02:50:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 rob.miller@broadcom.com, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 11:04 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/9 =E4=B8=8A=E5=8D=8812:32, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   hw/net/vhost_net.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 1af39abaf3..eff9ec9177 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -383,6 +383,10 @@ int vhost_net_start(VirtIODevice *dev, NetClientSt=
ate *ncs,
> >                   goto err_start;
> >               }
> >           }
> > +
> > +        if (virtio_queue_enabled(dev, i)) {
> > +            vhost_set_vring_ready(peer);
> > +        }
> >       }
> >
> >       return 0;
>
>
> Please place the patch before vhost-vdpa.
>
> Thanks
>
Sure will fix this


