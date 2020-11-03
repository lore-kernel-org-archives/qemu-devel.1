Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E56206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd8KofbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E56206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtbh-00067q-84
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZtZY-0004fv-0V
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZtZU-0002LD-6b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604399386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63GzjYcexcJ6f4R/gzQDJePTgnKS5LFqiJk6U1Jm9hg=;
 b=Cd8KofbOf9UH/JdymoklLAkxxSL3fHo6fx+LLQGsI+1aC5ysEwC7gH6lzGGpTUveQDNcq8
 14SUW9ZERyuqJyp30YmLcZLNcZcLqR5mmbrqo4bane+Y11zHP/0L3uUQsppHGe9wo1Efom
 r3ILXxZQYUysb6De+biyN9yqZXzuVGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-_fZyrOm6OnCxEQxUpihLNw-1; Tue, 03 Nov 2020 05:29:44 -0500
X-MC-Unique: _fZyrOm6OnCxEQxUpihLNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B434B6D271;
 Tue,  3 Nov 2020 10:29:43 +0000 (UTC)
Received: from work-vm (ovpn-115-84.ams2.redhat.com [10.36.115.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D78B05C230;
 Tue,  3 Nov 2020 10:29:35 +0000 (UTC)
Date: Tue, 3 Nov 2020 10:29:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PULL 10/12] virtiofsd: Announce sub-mount points
Message-ID: <20201103102933.GC3566@work-vm>
References: <20201102195657.219501-1-dgilbert@redhat.com>
 <20201102195657.219501-11-dgilbert@redhat.com>
 <a52b74d6-933d-7c44-ab06-725b5f38c4d1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a52b74d6-933d-7c44-ab06-725b5f38c4d1@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 zhangjiachen.jaycee@bytedance.com, stefanha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 02.11.20 20:56, Dr. David Alan Gilbert (git) wrote:
> > From: Max Reitz <mreitz@redhat.com>
> > 
> > Whenever we encounter a directory with an st_dev or mount ID that
> > differs from that of its parent, we set the FUSE_ATTR_SUBMOUNT flag so
> > the guest can create a submount for it.
> > 
> > We only need to do so in lo_do_lookup().  The following functions return
> > a fuse_attr object:
> > - lo_create(), though fuse_reply_create(): Calls lo_do_lookup().
> > - lo_lookup(), though fuse_reply_entry(): Calls lo_do_lookup().
> > - lo_mknod_symlink(), through fuse_reply_entry(): Calls lo_do_lookup().
> > - lo_link(), through fuse_reply_entry(): Creating a link cannot create a
> >   submount, so there is no need to check for it.
> > - lo_getattr(), through fuse_reply_attr(): Announcing submounts when the
> >   node is first detected (at lookup) is sufficient.  We do not need to
> >   return the submount attribute later.
> > - lo_do_readdir(), through fuse_add_direntry_plus(): Calls
> >   lo_do_lookup().
> > 
> > Make announcing submounts optional, so submounts are only announced to
> > the guest with the announce_submounts option.  Some users may prefer the
> > current behavior, so that the guest learns nothing about the host mount
> > structure.
> > 
> > (announce_submounts is force-disabled when the guest does not present
> > the FUSE_SUBMOUNTS capability, or when there is no statx().)
> > 
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-Id: <20201102161859.156603-6-mreitz@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/helper.c         |  1 +
> >  tools/virtiofsd/passthrough_ll.c | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> 
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> [...]
> 
> > index 34d107975f..ec1008bceb 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> 
> [...]
> 
> > @@ -601,6 +604,20 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
> 
> [...]
> 
> > +#ifndef CONFIG_STATX
> > +    if (lo->announce_submounts) {
> > +        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, there "
> > +                 "is no statx()\n");
> > +        lo->announce_submounts = false;
> > +    }
> > +#endif
> 
> When reviewing this series, Miklos noted today that this warning is
> wrong (we can still announce submounts even without statx()), and we
> concluded that we should probably drop it and the
> “lo->announce_submounts = false” assignment (i.e. this whole block).
> 
> I don’t think that needs to stop this pull request, though, we can
> easily fix it on top.

That's OK, send me a follow up patch to fix the warning; that's a minor.

Dave

> Max
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


