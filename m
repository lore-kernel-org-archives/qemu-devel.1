Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27266C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0F4206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUac7s28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0F4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PQd-00051B-5v
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0PPr-0004Ip-GZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:13:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0PPo-00076Y-Vd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595941988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmvMB+kuTOvKTA8kbs9YH85JIq/zGUGX9uhf0xoJxSY=;
 b=hUac7s28n2vRlkJ5lrZTkNFSxDeGkM+g5GSLlvxnA7xX7o12hPvnvqvYcPYV+t/B/7tJyN
 xOjmOYmpJDS7bAdvG4AZnsB0H3qXIXafeq8Xk3Zf8+VZeLc+LMpDhg/gvzbGhtIPn+C4RQ
 hd1Xk44hAkDa0fDHt/O0m3pIwYNcUlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-fGyXt2u0OGKTdLiPUl74WQ-1; Tue, 28 Jul 2020 09:13:04 -0400
X-MC-Unique: fGyXt2u0OGKTdLiPUl74WQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6111C100CC99;
 Tue, 28 Jul 2020 13:12:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-119.rdu2.redhat.com [10.10.116.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AFD05D9E8;
 Tue, 28 Jul 2020 13:12:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id A6D80220204; Tue, 28 Jul 2020 09:12:50 -0400 (EDT)
Date: Tue, 28 Jul 2020 09:12:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Roman Mohr <rmohr@redhat.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200728131250.GB78409@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:05:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> misono.tomohiro@fujitsu.com> wrote:
> 
> > > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
> > error
> > >
> > > An assertion failure is raised during request processing if
> > > unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
> > > be detected right away.
> > >
> > > Unfortunately Docker/Moby does not include unshare in the seccomp.json
> > > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > > include unshare (e.g. podman is unaffected):
> > >
> > https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json
> > >
> > > Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if the
> > > default seccomp.json is missing unshare.
> >
> > Hi, sorry for a bit late.
> >
> > unshare() was added to fix xattr problem:
> >
> > https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#
> > In theory we don't need to call unshare if xattr is disabled, but it is
> > hard to get to know
> > if xattr is enabled or disabled in fv_queue_worker(), right?
> >
> >
> In kubevirt we want to run virtiofsd in containers. We would already not
> have xattr support for e.g. overlayfs in the VM after this patch series (an
> acceptable con at least for us right now).
> If we can get rid of the unshare (and potentially of needing root) that
> would be great. We always assume that everything which we run in containers
> should work for cri-o and docker.

But cri-o and docker containers run as root, isn't it? (or atleast have
the capability to run as root). Havind said that, it will be nice to be able
to run virtiofsd without root. 

There are few hurdles though.

- For file creation, we switch uid/gid (seteuid/setegid) and that seems
  to require root. If we were to run unpriviliged, probably all files
  on host will have to be owned by unpriviliged user and guest visible
  uid/gid will have to be stored in xattrs. I think virtfs supports
  something similar.

I am sure there are other restrictions but this probably is the biggest
one to overcome.

 > 
> "Just" pointing docker to a different seccomp.json file is something which
> k8s users/admin in many cases can't do.

Or may be issue is that standard seccomp.json does not allow unshare()
and hence you are forced to use a non-standar seccomp.json.

Vivek

> 
> Best Regards,
> Roman
> 
> 
> > So, it looks good to me.
> > Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> >
> > Regards,
> > Misono
> >
> > >
> > > Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/tools/virtiofsd/fuse_virtio.c
> > b/tools/virtiofsd/fuse_virtio.c
> > > index 3b6d16a041..9e5537506c 100644
> > > --- a/tools/virtiofsd/fuse_virtio.c
> > > +++ b/tools/virtiofsd/fuse_virtio.c
> > > @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session *se)
> > >  {
> > >      int ret;
> > >
> > > +    /*
> > > +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will need
> > it. It's
> > > +     * an unprivileged system call but some Docker/Moby versions are
> > known to
> > > +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> > > +     *
> > > +     * Note that the program is single-threaded here so this syscall
> > has no
> > > +     * visible effect and is safe to make.
> > > +     */
> > > +    ret = unshare(CLONE_FS);
> > > +    if (ret == -1 && errno == EPERM) {
> > > +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EPERM. If
> > "
> > > +                "running in a container please check that the container
> > "
> > > +                "runtime seccomp policy allows unshare.\n");
> > > +        return -1;
> > > +    }
> > > +
> > >      ret = fv_create_listen_socket(se);
> > >      if (ret < 0) {
> > >          return ret;
> > > --
> > > 2.26.2
> >
> >


