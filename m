Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC39C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DD22075A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I09+YTkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DD22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Rwa-00079b-Ll
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0Rui-0003ts-R9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:53:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k0Rug-0006iD-PJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595951589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uBS8YEWffvMUWoBUUD4xWGkSiT7xmymi9OHV+NJxygU=;
 b=I09+YTkMEx4inFwNf9ff/lbTSTqrlWkPraCEpOTIMNMuUDvwFcAgqp6sDY+INXUADn+lXw
 WchTnHy1qMn+snZDpJecMF33SDIYstqrNc7olh9Ul0UC9UAkfUvVAhb2fLhKfpRi6I9P4Z
 16OgE0/E5XTrROxRXOR1qQaSddMH2gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-iyB_fjy0M-y-jHBvzacCBA-1; Tue, 28 Jul 2020 11:53:00 -0400
X-MC-Unique: iyB_fjy0M-y-jHBvzacCBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 730E379ED9;
 Tue, 28 Jul 2020 15:52:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C94C90E96;
 Tue, 28 Jul 2020 15:52:36 +0000 (UTC)
Date: Tue, 28 Jul 2020 16:52:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200728155233.GC3443476@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200728131250.GB78409@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>, Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 Roman Mohr <rmohr@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 09:12:50AM -0400, Vivek Goyal wrote:
> On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> > On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> > misono.tomohiro@fujitsu.com> wrote:
> > 
> > > > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
> > > error
> > > >
> > > > An assertion failure is raised during request processing if
> > > > unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
> > > > be detected right away.
> > > >
> > > > Unfortunately Docker/Moby does not include unshare in the seccomp.json
> > > > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > > > include unshare (e.g. podman is unaffected):
> > > >
> > > https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json
> > > >
> > > > Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if the
> > > > default seccomp.json is missing unshare.
> > >
> > > Hi, sorry for a bit late.
> > >
> > > unshare() was added to fix xattr problem:
> > >
> > > https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#
> > > In theory we don't need to call unshare if xattr is disabled, but it is
> > > hard to get to know
> > > if xattr is enabled or disabled in fv_queue_worker(), right?
> > >
> > >
> > In kubevirt we want to run virtiofsd in containers. We would already not
> > have xattr support for e.g. overlayfs in the VM after this patch series (an
> > acceptable con at least for us right now).
> > If we can get rid of the unshare (and potentially of needing root) that
> > would be great. We always assume that everything which we run in containers
> > should work for cri-o and docker.
> 
> But cri-o and docker containers run as root, isn't it? (or atleast have
> the capability to run as root). Havind said that, it will be nice to be able
> to run virtiofsd without root. 
> 
> There are few hurdles though.
> 
> - For file creation, we switch uid/gid (seteuid/setegid) and that seems
>   to require root. If we were to run unpriviliged, probably all files
>   on host will have to be owned by unpriviliged user and guest visible
>   uid/gid will have to be stored in xattrs. I think virtfs supports
>   something similar.

I think I've mentioned before, 9p virtfs supports different modes,
passthrough, squashed or remapped.

passthrough should be reasonably straightforward to support in virtiofs.
The guest sees all the host UID/GIDs ownership as normal, and can read
any files the host user can read, but are obviously restricted to write
to only the files that host user can write too. No DAC-OVERRIDE facility
in essence. You'll just get EPERM, which is fine. This simple passthrough
scenario would be just what's desired for a typical desktop virt use
cases, where you want to share part/all of your home dir with a guest for
easy file access. Personally this is the mode I'd be most interested in
seeing provided for unprivileged virtiofsd usage.

squash is similar to passthrough, except the guest sees everything
as owned by the same user. This can be surprising as the guest might
see a file owned by them, but not be able to write to it, as on the
host its actually owned by some other user. Fairly niche use case
I think.

remapping would be needed for a more general purpose use cases
allowing the guest to do arbitrary UID/GID changes, but on the host
everything is still stored as one user and remapped somehow.

The main challenge for all the unprivileged scenarios is safety of
the sandbox, to avoid risk of guests escaping to access files outside
of the exported dir via symlink attacks or similar.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


