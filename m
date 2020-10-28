Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA45C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3ED24694
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaS46vYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3ED24694
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhem-0000Ql-Cd
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kXhc1-000782-3u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kXhbz-0007MJ-7q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603876757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGlxmwrrPezV6ZqU5VKrATLLUrVnbAli2WafxuORVos=;
 b=VaS46vYNR6fUro7N9GOIiHeAFhT+F73Zc+Mbi8lohaokjhUYNtoITPD8sqzbvxNKJIcCGB
 BipiUBSLR7xTUmy/acLd5v4SDalxSlAxChEDixTXUIjqukOk4B8PIlsMth4Nhrz0iCIyZE
 wmCMdu4FYKKTsglp/euOGDEF47nElwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-BpPU1Bn1P0m8JptYTiqPBg-1; Wed, 28 Oct 2020 05:22:09 -0400
X-MC-Unique: BpPU1Bn1P0m8JptYTiqPBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78B978049DE;
 Wed, 28 Oct 2020 09:19:13 +0000 (UTC)
Received: from work-vm (ovpn-114-240.ams2.redhat.com [10.36.114.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75FD81002C11;
 Wed, 28 Oct 2020 09:19:02 +0000 (UTC)
Date: Wed, 28 Oct 2020 09:18:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>, mszeredi@redhat.com
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
Message-ID: <20201028091859.GA3701@work-vm>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA8yBrUH-Bqe7oNhBKqtyeUNw0xVA9aKm8DJFE-WLzLTwQ@mail.gmail.com>
 <20201027200021.00fac851@x1.home>
MIME-Version: 1.0
In-Reply-To: <20201027200021.00fac851@x1.home>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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
Cc: Artem Polyakov <artemp@nvidia.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Neo Jia <cjia@nvidia.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Tue, 27 Oct 2020 23:42:57 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Mon, 26 Oct 2020 at 19:39, Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > > ----------------------------------------------------------------
> > > VFIO update 2020-10-26
> > >
> > >  * Migration support (Kirti Wankhede)
> > >  * s390 DMA limiting (Matthew Rosato)
> > >  * zPCI hardware info (Matthew Rosato)
> > >  * Lock guard (Amey Narkhede)
> > >  * Print fixes (Zhengui li)  
> > 
> > I get a conflict here in
> > include/standard-headers/linux/fuse.h:
> > 
> > ++<<<<<<< HEAD
> >  +#define FUSE_ATTR_FLAGS               (1 << 27)
> > ++=======
> > + #define FUSE_SUBMOUNTS                (1 << 27)
> > ++>>>>>>> remotes/awilliam/tags/vfio-update-20201026.0  
> > 
> > I assume these should not both be trying to use the same value,
> > so something has gone wrong somewhere. The conflicting commit
> > now in master is Max's 97d741cc96dd08 ("linux/fuse.h: Pull in from Linux").
> > 
> > Can you sort out the correct resolution between you, please?
> > (My guess is that Max's commit is the erroneous one because
> > it doesn't look like it was created via a standard update
> > from the kernel headers.)

Eww that's messy; copying in Miklos to see what's going on.

> So as near as I can tell, QEMU commit 97d741cc96dd ("linux/fuse.h: Pull
> in from Linux") is fantasy land.  The only thing I can find of this
> FUSE_ATTR_FLAGS outside Max's QEMU series is this[1] posting where the
> fuse maintainer announces that he's replaced FUSE_ATTR_FLAGS with
> FUSE_SUBMOUNTS, but the usage is "slightly different".  Reading that
> thread, it seems that virtiofsd probably needed an update but I can't
> see that it ever happened.
> 
> I'm not comfortable trying to update Max's series to try to determine
> if FUSE_SUBMOUNTS can be interchanged with FUSE_ATTR_FLAGS, where the
> latter appears to be used to express the new field in struct fuse_attr
> exists, but the former appears to be a feature.  My guess would be that
> maybe FUSE_KERNEL_MINOR_VERSION needs to be tested instead for this new
> field??

They're part of the init flags sent in the negotiation; so they should
be fine.

> Anyway, I hate to pull the big hammer, but I think Max's series is
> bogus.  The only thing I can propose is to revert it in its entirety,
> after which this series applies cleanly.  I'll post a patch to do that
> as I think the code currently in master is on pretty shaky ground with
> respect to interpreting flag bits differently from those the kernel
> defines.  Thanks,

Yeh the kernel header is king in the definition of those flags.
It maybe bet, but I'd like to see what Miklos says.

Dave

> Alex
> 
> [1] https://marc.info/?l=fuse-devel&m=160069539811247
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


