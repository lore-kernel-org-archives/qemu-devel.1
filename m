Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A081C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A7A2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yjym5DFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A7A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7evs-0007sG-Hl
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7evM-0007Si-1Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:11:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7evJ-00042X-SX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597669897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E80IKpn60MGVNrUMp2fpnMGPM49g8q0lwBFMl2zWNLQ=;
 b=Yjym5DFDgCWFMHbR4exDc3FQfRTviRa8703wFAY0mJJBV3K78Mgk+PTagUaRStL/nHTJLk
 25LcloFvdHRjttk+PHJrge/niaIguyN5S22TsCuM87Iie6RAf92R+ZvYxZ5c2EVbJW0XBn
 9/MCku1nfb2TNn+hiojJfEEeNkMn5zA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-oUXSUWd1OUqNLI3fnQYu7Q-1; Mon, 17 Aug 2020 09:11:34 -0400
X-MC-Unique: oUXSUWd1OUqNLI3fnQYu7Q-1
Received: by mail-wm1-f71.google.com with SMTP id z1so6009695wmf.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 06:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E80IKpn60MGVNrUMp2fpnMGPM49g8q0lwBFMl2zWNLQ=;
 b=hLW/giJ/bKVrDDIcWTV3cpd57QUfF4lforfpWGk7MixCgpJpAPnPzAn/KH/x3emIMd
 M/5dpWkhYezyVa4/pLYcI9OrNyAPOaPOK6AgBwuKD3pvpYaigXvhHztPgtF5Tf0yrwvw
 zb1uRdTbDsYPkmOteA9/pZkzEIgUMRDDhAVqNdAxw5//dK+qxnqb4jtROuHVz1jl2pIM
 sRD5bpbP8zALsxfEbVgys/HR7QhGrQoS7glRfDLe7XSd96luRznXMSjlsqKJ53YUvh6B
 RDbAEw45seeGsm+0QN5jHxGWs03YSfw07sYd4PLZWBDgXsOhVmNKfo9E9qluIorqsq73
 TeHA==
X-Gm-Message-State: AOAM530Fb5H2x8srOnjCyxDIY6PVFH32qsJAiV/CBzT8YAoa9cWcnz1+
 AgwlFJlNbCEDAawrnCNvpB0jADFCKqq/Ozj7aFVKd7yja78nwGHN54o7dqfkFEyiEE6cPvjGbqn
 eLR4vqw72Oecz+20=
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr15744035wme.16.1597669893223; 
 Mon, 17 Aug 2020 06:11:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWAc5EOTYEAjIJRxr6vWuWDG8Goo+slLHtJDqo/8LeHXTw0RUYqPJhb7uboABDjQKQoY6kBw==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr15744007wme.16.1597669892905; 
 Mon, 17 Aug 2020 06:11:32 -0700 (PDT)
Received: from steredhat ([5.170.34.38])
 by smtp.gmail.com with ESMTPSA id b139sm31643031wmd.19.2020.08.17.06.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 06:11:32 -0700 (PDT)
Date: Mon, 17 Aug 2020 15:11:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200817131128.lgxn3pyzuzly4edp@steredhat>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
 <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
 <20200817122746.0b786372.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200817122746.0b786372.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 12:27:46PM +0200, Cornelia Huck wrote:
> On Thu, 13 Aug 2020 14:04:15 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Thu, Aug 13, 2020 at 12:37:37PM +0200, Cornelia Huck wrote:
> > > On Thu, 13 Aug 2020 12:24:30 +0200
> > > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >   
> > > > On Thu, Aug 13, 2020 at 11:28:20AM +0200, Cornelia Huck wrote:  
> > > > > We basically have three possible ways to deal with this:
> > > > > 
> > > > > - Force it to modern (i.e., what you have been doing; would need the
> > > > >   equivalent changes in ccw as well.)    
> > > > 
> > > > Oo, thanks for pointing out ccw!
> > > > I don't know ccw well, in this case should we set dev->max_rev to 1 or 2
> > > > to force to modern?  
> > > 
> > > No, ->max_rev is the wrong side of the limit :) You want  
> > 
> > Well :-) Thanks!
> > 
> > > 
> > >     ccw_dev->force_revision_1 = true;
> > > 
> > > in _instance_init() (see e.g. virtio-ccw-gpu.c).
> > >   
> > > >   
> > > > >   Pro: looks like the cleanest approach.
> > > > >   Con: not sure if we would need backwards compatibility support,
> > > > >   which looks hairy.    
> > > > 
> > > > Not sure too.  
> > > 
> > > Yes, I'm not sure at all how to handle user-specified values for
> > > legacy/modern.
> 
> Thinking a bit more about it, I'm not sure whether we even *can*
> provide backwards compatibility: we have different autoconfigurations
> for PCI based upon where it is plugged, and ccw does not have a way to
> turn legacy on/off, except from within the code.

Yes, I discovered today for example that the PCIe bus set auto-legacy
mode to off.

> 
> > >   
> > > >   
> > > > > - Add vsock to the list of devices with legacy support.
> > > > >   Pro: Existing setups continue to work.
> > > > >   Con: If vsock is really virtio-1-only, we still carry around
> > > > >   possibly broken legacy support.    
> > > > 
> > > > I'm not sure it is virtio-1-only, but virtio-vsock was introduced in
> > > > 2016, so I supposed it is modern-only.  
> > > 
> > > Yes, I would guess so as well.
> > >   
> > > > 
> > > > How can I verify that? Maybe forcing legacy mode and run some tests.  
> > > 
> > > Probably yes. The likeliest area with issues is probably endianness, so
> > > maybe with something big endian in the mix?
> > >   
> > 
> > Yeah, I'll try this setup!
> > 
> > > >   
> > > > > - Do nothing, have users force legacy off. Bad idea, as ccw has no way
> > > > >   to do that on the command line.
> > > > > 
> > > > > The first option is probably best.
> 
> The first option is now "force modern, but with no backwards
> compatibility", which is not that great; but "allow legacy, even though
> it should not exist" is not particularly appealing, either... what a
> mess :(

Yeah, it's a mess :-( anyway I still prefer option 1, it seems a little
bit more correct to me.

> 
> > > > >    
> > > > 
> > > > Yeah, I agree with you!  
> > > 
> > > Yes, it's really a pity we only noticed this after the release; this
> > > was supposed to stop new devices with legacy support creeping in, not
> > > to break existing command lines :(
> > >   
> > 
> > Yes, I forgot to test vsock stuff before the release :-(
> > Maybe we should add some tests...
> 
> Speaking of tests: do you have a quick way to test vhost-vsock at hand?
> Maybe I should add it to my manual repertoire...
> 

Sure, maybe the quickest way is to use ncat. Starting from version 7.80,
it supports AF_VSOCK sockets:

    host$ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5

    host$ ncat --vsock -l 1234

    # vsock address is <cid, port>, cid=2 is used always to reach the host
    guest$ ncat --vsock 2 1234

Other tests that I usually run are:
- iperf-vsock: https://github.com/stefano-garzarella/iperf-vsock
- vsock test suite in the Linux kernel (tools/testing/vsock)

Let me know if you want more details on these :-)

Thanks,
Stefano


