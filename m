Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720EFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 22:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9CA207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 22:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNLsjOSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9CA207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0YOT-0002Ch-GB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 18:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k0YNr-0001m5-A6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 18:47:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k0YNo-0001Ea-Jx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 18:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595976458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z184sD+2H6EPmLA2CuCse5TIC3U9yUZS5jMU5DfQXfc=;
 b=CNLsjOSGsaWpWdsdS352ZPnkt08f+ocylew99AMsZmreuS6xCabWGQ4iGCL3a1GPuPNefy
 D4iOuFAGLheypyH6ZD+/EIq/fhaoX0fNPOS3GStWmD1X127IDFbIV0xe24rEbclzzUX80w
 IJsdHdzU3tj3Re2C/+ZRee3E4YS9eT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Ry50BsD0PESLVvQv1b4Vfw-1; Tue, 28 Jul 2020 18:47:36 -0400
X-MC-Unique: Ry50BsD0PESLVvQv1b4Vfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51697102C7EC;
 Tue, 28 Jul 2020 22:47:35 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA9CF712FF;
 Tue, 28 Jul 2020 22:47:34 +0000 (UTC)
Date: Tue, 28 Jul 2020 18:47:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
Message-ID: <20200728224733.GP225270@habkost.net>
References: <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
MIME-Version: 1.0
In-Reply-To: <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.74; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 16:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 07:38:27PM +0200, Paolo Bonzini wrote:
> On 28/07/20 09:19, Markus Armbruster wrote:
> >> the composition tree generally mirrors things that are born and die
> >> at the same time, and creating children is generally reserved to the
> >> object itself.
> >
> > Yes.  Notable exceptions: containers /machine/peripheral,
> > /machine/peripheral-anon, /machine/unattached.
> 
> And /objects too.  Apart from /machine/unattached, all these dynamic
> objects are created by the monitor or the command line.
> 
> >>                 Children are usually embedded directly in a struct, for
> >> example.
> > 
> > We sometimes use object_new() + object_property_add_child() instead.
> > Extra indirection.  I guess we'd be better off without the extra
> > indirection most of the time.  Implementation detail.
> > 
> > We sometimes use object_new() without object_property_add_child(), and
> > have qdev_realize() put the device in the /machine/unattached orphanage.
> > Meh.  I guess the orphanage feature exists to make conversion to QOM
> > slightly easier.  Could we ban its use for new boards at least?
> 
> Banning perhaps is too strong, but yes /machine/unattached is an
> anti-pattern.
> 
> >> 3) accessing the QOM graph is slow (it requires hash table lookups,
> >> string comparisons and all that), so the pointers that cache the
> >> parent-child links are needed for use in hot paths.
> > 
> > True, but only because QOM's design opts for generality, efficiency be
> > damned :)
> 
> Remember that QOM's essential feature is the visitors: unlike GObject,
> QOM is not targeted at programming languages but rather at CLI and RPC.

This is surprising to me.  I never thought QOM was targeted at
the CLI or RPC.  (Every single property mentioned in this message
don't seem to be related to the CLI or RPC.)

About the visitors: I always had the impression that usage of
visitors inside QOM is unnecessary and avoidable (compared to
QAPI, where the visitors are an essential feature).


> 
> > I never quite understood why we need to build properties at run time.
> 
> I think it was (for once) Anthony reasoning that good is better than
> perfect.  You do need run-time properties for /machine/unattached,
> /machine/peripheral, etc., so he decided to only have run-time
> properties.  Introspection wasn't considered a primary design goal.
> 
> Also, even though child properties are quite often the same for all
> objects after initialization (and possibly realization) is complete,
> this does not cover in two cases:
> 
> 1) before the corresponding objects are created---so static child
> properties would only be possible if creation of all children is moved
> to instance_init, which is guaranteed not to fail.
> 
> 2) there are cases in which a property (e.g. an int) governs how many of
> those children exist, so you cannot create all children in instance_init.

Do we really need need QOM children to be accessible using the QOM
property API?

Using the same code for both user-configurable properties and for
the list of children of a QOM object might have saved some time
years ago, but I'm not sure this is still a necessary or useful
abstraction.

-- 
Eduardo


