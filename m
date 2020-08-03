Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A072E206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyPVQ115"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A072E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ayc-0007AG-M6
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k2ay4-0006l4-UU
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:57:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k2ay1-0008Q5-Bw
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596463047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERcYbJma07PP5JwVltItx54C93hyi5SMrlrkCUM1PRA=;
 b=KyPVQ115C5MacyJC3CiM44U5eMOIzTnOop/h9C0PDAmV8+xW1lQRCK/B8Lc9JZMTmBbadC
 vD513yPblso8qfObKq1pbxT+Lv/JgO4m87NcIvFt3nZzynsiic9bZ+s0dio8mgaKSgBm93
 iEdiBna30/9Fce4SHD529tgnR+/ZSqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-eaDJsORVPFeaUSGbD1yTtg-1; Mon, 03 Aug 2020 09:57:26 -0400
X-MC-Unique: eaDJsORVPFeaUSGbD1yTtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECAC91030C53
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 13:57:21 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BEEF8FA30;
 Mon,  3 Aug 2020 13:57:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 94504220406; Mon,  3 Aug 2020 09:57:15 -0400 (EDT)
Date: Mon, 3 Aug 2020 09:57:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 4/5] virtiofsd: Open lo->source while setting up root
 in sandbox=NONE mode
Message-ID: <20200803135715.GA233053@redhat.com>
References: <20200730194736.173994-1-vgoyal@redhat.com>
 <20200730194736.173994-5-vgoyal@redhat.com>
 <20200803095459.GD244853@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200803095459.GD244853@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, vromanso@redhat.com, dwalsh@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, virtio-fs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 10:54:59AM +0100, Stefan Hajnoczi wrote:
> On Thu, Jul 30, 2020 at 03:47:35PM -0400, Vivek Goyal wrote:
> > In sandbox=NONE mode, lo->source points to the directory which is being
> > exported. We have not done any chroot()/pivot_root(). So open lo->source.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> > index 76ef891105..a6fa816b6c 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -3209,7 +3209,10 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
> >      int fd, res;
> >      struct stat stat;
> >  
> > -    fd = open("/", O_PATH);
> > +    if (lo->sandbox == SANDBOX_NONE)
> > +        fd = open(lo->source, O_PATH);
> > +    else
> > +        fd = open("/", O_PATH);
> 
> Up until now virtiofsd has been able to assume that path traversal has
> the shared directory as "/".
> 
> Now this is no longer true and it is necessary to audit all syscalls
> that take path arguments. They must ensure that:
> 1. Path components are safe (no ".." or "/" allowed)
> 2. Symlinks are not followed.

This code does not change the path client is passing in and we are
already doing the checks on passed in paths/names. So existing checks
should work even for this case, isn't it?

lo_lookup() {
    if (strchr(name, '/')) {
        fuse_reply_err(req, EINVAL);
        return;
    }
}

lo_do_lookup() {
    /* Do not allow escaping root directory */
    if (dir == &lo->root && strcmp(name, "..") == 0) {
        name = ".";
    }
}

> 
> Did you audit all syscalls made by passthrough_ll.c?
> 
> virtiofsd still needs to restrict the client to the shared directory for
> two reasons:
> 1. The guest may not be trusted. An unprivileged sandbox=none mount can
>    be used with a malicious guest.
> 2. If accidental escapes are possible then the guest could accidentally
>    corrupt or delete files outside the shared directory.

Even if escape is possible, its no different than a malicious user
application running. Given sandbox=none can be used in case of
unpriviliged mode, that means user app can only affect files owned by
that user.

Given we are not doing chroot()/pivot_root(), key question will be
what additional path we are enabling using which one can escape
out of this shared directory.

Having said that, In case of unpriviliged mode, it feels that chroot()
is more of a nice to have kind of functionality. Even if guest manages
to break out of shared directory, impact is equivalent to user running a
malicious app directly. 

If doing chroot/pivot_root is must, then we need additional capabilities.
And that probably means we need to launch virtiofsd in a user namespace
with required caps. And that will fall back into the territory of
running virtiofsd in a user namespace. That indeed is an important
use case which needs to be solved.

Thanks
Vivek


