Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E62C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D873020661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzYbU6t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D873020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRT1-0005DE-V4
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYRS7-0003s2-2v
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:43:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYRS5-0000dO-95
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589276631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHonFnekkvmUcsU+mGPVBjYKsDNqrXQjZxn1di+Dyp0=;
 b=OzYbU6t9M4mRng7iEQzl9Hen9GmP/Ul66Nz88RNpfw1Ywjb7PwC66M67gDqTsypeEA1clw
 p1zOrY2nU9eoHq60EO32y8+Vu8UjGj29VcEQ3pElMCnFbUR7DEnIq59bLSvWH5rBQxfGrj
 2CHBXjopx0pso3xi5d9OaO9v+SIfCcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-27zHcv4ZN82ZF766HT-Liw-1; Tue, 12 May 2020 05:43:47 -0400
X-MC-Unique: 27zHcv4ZN82ZF766HT-Liw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9BE918FE866;
 Tue, 12 May 2020 09:43:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 250501001DC2;
 Tue, 12 May 2020 09:43:40 +0000 (UTC)
Date: Tue, 12 May 2020 10:43:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512094337.GK1191162@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
MIME-Version: 1.0
In-Reply-To: <20200512113206.62836e44@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 11:32:06AM +0200, Lukas Straub wrote:
> On Mon, 11 May 2020 16:46:45 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Daniel P. BerrangÃ© (berrange@redhat.com) wrote: 
> > > ...
> > > That way if QEMU does get stuck, you can start by tearing down the
> > > least distruptive channel. eg try tearing down the migration connection
> > > first (which shouldn't negatively impact the guest), and only if that
> > > doesn't work then, move on to tear down the NBD connection (which risks
> > > data loss)  
> > 
> > I wonder if a different way would be to make all network connections
> > register with yank, but then make yank take a list of connections to
> > shutdown(2).
> 
> Good Idea. We could name the connections (/yank callbacks) in the
> form "nbd:<node-name>", "chardev:<chardev-name>" and "migration"
> (and add "netdev:...", etc. in the future). Then make yank take a
> list of connection names as you suggest and silently ignore connections
> that don't exist. And maybe even add a 'query-yank' oob command returning
> a list of registered connections so the management application can do
> pattern matching if it wants.

Yes, that would make the yank command much more flexible in how it can
be used.

As an alternative to using formatted strings like this, it could be
modelled more explicitly in QAPI

  { 'struct':  'YankChannels',
    'data': { 'chardev': [ 'string' ],
              'nbd': ['string'],
	      'migration': bool } }

In this example, 'chardev' would accept a list of chardev IDs which
have it enabled, 'nbd' would accept a list of block node IDs which
have it enabled, and migration is a singleton on/off.

The benefit of this modelling is that you can introspect QEMU
to discover what classes of channels support being yanked by
this QEMU build, as well as what instances are configured to
be yanked. ie you can distinguish between a QEMU that doesn't
support yanking network devices, from a QEMU that does support
yanking network devices, but doesn't have it enabled for any
network device instances.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


