Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED96221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfhCzt+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED96221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k44L3-0001Gc-7J
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k44K3-0000Sk-1m
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:30:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k44Jz-0003VS-Sd
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596814214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaT4Sdz+/rCVr9OvsMUprb56nF64qSdiJORHxe9gLsw=;
 b=RfhCzt+MysmiJpSiuXrk7nCswBLe4YkhePvd5nL+rsWYOHY5scXXhFfScffzGtGHx7WNVF
 3VhkX+ZP52wnY7qhcETQ7V2trbKUyrdeAv1EOd14SZAKNZszNW4T20VUc5zreCBlKaN/ap
 YC/zLCDBAjxL+afahU1vU7JxnQ8hlrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-QaE6JB90Maqv0P1L7FBljQ-1; Fri, 07 Aug 2020 11:30:00 -0400
X-MC-Unique: QaE6JB90Maqv0P1L7FBljQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3B19106B243;
 Fri,  7 Aug 2020 15:29:59 +0000 (UTC)
Received: from work-vm (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C30D65C91;
 Fri,  7 Aug 2020 15:29:52 +0000 (UTC)
Date: Fri, 7 Aug 2020 16:29:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Message-ID: <20200807152949.GF2780@work-vm>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rmohr@redhat.com" <rmohr@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 'Stefan Hajnoczi' <stefanha@redhat.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* misono.tomohiro@fujitsu.com (misono.tomohiro@fujitsu.com) wrote:
> > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an error
> > 
> > An assertion failure is raised during request processing if
> > unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
> > be detected right away.
> > 
> > Unfortunately Docker/Moby does not include unshare in the seccomp.json
> > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > include unshare (e.g. podman is unaffected):
> > https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json
> > 
> > Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if the
> > default seccomp.json is missing unshare.
> 
> Hi, sorry for a bit late.
> 
> unshare() was added to fix xattr problem: 
>   https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#
> In theory we don't need to call unshare if xattr is disabled, but it is hard to get to know
> if xattr is enabled or disabled in fv_queue_worker(), right?
> 
> So, it looks good to me.
> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

OK, I think it might also be OK to just fail the xattr operation on a
non-file/directory in this case.

Dave

> Regards,
> Misono
> 
> > 
> > Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> > index 3b6d16a041..9e5537506c 100644
> > --- a/tools/virtiofsd/fuse_virtio.c
> > +++ b/tools/virtiofsd/fuse_virtio.c
> > @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session *se)
> >  {
> >      int ret;
> > 
> > +    /*
> > +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will need it. It's
> > +     * an unprivileged system call but some Docker/Moby versions are known to
> > +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> > +     *
> > +     * Note that the program is single-threaded here so this syscall has no
> > +     * visible effect and is safe to make.
> > +     */
> > +    ret = unshare(CLONE_FS);
> > +    if (ret == -1 && errno == EPERM) {
> > +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EPERM. If "
> > +                "running in a container please check that the container "
> > +                "runtime seccomp policy allows unshare.\n");
> > +        return -1;
> > +    }
> > +
> >      ret = fv_create_listen_socket(se);
> >      if (ret < 0) {
> >          return ret;
> > --
> > 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


