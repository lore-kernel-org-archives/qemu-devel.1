Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E4C56202
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C4A2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp1Vco2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kag5y-0006vk-Pz
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kag5O-0006Tw-52
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kag5M-0000CO-9W
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604585874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1jYd+omDrCZMHLyMdz30+lP8FJrzziRwLSU7MibdhE=;
 b=Cp1Vco2P2N8JwAE6TOp6mBrI7reAfJp4ZKOYRdZ0GPvON7BeGCSZ9+D5dOGbemEY8HeGKB
 rq2IuyP6gAyVJEdpshOzbQwP93xmTXhPiy0R8fe6Y6sWId1rFmd8tZV2JTSGufwCMvX+8G
 9hhgVM6yvKBT8SLa/jEWcO39sEzhJ1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-5sUMWljUOo-e84xhOQgDLA-1; Thu, 05 Nov 2020 09:17:43 -0500
X-MC-Unique: 5sUMWljUOo-e84xhOQgDLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BF931891E82;
 Thu,  5 Nov 2020 14:17:42 +0000 (UTC)
Received: from work-vm (ovpn-113-170.ams2.redhat.com [10.36.113.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01FEF60C17;
 Thu,  5 Nov 2020 14:17:27 +0000 (UTC)
Date: Thu, 5 Nov 2020 14:17:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201105141725.GK3186@work-vm>
References: <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
 <20201104073636.GB390503@stefanha-x1.localdomain>
 <20201104101423.GB3896@work-vm>
 <20201104164744.GC425016@stefanha-x1.localdomain>
 <20201104173202.GG3896@work-vm>
 <20201105114037.GC462479@stefanha-x1.localdomain>
 <20201105121324.GH3186@work-vm>
 <20201105074428-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201105074428-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Nov 05, 2020 at 12:13:24PM +0000, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Wed, Nov 04, 2020 at 05:32:02PM +0000, Dr. David Alan Gilbert wrote:
> > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > Michael replied in another sub-thread wondering if versions are really
> > > > > necessary since tools do the migration checks. Let's try dropping
> > > > > versions to simplify things. We can bring them back if needed later.
> > > > 
> > > > What does a user facing tool do?  If I say I want one of these NICs
> > > > and I'm on the latest QEMU machine type, who sets all these parameters?
> > > 
> > > The machine type is orthogonal since QEMU doesn't know about every
> > > possible VFIO device. The device is like a PCI adapter that is added to
> > > a physical machine aftermarket, it's not part of the base machine's
> > > specs.
> > 
> > OK, but ignoring migration, I think the same problem holds; if I'm a
> > tool creating one of these VMs, and I plug this device in, what do I do
> > with all it's configuration parameters?  I'd assume most of the time
> > that they don't know about or dont care about most of the parameters,
> > they just want the sane defaults unless told otherwise.
> 
> I think that if you ignore migration then you can ignore parameters.

So if I ingore parameters, do I get the latest, greatest config from the
device implementation I have?

> > > The migration tool queries the parameters from the source device.
> > > VFIO/mdev will provide sysfs attrs. For vfio-user I'm not sure whether
> > > to print the parameters during device instantiation, require a
> > > VFIO-compatible FUSE directory, or to use a query-migration-params RPC
> > > command.
> > 
> > But on VM creation we have to answer the question of what config do we
> > want; so for example lets say I'm creating a new VM in my cluster,
> > but I want to be sure that later I can migrate it.  I can read the 
> > config off one of the other machines;  can I just use that even if my
> > new machine has a later device implementation?
> > 
> > Dave
> 
> I don't think so - we need a tool that can query a set of machines and then
> produce a safe configuration.

That's why I liked the 'version' idea; you just have to find the lowest
version in your set.

Dave

> The same problem exists with vhost as well it will just
> explode exponentially with lots more devices and backends ...
> Talked about it a bit in my kvm forum preso ...
> 
> > > Let's discuss this more when the next revision of the document is sent
> > > out, because it modifies the approach so that migration parameters are
> > > logically separate from device configuration parameters. That changes
> > > things a bit.
> > > 
> > > Stefan
> > 
> > 
> > -- 
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


