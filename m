Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACBFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A862072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwQrg8dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A862072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jis9g-00047x-Fs
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jis8w-0003X8-Pm
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:15:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jis8v-00067k-6u
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591762511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vap+EJMLiPvitLTsaL1pIVHhtRBheDg/G4OUawWlWko=;
 b=hwQrg8dqfVFRtZwCpg5uiC/Vvo/WHH6z76tFl2k+4JGImSSiMK6UYMv6IZJeXUHq3bz1nN
 T4FMn1OP4XvxcXTQD3hQj3QOgGn0ICCZK4MPstcW2YkNDU0bAr+0nxwVB58Og7xXNwgR/U
 PVyehLP6lqwpLkMxzkOPIfK+90xvcfA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-pD7RJv1nMyGx2uNXtvVDYg-1; Wed, 10 Jun 2020 00:15:08 -0400
X-MC-Unique: pD7RJv1nMyGx2uNXtvVDYg-1
Received: by mail-wr1-f69.google.com with SMTP id r5so499169wrt.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vap+EJMLiPvitLTsaL1pIVHhtRBheDg/G4OUawWlWko=;
 b=Zqb9s2n3RKW60AJy5VYjLj7eopHu9F6pKLp6Rm7biFc9FJWHrmOZ97RTiPFhEEVZiP
 rclLkAc/OHr0lap3z93TNyCB6YgP2H7UJDEMBuDzBfr+GQC11MOJxLz9dsY6ZtoERyQ0
 K30jG45IVQzGnIBv1S8ysxud9t85wMUpUiiaqbC1j+nJxY56xRJew1K+Uhb/8s0xRunZ
 WDuVdvmOCKkUxv006kb2J35eOsxwQ9cznr5tgzq+yfAu3b8QC1fpjZ8vR2maooHinmLf
 YYviDZK17vNcV5LwS+0G7z+K2IpJRTUeHUsYcFy6ZwdFlKLOKvEF5XZkW25Iy3lmRrRc
 67Zw==
X-Gm-Message-State: AOAM533oEA1wph8A6c5ZPgY60PCQyfqqr/XfdrVpyuwwBO1Knp7v3ueM
 dAfPt4PsFJxITqcDoBmGpyOZJKbW2EGfg7Fn7UO9sy5xhtZmZjVc7DxO74HsfCV1pKDb9o08wAT
 aLMAMCYplEqEoCmY=
X-Received: by 2002:a1c:7206:: with SMTP id n6mr1183341wmc.4.1591762506977;
 Tue, 09 Jun 2020 21:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQbsu9w5gxQ3o7+bSnersgWGX7WJR7Gw+Pe4U8RNTdvppn2KMTmhpEPh2BFxXEdZsEQsataA==
X-Received: by 2002:a1c:7206:: with SMTP id n6mr1183311wmc.4.1591762506600;
 Tue, 09 Jun 2020 21:15:06 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id y80sm5505160wmc.34.2020.06.09.21.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:15:05 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:15:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/7] vhost: involve device backends in feature
 negotiation
Message-ID: <20200610001156-mutt-send-email-mst@kernel.org>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-5-stefanha@redhat.com>
 <20200609135007-mutt-send-email-mst@kernel.org>
 <37ac3fbb-9a9b-9290-abee-a8603c81925c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <37ac3fbb-9a9b-9290-abee-a8603c81925c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 11:21:50AM +0800, Jason Wang wrote:
> 
> On 2020/6/10 上午2:07, Michael S. Tsirkin wrote:
> > > +/*
> > > + * Default vhost_get_features() feature bits for existing device types that do
> > > + * not define their own.
> > > + *
> > > + * This is a workaround for existing device types, do not use this in new vhost
> > > + * device types. Explicitly define a list of feature bits instead.
> > > + *
> > > + * The following feature bits are excluded because libvhost-user device
> > > + * backends did not advertise them for a long time. Therefore we cannot detect
> > > + * their presence. Instead we assume they are always supported by the device
> > > + * backend:
> > > + * VIRTIO_F_NOTIFY_ON_EMPTY
> > > + * VIRTIO_F_ANY_LAYOUT
> > > + * VIRTIO_F_VERSION_1
> > > + * VIRTIO_RING_F_INDIRECT_DESC
> > > + * VIRTIO_RING_F_EVENT_IDX
> > Weird. I remember that it's common for vhost-user not to set
> > VIRTIO_RING_F_INDIRECT_DESC - they have huge queues so
> > don't need it and inline descriptors give them better
> > performance.
> > 
> > So what's going on here?
> 
> 
> I guess one reason is to support live migration between vhost-user and
> vhost-net.
> 
> Thanks
> 

But how can we force-enable features backend doesn't want to enable?
This may or may not break backends ...
I would rather just be strict and ask backends to fix their feature
bits. See user_feature_bits in hw/net/vhost-net.c which supports
all these features.

-- 
MST


