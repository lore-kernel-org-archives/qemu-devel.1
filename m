Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAECC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4543B22B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De4AibQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4543B22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFMT-0006v3-BA
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFLs-0006P3-3O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:41:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFLq-0004ly-0K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598524909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QCOB4XPZGvatveweFCyv159KnGPJ1ud2skpJEQ9LOk=;
 b=De4AibQREX1KN9xPP65rc5H1UHXefa1hnXrCSwv+/njs7IWgp3w0y27CMC64InVFiEjdxV
 dHwKQV+0/45BpQIhrFACREnY+RQ1SSiEDtwZApyqwiex3oqDXVRxeY+IaviStP3mpPmMvA
 aKRBGZp31PFkkPMybBr3qn+zPpC8ka0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-5Sz7LQ4tN2i0MEDRidqSzQ-1; Thu, 27 Aug 2020 06:41:47 -0400
X-MC-Unique: 5Sz7LQ4tN2i0MEDRidqSzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BCE81084C83;
 Thu, 27 Aug 2020 10:41:46 +0000 (UTC)
Received: from redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1224319936;
 Thu, 27 Aug 2020 10:41:40 +0000 (UTC)
Date: Thu, 27 Aug 2020 11:41:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v7 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200827104138.GN192458@redhat.com>
References: <cover.1596528468.git.lukasstraub2@web.de>
 <20200818142631.3e1c1481@luklap> <20200827104246.63754338@luklap>
MIME-Version: 1.0
In-Reply-To: <20200827104246.63754338@luklap>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 10:42:46AM +0200, Lukas Straub wrote:
> On Tue, 18 Aug 2020 14:26:31 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
> 
> > On Tue, 4 Aug 2020 10:11:22 +0200
> > Lukas Straub <lukasstraub2@web.de> wrote:
> > 
> > > Hello Everyone,
> > > In many cases, if qemu has a network connection (qmp, migration, chardev, etc.)
> > > to some other server and that server dies or hangs, qemu hangs too.
> > > These patches introduce the new 'yank' out-of-band qmp command to recover from
> > > these kinds of hangs. The different subsystems register callbacks which get
> > > executed with the yank command. For example the callback can shutdown() a
> > > socket. This is intended for the colo use-case, but it can be used for other
> > > things too of course.
> > > 
> > > Regards,
> > > Lukas Straub
> > > 
> > > v7:
> > >  -yank_register_instance now returns error via Error **errp instead of aborting
> > >  -dropped "chardev/char.c: Check for duplicate id before  creating chardev"
> > > 
> > > v6:
> > >  -add Reviewed-by and Acked-by tags
> > >  -rebase on master
> > >  -lots of changes in nbd due to rebase
> > >  -only take maintainership of util/yank.c and include/qemu/yank.h (Daniel P. Berrangé)
> > >  -fix a crash discovered by the newly added chardev test
> > >  -fix the test itself
> > > 
> > > v5:
> > >  -move yank.c to util/
> > >  -move yank.h to include/qemu/
> > >  -add license to yank.h
> > >  -use const char*
> > >  -nbd: use atomic_store_release and atomic_load_aqcuire
> > >  -io-channel: ensure thread-safety and document it
> > >  -add myself as maintainer for yank
> > > 
> > > v4:
> > >  -fix build errors...
> > > 
> > > v3:
> > >  -don't touch softmmu/vl.c, use __contructor__ attribute instead (Paolo Bonzini)
> > >  -fix build errors
> > >  -rewrite migration patch so it actually passes all tests
> > > 
> > > v2:
> > >  -don't touch io/ code anymore
> > >  -always register yank functions
> > >  -'yank' now takes a list of instances to yank
> > >  -'query-yank' returns a list of yankable instances
> > > 
> > > Lukas Straub (8):
> > >   Introduce yank feature
> > >   block/nbd.c: Add yank feature
> > >   chardev/char-socket.c: Add yank feature
> > >   migration: Add yank feature
> > >   io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
> > >   io: Document thread-safety of qio_channel_shutdown
> > >   MAINTAINERS: Add myself as maintainer for yank feature
> > >   tests/test-char.c: Wait for the chardev to connect in
> > >     char_socket_client_dupid_test
> > > 
> > >  MAINTAINERS                   |   6 ++
> > >  block/nbd.c                   | 129 +++++++++++++++---------
> > >  chardev/char-socket.c         |  31 ++++++
> > >  include/io/channel.h          |   2 +
> > >  include/qemu/yank.h           |  80 +++++++++++++++
> > >  io/channel-tls.c              |   6 +-
> > >  migration/channel.c           |  12 +++
> > >  migration/migration.c         |  25 ++++-
> > >  migration/multifd.c           |  10 ++
> > >  migration/qemu-file-channel.c |   6 ++
> > >  migration/savevm.c            |   6 ++
> > >  qapi/misc.json                |  45 +++++++++
> > >  tests/Makefile.include        |   2 +-
> > >  tests/test-char.c             |   1 +
> > >  util/Makefile.objs            |   1 +
> > >  util/yank.c                   | 184 ++++++++++++++++++++++++++++++++++
> > >  16 files changed, 493 insertions(+), 53 deletions(-)
> > >  create mode 100644 include/qemu/yank.h
> > >  create mode 100644 util/yank.c
> > > 
> > > --
> > > 2.20.1  
> > 
> > Ping...
> 
> Ping 2...
> 
> Also, can the different subsystems have a look at this and give their ok?

We need ACKs from the NBD, migration and chardev maintainers, for the
respective patches, then I think this series is ready for a pull request.

Once acks arrive, I'm happy to send a PULL unless someone else has a
desire todo it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


