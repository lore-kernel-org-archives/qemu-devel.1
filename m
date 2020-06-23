Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCA820724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgdFiUa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCA820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf6r-00045C-I8
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf5h-0002tP-Va
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:19:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf5g-0001IF-8I
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bl7lOpgMnvotqjPLbSfMN9zL6BPdSRJ7iWJANapg8XE=;
 b=hgdFiUa6THyInFBEqlo2WhR40mnOlTVv3VqZ+cqhslw31o1EubODOF60jLpGZ29EoH2QCM
 N+crX+YCZPtsIRijRqyHHafhqBEk1SXRK3dawm+jA+UzKoM6IyMNDBOX2AUMq+fw4bn4kt
 m4BYHGhQkZ2i+hXZItBtCaMv5BFKUrs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-cbDfmqXvPQqWSxJrxbIYSg-1; Tue, 23 Jun 2020 05:19:35 -0400
X-MC-Unique: cbDfmqXvPQqWSxJrxbIYSg-1
Received: by mail-pf1-f200.google.com with SMTP id b6so15365556pfr.20
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bl7lOpgMnvotqjPLbSfMN9zL6BPdSRJ7iWJANapg8XE=;
 b=gPRGgzMpFNX8X/2u0CSMBvsS7qtZkOLRtQTAeWQk8V18XpeYxXoJIgw3BTmxrNK2m2
 deXANW6med1kQ62P4k0AUXMxqO/JG/4so9CpV1NKHRQBBjqKS7GqYMJNF8OLTCtzNUJN
 b7MmxDtJVR/raEjnLrOID/1yMBjycHgLTPyu0zNOs83NdImq0P9i5Ay54NuPH5SaIONE
 swVSol0MyPXBjU/z8VI+dw4k7hp/zKgYZ3S08Nwkc+hUMi8vB53aXsg5yLrua1uxaWJK
 +e7tDEX+2TthZWteiE5OPvEIsYaRk1fNKCEYcjONm+S+8ZQFevfJszL9f/Dcx2RZ1ljS
 WmNg==
X-Gm-Message-State: AOAM530KcWXxgYY4tRLYuYsj+iPQRMXCNtr5uF+VGPMsXvrWmJikva7l
 PhjmAsLikNnftlQs7DSK5Y2mxah64+4Z0T1PXg5x9cbOtHKcUVshk4fqYZQ86LX7G/flIocc6Wl
 mvxUZfIcOW6bsH+lIyqF+ngFh0Rz9t/4=
X-Received: by 2002:a63:1617:: with SMTP id w23mr16751394pgl.248.1592903974197; 
 Tue, 23 Jun 2020 02:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/6j++m60K2Mb7qqTgUzC3iqArXSQprwM2RfHxMWJ4Xfvg6YKvogEubGNvPAKJDk/BqrWww4lDJXnUYBCSf7E=
X-Received: by 2002:a63:1617:: with SMTP id w23mr16751381pgl.248.1592903973966; 
 Tue, 23 Jun 2020 02:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-11-lulu@redhat.com>
 <875zbi45n2.fsf@dusky.pond.sub.org>
In-Reply-To: <875zbi45n2.fsf@dusky.pond.sub.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:19:23 +0800
Message-ID: <CACLfguUyyuwTAa8P5dnKM+Zu5TboG8gAoLWAWLwvAoipiipWEQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] vhost-vdpa: introduce vhost-vdpa net client
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 3:13 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> QAPI schema review only.
>
> Cindy Lu <lulu@redhat.com> writes:
>
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is specified
> > by a "vhostdev" parameter.
> >
> > Signed-off-by: Lingshan Zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> [...]
> > diff --git a/qapi/net.json b/qapi/net.json
> > index cebb1b52e3..03aad67693 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -428,6 +428,24 @@
> >      '*vhostforce':    'bool',
> >      '*queues':        'int' } }
> >
> > +##
> > +# @NetdevVhostVDPAOptions:
> > +#
> > +# Vhost-vdpa network backend
>
> Considering this ends up in QMP reference documentation, could you add a
> hint on what "Vhost-vdpa" is?
>
> > +#
> > +# @vhostdev: name of a vdpa dev path in sysfs
>
> How is this thing to be spelled in text, vdpa, VDPA or vDPA?
>
> Avoid unnecessary abbreviations in doc text, please: write "device
> path", not "dev path".
>
> > +#            (default path:/dev/vhost-vdpa-$ID)
>
> What's $ID?
>
Thanks, I will rewrite this part and make it clear
> > +#
> > +# @queues: number of queues to be created for multiqueue vhost-vdpa
> > +#          (default: 1)
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'NetdevVhostVDPAOptions',
> > +  'data': {
> > +    '*vhostdev':     'str',
> > +    '*queues':       'int' } }
> > +
> >  ##
> >  # @NetClientDriver:
> >  #
> > @@ -437,7 +455,7 @@
> >  ##
> >  { 'enum': 'NetClientDriver',
> >    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
> >
> >  ##
> >  # @Netdev:
> > @@ -465,7 +483,8 @@
> >      'bridge':   'NetdevBridgeOptions',
> >      'hubport':  'NetdevHubPortOptions',
> >      'netmap':   'NetdevNetmapOptions',
> > -    'vhost-user': 'NetdevVhostUserOptions' } }
> > +    'vhost-user': 'NetdevVhostUserOptions',
> > +    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
> >
> >  ##
> >  # @NetLegacy:
>


