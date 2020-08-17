Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E22D20738
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhsaLhpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E22D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cNh-0008QH-Gy
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7cN1-0007yF-EG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7cMy-0000AF-Jq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597660078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5t4AMbi3BwtliqZ1VzYEVSDte52IZZWnAjRAQoK0j1g=;
 b=dhsaLhpmVIjo8MZWmB4J2HjjbP8WxxDfnoYdERsDDOcKcmzBWDYdbGCkQ1Z8Hs6GA11Nq4
 HnWAUZtaojteqw+m7YcOa1lZmlIOwusG2vXIkfsOfPHKUl/l3j0s1GTdd0D3W73K2TN6vA
 MJi+siFZjtHUkT54Von0U9EOPouAL2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-shrARw0MObajYwjTRrt5eA-1; Mon, 17 Aug 2020 06:27:57 -0400
X-MC-Unique: shrARw0MObajYwjTRrt5eA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456C0807338;
 Mon, 17 Aug 2020 10:27:56 +0000 (UTC)
Received: from gondolin (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E630410027AB;
 Mon, 17 Aug 2020 10:27:48 +0000 (UTC)
Date: Mon, 17 Aug 2020 12:27:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200817122746.0b786372.cohuck@redhat.com>
In-Reply-To: <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
 <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 14:04:15 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Thu, Aug 13, 2020 at 12:37:37PM +0200, Cornelia Huck wrote:
> > On Thu, 13 Aug 2020 12:24:30 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> >   
> > > On Thu, Aug 13, 2020 at 11:28:20AM +0200, Cornelia Huck wrote:  
> > > > We basically have three possible ways to deal with this:
> > > > 
> > > > - Force it to modern (i.e., what you have been doing; would need the
> > > >   equivalent changes in ccw as well.)    
> > > 
> > > Oo, thanks for pointing out ccw!
> > > I don't know ccw well, in this case should we set dev->max_rev to 1 or 2
> > > to force to modern?  
> > 
> > No, ->max_rev is the wrong side of the limit :) You want  
> 
> Well :-) Thanks!
> 
> > 
> >     ccw_dev->force_revision_1 = true;
> > 
> > in _instance_init() (see e.g. virtio-ccw-gpu.c).
> >   
> > >   
> > > >   Pro: looks like the cleanest approach.
> > > >   Con: not sure if we would need backwards compatibility support,
> > > >   which looks hairy.    
> > > 
> > > Not sure too.  
> > 
> > Yes, I'm not sure at all how to handle user-specified values for
> > legacy/modern.

Thinking a bit more about it, I'm not sure whether we even *can*
provide backwards compatibility: we have different autoconfigurations
for PCI based upon where it is plugged, and ccw does not have a way to
turn legacy on/off, except from within the code.

> >   
> > >   
> > > > - Add vsock to the list of devices with legacy support.
> > > >   Pro: Existing setups continue to work.
> > > >   Con: If vsock is really virtio-1-only, we still carry around
> > > >   possibly broken legacy support.    
> > > 
> > > I'm not sure it is virtio-1-only, but virtio-vsock was introduced in
> > > 2016, so I supposed it is modern-only.  
> > 
> > Yes, I would guess so as well.
> >   
> > > 
> > > How can I verify that? Maybe forcing legacy mode and run some tests.  
> > 
> > Probably yes. The likeliest area with issues is probably endianness, so
> > maybe with something big endian in the mix?
> >   
> 
> Yeah, I'll try this setup!
> 
> > >   
> > > > - Do nothing, have users force legacy off. Bad idea, as ccw has no way
> > > >   to do that on the command line.
> > > > 
> > > > The first option is probably best.

The first option is now "force modern, but with no backwards
compatibility", which is not that great; but "allow legacy, even though
it should not exist" is not particularly appealing, either... what a
mess :(

> > > >    
> > > 
> > > Yeah, I agree with you!  
> > 
> > Yes, it's really a pity we only noticed this after the release; this
> > was supposed to stop new devices with legacy support creeping in, not
> > to break existing command lines :(
> >   
> 
> Yes, I forgot to test vsock stuff before the release :-(
> Maybe we should add some tests...

Speaking of tests: do you have a quick way to test vhost-vsock at hand?
Maybe I should add it to my manual repertoire...


