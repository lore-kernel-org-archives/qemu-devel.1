Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87AAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7352620825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgKAR26p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7352620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jya8v-0001xf-Oi
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jya8D-0001Sa-VP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:15:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jya8B-0001Ym-QV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595506523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Js0LG+sFT/+31vmiu9Cc8YckwK1kNNamB61ypEfRDs=;
 b=SgKAR26pn3GacwQcm8BgxA6nP/20wHRy+xMwr+f7iXhvZfKe3RPbSmLmMfx68S3psOLZ5T
 joCu1+AVMji7Ooe+fPF/2NvS/PD3xQb/27BwQmuzJklpFj15TdLkqkQDBnVatNNo6pwOFc
 5EDO0q2L/sULg+zcpq9S0qnEn6pNZ/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-d3Yeo_eZMdynAmP-dKMKug-1; Thu, 23 Jul 2020 08:15:20 -0400
X-MC-Unique: d3Yeo_eZMdynAmP-dKMKug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9736DE919;
 Thu, 23 Jul 2020 12:15:19 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92E1378540;
 Thu, 23 Jul 2020 12:15:09 +0000 (UTC)
Date: Thu, 23 Jul 2020 14:15:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/2] virtio: non-legacy device handling
Message-ID: <20200723141507.2e3004d8.cohuck@redhat.com>
In-Reply-To: <c4c2e135-d648-0754-cae4-264a3d3f9892@redhat.com>
References: <20200707105446.677966-1-cohuck@redhat.com>
 <51e457ef-106e-1c1a-778d-4d53d9e48d8e@redhat.com>
 <20200720050215-mutt-send-email-mst@kernel.org>
 <4309b9dd-cc94-e183-60f8-67e4ec36c666@redhat.com>
 <20200723083313.49e3502a.cohuck@redhat.com>
 <c4c2e135-d648-0754-cae4-264a3d3f9892@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 13:57:08 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 23.07.20 08:33, Cornelia Huck wrote:
> > On Mon, 20 Jul 2020 11:07:51 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 20.07.20 11:03, Michael S. Tsirkin wrote:  
> >>> On Mon, Jul 20, 2020 at 10:09:57AM +0200, David Hildenbrand wrote:    
> >>>> On 07.07.20 12:54, Cornelia Huck wrote:    
> >>>>> As discussed in "virtio-fs: force virtio 1.x usage", it seems like
> >>>>> a good idea to make sure that any new virtio device (which does not
> >>>>> support legacy virtio) is indeed a non-transitional device, just to
> >>>>> catch accidental misconfigurations. We can easily compile a list
> >>>>> of virtio devices with legacy support and have transports verify
> >>>>> in their plugged callbacks that legacy support is off for any device
> >>>>> not in that list.
> >>>>>
> >>>>> Most new virtio devices force non-transitional already, so nothing
> >>>>> changes for them. vhost-user-fs-pci even does not allow to configure
> >>>>> a non-transitional device, so it is fine as well.
> >>>>>
> >>>>> One problematic device, however, is virtio-iommu-pci. It currently
> >>>>> offers both the transitional and the non-transitional variety of the
> >>>>> device, and does not force anything. I'm unsure whether we should
> >>>>> consider transitional virtio-iommu unsupported, or if we should add
> >>>>> some compat handling. (The support for legacy or not generally may
> >>>>> change based upon the bus, IIUC, so I'm unsure how to come up with
> >>>>> something generic.)
> >>>>>
> >>>>> Cornelia Huck (2):
> >>>>>   virtio: list legacy-capable devices
> >>>>>   virtio: verify that legacy support is not accidentally on    
> >>>>
> >>>> I'd squash both patches. Looking at patch #1, I wonder why we don't
> >>>> store that information along with the device implementation? What was
> >>>> the motivation to define this information separately?    
> >>>
> >>> Because people seem to cut and paste code, so when one
> >>> enables it in an old device, it gets pasted into a new one.
> >>> With a list in a central place, it's easier to figure out
> >>> what's going on.    
> >>
> >> Makes sense, I suggest adding that to the patch description.  
> > 
> > "The list of devices supporting legacy is supposed to be static. We
> > keep it in a central place to make sure that new devices do not enable
> > legacy by accident."
> > 
> > ?  
> 
> Ack!
> 
> >   
> >>
> >> Both patches look sane to me (- squashing them).
> >>  
> > 
> > Patch 1 does not change behaviour, while patch 2 does (for
> > virtio-iommu-pci). Still would like an opinion whether changing the
> > behaviour for virtio-iommu-pci with no compat handling is ok.
> > 
> > (I could be persuaded to squash them.)  
> 
> I'm a friend of introducing helper functions along with code that
> actually uses it. But I agree that the change in behavior might be
> hairy. Maybe we can split that out somehow to give it more attention?

It should not really be noticeable for anything but virtio-iommu.

However, I see these are already in a pull request...


