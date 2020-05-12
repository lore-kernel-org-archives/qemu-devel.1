Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D4C54E8F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E5120575
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN3nT58z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E5120575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQqT-0004Lz-Fl
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQpf-0003qU-TZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:04:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQpc-00075B-QL
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589274247;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP5OIdppnF9wjTNab8JL/hH5f9l2LHtV3MoWTuIc32w=;
 b=jN3nT58z5rTxqAyzvyBfYV5EXGSUlmLB8e4EwmWvYhnc358GVFZdXphwUIsCYSbwFLpZPK
 CYznbi6XRMtNAJ1qydDmorx9CoN0Hiv0Dz06zr2DnDt9edyPpN8tjfR2SOo01PpWiSFrae
 xH1QBTndFd/lxfSJErWn0TrhYc//dzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-LN8WoJXCP8Co7skOl2katA-1; Tue, 12 May 2020 05:04:03 -0400
X-MC-Unique: LN8WoJXCP8Co7skOl2katA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2820835B40;
 Tue, 12 May 2020 09:04:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B285C1059115;
 Tue, 12 May 2020 09:03:55 +0000 (UTC)
Date: Tue, 12 May 2020 10:03:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512090352.GG1191162@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511201218.76f30e0b@luklap>
MIME-Version: 1.0
In-Reply-To: <20200511201218.76f30e0b@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
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

On Mon, May 11, 2020 at 08:12:18PM +0200, Lukas Straub wrote:
> On Mon, 11 May 2020 12:49:47 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Mon, May 11, 2020 at 01:14:34PM +0200, Lukas Straub wrote:
> > > Hello Everyone,
> > > In many cases, if qemu has a network connection (qmp, migration, chardev, etc.)
> > > to some other server and that server dies or hangs, qemu hangs too.  
> > 
> > If qemu as a whole hangs due to a stalled network connection, that is a
> > bug in QEMU that we should be fixing IMHO. QEMU should be doing non-blocking
> > I/O in general, such that if the network connection or remote server stalls,
> > we simply stop sending I/O - we shouldn't ever hang the QEMU process or main
> > loop.
> > 
> > There are places in QEMU code which are not well behaved in this respect,
> > but many are, and others are getting fixed where found to be important.
> > 
> > Arguably any place in QEMU code which can result in a hang of QEMU in the
> > event of a stalled network should be considered a security flaw, because
> > the network is untrusted in general.
> 
> The fact that out-of-band qmp commands exist at all shows that we have to make tradeoffs of developer time vs. doing things right. Sure, the migration code can be rewritten to use non-blocking i/o and finegrained locks. But as a hobbyist I don't have time to fix this.
> 
> > > These patches introduce the new 'yank' out-of-band qmp command to recover from
> > > these kinds of hangs. The different subsystems register callbacks which get
> > > executed with the yank command. For example the callback can shutdown() a
> > > socket. This is intended for the colo use-case, but it can be used for other
> > > things too of course.  
> > 
> > IIUC, invoking the "yank" command unconditionally kills every single
> > network connection in QEMU that has registered with the "yank" subsystem.
> > IMHO this is way too big of a hammer, even if we accept there are bugs in
> > QEMU not handling stalled networking well.
> > 
> > eg if a chardev hangs QEMU, and we tear down everything, killing the NBD
> > connection used for the guest disk, we needlessly break I/O.
> 
> Yeah, these patches are intended to solve the problems with the colo
> use-case where all external connections (migration, chardevs, nbd)
> are just for replication. In other use-cases you'd enable the yank
> feature only on the non-essential connections.

That is a pretty inflexible design for other use cases though,
as "non-essential" is not a black & white list in general. There
are varying levels of importance to the different channels. We
can afford to loose migration without any user visible effects.
If that doesn't solve it, a serial device chardev, or VNC connection
can be dropped at the inconvenience of loosing interactive console
which is end user visible impact, so may only be want to be yanked
if the migration yank didn't fix it. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


