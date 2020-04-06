Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2A8C2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A719D22246
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giYhbe80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A719D22246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSRT-0002mF-SL
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jLSNi-0007fq-ND
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jLSNg-0008IA-Os
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:05:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jLSNg-0008I2-L4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586181940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+4kbNaYKSc37XZ9+Furg1Tl1WS9KYQK9628t6eyCzg=;
 b=giYhbe80+Qk+X1dgI+1RjV0QmEzPx0wgIC42B1M+FOF1ufHsZrIdzG9ErSg2Bhgym8vgYa
 cOJswSRgHbTfNgNLZkcrWIn+8Tq75aWvBhZOHVvPkJgKjBBu3ELlIKWUDPlq5Ni99wf87X
 5kUMf0EBFKnWsOA7BsWEhsW6A3+a/og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-xr3WpJeUP1-xHtW-G5EonQ-1; Mon, 06 Apr 2020 10:05:37 -0400
X-MC-Unique: xr3WpJeUP1-xHtW-G5EonQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD031005509;
 Mon,  6 Apr 2020 14:05:36 +0000 (UTC)
Received: from localhost (ovpn-116-201.gru2.redhat.com [10.97.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43D62277B6;
 Mon,  6 Apr 2020 14:05:33 +0000 (UTC)
Date: Mon, 6 Apr 2020 11:05:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Questionable aspects of QEMU Error's design
Message-ID: <20200406140531.GE299832@habkost.net>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
 <87sghjfre8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sghjfre8.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 04, 2020 at 12:59:27PM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> QEMU's Error was patterned after GLib's GError.  Differences include:
> > [...]
> >> * Return value conventions
> >>
> >>   Common: non-void functions return a distinct error value on failure
> >>   when such a value can be defined.  Patterns:
> >>
> >>   - Functions returning non-null pointers on success return null point=
er
> >>     on failure.
> >>
> >>   - Functions returning non-negative integers on success return a
> >>     negative error code on failure.
> >>
> >>   Different: GLib discourages void functions, because these lead to
> >>   awkward error checking code.  We have tons of them, and tons of
> >>   awkward error checking code:
> >>
> >>     Error *err =3D NULL;
> >>     frobnicate(arg, &err);
> >>     if (err) {
> >>         ... recover ...
> >>         error_propagate(errp, err);
> >>     }
> >>
> >>   instead of
> >>
> >>     if (!frobnicate(arg, errp))
> >>         ... recover ...
> >>     }
> >>
> >>   Can also lead to pointless creation of Error objects.
> >>
> >>   I consider this a design mistake.  Can we still fix it?  We have mor=
e
> >>   than 2000 void functions taking an Error ** parameter...
> >>
> >>   Transforming code that receives and checks for errors with Coccinell=
e
> >>   shouldn't be hard.  Transforming code that returns errors seems more
> >>   difficult.  We need to transform explicit and implicit return to
> >>   either return true or return false, depending on what we did to the
> >>   @errp parameter on the way to the return.  Hmm.
> > [...]
> >
> > To figure out what functions with an Error ** parameter return, I used
> > Coccinelle to find such function definitions and print the return types=
.
> > Summary of results:
> >
> >    2155 void
> >     873 signed integer
> >     494 pointer
> >     153 bool
> >      33 unsigned integer
> >       6 enum
> >    ---------------------
> >    3714 total
> >
> > I then used Coccinelle to find checked calls of void functions (passing
> > &error_fatal or &error_abort is not considered "checking" here).  These
> > calls become simpler if we make the functions return a useful value.  I
> > found a bit under 600 direct calls, and some 50 indirect calls.
> >
> > Most frequent direct calls:
> >
> >     127 object_property_set_bool
> >      27 qemu_opts_absorb_qdict
> >      16 visit_type_str
> >      14 visit_type_int
> >      10 visit_type_uint32
> >
> > Let's have a closer look at object_property_set() & friends.  Out of
> > almost 1000 calls, some 150 are checked.  While I'm sure many of the
> > unchecked calls can't actually fail, I am concerned some unchecked call=
s
> > can.
> >
> > If we adopt the convention to return a value that indicates success /
> > failure, we should consider converting object.h to it sooner rather tha=
n
> > later.
> >
> > Please understand these are rough numbers from quick & dirty scripts.
>=20
> Paolo, Daniel, Eduardo,
>=20
> Please pick one for QOM:

Replying this without reading the whole discussion and context:

>=20
> * Do nothing.  Looks like
>=20
>      object_property_set_bool(..., &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
>=20
> * Return true on success, false on error.  Looks like
>=20

I prefer this one.

>      if (!object_property_set_bool(..., errp)) {
>          return;
>      }
>=20
> * Return 0 on success, -1 on error.  Looks like
>=20
>      if (object_property_set_bool(..., errp) < 0) {
>          return;
>      }
>=20
>   This is slightly more likely to require line wrapping than the
>   previous one.

--=20
Eduardo


