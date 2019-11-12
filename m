Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A35C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDAF206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="godzF7Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDAF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTxy-0007vg-KH
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iUTwc-0007Ny-4k
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iUTwW-0007ks-N8
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:02:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iUTwW-0007kF-EI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573556559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHBwXmcusgob1tw6Cs/GshIqvdX+LFyga6dcQARmgTU=;
 b=godzF7Z0BdLWoQUQHw4hbmM8iVsaSENlDUHuKbic9HGceltBFqret4pj0HnGxtW73NPBr/
 5JQ+AJm9n8t93Ej3676RwpRW2QLnXa5p2EgJ5uH7L/2BW1Ax2306Dwqk7XXq4n4pY2KBKW
 iRh44VGwaUioIdeGIx5tKOm0h/cbP7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-dPR8NrkPOtqp7B_Q92hXZg-1; Tue, 12 Nov 2019 06:02:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5420911A3;
 Tue, 12 Nov 2019 11:02:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92FF910027B5;
 Tue, 12 Nov 2019 11:02:30 +0000 (UTC)
Date: Tue, 12 Nov 2019 11:02:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: API definition for LUKS key management
Message-ID: <20191112110227.GN2366658@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191111183424.GR814211@redhat.com>
 <20191112091245.GB5364@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191112091245.GB5364@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: dPR8NrkPOtqp7B_Q92hXZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 10:12:45AM +0100, Kevin Wolf wrote:
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

I'd be very wary of having a "null" vs "empty dict" distinction to
mean "erase" vs "don't touch".

It feels like that is designed to maximise the chances of someone
shooting themselves in the foot by accidentally using "null" instead
of an "empty dict".

The reason for the use of "active=3Dyes" / "active=3Dno" is because that
was reasonable explicit about wanting to erase a keyslot, and it does
does actually map to the key slot on disk which has an "active" field
taking two magic values.

> 2. Allow to query and set the raw key, which doesn't require a password

I don't think I understand what you mean here. If you don't have a
password the only change you can make is to erase key slots.

> > >    * erase all keyslots matching a password - this is really hard to =
do using this approach,
> > >      unless we give user some kind of api to try each keyslot with gi=
ven password,
> > >      which is kind of ugly and might be racy as well.
> >=20
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


BTW, looking forward to the future, if we ever implement LUKS version 2
support there are a bunch more things can be tweaked at runtime. Most
notable is that it is possible to change the master key, and change the
encryption algorithm choices. Both of these then need to trigger a bulk
re-encrypt of the entire disk contents, which takes a long time.

I doubt we'll do this in the near term, but we should consider how this
might fit into whatever scheme we pick for updates.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


