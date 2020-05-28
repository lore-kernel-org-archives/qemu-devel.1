Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E560C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EEF206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBTWlEup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EEF206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGc1-0003MX-HE
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jeGbJ-0002ud-Ir
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:21:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jeGbI-0004pT-Ei
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590664886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nWuRpcoXWWjK2dG1tSHCDxX9E7W0Vv+gaRQR6GjJW0=;
 b=CBTWlEup225v3ul+E6/6WHJVsbi2SrTbzh/3z2P+Dwume5xR3LKAgOgUG1M45FkEZE7t8n
 9PuldCW/zm/hDsqbjb0UIU++e9Ff0eP0agQY24lgc2lmUNn/LOq/wvNCZE/UGGdPXxGoRb
 XNrHUOIC698PmiJDQQPForC4TH/uHos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-j4MukKa_O-uq5QVb5ps1ng-1; Thu, 28 May 2020 07:21:25 -0400
X-MC-Unique: j4MukKa_O-uq5QVb5ps1ng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4AFB835B40;
 Thu, 28 May 2020 11:21:23 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B594768B0;
 Thu, 28 May 2020 11:21:15 +0000 (UTC)
Date: Thu, 28 May 2020 13:21:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200528132112.2a1fdf45.cohuck@redhat.com>
In-Reply-To: <20200522230451.632a3787.pasic@linux.ibm.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200522230451.632a3787.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 23:04:51 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 20 May 2020 12:23:24 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, May 15, 2020 at 12:11:55AM +0200, Halil Pasic wrote:  
> > > The virtio specification tells that the device is to present
> > > VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> > > device "can only access certain memory addresses with said access
> > > specified and/or granted by the platform". This is the case for a
> > > protected VMs, as the device can access only memory addresses that are
> > > in pages that are currently shared (only the guest can share/unsare its
> > > pages).
> > > 
> > > No VM, however, starts out as a protected VM, but some VMs may be
> > > converted to protected VMs if the guest decides so.
> > > 
> > > Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> > > the property iommu_on is a minor disaster. Since the correctness of the
> > > paravirtualized virtio devices depends (and thus in a sense the
> > > correctness of the hypervisor) it, then the hypervisor should have the
> > > last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or
> > > not.  
> > 
> > So, how about this: switch iommu to on/off/auto.  
> 
> Many thanks for the reveiw, and sorry about the delay on my side. We
> have holidays here in Germany and I was not motivated enough up until
> now to check on my mails.
> 
> 
> I've actually played  with the thought of switching iommu_platform to 
> 'on/off/auto', but I didn't find an easy way to do it. I will look
> again. This would be the first property of this kind in QEMU, or?

virtio-pci uses it for 'disable-legacy'.

> 
> The 'on/off/auto' would be certainly much cleaner form user-interface
> perspective. The downsides are that it is more invasive, and more
> complicated. I'm afraid that it would also leave more possibilities for
> user error.

To me, on/off/auto sounds like a reasonable thing to do.

What possibilities of 'user error' do you see? Shouldn't we fence off
misconfigurations, if the consequences would be disastrous?

> 
> >  Add a property with a
> > reasonable name "allow protected"?  If set allow switch to protected
> > memory and also set iommu auto to on by default.  If not set then don't.
> >  
> 
> I think we have "allow protected" already expressed via cpu models. I'm
> also not sure how libvirt would react to the idea of a new machine
> property for this. You did mean "allow protected" as machine property,
> or?

"Unpack facility in cpu model" means "guest may transition into pv
mode", right? What does it look like when the guest actually has
transitioned?

> 
> AFAIU "allow protected" would be required for the !PV to PV switch, and
> we would have to reject paravirtualized devices with iommu_platform='off'
> on VM construction or hotplug (iommu_platform='auto/on' would be fine).
> 
> Could you please confirm that I understood this correctly?
> 
> 
> > This will come handy for other things like migrating to hosts without
> > protected memory support.
> >   
> 
> This is already covered by cpu model AFAIK.

I don't think we'd want to migrate between pv and non-pv anyway?

> 
> > 
> > Also, virtio now calls this PLATFORM_ACCESS, maybe we should rename
> > the property (keeping old one around for compat)?  
> 
> You mean the like rename 'iommu_platform' to 'platform_access'? I like
> the idea, but I'm not sure libvirt will like it as well. Boris any
> opinions?
> 
> > I feel this will address lots of complaints ...
> >   
> > > Currently presenting a PV guest with a (paravirtualized) virtio-ccw
> > > device has catastrophic consequences for the VM (after the hypervisors
> > > access to protected memory). This is especially grave in case of device
> > > hotplug (because in this case the guest is more likely to be in the
> > > middle of something important).
> > > 
> > > Let us manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
> > > for virtio-ccw devices, i.e. force it before we start the protected VM.
> > > If the VM should cease to be protected, the original value is restored.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>  
> > 
> > 
> > I don't really understand things fully but it looks like you are
> > changing features of a device.  If so this bothers me, resets
> > happen at random times while driver is active, and we never
> > expect features to change.
> >  
> 
> Changing the device features is IMHO all right because the features can
> change only immediately after a system reset and before the first vCPU
> is run. That is ensured by two facts.
> 
> 
> First, the feature can only change when ms->pv changes. That is on the
> first reset after the VM entered or left the "protected virtualization"
> mode of operation. And that switch requires a system reset. Because the
> PV switch is initiated by the guest, and the guest is rebooted as a
> consequence, the guest will never observe the change in features.

This really needs more comments, as it is not obvious to the casual
reader. (I also stumbled over the resets.)

But I wonder whether we are actually missing those subsystems resets
today?


