Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E60C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7927F206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4WOdCfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927F206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Wdp-0005li-OK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 16:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0Wcc-00056Y-74
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 16:54:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0WcX-0000Nr-4m
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 16:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595969683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30ReC8xo3Z5FpSXgaCMaoDEmP0hOSpOuYARATl3+TEw=;
 b=O4WOdCfXR86IJKZROQ/PwkJHwtYdy5wVzcn7PokC2rZQ7g9XH9ScUsLRFi5G1Ivf1gJq1M
 vDCK5u39Ei4nJIEBWZr6V6UiO65K+y1IaXTCQz5n6Wy59+4dl0Uu62YDVfkKef5jAx86qg
 Yezwxj2IvGz1EBEJ9rw5ub7ChXOGiG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-1oN1AiWMN0yxjSp3dNO3eg-1; Tue, 28 Jul 2020 16:54:32 -0400
X-MC-Unique: 1oN1AiWMN0yxjSp3dNO3eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4481F101C8AB;
 Tue, 28 Jul 2020 20:54:31 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-119.rdu2.redhat.com [10.10.116.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9657A8A16A;
 Tue, 28 Jul 2020 20:54:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 250EA220204; Tue, 28 Jul 2020 16:54:25 -0400 (EDT)
Date: Tue, 28 Jul 2020 16:54:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200728205425.GE78409@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
 <20200728155233.GC3443476@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200728155233.GC3443476@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.74; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 16:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 28, 2020 at 04:52:33PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 28, 2020 at 09:12:50AM -0400, Vivek Goyal wrote:
> > On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> > > On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> > > misono.tomohiro@fujitsu.com> wrote:
> > > 
> > > > > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
> > > > error
> > > > >
> > > > > An assertion failure is raised during request processing if
> > > > > unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
> > > > > be detected right away.
> > > > >
> > > > > Unfortunately Docker/Moby does not include unshare in the seccomp.json
> > > > > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > > > > include unshare (e.g. podman is unaffected):
> > > > >
> > > > https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json
> > > > >
> > > > > Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if the
> > > > > default seccomp.json is missing unshare.
> > > >
> > > > Hi, sorry for a bit late.
> > > >
> > > > unshare() was added to fix xattr problem:
> > > >
> > > > https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#
> > > > In theory we don't need to call unshare if xattr is disabled, but it is
> > > > hard to get to know
> > > > if xattr is enabled or disabled in fv_queue_worker(), right?
> > > >
> > > >
> > > In kubevirt we want to run virtiofsd in containers. We would already not
> > > have xattr support for e.g. overlayfs in the VM after this patch series (an
> > > acceptable con at least for us right now).
> > > If we can get rid of the unshare (and potentially of needing root) that
> > > would be great. We always assume that everything which we run in containers
> > > should work for cri-o and docker.
> > 
> > But cri-o and docker containers run as root, isn't it? (or atleast have
> > the capability to run as root). Havind said that, it will be nice to be able
> > to run virtiofsd without root. 
> > 
> > There are few hurdles though.
> > 
> > - For file creation, we switch uid/gid (seteuid/setegid) and that seems
> >   to require root. If we were to run unpriviliged, probably all files
> >   on host will have to be owned by unpriviliged user and guest visible
> >   uid/gid will have to be stored in xattrs. I think virtfs supports
> >   something similar.
> 
> I think I've mentioned before, 9p virtfs supports different modes,
> passthrough, squashed or remapped.
> 
> passthrough should be reasonably straightforward to support in virtiofs.
> The guest sees all the host UID/GIDs ownership as normal, and can read
> any files the host user can read, but are obviously restricted to write
> to only the files that host user can write too. No DAC-OVERRIDE facility
> in essence. You'll just get EPERM, which is fine. This simple passthrough
> scenario would be just what's desired for a typical desktop virt use
> cases, where you want to share part/all of your home dir with a guest for
> easy file access. Personally this is the mode I'd be most interested in
> seeing provided for unprivileged virtiofsd usage.

Interesting. So passthrough will have two sub modes. priviliged and
unpriviliged. As of now we support priviliged passthrough. 

I guess it does make sense to look into unpriviliged passthrough
and see what other operations will not be allowed.

Thanks
Vivek

> 
> squash is similar to passthrough, except the guest sees everything
> as owned by the same user. This can be surprising as the guest might
> see a file owned by them, but not be able to write to it, as on the
> host its actually owned by some other user. Fairly niche use case
> I think.
> 
> remapping would be needed for a more general purpose use cases
> allowing the guest to do arbitrary UID/GID changes, but on the host
> everything is still stored as one user and remapped somehow.
> 
> The main challenge for all the unprivileged scenarios is safety of
> the sandbox, to avoid risk of guests escaping to access files outside
> of the exported dir via symlink attacks or similar.
> 
> 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


