Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F59C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113BF20575
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEH96NNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113BF20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQvM-0000EO-7l
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYQuh-0007pE-DF
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:09:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYQug-0007oQ-Mx
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589274562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GD4w0w8rBbJHFKG55rMqA9SqE4ywZ7QiqKmS0EA4RwU=;
 b=FEH96NNOnsh+eNTUPeTn4i2b25zNwcF+/GIeTjdLxyP/90cZENqW/Hpaga2xmCWl1qnwFw
 8q2f04Ouh7NkMkW3PUeJAakTUkN2a2B+IVv+ABgolWoEA2gfekoGAmcHY5kdKY8W0PIncY
 2kCcDpOAhQI+B9obTKO5EMWHVXMrevU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-McUin0A3NI6i0DBqNy4O_w-1; Tue, 12 May 2020 05:09:18 -0400
X-MC-Unique: McUin0A3NI6i0DBqNy4O_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CFCB107ACF2;
 Tue, 12 May 2020 09:09:17 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8092B6C78E;
 Tue, 12 May 2020 09:09:12 +0000 (UTC)
Date: Tue, 12 May 2020 10:09:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512090909.GB2802@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511201218.76f30e0b@luklap>
MIME-Version: 1.0
In-Reply-To: <20200511201218.76f30e0b@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
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

If it was just an hobbyist vs fulltime thing then I'd say that was a bad
way to make the decision; however the reality is that even those who are
paid to watch this code don't have the feeling we can make it fail
quickly/non-blocking - and for COLO you need to be absolutely sure you
nail every case, so you'd some how have to audit the whole lot, and keep
watching it.

(and thank you for taking your time to do this!)

Dave


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
> Yeah, these patches are intended to solve the problems with the colo use-case where all external connections (migration, chardevs, nbd) are just for replication. In other use-cases you'd enable the yank feature only on the non-essential connections.
> 
> > eg doing this in the chardev backend is not desirable, because the bugs
> > with hanging QEMU are typically caused by the way the frontend device
> > uses the chardev blocking I/O calls, instead of non-blocking I/O calls.
> > 
> > 
> > Regards,
> > Daniel
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


