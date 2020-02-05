Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD68C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BBC217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI1viVtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BBC217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKTk-0005OM-CA
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izKRh-00049V-KO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izKRd-0001zt-JP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izKRd-0001sf-6A
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580908213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnBC7FiBfB4t2JU3nYKzZZYEuld5OwAD+bBu0TYQ7fI=;
 b=bI1viVtCWsiOklqSANoxar5o+RD6JEj1YZStaA3BMELNPotj4YqGXRVmSkgF7ybJPb/vp4
 QxBBG5jiMiIsFrpGXp71VRYsLGzwRuFNTpPNKl+8XZLDilPzYBaeq0hmi/6TVWFIzxWImT
 QLsrAQ4+258PBbMZ/GR8MqfkheVSnzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-5FTPrfSzNPmLikHfv14xgQ-1; Wed, 05 Feb 2020 08:10:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A7CA0CDC;
 Wed,  5 Feb 2020 13:10:04 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1188F5DA7C;
 Wed,  5 Feb 2020 13:09:47 +0000 (UTC)
Date: Wed, 5 Feb 2020 14:09:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200128105932.GC6431@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5FTPrfSzNPmLikHfv14xgQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.01.2020 um 11:59 hat Kevin Wolf geschrieben:
> > > The other part that it needs to solve is how to be available by defau=
lt
> > > without specifying anything on the command line. Basically, if I pres=
s
> > > Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
> > > implemented internally or by an external Python process, I don't mind=
.
> >=20
> > That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mostly
> > use HMP on stdin).
>=20
> I don't think it would be that hard, actually.
>=20
> If you have a -qmp-shell option that takes a chardev and defaults to vc,
> you've solved the part with both stdio and Ctrl-Alt-2. Now all you need
> to do is launch the Python child process, pass it a pair of pipes for
> communication and forward everything between the pipes and the chardev.
>=20
> (That's the theory anyway.)

If someone is interested, I did a quick proof-of-concept hack:

    https://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/qmp-shell

It doesn't clean up anything properly (including the qmp-shell processes
it starts), but it spawns a usable qmp-shell on a user-specified
character device. stdio seems to work, though without readline
functionality (I suppose I still have line-buffering somewhere), vc
doesn't really work at all yet.

Try it out like this:

    $ ./qemu-storage-daemon --chardev stdio,id=3Dm --monitor m,mode=3Dqmp-s=
hell
    monitor_qmp_event: 1
    Welcome to the QMP low-level shell!
    Connected to QEMU 4.2.50

    (QEMU) query-version
    {"return": {"qemu": {"micro": 50, "major": 4, "minor": 2}, "package": "=
v4.2.0-1188-gd95a3885a9"}}
    (QEMU) quit

(Or use x86_64-softmmu/qemu-system-x86_64, but it's based on the
refactorings in the storage daemon branch, so why not try both at once?)

Polishing this to make it mergable would still require substantial work,
so at the moment I'm not planning to do this. But if someone wants to
pick it up, feel free (just let us know).

Hm, in fact... A qmp-shell GSoC project?

Kevin


