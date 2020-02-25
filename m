Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421EEC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C68920732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K47lu+Bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C68920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dss-00079K-1O
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6dqu-0005m3-He
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6dqs-0000cd-Lv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:18:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6dqs-0000aq-48
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582651111;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOQIC/l0/VIwmdcK5+B9rDpemt2Ydosd8CCDl5wK6o0=;
 b=K47lu+BdyyYtFCgU6A5AsUOzLfQ4pFedIMuxFImD7N1laaEumZ+42Crfrqr6xNVVDHEsRQ
 TKX4LLYPZ2sHCobcyzDVrsPqH+YmuHeEOUbYCQvmeqnfFTuH6gf6V0YZ9a6Co9XEnyfI8y
 gPCXN//ixK2LpVx4FVscO17Cej+LP4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-T2ZS7ayZNxqpQ32VG-eAUQ-1; Tue, 25 Feb 2020 12:18:29 -0500
X-MC-Unique: T2ZS7ayZNxqpQ32VG-eAUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94880800D53;
 Tue, 25 Feb 2020 17:18:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 820AF5C241;
 Tue, 25 Feb 2020 17:18:26 +0000 (UTC)
Date: Tue, 25 Feb 2020 17:18:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots
Message-ID: <20200225171823.GV1148628@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <ad92d470-7388-c419-f3fb-0bfd541b670b@redhat.com>
 <871rqid35p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rqid35p.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 05:48:02PM +0100, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
> > On 15.02.20 15:51, Markus Armbruster wrote:
> >> Review of this patch led to a lengthy QAPI schema design discussion.
> >> Let me try to condense it into a concrete proposal.
> >>=20
> >> This is about the QAPI schema, and therefore about QMP.  The
> >> human-friendly interface is out of scope.  Not because it's not
> >> important (it clearly is!), only because we need to *focus* to have a
> >> chance at success.
> >>=20
> >> I'm going to include a few design options.  I'll mark them "Option:".
> >>=20
> >> The proposed "amend" interface takes a specification of desired state,
> >> and figures out how to get from here to there by itself.  LUKS keyslot=
s
> >> are one part of desired state.
> >>=20
> >> We commonly have eight LUKS keyslots.  Each keyslot is either active o=
r
> >> inactive.  An active keyslot holds a secret.
> >>=20
> >> Goal: a QAPI type for specifying desired state of LUKS keyslots.
> >>=20
> >> Proposal:
> >>=20
> >>     { 'enum': 'LUKSKeyslotState',
> >>       'data': [ 'active', 'inactive' ] }
> >>=20
> >>     { 'struct': 'LUKSKeyslotActive',
> >>       'data': { 'secret': 'str',
> >>                 '*iter-time': 'int } }
> >>=20
> >>     { 'struct': 'LUKSKeyslotInactive',
> >>       'data': { '*old-secret': 'str' } }
> >>=20
> >>     { 'union': 'LUKSKeyslotAmend',
> >>       'base': { '*keyslot': 'int',
> >>                 'state': 'LUKSKeyslotState' }
> >>       'discriminator': 'state',
> >>       'data': { 'active': 'LUKSKeyslotActive',
> >>                 'inactive': 'LUKSKeyslotInactive' } }
> >
> > Looks OK to me.  The only thing is that @old-secret kind of works as an
> > address, just like @keyslot,
>=20
> It does.
>=20
> >                              so it might also make sense to me to put
> > @keyslot/@old-secret into a union in the base structure.
>=20
> I'm fine with state-specific extra adressing modes (I better be, I
> proposed them).
>=20
> I'd also be fine with a single state-independent addressing mode, as
> long as we can come up with sane semantics.  Less flexible when adding
> states, but we almost certainly won't.
>=20
> Let's see how we could merge my two addressing modes into one.
>=20
> The two are
>=20
> * active
>=20
>   keyslot     old-secret      slot(s) selected
>   absent      N/A             one inactive slot if exist, else error
>   present     N/A             the slot given by @keyslot
>=20
> * inactive
>=20
>   keyslot     old-secret      slot(s) selected
>   absent      absent          all keyslots
>   present     absent          the slot given by @keyslot
>   absent      present         all active slots holding @old-secret
>   present     present         the slot given by @keyslot, error unless
>                               it's active holding @old-secret
>=20
> They conflict:
>=20
> > (One of the problems that come to mind with that approach is that not
> > specifying either of @old-secret or @keyslot has different meanings for
> > activating/inactivating a keyslot: When activating it, it means =E2=80=
=9CThe
> > first unused one=E2=80=9D; when deactivating it, it=E2=80=99s just an e=
rror because it
> > doesn=E2=80=99t really mean anything.)
> >
> > *shrug*
>=20
> Note we we don't really care what "inactive, both absent" does.  My
> proposed semantics are just the most regular I could find.  We can
> therefore resolve the conflict by picking "active, both absent":
>=20
>   keyslot     old-secret      slot(s) selected
>   absent      absent          one inactive slot if exist, else error
>   present     absent          the slot given by @keyslot
>   absent      present         all active slots holding @old-secret
>   present     present         the slot given by @keyslot, error unless
>                               it's active holding @old-secret
>=20
> Changes:
>=20
> * inactive, both absent: changed; we select "one inactive slot" instead o=
f
>   "all slots".
>=20
>   "All slots" is a no-op when the current state has no active keyslots,
>   else error.
>=20
>   "One inactive slot" is a no-op when the current state has one, else
>   error.  Thus, we no-op rather than error in some states.
>=20
> * active, keyslot absent or present, old-secret present: new; selects
>   active slot(s) holding @old-secret, no-op when old-secret =3D=3D secret=
,
>   else error (no in place update)
>=20
> Can do.  It's differently irregular, and has a few more combinations
> that are basically useless, which I find unappealing.  Matter of taste,
> I guess.
>=20
> Anyone got strong feelings here?

I don't feel like the changes give us any real world benefit, and
especially think deleting one arbitrary slot is just wierd.

IMHO, inactive with both keyslot & old-secret missing should just
be an error condition.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


