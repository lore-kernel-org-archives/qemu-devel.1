Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3457C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA5D207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G61nfUz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA5D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j55W1-00021o-Ux
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j55VQ-0001bF-HS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j55VP-0003VZ-Fo
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:26:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j55VP-0003V9-Bs
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582280758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWHp7UJ+iuNrvvkTAkgknJN4pFQix2N3TG9NIPvtJpM=;
 b=G61nfUz4RWCHjQfcee4OfF1AcOrOMq9iUHRJkJSqmpjHfrQ0mlJCsd8tUzIGni9Z0MlFGM
 5SlKvGiqwNixhRLr0Egr0moKtUTx22SFnj2hJKQTKaw1FE9m7y/PQaPDbo7YYK6G37xx3L
 4Y6JX5JxGii1Bdpk+Y/ySyd2xfuEExo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-nqXrpn5sMiCkJJk25zgK2A-1; Fri, 21 Feb 2020 05:25:56 -0500
X-MC-Unique: nqXrpn5sMiCkJJk25zgK2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C56018AB2C0;
 Fri, 21 Feb 2020 10:25:55 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C13819076D;
 Fri, 21 Feb 2020 10:25:51 +0000 (UTC)
Date: Fri, 21 Feb 2020 10:25:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
Message-ID: <20200221102548.GA2931@work-vm>
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org> <20200220201155.GJ2836@work-vm>
 <87k14ga1ud.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87k14ga1ud.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>=20
> > * Markus Armbruster (armbru@redhat.com) wrote:
> [...]
> >> Collecting several users before building infrastructure makes sense wh=
en
> >> the design of the infrastructure isn't obvious, or when the need for i=
t
> >> is in doubt.
> >>=20
> >> Neither is the case for running QMP handlers in a coroutine: QMP
> >> commands blocking the main loop is without doubt a problem we need to
> >> solve, and the way to solve it was obvious enough for Kevin to do it
> >> with one user: block_resize.  A second one quickly followed: screendum=
p.
> >>=20
> >> The only part that's different for HMP, I think, is "need".
> >>=20
> >> Is HMP blocking the main loop a problem?
> >>=20
> >> If yes, is it serious enough to justify solving it?
> >
> > I don't mind if HMP blocks for a small time while doing something, but
> > not if it can hang if the guest (or something else like it) misbehaves.
> > Not if it's something you might need to issue another command to recove=
r
> > from.
>=20
> The issue isn't HMP being unavailable while a command executes.  The
> issue is HMP stopping the main loop while a command executes.
>=20
> Stopping the main loop not only stops everything running there, it can
> also stop other threads when they synchronize with the main loop via the
> Big QEMU Lock.

Yep.

> The obvious example is a command accessing a remote filesystem.  Special
> case: NFS with the hard option can hang indefinitely.

That I don't worry about too much for HMP; if your host is hosed, fix your =
host.

> screendump does that, and also waits for asynchronous gfx_update() with
> qxl devices.  Networking again, with a different peer.

That I would worry about since that's probably got interactions with the
guest and spice, and all the type of things you might be trying to debug
or test.

> We already decided that QMP commands stopping the main loop is serious.
>=20
> To say it's not serious for HMP amounts to "don't do that then, use
> QMP".  Which may be fair.  Not for me to decide, though.

It's certainly more important for QMP; you don't want the main lock
being held for everyday type of interactions with management layers.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


