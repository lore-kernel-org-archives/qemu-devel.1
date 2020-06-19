Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC4AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AAA208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEGiKC36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AAA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKhD-0005EY-Nq
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmKdC-00068Q-N8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmKdA-00061u-SY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592587004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tN3Ij5wzTKQaU0Ddmdd6o/1UsrLQev6hzXuBwg3HRBI=;
 b=WEGiKC360f6ogqzJwN0UhDVD8drXK931QFnJyzGuYeps/R38O0b1IaoiE79AmW7uzgX0AS
 tbOvODEEJ+pzRD69TQ6ygG5pOBCU5av4PGJ0Xo4gJdUSJa11nr+Myp1geOVWgsPMSARVvS
 lxUcoHy8iN1n3JIYmiD1A+m7fUPngDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-FVHOaU_YMA-ulL0g2UB7bg-1; Fri, 19 Jun 2020 13:16:42 -0400
X-MC-Unique: FVHOaU_YMA-ulL0g2UB7bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F1E1005512;
 Fri, 19 Jun 2020 17:16:41 +0000 (UTC)
Received: from work-vm (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56E3271662;
 Fri, 19 Jun 2020 17:16:34 +0000 (UTC)
Date: Fri, 19 Jun 2020 18:16:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619171631.GK2690@work-vm>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com> <20200619082746.GA2690@work-vm>
 <20200619160923.GD3154@redhat.com> <20200619161648.GJ2690@work-vm>
 <20200619171121.GE3154@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619171121.GE3154@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Fri, Jun 19, 2020 at 05:16:48PM +0100, Dr. David Alan Gilbert wrote:
> 
> [..]
> > > > > >   b) If something nasty was to write junk into the trusted attributes,
> > > > > >     what would happen?
> > > > > 
> > > > > This directory is owned by guest. So it should be able to write
> > > > > anything it wants, as long as process in guest has CAP_SYS_ADMIN, right?
> > > > 
> > > > Well, we shouldn't be able to break/crash/escape into the host; how
> > > > much does overlayfs validate trusted.* it uses?
> > > 
> > > I thought qemu and kvm are the one who should ensure we should not be
> > > able to break out of sandbox. Kernel implementation could be as 
> > > buggy as it wanted to be. We are working with this security model
> > > that kernel is completely untrusted.
> > 
> > But with virtiofs we allow the guest to do a lot of filesystem
> > operations on the host.  It's the virtiofsd that has to ensure that
> > these are safe and contained within the fs it's exposed; the qemu/kvm
> > can't protect us from that.
> 
> Fair enough. I should have added virtiofsd to list. Its an attack
> vector and is of concern.
> 
> > 
> > That's why we sandbox the virtiofsd like we do - if we allow a
> > priviliged guest to perform calls to an unconstrained virtiofsd it would
> > be able to escape.  That's what I want to check.
> 
> Sure. So does giving CAP_SYS_ADMIN to virtiofsd allow daemon to escape
> the jail.

So that's *my* question - what bad things can someone do by setting
attributes (trusted/system/security) - it's fine if they break they
screwup the security inside the container, because they'd need to be
CAP_SYS_ADMIN inside the container to do it - as long as they can't
break the host.  So what happens if someone starts doing bad things to
trusted.* attributes on an overlayfs - no other fs uses them as far as I
know.

> If it does we need to implement what crossvm folks did,
> remapping of trusted xattr. That will also allow us to run inside
> user namespace and still be able to support trusted xattr emulation
> for guest.

I think we need to do that anyway, it's just going to take a while to
figure out.

Dave

> 
> Vivek
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


