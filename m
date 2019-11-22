Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AE5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1492071C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6/x4CNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1492071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBZY-0001Ld-Cf
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iYBXm-0008Av-22
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iYBXi-0005t8-OP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:12:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iYBXi-0005sq-KD
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574439141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aa8cr2L5PAalYf6hTB88HRavTcaQp/GfSYwCnB3HnFo=;
 b=a6/x4CNKVFiGsTaxZkXCr/UoIM7Xo+i0fYsJlp3t2tLLLvok7BOYXBmzNMz2hQcR5T6uBu
 m0jdQO8jJFbvwtg9gz4/Z2reo4fa9VyCzta42WkmqtqjQLmEI30icf3c51s63Nhb5IdNho
 w6d0NyTpm43nHaLAuFxMaXt5fvs+azs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-mZ9A0nC0ODyza3paZhaUtA-1; Fri, 22 Nov 2019 11:12:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB3418B5F6B;
 Fri, 22 Nov 2019 16:12:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-252.ams2.redhat.com [10.36.117.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6602446453;
 Fri, 22 Nov 2019 16:12:17 +0000 (UTC)
Date: Fri, 22 Nov 2019 17:12:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qapi: Introduce default values for
 struct members
Message-ID: <20191122161215.GD4433@linux.fritz.box>
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-4-mreitz@redhat.com>
 <87eey1b73y.fsf@dusky.pond.sub.org>
 <0214e73e-062e-a9c8-16c9-e99354c07277@redhat.com>
 <871ru1811o.fsf@dusky.pond.sub.org>
 <817914b7-79d7-a2c9-142b-0a040b1da7ff@redhat.com>
 <874kyw74jn.fsf@dusky.pond.sub.org>
 <20191122102519.GB4433@linux.fritz.box>
 <87k17sq8im.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87k17sq8im.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mZ9A0nC0ODyza3paZhaUtA-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.11.2019 um 15:40 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 22.11.2019 um 08:29 hat Markus Armbruster geschrieben:
> >> > At any rate, your counterpoint is taken - whatever we pick, we'll wa=
nt
> >> > to make sure that introspection can expose semantics, and whether we
> >> > can make '*' redundant with some other form of longhand in the qapi
> >> > language is in part determined by whether we also reflect that throu=
gh
> >> > introspection.
> >>=20
> >> Introspection has the true member name, without the '*' prefix.
> >>=20
> >> We'll also want to avoid unnecessary compromises on QAPI schema
> >> expressiveness.  If we use null to mean "schema does not specify
> >> behavior when member is absent", we can't use it to mean "absent membe=
r
> >> behaves like the value null".  A bit of a blemish, but I think it's a
> >> tolerable one.
> >
> > If you want an example for an option that defaults to null, take the
> > backing option of BlockdevOptionsGenericCOWFormat.
> >
> > What is the reason for even considering limiting the expressiveness? Do
> > you think that an additional 'optional' bool, at least for those option=
s
> > that don't have a default, would be so bad in the longhand form? Or
> > keeping '*' even in the longhand form, as suggested below.
>=20
> Well, one reason is this:
>=20
>     ##
>     # @SchemaInfoObjectMember:
>     #
>     # An object member.
>     #
>     # @name: the member's name, as defined in the QAPI schema.
>     #
>     # @type: the name of the member's type.
>     #
>     # @default: default when used as command parameter.
>     #           If absent, the parameter is mandatory.
>     #           If present, the value must be null.  The parameter is
>     #           optional, and behavior when it's missing is not specified
>     #           here.
>     #           Future extension: if present and non-null, the parameter
>     #           is optional, and defaults to this value.
>     #
>     # Since: 2.5
>     ##
>=20
> If we want to be able to express the difference between "behavior when
> absent is not specified here" and "absent behaves like value null", then
> we need to somehow add that bit of information here.
>=20
> Could use a feature.  Features are not yet implemented for members, but
> we need them anyway.

That definition wasn't a great idea, I'm afraid. :-(

But "default is QNull" is still acceptable behaviour for "not
specified" if the client doesn't need to know what the default is.

> >> >                 If that means that keeping '*' in the longhand form =
of
> >> > optional members (whether or not those members have a default value)=
,
> >> > then so be it.
> >>=20
> >> I believe both
> >>=20
> >>     '*KEY': { 'type': ARG': 'default': null }
> >>=20
> >> and
> >>=20
> >>     'KEY': { 'type': ARG': 'default': null }
> >>=20
> >> are viable longhand forms for '*KEY': 'ARG'.
> >>=20
> >> I prefer the latter, but I'm open to arguments.
> >
> > If you go for the former, then you certainly want to use absent
> > 'default' to indicate no default, and allow a QNull default with
> > 'default': null.
> >
> > The only reason to abuse 'default': null for no default is that you
> > can't distinguish optional and non-optional if you use 'KEY' for both
> > instead of 'KEY' for mandatory and '*KEY' for optional.
> >
> > So while I understand and to some degree share your dislike for the '*'
> > prefix, I think I cast my pragmatic vote for:
> >
> > mandatory:                   'KEY':  { 'type': 'ARG' }
> > optional without a default:  '*KEY': { 'type': 'ARG' }
> > optional with QNull default: '*KEY': { 'type': 'ARG', 'default': null }
>=20
> The last one could also be     'KEY': { 'type': 'ARG', 'default': null }
> without loss of expressiveness.
>=20
> Differently ugly.

Not loss of expressiveness, but loss of consistency.

> Here's yet another idea.  For the "absent is not specified here" case,
> use
>=20
>     'KEY': { 'type': 'ARG', optional: true }
>     '*KEY': 'ARG'
>=20
> For the "absent defaults to DEFVAL" case, use
>=20
>     'KEY': { 'type': 'ARG', optional: true, 'default': DEFVAL }
>     'KEY': { 'type': 'ARG', 'default': DEFVAL }

I assume this means: 'optional' defaults to true if 'default' is
present, and to false if 'default' is absent. (It's an example of a
default that can't be expressed in the schema.)

Works for me.

Kevin


