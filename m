Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECA0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BC02070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7h6ApAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BC02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k009p-0001QF-Pa
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0093-0000DV-7I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:14:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0091-0002v3-9z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595844846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSYfvSUw/sHX1d2uoDlQ9iFSY2DNKfKo79WAJdSNY+8=;
 b=G7h6ApAo2V+hjuHg45gp6O4rZQaZI7uru1m8T0rhH4krxuFMDtvmnyjJlZ6SPYZycGvhuE
 OSSXRMfzv4Nvawd+ju6dt3iRypE9HFJ8ilJFGlMRpkwznfWXPIm/arM9iX7DUBCX3igsLU
 kBdvXGqq8LKKgPt6L/FlhcNB1UMnyn8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-kqhl5hagPeOqMMDgSi-gdA-1; Mon, 27 Jul 2020 06:14:05 -0400
X-MC-Unique: kqhl5hagPeOqMMDgSi-gdA-1
Received: by mail-wr1-f70.google.com with SMTP id j16so3768651wrw.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 03:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pSYfvSUw/sHX1d2uoDlQ9iFSY2DNKfKo79WAJdSNY+8=;
 b=qD7kdOPymT8npTBPM8llq/iQIKaZWdyC2MSDEq1dEx0LOKL0yVeXdry3yiiSg2hrit
 sOyQbWKHV2IAoiMJzfvvj4G2IJ6oGviKbLURVyHuH57/g8dyr1KmQ1PN8gxmbbyEvmT+
 o5crZjk+MXH8SiUZC9Gw2qHxkqUHOobnx7/Xu0SimLD0QJgKseXhPg3HJhRaJlcqjFvJ
 9Jusav1vrtv6yAMXgcJNmLXIwIS3/OXWtZZGl8o4IaPWfRoeuHs5DuBWrOW5x3nuOlqA
 yGFL0cBfXZ30XR9DRhRPRX9rMZxApBv/NH/jh5RrbZHowYssoprV5AGhQWH8FIseM49h
 d4VQ==
X-Gm-Message-State: AOAM530NvFL/kIcD9V1WAoLj5tlEyVhLoxAjuEZjQHunU5xUar50LgKQ
 cULsH3rk6ubbNvHvFAdaLEvX7tr/vh2aiHLvcKOjh/nb7o98cgI8QV6bjUIVXh0AyMixTqPvWLf
 3tXSoyrVONDg3qwE=
X-Received: by 2002:a1c:98c1:: with SMTP id
 a184mr20080037wme.116.1595844844013; 
 Mon, 27 Jul 2020 03:14:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuyQs3fKw6FKIam4q7i+2nRCIxP8NkunPWpMxN91+d+LUR0OHM+xMI6D57Y1bo04JJ5WpbIQ==
X-Received: by 2002:a1c:98c1:: with SMTP id
 a184mr20080010wme.116.1595844843772; 
 Mon, 27 Jul 2020 03:14:03 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id k4sm12744266wrd.72.2020.07.27.03.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 03:14:03 -0700 (PDT)
Date: Mon, 27 Jul 2020 06:13:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
Message-ID: <20200727061112-mutt-send-email-mst@kernel.org>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
 <20200727115322.4e7fe1aa.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727115322.4e7fe1aa.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 11:53:22AM +0200, Cornelia Huck wrote:
> On Mon, 27 Jul 2020 05:41:17 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
> > > We try to get config from peer unconditionally which may lead NULL
> > > pointer dereference. Add a check before trying to access the config.
> > > 
> > > Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
> > > Cc: Cindy Lu <lulu@redhat.com>
> > > Tested-by: Cornelia Huck <cohuck@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > 
> > I am a bit lost here. Isn't this invoked
> > when guest attempts to read the config?
> > With no peer, what do we return to guest?
> 
> Same as with a non-vdpa peer? It's the dereference that needs to be
> guarded.

So vdpa has a GET_CONFIG ioctl which to me hints that a peer needs to be
notified on get config calls.
If we return config from qemu memory here, then I guess we
need to call GET_CONFIG on connect and validate it -
does this make sense?

Cindy, Jason?

> > A code comment might be helpful here.
> > 
> > > ---
> > >  hw/net/virtio-net.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)


