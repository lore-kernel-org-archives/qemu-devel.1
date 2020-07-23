Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259E8C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF11C206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7MWoode"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF11C206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfT3-0007Uh-5C
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyfRh-0006HN-Be
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:55:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyfRf-0005ES-B6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595526950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5zZIOzo0xbLxcEsrvSl5ftAFYw3udlEjXVl0+lNTWA=;
 b=I7MWoodecTxpqRjmOKDQ3uLdBFVjoU6NIopVkofveiOXISniiaT8x89VKI1+bJAYT6BL1g
 /ibWnJ/oqkAoMJrhKHuML/0AHpyliHZjmhWbRyx34pB2sMcZ3dVegHoq2Yb0h2/MdpQSMD
 wL4TEWwT7nHDUzgxRGJRS1fvFQXuqcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-oKIlY2sRMr2p7TVDJWXU1g-1; Thu, 23 Jul 2020 13:55:47 -0400
X-MC-Unique: oKIlY2sRMr2p7TVDJWXU1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119CC57
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:55:47 +0000 (UTC)
Received: from work-vm (ovpn-114-148.ams2.redhat.com [10.36.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 636E760E1C;
 Thu, 23 Jul 2020 17:55:40 +0000 (UTC)
Date: Thu, 23 Jul 2020 18:55:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Message-ID: <20200723175538.GW2621@work-vm>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722190318.GM2660@work-vm>
 <20200723123229.GK186372@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200723123229.GK186372@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com, qemu-devel@nongnu.org,
 vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Jul 22, 2020 at 08:03:18PM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > +    /*
> > > +     * Make the shared directory the file system root so that FUSE_OPEN
> > > +     * (lo_open()) cannot escape the shared directory by opening a symlink.
> > > +     *
> > > +     * It's still possible to escape the chroot via lo->proc_self_fd but that
> > > +     * requires gaining control of the process first.
> > > +     */
> > > +    if (chroot(lo->source) != 0) {
> > > +        fuse_log(FUSE_LOG_ERR, "chroot(\"%s\"): %m\n", lo->source);
> > > +        exit(1);
> > > +    }
> > 
> > I'm seeing suggestions that you should drop CAP_SYS_CHROOT after
> > chroot'ing to stop an old escape (where you create another jail inside
> > the jail and the kernel then lets you walk outside of the old one).
> 
> That's already the case:
> 
> 1. setup_seccomp() blocks further chroot(2) calls.
> 2. setup_capabilities() drops CAP_SYS_CHROOT.

Ah yes; could you add a comment if you respin; it's not obvious that
the capability to chroot allows you to break out of an existing chroot
you're in.

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


