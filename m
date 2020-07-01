Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0D8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC90207D0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUdDaHAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC90207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqef8-0001Qr-J7
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqeXs-0002xp-CV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:21:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33137
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqeXq-0004Bw-7Q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593616865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Z8UT5vSj2pQ4GzIt6e3dNiiN0wVzPrBzTl5msxzeko=;
 b=FUdDaHAptk0oj3KAB3O7dQDfjbbWT207QJ/DP3njIeD9soNMs/NAS3ckA24R2WI3aClOHB
 98rg9Wtz6WJsyeW0GTqvlx6R9jcLsrewTXIt7ywNr3zjmx5w1xLKjbpRL39z7Ir+VfkidG
 lVIFmE1Nv5o1TNXna97OwZvaQlcInqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-NgPjv5PjMNuaShWJ1sJIaQ-1; Wed, 01 Jul 2020 11:20:56 -0400
X-MC-Unique: NgPjv5PjMNuaShWJ1sJIaQ-1
Received: by mail-wr1-f72.google.com with SMTP id i12so21069755wrx.11
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Z8UT5vSj2pQ4GzIt6e3dNiiN0wVzPrBzTl5msxzeko=;
 b=VAMSJp/5avUlcgZA6nLQNFETymLiNX4BQI6fyZHBIVIqubGGXhg0oc031vMT/TM0kw
 SDSlAL/7YZ9u9dhYtJD6fDK375ZFODFwgXFZGmaUKTA0Y6WJMcgm5BeNiyebpomLz2Ee
 0b5x8vLMQfqHzR4ZvG2I6Astyj0SbnqYWMiucdjfI0HyaBgyAreQe7656O1ehIeFtsPa
 vKPEx8kD9qloTC15uB0X0TKYadb9j3+HCl8yxlYAxnzP5nZhNDPHv5os4LGcZ1F4fOoc
 SbNe6WZoz+RX3pLN6GUDzfzqHTkT/Xg6Xo2B0kkpCc0JO9Y7KaNw+9vYk3wWOSZ8JXtk
 Nuow==
X-Gm-Message-State: AOAM5306JBafK5oWbWDTBcm4RngpAoG3mqRM1aMNfj2IDGSUiLU3GL3O
 Pj4d0zz6uPZfGTdpwXOvy5ya/qU1Ud0UGJdP+thS/f7amiGojThb41HXTDbNJ3nX2t2azywD9/4
 O5Pb5jLai9pELR/8=
X-Received: by 2002:a1c:6788:: with SMTP id
 b130mr28037275wmc.100.1593616855659; 
 Wed, 01 Jul 2020 08:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsFkH37qn8s18wOU+ttqmUOj0jBQh4pSgJx4/AyoZICav/pKkclQxjjRRhi40LztVmLLvIQw==
X-Received: by 2002:a1c:6788:: with SMTP id
 b130mr28037240wmc.100.1593616855455; 
 Wed, 01 Jul 2020 08:20:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 138sm1749480wmb.1.2020.07.01.08.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 08:20:54 -0700 (PDT)
Date: Wed, 1 Jul 2020 11:20:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 13/13] vhost-vdpa: introduce vhost-vdpa net client
Message-ID: <20200701112022-mutt-send-email-mst@kernel.org>
References: <20200701092449.17451-1-lulu@redhat.com>
 <20200701092449.17451-14-lulu@redhat.com>
 <dc1c8668-54b7-4b9f-cf0f-a0479339fa7d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dc1c8668-54b7-4b9f-cf0f-a0479339fa7d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: cohuck@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 hanand@xilinx.com, rob.miller@broadcom.com, saugatm@xilinx.com,
 Cindy Lu <lulu@redhat.com>, armbru@redhat.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, mhabets@solarflare.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, cunming.liang@intel.com, gdawar@xilinx.com,
 jiri@mellanox.com, xiao.w.wang@intel.com, stefanha@redhat.com,
 zhihong.wang@intel.com, Tiwei Bie <tiwei.bie@intel.com>, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 09:28:27AM -0500, Eric Blake wrote:
> On 7/1/20 4:24 AM, Cindy Lu wrote:
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is specified
> > by a "vhostdev" parameter.
> > 
> > Signed-off-by: Lingshan Zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> 
> > +++ b/qapi/net.json
> 
> >   ##
> >   # @NetClientDriver:
> >   #
> >   # Available netdev drivers.
> >   #
> > -# Since: 2.7
> > +# Since: 5.1
> 
> This should be:
> 
> # Since 2.7
> # @vhost-vdpa since 5.1
> 
> since the enum itself is still available in older releases, it is only the
> new member that was introduced in this series.
> 
> >   ##
> >   { 'enum': 'NetClientDriver',
> >     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
> 


Thanks! I will fix it up when applying.
Ack with that fixed?


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org


