Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF1A20760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqowPk9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF1A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiuA6-0005AS-DC
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jitxI-0007sX-8L
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:11:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jitxH-000338-7M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591769477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xVJbzgapHumTZzw41eLtnS/uNwrsbkLhVeL+Tlljxc=;
 b=MqowPk9orPTyIFlrvziRKAKvjbuAfx4oZCRztct7Y3bg+aZGpbBnG6ba815AUfxMZPDZKS
 PzQ+mlZ3vSf8z1BgeHOmSZvukb1f2YH1i5BhaweeB2+quTve/m/gxv4EThyx3Cra3ebq80
 7uODuR+mkOGwri7OrGnDfCAB7XgcppI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-8u7WKT51NOCpkLU8E5qxyw-1; Wed, 10 Jun 2020 02:11:14 -0400
X-MC-Unique: 8u7WKT51NOCpkLU8E5qxyw-1
Received: by mail-wm1-f71.google.com with SMTP id p24so141023wmc.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 23:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7xVJbzgapHumTZzw41eLtnS/uNwrsbkLhVeL+Tlljxc=;
 b=XImczn9+kDnVeVgb4y+QgWCNLEL6fKh2gZcw/WRJJc/zLLfns6V1POJgMIMqKp1EeU
 C0dtHKKU1VqsjhTGehXfpgBewFnyX29C94vNRygIzOkZdUStJ5gts1n2dCAdZnyhmTiM
 svsUq5YcG4cPrRwR+w8szSYMDD0K6bsCy/6j9V/v4SO/S7U8SOim4+JYEjC5hCQDqV4e
 ZAjF8fl0B8x+qe/A/wNVGoei4TlS7ClDwgdcXEPkDDj2bN/lyEfJUnfXm5YCo7mA+dGa
 vSl2iFK1AX4sWxnjVtdECfjrHVL3mgq5/m8U8moWD2gy5fyVGimNCAUO6xDana3jojPa
 BH5w==
X-Gm-Message-State: AOAM533dMol4JPvycwiPF0cpplpeC+FlP5YB0uuBHAuxNeRxFg9hv9DY
 VSU+lcCs7mrPOrrezc2VriPpmTbNOx3ElboE9CwgFG6qFLjVmuJbdOwMVIlF3DSfIOwcB6jNKz8
 wL26WCmKxFkGMfo8=
X-Received: by 2002:adf:e749:: with SMTP id c9mr1835922wrn.25.1591769473074;
 Tue, 09 Jun 2020 23:11:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyrXBK9iTGF63NevDsMQC2I1K2EbL01ghgD7FzaBVeUtAulUqB3HGqIIZsSi3JnxkR9sz5lw==
X-Received: by 2002:adf:e749:: with SMTP id c9mr1835877wrn.25.1591769472711;
 Tue, 09 Jun 2020 23:11:12 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id 30sm6615267wrd.47.2020.06.09.23.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 23:11:12 -0700 (PDT)
Date: Wed, 10 Jun 2020 02:11:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/7] vhost: involve device backends in feature
 negotiation
Message-ID: <20200610020908-mutt-send-email-mst@kernel.org>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-5-stefanha@redhat.com>
 <20200609135007-mutt-send-email-mst@kernel.org>
 <37ac3fbb-9a9b-9290-abee-a8603c81925c@redhat.com>
 <20200610001156-mutt-send-email-mst@kernel.org>
 <1e503661-0652-b0dc-f900-8cd9aca2ccb8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1e503661-0652-b0dc-f900-8cd9aca2ccb8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 01:53:57PM +0800, Jason Wang wrote:
> 
> On 2020/6/10 下午12:15, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2020 at 11:21:50AM +0800, Jason Wang wrote:
> > > On 2020/6/10 上午2:07, Michael S. Tsirkin wrote:
> > > > > +/*
> > > > > + * Default vhost_get_features() feature bits for existing device types that do
> > > > > + * not define their own.
> > > > > + *
> > > > > + * This is a workaround for existing device types, do not use this in new vhost
> > > > > + * device types. Explicitly define a list of feature bits instead.
> > > > > + *
> > > > > + * The following feature bits are excluded because libvhost-user device
> > > > > + * backends did not advertise them for a long time. Therefore we cannot detect
> > > > > + * their presence. Instead we assume they are always supported by the device
> > > > > + * backend:
> > > > > + * VIRTIO_F_NOTIFY_ON_EMPTY
> > > > > + * VIRTIO_F_ANY_LAYOUT
> > > > > + * VIRTIO_F_VERSION_1
> > > > > + * VIRTIO_RING_F_INDIRECT_DESC
> > > > > + * VIRTIO_RING_F_EVENT_IDX
> > > > Weird. I remember that it's common for vhost-user not to set
> > > > VIRTIO_RING_F_INDIRECT_DESC - they have huge queues so
> > > > don't need it and inline descriptors give them better
> > > > performance.
> > > > 
> > > > So what's going on here?
> > > 
> > > I guess one reason is to support live migration between vhost-user and
> > > vhost-net.
> > > 
> > > Thanks
> > > 
> > But how can we force-enable features backend doesn't want to enable?
> 
> 
> We can't and the code just forces qemu to validate
> VIRTIO_RING_F_INDIRECT_DESC for each vhost backends instead of assuming the
> support silently.
> 
> Thanks

So why does the comment above say:

     Instead we assume they are always supported by the device backend




> 
> > This may or may not break backends ...
> > I would rather just be strict and ask backends to fix their feature
> > bits. See user_feature_bits in hw/net/vhost-net.c which supports
> > all these features.
> > 


