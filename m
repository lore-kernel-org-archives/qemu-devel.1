Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19F3CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954AA20673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AclirYO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954AA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYa7Z-0008Jo-RL
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYa6w-0007WD-Qx
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:58:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYa6v-0001Lq-95
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589309915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wdA/ZCB1wurWoeejaJX1atNzZ7BnHlvvvUwMQdxVso=;
 b=AclirYO3VQeuj8nlRGlkxFF8xwaZO5egrRJ0stk2mQVdR1+aEQIDC34o7lNsA48gyCoC4G
 K6AKe8tj1wtS45jYWbZt0pFEBbfSZ2Lkfw6R5Y71GJ0qk+8ZwrptRhAN32l2dPLaNuUo1F
 2VtrlAetKm0TKKdXO9dGqrjGNw0uWmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-a8WUBhtzNQew4lH0oTZUgQ-1; Tue, 12 May 2020 14:58:26 -0400
X-MC-Unique: a8WUBhtzNQew4lH0oTZUgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1B0A8005B7;
 Tue, 12 May 2020 18:58:24 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E95584233;
 Tue, 12 May 2020 18:58:19 +0000 (UTC)
Date: Tue, 12 May 2020 19:58:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512185817.GJ2802@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
 <20200512094337.GK1191162@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200512094337.GK1191162@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Tue, May 12, 2020 at 11:32:06AM +0200, Lukas Straub wrote:
> > On Mon, 11 May 2020 16:46:45 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > 
> > > * Daniel P. BerrangÃ© (berrange@redhat.com) wrote: 
> > > > ...
> > > > That way if QEMU does get stuck, you can start by tearing down the
> > > > least distruptive channel. eg try tearing down the migration connection
> > > > first (which shouldn't negatively impact the guest), and only if that
> > > > doesn't work then, move on to tear down the NBD connection (which risks
> > > > data loss)  
> > > 
> > > I wonder if a different way would be to make all network connections
> > > register with yank, but then make yank take a list of connections to
> > > shutdown(2).
> > 
> > Good Idea. We could name the connections (/yank callbacks) in the
> > form "nbd:<node-name>", "chardev:<chardev-name>" and "migration"
> > (and add "netdev:...", etc. in the future). Then make yank take a
> > list of connection names as you suggest and silently ignore connections
> > that don't exist. And maybe even add a 'query-yank' oob command returning
> > a list of registered connections so the management application can do
> > pattern matching if it wants.
> 
> Yes, that would make the yank command much more flexible in how it can
> be used.
> 
> As an alternative to using formatted strings like this, it could be
> modelled more explicitly in QAPI
> 
>   { 'struct':  'YankChannels',
>     'data': { 'chardev': [ 'string' ],
>               'nbd': ['string'],
> 	      'migration': bool } }
> 
> In this example, 'chardev' would accept a list of chardev IDs which
> have it enabled, 'nbd' would accept a list of block node IDs which
> have it enabled, and migration is a singleton on/off.

Do we already have a QOM object name for each of these things?
Is that nbd/blockdevice unique - i.e. can you have multiple nbd clients
on the same node?

> The benefit of this modelling is that you can introspect QEMU
> to discover what classes of channels support being yanked by
> this QEMU build, as well as what instances are configured to
> be yanked. ie you can distinguish between a QEMU that doesn't
> support yanking network devices, from a QEMU that does support
> yanking network devices, but doesn't have it enabled for any
> network device instances.

What do we need to make it introspectable like that?

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


