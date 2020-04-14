Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7325C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9310C20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h98ivOh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9310C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPKc-00047T-Mi
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOOwj-0007fu-66
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOOwf-0002r1-AG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:02:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOMBu-0001l5-3T
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586873129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7c+Lu2vsbU84O+Xkqb0dwQFHWNxrp0KfedEvIPj8EBk=;
 b=h98ivOh87/gwh26U2Hc+cpeqesvuDgD9iPRIbNKToD3AO02yEH6+yklvwB8uo4EFxCIzoi
 VDS5y2TXvKQTQ0OVDO09NrsTFh3SZ1nJntfeRfj+S6C6qW0ustApDhHKfHRPr3DspALLmn
 ALxgbwZ3lIwaXEQ/jROKLJnqQgyFqqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-lJxFm8vzNhCKdpuk2MCeYg-1; Tue, 14 Apr 2020 10:05:26 -0400
X-MC-Unique: lJxFm8vzNhCKdpuk2MCeYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6DC5802568;
 Tue, 14 Apr 2020 14:05:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E4039F99D;
 Tue, 14 Apr 2020 14:05:19 +0000 (UTC)
Date: Tue, 14 Apr 2020 16:05:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-5.1 2/8] qemu-options: Factor out
 get_opt_name_value() helper
Message-ID: <20200414140517.GF7747@linux.fritz.box>
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-3-armbru@redhat.com>
 <5f39e636-f799-55f3-873f-08a3a0f53dca@redhat.com>
 <87blnuwght.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87blnuwght.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.04.2020 um 11:42 hat Markus Armbruster geschrieben:
> Eric Blake <eblake@redhat.com> writes:
>=20
> > On 4/9/20 10:30 AM, Markus Armbruster wrote:
> >> The next commits will put it to use.
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>   util/qemu-option.c | 102 +++++++++++++++++++++++++------------------=
--
> >>   1 file changed, 56 insertions(+), 46 deletions(-)
> >>
> >
> >> +static const char *get_opt_name_value(const char *params,
> >> +                                      const char *firstname,
> >> +                                      char **name, char **value)
> >> +{
> >> +    const char *p, *pe, *pc;
> >> +
> >> +    pe =3D strchr(params, '=3D');
> >> +    pc =3D strchr(params, ',');
> >> +
> >> +    if (!pe || (pc && pc < pe)) {
> >> +        /* found "foo,more" */
> >> +        if (firstname) {
> >> +            /* implicitly named first option */
> >> +            *name =3D g_strdup(firstname);
> >> +            p =3D get_opt_value(params, value);
> >
> > Is this correct even when params is "foo,,more"?  But...
> >
> >>   static void opts_do_parse(QemuOpts *opts, const char *params,
> >>                             const char *firstname, bool prepend,
> >>                             bool *invalidp, Error **errp)
> >>   {
> >> -    char *option =3D NULL;
> >> -    char *value =3D NULL;
> >> -    const char *p,*pe,*pc;
> >>       Error *local_err =3D NULL;
> >> +    char *option, *value;
> >> +    const char *p;
> >>   -    for (p =3D params; *p !=3D '\0'; p++) {
> >> -        pe =3D strchr(p, '=3D');
> >> -        pc =3D strchr(p, ',');
> >> -        if (!pe || (pc && pc < pe)) {
> >> -            /* found "foo,more" */
> >> -            if (p =3D=3D params && firstname) {
> >> -                /* implicitly named first option */
> >> -                option =3D g_strdup(firstname);
> >> -                p =3D get_opt_value(p, &value);
> >
> > ...in this patch, it is just code motion, so if it is a bug, it's
> > pre-existing and worth a separate fix.
>=20
> If @p points to "foo,,more", possibly followed by additional characters,
> then we have pc && pc < pe, and enter this conditional.  This means that
>=20
>     foo,,more=3D42
>=20
> gets parsed as two name=3Dvalue, either as
>=20
>     name        value
>     -----------------------
>     @firstname  "foo,more"
>     ""          "42"
>=20
> if @firstname is non-null

Hm, how that? get_opt_value() doesn't stop at '=3D', so shouldn't you get
a single option @firstname with a value of "foo,more=3D42"?

     name        value
     -----------------------
     @firstname  "foo,more=3D42"

> or else as
>=20
>     name        value
>     -----------------
>     "foo,,more" "on"
>     ""          "42"

Here get_opt_name() stops at the first comma. You get a positive flag
"foo" and the remaing option string starts with a comma, so the
condition will still be true for the next loop iteration. Now you get a
positive flag with an empty name "". Finally, the rest is parsed as an
option, so we get:

     name        value
     -----------------------
     "foo"       "on"
     ""          "on"
     "more"      "42"

Actually, at this point I thought I could just check, and gdb confirms
my reading for both cases.

This is still crazy, but perhaps less so than the interpretations you
suggested.

Kevin


