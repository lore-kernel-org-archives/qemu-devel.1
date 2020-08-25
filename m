Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C4820706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRUBsGwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C4820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWJC-0000nS-2I
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAWIb-0000Lf-Fl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:35:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAWIY-0006qn-DB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598351724;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VkizQTrQ9NVV5xVhQT6cC1Gwo4UPmf8417bwXBgrOx4=;
 b=fRUBsGwZJ7X0OoRN2TAGNzN2FHW6468BLYOXmXJAZdMhRIeESuljJnQCXJzhw0KJ47pEMd
 xMypv/7Wa+pEwbQub4fDc7BuvJK025wWJJ4+oq2hQZ+/X7uvZpP1zzhHgDVQAowZgrfOax
 soxft/RcbEsJghWEdnmGDJuDzCRzUjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-EV1ORq2NM3qjlHxpXfyuYw-1; Tue, 25 Aug 2020 06:35:18 -0400
X-MC-Unique: EV1ORq2NM3qjlHxpXfyuYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC0FD10ABDAD;
 Tue, 25 Aug 2020 10:35:17 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A2895D9D3;
 Tue, 25 Aug 2020 10:35:15 +0000 (UTC)
Date: Tue, 25 Aug 2020 11:35:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] nbd: disable signals and forking on Windows builds
Message-ID: <20200825103513.GJ107278@redhat.com>
References: <20200824170218.106255-1-berrange@redhat.com>
 <20200824170218.106255-3-berrange@redhat.com>
 <9655e35a-7c0e-0be9-dd7f-a1e7bde7f634@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9655e35a-7c0e-0be9-dd7f-a1e7bde7f634@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 12:12:53PM -0500, Eric Blake wrote:
> On 8/24/20 12:02 PM, Daniel P. Berrangé wrote:
> > Disabling these parts are sufficient to get the qemu-nbd program
> > compiling in a Windows build.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   meson.build |  7 ++-----
> >   qemu-nbd.c  | 10 +++++++++-
> >   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> Feels a bit hacky at what it supports, but certainly better than nothing ;)
> 
> > 
> > diff --git a/meson.build b/meson.build
> > index df5bf728b5..1071871605 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1074,12 +1074,9 @@ if have_tools
> >                dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
> >     qemu_io = executable('qemu-io', files('qemu-io.c'),
> >                dependencies: [block, qemuutil], install: true)
> > -  qemu_block_tools += [qemu_img, qemu_io]
> > -  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
> > -    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
> > +  qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
> >                  dependencies: [block, qemuutil], install: true)
> 
> Conflicts with this patch:
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05546.html
> 
> but this one gets rid of the need for that one.
> 
> > -    qemu_block_tools += [qemu_nbd]
> > -  endif
> > +  qemu_block_tools += [qemu_img, qemu_io, qemu_nbd]
> >     subdir('storage-daemon')
> >     subdir('contrib/rdmacm-mux')
> > diff --git a/qemu-nbd.c b/qemu-nbd.c
> > index b102874f0f..c6fd6524d3 100644
> > --- a/qemu-nbd.c
> > +++ b/qemu-nbd.c
> > @@ -155,12 +155,13 @@ QEMU_COPYRIGHT "\n"
> >       , name);
> >   }
> > +#ifndef WIN32
> >   static void termsig_handler(int signum)
> >   {
> >       atomic_cmpxchg(&state, RUNNING, TERMINATE);
> >       qemu_notify_event();
> >   }
> > -
> > +#endif
> 
> How does one terminate a long-running server on Windows if there is no
> SIGTERM handler?  I guess Ctrl-C does something, but without the state
> notification from a signal handler, you are getting less-clean shutdowns,
> which may explain the hangs you were seeing in testing?  But incremental
> progress is fine, and I see no reason to not take this patch as-is.

The hangs occurred even with windows client/ native server, just less
frequently so don't think it is related.

Re-reading the code I notice this SIGTERM handler is only there for
the NBD device client thread, so we should skip it if that is not
installed.

Ctrl-C does SIGINT, so that's unrelated to the SIGTERM handler.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> I'm happy to queue this series through my NBD tree.

I'll post a v2

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


