Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041EEC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD89F206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2Gn9Xit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD89F206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAfc-0007yl-Ul
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYAeF-00078e-FR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:47:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYAeE-0001se-JP
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589212037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKy+Aa5m4DNYSp4Uctc5auKxOIyeyYkksy7ZRfq2Avg=;
 b=f2Gn9Xitp2C+FZpJKFgsoYhQvZFCoi7HjS6LyB7UXAbdYVDywbzNP78LaTue+8gijv7jX4
 s5eZPvXpgksFZDD1fI9x7fOO6NlVDbaovH5u0Yvaoxb0qN0Agt4N4iOd0UBk7UqFmoMtyd
 YigNz+p7wlqBtx5n18BTzVGHWfqVKL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-IJcZNSZdNPeROMZMDUWzwQ-1; Mon, 11 May 2020 11:46:56 -0400
X-MC-Unique: IJcZNSZdNPeROMZMDUWzwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D859107B267;
 Mon, 11 May 2020 15:46:55 +0000 (UTC)
Received: from work-vm (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBDA55C1B2;
 Mon, 11 May 2020 15:46:47 +0000 (UTC)
Date: Mon, 11 May 2020 16:46:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200511154645.GI2811@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200511121714.GL1135885@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
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
> On Mon, May 11, 2020 at 01:07:18PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
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
> > That's not really true of the 'management network' - people trust that
> > and I don't see a lot of the qemu code getting fixed safely for all of
> > them.
> 
> It depends on the user / app / deployment scenario. In OpenStack alot of
> work was done to beef up security between services on the mgmt network,
> with TLS encryption as standard to reduce attack vectors.
> 
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
> > 
> > But isn't this hammer conditional - I see that it's a migration
> > capabiltiy for the migration socket, and a flag in nbd - so it only
> > yanks things you've told it to.
> 
> IIUC, you have to set these flags upfront when you launch QEMU, or
> hotplug the device using the feature. When something gets stuck,
> and you issue the "yank" command, then everything that has the flag
> enabled gets torn down. So in practice it looks like the flag will
> get enabled for everything at QEMU startup, and yanking down tear
> down everything.

For COLO I really expect it for the migration stream, the disk mirroring
stream and probably the network comparison/forwarding streams.

> > > eg if a chardev hangs QEMU, and we tear down everything, killing the NBD
> > > connection used for the guest disk, we needlessly break I/O.
> > > 
> > > eg doing this in the chardev backend is not desirable, because the bugs
> > > with hanging QEMU are typically caused by the way the frontend device
> > > uses the chardev blocking I/O calls, instead of non-blocking I/O calls.
> > > 
> > 
> > Having a way to get out of any of these problems from a single point is
> > quite nice.  To be useful in COLO you need to know for sure you can get
> > out of any network screwup.
> > 
> > We already use shutdown(2) in migrate_cancel and migrate-pause for
> > basically the same reason; I don't think we've got anything similar for
> > NBD, and we probably should have (I think I asked for it fairly
> > recently).
> 
> Yes, the migrate_cancel is an example of a more fine grained way to
> recover. I was thinking that we need an equivalent fine control knob
> for NBD too.

I feel it might be nice not to have to create so many separate knobs.

> That way if QEMU does get stuck, you can start by tearing down the
> least distruptive channel. eg try tearing down the migration connection
> first (which shouldn't negatively impact the guest), and only if that
> doesn't work then, move on to tear down the NBD connection (which risks
> data loss)

I wonder if a different way would be to make all network connections
register with yank, but then make yank take a list of connections to
shutdown(2).

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


