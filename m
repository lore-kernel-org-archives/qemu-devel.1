Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA7DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796A20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMDadn6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXDJ-0004Xx-5v
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZXCc-0003gK-OE
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:04:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZXCb-0007CA-Po
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589537065;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yk1drrKUPdP+/s5oZImaqxNNy9reJiPKMkK/TaA3mHA=;
 b=jMDadn6ypv4zesPDHaSkLHlIPfiChNH6wL0OiyY98dcXEJ9oQv+XjQpwjDJssN9jWb/Gt/
 5rxNr1Id0Q4tGvxp8a7/4CE4sIyQgO4SCwmM8TeiAQSOtbf4rIQvpW5i6s8lNC8s+sHdug
 MiLuVlY3KYd7m+WsTF8rDzJPEOJzDqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-SlWHVpUwMZC5xg1UCm0GoQ-1; Fri, 15 May 2020 06:04:23 -0400
X-MC-Unique: SlWHVpUwMZC5xg1UCm0GoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F242100A8E7;
 Fri, 15 May 2020 10:04:22 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B93B878B26;
 Fri, 15 May 2020 10:04:16 +0000 (UTC)
Date: Fri, 15 May 2020 11:04:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 3/5] block/nbd.c: Add yank feature
Message-ID: <20200515100413.GG1300305@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <1e712fa7f08e4772c2a68197a851161bee51610f.1589193717.git.lukasstraub2@web.de>
 <20200511161909.GJ2811@work-vm> <20200511190524.3681e58c@luklap>
 <20200512085458.GE1191162@redhat.com>
 <20200515114818.25d9eb9c@luklap>
MIME-Version: 1.0
In-Reply-To: <20200515114818.25d9eb9c@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 11:48:18AM +0200, Lukas Straub wrote:
> On Tue, 12 May 2020 09:54:58 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Mon, May 11, 2020 at 07:05:24PM +0200, Lukas Straub wrote:
> > > On Mon, 11 May 2020 17:19:09 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Lukas Straub (lukasstraub2@web.de) wrote:  
> > > > > Add yank option, pass it to the socket-channel and register a yank
> > > > > function which sets s->state = NBD_CLIENT_QUIT. This is the same
> > > > > behaviour as if an error occured.
> > > > > 
> > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>    
> > > >   
> > > > > +static void nbd_yank(void *opaque)
> > > > > +{
> > > > > +    BlockDriverState *bs = opaque;
> > > > > +    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
> > > > > +
> > > > > +    atomic_set(&s->state, NBD_CLIENT_QUIT);    
> > > > 
> > > > I think I was expecting a shutdown on the socket here - why doesn't it
> > > > have one?  
> > > 
> > > For nbd, we register two yank functions: This one and we enable
> > > the yank feature on the qio channel (see function
> > > nbd_establish_connection below).  
> > 
> > As mentioned on the earlier patch, I don't want to see any yank
> > code in the QIOChannel object directly. This nbd_yank function
> > can simply call the qio_channel_shutdown() function directly
> > and avoid need for modifying the QIOChannel object with yank
> > support.
> 
> Hi,
> Looking at it again, the problem is not with registering the yank functions, but with tracking the lifetime of it. Suppose we add qio_channel_shutdown to the yank_nbd function. Then we need to unregister it whenever the QIOChannel object is freed.
> 
> In the code that would lead to the following constructs in a lot of places:
>      if (local_err) {
>          yank_unregister_function(s->yank_name, yank_nbd, bs);
>          object_unref(OBJECT(sioc));
>          error_propagate(errp, local_err);
>          return NULL;
>      }

The nbd patch here already has a yank_unregister_function() so I'm
not seeing anything changes in that respect. The "yank_nbd" function
should check that the I/O channel is non-NULL before calling the
qio_channel_shutdown method.

> If you don't want the code in QIOChannel I guess I can create a
> subclass (YankableChannelSocket?) of QIOChannelSocket. What do
> you think?

That's no better, and I don't see any compelling need for it as calling
yank_unregister_function is something nbd already does in its nbd_close
function. It isn't a burden for the other backends to do similarly.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


