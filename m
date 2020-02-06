Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDA6C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A69221741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wfv0TNCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A69221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhYI-0002SA-7V
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1izhXL-0001wd-B3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1izhXJ-00009x-Cm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:49:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1izhXJ-00006W-72
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580996980;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWmka+qhZWPIQ5GSZVzUYi0TfmOxWcOPae+1UXg4W2M=;
 b=Wfv0TNCYGwYrGE0DAoWd6vx82WgiFY+OFbrRLrF0xEpBxiow75B9nHNlgD1f0cB6MCExGA
 DvL9FH3OwyRKp10gUK39fWSi6inmcyFZYzFCtpsFc5scFTHmytEwpMtxZyHNrZQu0WO5/1
 FCDk4GW9W2VhQGgl77mQwFc+jxxsJnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-CAxFTFBaNSaEGmmSOU4WqA-1; Thu, 06 Feb 2020 08:49:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8FCE800EB2;
 Thu,  6 Feb 2020 13:49:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C8D790E5;
 Thu,  6 Feb 2020 13:49:21 +0000 (UTC)
Date: Thu, 6 Feb 2020 13:49:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
Message-ID: <20200206134918.GM2391707@redhat.com>
References: <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
 <87tv45wdui.fsf@dusky.pond.sub.org>
 <20200205110250.GB5768@dhcp-200-226.str.redhat.com>
 <87blqdgl70.fsf@dusky.pond.sub.org>
 <87blqbu8xe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87blqbu8xe.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: CAxFTFBaNSaEGmmSOU4WqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 02:44:45PM +0100, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Kevin Wolf <kwolf@redhat.com> writes:
> >
> >> Am 05.02.2020 um 11:03 hat Markus Armbruster geschrieben:
> >>> Kevin Wolf <kwolf@redhat.com> writes:
> [...]
> >>> > Adding a key gets more complicated with your proposed interface bec=
ause
> >>> > state must be set explicitly now whereas before it was derived
> >>> > automatically from the fact that if you give a key, only active mak=
es
> >>> > sense.
> >>>=20
> >>> The explicitness could be viewed as an improvement :)
> >>
> >> Not really. I mean, I really know to appreciate the advantages of
> >> -blockdev where needed, but usually I don't want to type all that stuf=
f
> >> for the most common tasks. qemu-img amend is similar.
> >>
> >> For deleting, I might actually agree that explicitness is an
> >> improvement, but for creating it's just unnecessary verbosity.
> >>
> >>> If you'd prefer implicit here: Max has patches for making union tags
> >>> optional with a default.  They'd let you default active to true.
> >>
> >> I guess this would improve the usability in this case.
>=20
> Thinking and writing in the "Making QEMU easier for management tools and
> applications" monster thread have made me realize we're mixing up two
> aspects that ought to be kept separate: machine-friendly QMP and
> human-friendly CLI.
>=20
> You argue that
>=20
>     $ qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2
>=20
> is nicer than
>=20
>     $ qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.secr=
et=3Dsec0 test.qcow2
>=20
> and you do have a point: humans want their CLI terse.  Redundancy is
> unwanted, except perhaps to protect users from dangerous accidents.  In
> this example, state=3Dactive is redundant when a secret is given, because
> anything else would be an error.
>=20
> In QMP, however, we like things simple and explicit, and we eschew
> magic.
>=20
> This particular magic might just be simple enough to be acceptable in
> QMP.  We'd "merely" have to support explicit defaults in the schema (a
> clear improvement if you ask me), and optional union tags (tolerable as
> long as the default comes from the schema, I guess).
>=20
> My point is: QAPI schema design *must* focus on QMP and nothing else.
> If we try to serve both QMP and human-friendly CLI, we'll likely botch
> both.
>=20
> I believe a truly human-friendly CLI requires more than just
> human-friendly concrete syntax for QMP.  Same as HMP, really.

A human-friendly approach to this problem would never even
have the generic "amend" design IMHO. Friendly would be to
have a CLI that is approx the same as "cryptsetup" provides
eg

    $ qemu-img add-key /path/to/disk
    enter key>..
    re-enter key>...

or

    qemu-img add-key --keyfile /some/file.txt /path/to/disk


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


