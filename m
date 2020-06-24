Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823FD20768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhV2/Mu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823FD20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6qQ-0000LM-LZ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo6pe-0007uI-Pc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:56:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo6pc-0002XB-U0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593010615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QsXSoUM4XsQ41gd4Lxcxe4wV0d1O9gsWuRDQGYIXFd8=;
 b=FhV2/Mu4UgdhdR7DTBiYHpLcMJw7a7BNMT6UeBEkNCJwWXO+wAsjzDWq8nKYT88aigCqKD
 /jzShCyboKQN+wswq+AcSHVv1jVVPTjdi7IqQll5YCFVpzzcb622B8qg15fBOzM/XqaWqV
 Vt2EKFmDenPywXqcyIyfWByF/XSsEis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-ksPJ7TIUPOOr2kZz2hNGzQ-1; Wed, 24 Jun 2020 10:56:54 -0400
X-MC-Unique: ksPJ7TIUPOOr2kZz2hNGzQ-1
Received: by mail-wm1-f69.google.com with SMTP id a21so2771638wmd.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QsXSoUM4XsQ41gd4Lxcxe4wV0d1O9gsWuRDQGYIXFd8=;
 b=A6OIyFEB+GZDhKlKZyowGLmhMBHHDpkwHgGON9H44RMkGcMy7bF2MiBQyhMqfqqCmC
 U/TnANgjID99jTNkkJ2BjFhBNLY9BWjH0XprR/Z7LqFLYJ7yPYpwvpxn/BsnzZJIpF7t
 PQq2p84qwXB2Amsl/0DgyAXHNhoU9782KgecevzSxtE+f0VOogAEEdQIWpggfVNKxobx
 YHO7WZZBzpbQokCDgwprQvoXpM7tkYehZB8BxcX2KQt/T8C/rtdERYLPB20bHbXpubqX
 RRL5mqMnmU3PV6XNVSA6/0dMopvAutcOr5Ch2bYL2bmFVKGnwb2q3Sb0YJisCDKfIwzk
 IcOQ==
X-Gm-Message-State: AOAM533a0dz3h3qpFhRj2iaTrnw1+fHldZa/zv7xvJ2xPGdLC1cDQLhA
 DCE7g/kx8TFuTMKq5EGsjpIcbRJlbR0WXXspiZzHzJoZuEYOm5xy4lhVzwK6aU8q2RcIQ3Re0cQ
 MHyfiJMDnfofO6kg=
X-Received: by 2002:a5d:498f:: with SMTP id r15mr33595597wrq.175.1593010612866; 
 Wed, 24 Jun 2020 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTkSWp/ZLKltPbd6j54lCFAi3z6NTd2ZXLKH2dvj8E/X21/zdahiR1/CIILoPhgIiXARL1DQ==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr33595570wrq.175.1593010612581; 
 Wed, 24 Jun 2020 07:56:52 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id r12sm27185507wrc.22.2020.06.24.07.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:56:51 -0700 (PDT)
Date: Wed, 24 Jun 2020 10:56:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Message-ID: <20200624103559-mutt-send-email-mst@kernel.org>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 07:10:43PM +0200, David Hildenbrand wrote:
> >>
> >> Ugh, ...
> >>
> >> @MST, you might have missed that in another discussion, what's your
> >> general opinion about removing free page hinting in QEMU (and Linux)? We
> >> keep finding issues in the QEMU implementation, including non-trivial
> >> ones, and have to speculate about the actual semantics. I can see that
> >> e.g., libvirt does not support it yet.
> > 
> > Not maintaining two similar features sounds attractive.
> 
> I consider free page hinting (in QEMU) to be in an unmaintainable state
> (and it looks like Alex and I are fixing a feature we don't actually
> intend to use / not aware of users). In contrast to that, the free page
> reporting functionality/implementation is a walk in the park.

So at the high level the idea was simple, we just clear the dirty bit
when page is hinted, unless we sent a new command since. Implementation
was reviewed by migration maintainers. If there's a consensus the code
is written so badly we can't maintain it, maybe we should remove it.
Which parts are unmaintainable in your eyes - migration or virtio ones?
Or maybe it's the general thing that interface was never specced
properly.

> > 
> > I'm still trying to get my head around the list of issues.  So far they
> > all look kind of minor to me.  Would you like to summarize them
> > somewhere?
> 
> Some things I still have in my mind

Thanks for the summary!

> 
> 1. If migration fails during RAM precopy, the guest will never receive a
> DONE notification. Probably easy to fix.
> 
> 2. Unclear semantics. Alex tried to document what the actual semantics
> of hinted pages are.

I'll reply to that now.

> Assume the following in the guest to a previously
> hinted page
> 
> /* page was hinted and is reused now */
> if (page[x] != Y)
> 	page[x] == Y;
> /* migration ends, we now run on the destination */
> BUG_ON(page[x] != Y);
> /* BUG, because the content chan

The assumption hinting makes is that data in page is writtent to before it's used.


> A guest can observe that. And that could be a random driver that just
> allocated a page.
> 
> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> sure, also, the actual semantics to document are unclear - e.g., for
> other guests)

I think it's basically simple: hinting means it's ok to
fill page with trash unless it has been modified since the command
ID supplied.

> As Alex mentioned, it is not even guaranteed in QEMU that we receive a
> zero page on the destination, it could also be something else (e.g.,
> previously migrated values).


Absolutely.

> 3. If I am not wrong, the iothread works in
> virtio_ballloon_get_free_page_hints() on the virtqueue only with holding
> the free_page_lock (no BQL).
> 
> Assume we're migrating, the iothread is active, and the guest triggers a
> device reset.
> 
> virtio_balloon_device_reset() will trigger a
> virtio_balloon_free_page_stop(s). That won't actually wait for the
> iothread to stop, it will only temporarily lock free_page_lock and
> update s->free_page_report_status.
> 
> I think there can be a race between the device reset and the iothread.
> Once virtio_balloon_free_page_stop() returned,
> virtio_ballloon_get_free_page_hints() can still call
> - virtio_queue_set_notification(vq, 0);
> - virtio_queue_set_notification(vq, 1);
> - virtio_notify(vdev, vq);
> - virtqueue_pop()
> 
> I doubt this is very nice.

Reset is notoriously hard to get right.

> There are other concerns I had regarding the iothread (e.g., while
> reporting is active, virtio_ballloon_get_free_page_hints() is
> essentially a busy loop, in contrast to documented -
> continue_to_get_hints will always be true).

So that would be a performance issue you are suggesting, right?

> > The appeal of hinting is that it's 0 overhead outside migration,
> > and pains were taken to avoid keeping pages locked while
> > hypervisor is busy.
> > 
> > If we are to drop hinting completely we need to show that reporting
> > can be comparable, and we'll probably want to add a mode for
> > reporting that behaves somewhat similarly.
> 
> Depends on the actual users. If we're dropping a feature that nobody is
> actively using, I don't think we have to show anything.


I don't know how to find out. So far it doesn't look like we found
any common data corruptions that would indicate no one can use it safely.
Races around reset aren't all that uncommon but I don't think that
qualifies as a deal breaker.

I find the idea of asynchronously sending hints to host without
waiting for them to be processed intriguing. Not something
I'd work on implementing if we had reporting originally,
but since it's there I'm not sure we should just discard it
at this point.

> This feature obviously saw no proper review.

I did my best but obviously missed some things.

> -- 
> Thanks,
> 
> David / dhildenb


