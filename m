Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F23C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78372080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbBC+IH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78372080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEyb-0002xP-38
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmExB-0002GO-No
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:13:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmExA-0006bj-18
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592565178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+3IdncLpSdgrE0xzGf/jKBl5+pdz+ph5+8dK/BLOCA=;
 b=IbBC+IH1NR2XB7gIY/4Wcipx4L99pwDijiIanxbV//4ixDRSX9CtBJw4buHtZu35ZhN5I/
 wHZR85OflxFq8ZCbXAkWU6UXTPH+stqUjXqbl5EHTAHLZlT8b32e3CB82r+KcK+YTat3jP
 t9T1+unkUPOFEDtEjwq1tUFIpJfNKu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-ckN5wm1EMp2Qzb9M7ILWFw-1; Fri, 19 Jun 2020 07:12:57 -0400
X-MC-Unique: ckN5wm1EMp2Qzb9M7ILWFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C39484B8A0;
 Fri, 19 Jun 2020 11:12:56 +0000 (UTC)
Received: from work-vm (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 570B85C1D6;
 Fri, 19 Jun 2020 11:12:47 +0000 (UTC)
Date: Fri, 19 Jun 2020 12:12:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619111244.GE2690@work-vm>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com>
 <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
 <20200619083953.GB2690@work-vm>
 <CAJFHJrpRGJ=myQzJtxjgQhHdbyhGXhz_N24=xJTKM4JqhhZG2g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJrpRGJ=myQzJtxjgQhHdbyhGXhz_N24=xJTKM4JqhhZG2g@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chirantan Ekbote (chirantan@chromium.org) wrote:
> On Fri, Jun 19, 2020 at 5:40 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Chirantan Ekbote (chirantan@chromium.org) wrote:
> >
> > > We ended up working around it by prefixing "user.virtiofs." to the
> > > xattr name[2], which has its own problems but there was pretty much no
> > > chance that we would be able to give the fs device CAP_SYS_ADMIN in
> > > the init namespace.
> >
> >
> > What problems did you hit with that?  We should standardise the renaming
> > so we make an on-disc format that's compatible.
> >
> 
> I guess what I meant by problems is that it made what was previously a
> simple and straightforward implementation into something more complex
> and added some limitations.

Yeh.

>  For example, we now need to parse the
> result of the listxattr system call and strip out the prefix from any
> name in the list.  It also means that we cannot allow the guest to
> directly set or remove any "user.virtiofs." xattr as this would allow
> an unprivileged process in the vm to modify an xattr that it wouldn't
> otherwise be allowed to modify.  On top of being a somewhat arbitrary
> restriction this also means that you can't have stacked virtiofs
> instances as the lower instance would reject attempts by the upper one
> to set those xattrs.  These limitations aren't really a problem for us
> but I can see how they might be a problem for others.

Isn't this a classic escaping problem?
Would it work if you prepended  'user.virtiofs.' onto any xattr
that started with 'trusted' or 'user.virtiofs.' ?

> The change was also merged just yesterday so there may be other
> problems with it that haven't surfaced yet.
> 
> I didn't mention it before because I figured this was something that
> we brought upon ourselves as chrome os is a bit extreme about
> sandboxing. 

I think we're trying to be as extreme in virtiofsd, but it is causing us
similar problems.

> If we can come up with a standardized way to handle this
> I think we'll gladly switch the chrome os implementation to use it.

Great!

Dave

> 
> Chirantan
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


