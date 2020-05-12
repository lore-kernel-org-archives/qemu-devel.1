Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17569C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF8B20575
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRjrtdMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF8B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQsG-0005ee-3M
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYQrf-0005A7-D7
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:06:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYQre-0007VK-BF
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589274373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOKYF3rGd2Wmnlaw6h0LtWDu4P3YqNZB4tXHE19qUVM=;
 b=NRjrtdMC7jo8Xjk8unA1q0oCKK155gjjRe4LEAiC+c5nb7aUHnQ1SISDib29s5XpLA0Wtx
 JTbeLQGNxcEz4f4lxWtfDz+WHJJcaZzmkOjkQlc2H+p2fvxXZ79RrlgVKABfDb/ychaNbJ
 fQC0HmnFtI2RW4DlWNP5RguYjGXYO4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-SzyF5R17N82X3no7Dr_MbQ-1; Tue, 12 May 2020 05:06:09 -0400
X-MC-Unique: SzyF5R17N82X3no7Dr_MbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AECC83DB38;
 Tue, 12 May 2020 09:06:08 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65ADD5C1B5;
 Tue, 12 May 2020 09:06:03 +0000 (UTC)
Date: Tue, 12 May 2020 10:06:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512090600.GA2802@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511201218.76f30e0b@luklap>
 <20200512090352.GG1191162@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200512090352.GG1191162@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Mon, May 11, 2020 at 08:12:18PM +0200, Lukas Straub wrote:
> > On Mon, 11 May 2020 12:49:47 +0100
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > > On Mon, May 11, 2020 at 01:14:34PM +0200, Lukas Straub wrote:
> > > > Hello Everyone,
> > > > In many cases, if qemu has a network connection (qmp, migration, chardev, etc.)
> > > > to some other server and that server dies or hangs, qemu hangs too.  
> > > 
> > > If qemu as a whole hangs due to a stalled network connection, that is a
> > > bug in QEMU that we should be fixing IMHO. QEMU should be doing non-blocking
> > > I/O in general, such that if the network connection or remote server stalls,
> > > we simply stop sending I/O - we shouldn't ever hang the QEMU process or main
> > > loop.
> > > 
> > > There are places in QEMU code which are not well behaved in this respect,
> > > but many are, and others are getting fixed where found to be important.
> > > 
> > > Arguably any place in QEMU code which can result in a hang of QEMU in the
> > > event of a stalled network should be considered a security flaw, because
> > > the network is untrusted in general.
> > 
> > The fact that out-of-band qmp commands exist at all shows that we have to make tradeoffs of developer time vs. doing things right. Sure, the migration code can be rewritten to use non-blocking i/o and finegrained locks. But as a hobbyist I don't have time to fix this.
> > 
> > > > These patches introduce the new 'yank' out-of-band qmp command to recover from
> > > > these kinds of hangs. The different subsystems register callbacks which get
> > > > executed with the yank command. For example the callback can shutdown() a
> > > > socket. This is intended for the colo use-case, but it can be used for other
> > > > things too of course.  
> > > 
> > > IIUC, invoking the "yank" command unconditionally kills every single
> > > network connection in QEMU that has registered with the "yank" subsystem.
> > > IMHO this is way too big of a hammer, even if we accept there are bugs in
> > > QEMU not handling stalled networking well.
> > > 
> > > eg if a chardev hangs QEMU, and we tear down everything, killing the NBD
> > > connection used for the guest disk, we needlessly break I/O.
> > 
> > Yeah, these patches are intended to solve the problems with the colo
> > use-case where all external connections (migration, chardevs, nbd)
> > are just for replication. In other use-cases you'd enable the yank
> > feature only on the non-essential connections.
> 
> That is a pretty inflexible design for other use cases though,
> as "non-essential" is not a black & white list in general. There
> are varying levels of importance to the different channels. We
> can afford to loose migration without any user visible effects.
> If that doesn't solve it, a serial device chardev, or VNC connection
> can be dropped at the inconvenience of loosing interactive console
> which is end user visible impact, so may only be want to be yanked
> if the migration yank didn't fix it. 

In the case of COLO that's not the case though - here we explicitly want
to kill the migration to be able to ensure that we can recover - and
we're under time pressure to get the other member of the pair running
again. 

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


