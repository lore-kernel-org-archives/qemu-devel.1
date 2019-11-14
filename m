Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB3C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2FF206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQvRGwbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2FF206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCpz-0003yA-6x
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iVCpI-0003RI-RL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iVCpH-0005rz-GL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:58:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iVCpH-0005rc-D4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573729091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hrpnXes6d6ykTr9S1TgPkHYSolZ1yNdGO/fi+PjEKY=;
 b=FQvRGwbDgt734Cr3S0LWH0hAmGmknJ2BPxN36cOTi5Y2VhJFAC2PgPcoXF+4jYEIHefu4P
 XhL6vVN6VcjEVLJ25/9lQYdWZhE4eEcfKd7aARYvOQQbxHQwah3t1caUoq1vv8MvWSnuvj
 cUN7rDw1989C+vxhRSwzrXkG9nwlTB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-T5zmQ8gENj2pKJupjJp9RA-1; Thu, 14 Nov 2019 05:58:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D146A186E6E3;
 Thu, 14 Nov 2019 10:58:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3420C60BFB;
 Thu, 14 Nov 2019 10:58:02 +0000 (UTC)
Message-ID: <5218a8db9c6abfc0f9102a6e0b693eaf09e57f0e.camel@redhat.com>
Subject: Re: API definition for LUKS key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Date: Thu, 14 Nov 2019 12:58:00 +0200
In-Reply-To: <20191112091245.GB5364@linux.fritz.box>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191111183424.GR814211@redhat.com>
 <20191112091245.GB5364@linux.fritz.box>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: T5zmQ8gENj2pKJupjJp9RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 John Ferlan <jferlan@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-11-12 at 10:12 +0100, Kevin Wolf wrote:
> Am 11.11.2019 um 19:34 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Mon, Nov 11, 2019 at 05:58:20PM +0200, Maxim Levitsky wrote:
> > > One of the concerns that was raised during the review was that amend =
interface for luks that I propose is
> > > different from the amend inteface used currently for qcow2.
> > >=20
> > > qcow2 amend interface specifies all the format options, thus overwrit=
es the existing options.
> > > Thus it seems natural to make the luks amend interface work the same =
way, that it receive an array
> > > of 8 slots, and for each slot specify if it is active, and if true wh=
at password to put in it.
> > > This does allow to add and erase the keyslots, but it doesn't allow:
> > >=20
> > >    * add a password without knowing all other passwords that exist in=
 existing keyslots
> > >      this can be mitigated by specifying which keyslots to modify for=
 example by omitting the
> > >      keyslots that shouldn't be touched from the array (passing null =
placeholder instead)
> > >      but then it already doesn't follow the 'specify all the options =
each time' principle.
> >=20
> > I think this is highly undesirable, as we must not assume that the
> > mgmt app has access to all the passwords currently set.
>=20
> And I think this shows the problem that we realy have with the crypto
> driver and amend: For every other driver, if you must, you can query the
> current settings and just write them back.
>=20
> The difference here is that crypto doesn't allow to directly query or
> specify the content of some options (the keyslots), but provides only a
> way to derives that content from a secret, and obviously there is no way
> back from the stored data to the secret (that's what it's for).
>=20
> I think we have two options here:
>=20
> 1. Add a special "don't touch this" value for keyslots. Normally, just
>    leaving out the value would be suitable syntax for this. Here,
>    however, we have a list of keyslots, so we can't leave anything out.
>=20
>    We could use something like an alternate between str (new secret ID),
>    null (erase keyslot) and empty dict (leave it alone) - the latter
>    feels a bit hackish, but maybe it's not too bad. If the list is
>    shorter than 8 entries, the rest is assumed to mean "leave it alone",
>    too.
>=20
> 2. Allow to query and set the raw key, which doesn't require a password
>=20
> > The two key use cases for having multiple key slots are
> >=20
> >   - To enable a two-phase change of passwords to ensure new password
> >     is safely written out before erasing the old password
> >    =20
> >   - To allow for multiple access passwords with different controls
> >     or access to when each password is made available.
> >=20
> >     eg each VM may have a separate "backup password" securely
> >     stored off host that is only made available for use when
> >     doing disaster recovery.
> >=20
> > the second use case is doomed if you need to always provide all
> > current passwords when changing any key slots.
>=20
> That providing all current passwords doesn't work is obvious.

I also want to *emphasise* that not being able to provide all the keyslots
is the smaller problem here, since it is relatively easy to omit slots that
should be left untouched.
The bigger problem is supporting the 'erase all keyslots that match the pas=
sword'
That doesn't fit into current amend definition at all.

>=20
> > >    * erase all keyslots matching a password - this is really hard to =
do using this approach,
> > >      unless we give user some kind of api to try each keyslot with gi=
ven password,
> > >      which is kind of ugly and might be racy as well.
> > > So what do you think?
> >=20
> > The point of using "amend" is that we already have some of the boilerpl=
ate
> > supporting framework around that, so it saves effort for both QEMU and
> > our users. If the semantics of "amend" don't fit nicely though, then th=
e
> > benefit of re-using "amend" is cancelled out and we should go back to
> > considering a separate "key-manage" command.
>=20
> This wouldn't solve the fundamental problem that the crypto block
> driver, as it currently is, isn't able to provide a blockdev-amend
> callback. It's worse for qcow2 because qcow2 already implements amend.
>=20
> I think we need to find a solution for the amend API.
>=20
> Kevin

Best regards,
=09Maxim Levitsky



