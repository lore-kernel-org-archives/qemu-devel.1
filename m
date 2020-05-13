Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8433CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F781206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpWnDu3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F781206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYqNG-000884-Pf
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 08:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYqLg-0007FL-FG
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:18:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYqLf-00021h-EY
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589372334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdcJziR247uemlpRZaJTSsubMzSrkPE55GBzkD+9TNo=;
 b=CpWnDu3PoJBxPIxU1t5beP9xtTsqXbeL+zFBREYdpgRjjnBOCiJ/lecyrZkRx0G1KFVqlu
 XTD1L7MYAP+jMenfoxpNT72QX83bsmTf8H5wSz7Zo0vRslU52UkcGaYxM5pBsQfyKlDSY6
 ZrknLacJD7WoZknDkU3iVln5y4M9d+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-m_D6KsaeNL-LX44nHG-D1w-1; Wed, 13 May 2020 08:18:53 -0400
X-MC-Unique: m_D6KsaeNL-LX44nHG-D1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C6F68015CE;
 Wed, 13 May 2020 12:18:52 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C1D638D;
 Wed, 13 May 2020 12:18:47 +0000 (UTC)
Date: Wed, 13 May 2020 14:18:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200513121846.GF6202@linux.fritz.box>
References: <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
 <20200512094337.GK1191162@redhat.com>
 <20200513103245.GD6202@linux.fritz.box>
 <20200513105359.GF3225@work-vm>
 <20200513111320.GE6202@linux.fritz.box>
 <20200513112630.GJ1215285@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200513112630.GJ1215285@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.05.2020 um 13:26 hat Daniel P. Berrangé geschrieben:
> On Wed, May 13, 2020 at 01:13:20PM +0200, Kevin Wolf wrote:
> > Am 13.05.2020 um 12:53 hat Dr. David Alan Gilbert geschrieben:
> > > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > > Am 12.05.2020 um 11:43 hat Daniel P. Berrangé geschrieben:
> > > > > On Tue, May 12, 2020 at 11:32:06AM +0200, Lukas Straub wrote:
> > > > > > On Mon, 11 May 2020 16:46:45 +0100
> > > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > > > 
> > > > > > > * Daniel P. BerrangÃ© (berrange@redhat.com) wrote: 
> > > > > > > > ...
> > > > > > > > That way if QEMU does get stuck, you can start by tearing down the
> > > > > > > > least distruptive channel. eg try tearing down the migration connection
> > > > > > > > first (which shouldn't negatively impact the guest), and only if that
> > > > > > > > doesn't work then, move on to tear down the NBD connection (which risks
> > > > > > > > data loss)  
> > > > > > > 
> > > > > > > I wonder if a different way would be to make all network connections
> > > > > > > register with yank, but then make yank take a list of connections to
> > > > > > > shutdown(2).
> > > > > > 
> > > > > > Good Idea. We could name the connections (/yank callbacks) in the
> > > > > > form "nbd:<node-name>", "chardev:<chardev-name>" and "migration"
> > > > > > (and add "netdev:...", etc. in the future). Then make yank take a
> > > > > > list of connection names as you suggest and silently ignore connections
> > > > > > that don't exist. And maybe even add a 'query-yank' oob command returning
> > > > > > a list of registered connections so the management application can do
> > > > > > pattern matching if it wants.
> > > > 
> > > > I'm generally not a big fan of silently ignoring things. Is there a
> > > > specific requirement to do it in this case, or can management
> > > > applications be expected to know which connections exist?
> > > > 
> > > > > Yes, that would make the yank command much more flexible in how it can
> > > > > be used.
> > > > > 
> > > > > As an alternative to using formatted strings like this, it could be
> > > > > modelled more explicitly in QAPI
> > > > > 
> > > > >   { 'struct':  'YankChannels',
> > > > >     'data': { 'chardev': [ 'string' ],
> > > > >               'nbd': ['string'],
> > > > > 	      'migration': bool } }
> > > > > 
> > > > > In this example, 'chardev' would accept a list of chardev IDs which
> > > > > have it enabled, 'nbd' would accept a list of block node IDs which
> > > > > have it enabled, and migration is a singleton on/off.
> > > > 
> > > > Of course, it also means that the yank code needs to know about every
> > > > single object that supports the operation, whereas if you only have
> > > > strings, the objects could keep registering their connection with a
> > > > generic function like yank_register_function() in this version.
> > > > 
> > > > I'm not sure if the additional complexity is worth the benefits.
> > > 
> > > I tend to agree; although we do have to ensure we either use an existing
> > > naming scheme (e.g. QOM object names?) or make sure we've got a well
> > > defined list of prefixes.
> > 
> > Not everything that has a network connection is a QOM object (in fact,
> > neither migration nor chardev nor nbd are QOM objects).
> > 
> > I guess it would be nice to have a single namespace for everything in
> > QEMU, but the reality is that we have a few separate ones. As long as we
> > consistently add a prefix that identifies the namespace in question, I
> > think that would work.
> > 
> > This means that if we're using node-name to identify the NBD connection,
> > the namespace should be 'block' rather than 'nbd'.
> > 
> > One more thing to consider is, what if a single object has multiple
> > connections? In the case of node-names, we have a limited set of allowed
> > characters, so we can use one of the remaining characters as a separator
> > and then suffix a counter. In other places, the identifier isn't
> > restricted, so suffixing doesn't work. Maybe prefixing does, but it
> > would have to be there from the beginning then.
> > 
> > And another thing: Do we really want to document this as limited to
> > network connections? Another common cause of hangs is when you have
> > image files on an NFS mount and the connection goes away. Of course, in
> > the end this is still networking, but inside of QEMU it looks like
> > accessing any other file. I'm not sure that we'll allow yanking access
> > to image files anytime soon, but it might not hurt to keep it at the
> > back of our mind as a potential option we might want the design to
> > allow.
> 
> Are you referring to the in-kernel NFS client hangs here ?  AFAIK, it is
> impossible to do anything to get out of those hangs from userspace, because
> the thread is stuck in an uninterruptable sleep in kernel space.

I'm not sure if it's always uninterruptible, but yes, in general you
would be sacrificing the block node and some of its worker threads to
get the VM unstuck.

The next thing you should probably do is migrate off to another QEMU
instance without a hanging thread. But at least it would let you migrate
off instead of getting stuck while trying to wait for all running
requests to complete.

> If using the in-QEMU NFS client, then there is a network connection
> that can be yanked just like the NBD client.

Yes, that's the same case as NBD.

Kevin


