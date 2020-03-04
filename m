Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E5AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD4920709
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTG0bJeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD4920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Rxn-0003v5-Mh
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9RxB-0003Ry-EB
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9Rx9-0003HE-Uq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:12:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9Rx9-0003GU-Pb
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583320358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62H0elrZKrZQtAYdZB6Y/hvkGj4LukajWlKg2++9QeQ=;
 b=LTG0bJeF7pcauH1yqNs7Crt+qHiY/u+oVx0k9B/fn0PDJ4HHQ8RRmD4JU0to/5mmNLUCEp
 B9H7Ldz94KqeQjIovEo1UOS8nNScR6tmdInKIVadeFXt4T5kBW9jwoRQ0zOkGkKgdoz7Ny
 Ggeiew72AYlRnpg2d5FE8GcDY3Eltkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-MKpY7BwsMV2FpPL-QK4KYA-1; Wed, 04 Mar 2020 06:12:37 -0500
X-MC-Unique: MKpY7BwsMV2FpPL-QK4KYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87559DB61;
 Wed,  4 Mar 2020 11:12:36 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B1591D92;
 Wed,  4 Mar 2020 11:12:35 +0000 (UTC)
Date: Wed, 4 Mar 2020 12:12:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v6 1/9] iotests: do a light delinting
Message-ID: <20200304111234.GB5477@dhcp-200-226.str.redhat.com>
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-2-jsnow@redhat.com>
 <5c3f3029-37c3-dd97-efb7-ea244742ab51@redhat.com>
 <c84ac4a9-7fa4-2dac-ed88-cf7c1441f0c4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c84ac4a9-7fa4-2dac-ed88-cf7c1441f0c4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.03.2020 um 22:25 hat John Snow geschrieben:
>=20
>=20
> On 2/27/20 7:59 AM, Max Reitz wrote:
> > On 27.02.20 01:06, John Snow wrote:
> >> This doesn't fix everything in here, but it does help clean up the
> >> pylint report considerably.
> >>
> >> This should be 100% style changes only; the intent is to make pylint
> >> more useful by working on establishing a baseline for iotests that we
> >> can gate against in the future. This will be important if (when?) we
> >> begin adding type hints to our code base.

I'm not sure I understand this connection. mypy doesn't care about
style.

> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  tests/qemu-iotests/iotests.py | 88 ++++++++++++++++++----------------=
-
> >>  1 file changed, 45 insertions(+), 43 deletions(-)
> >=20
> > I feel like I=E2=80=99m the wrongest person there is for reviewing a Py=
thon
> > style-fixing patch, but here I am and so here I go:
>=20
> No, it's good.

Max can't be the wrongest person for it because that's already me.

> >> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
> >> index 8815052eb5..e8a0ea14fc 100644
> >> --- a/tests/qemu-iotests/iotests.py
> >> +++ b/tests/qemu-iotests/iotests.py
> >=20
> > [...]
> >=20
> >> @@ -245,8 +243,7 @@ def qemu_nbd_early_pipe(*args):
> >>                            ' '.join(qemu_nbd_args + ['--fork'] + list(=
args))))
> >>      if exitcode =3D=3D 0:
> >>          return exitcode, ''
> >> -    else:
> >> -        return exitcode, subp.communicate()[0]
> >> +    return exitcode, subp.communicate()[0]
> >=20
> > If we want to make such a change (which I don=E2=80=99t doubt we want),=
 I think
> > it should be the other way around: Make the condition =E2=80=9Cexitcode=
 !=3D 0=E2=80=9D,
> > so the final return is the return for the successful case.  (Just
> > because I think that=E2=80=99s how we usually do it, at least in the qe=
mu code?)
> >=20
> > [...]
> >=20
>=20
> Yes, makes sense. I was behaving a little more mechanically.

Here and...

> >> @@ -756,12 +750,13 @@ def assert_block_path(self, root, path, expected=
_node, graph=3DNone):
> >>              assert node is not None, 'Cannot follow path %s%s' % (roo=
t, path)
> >> =20
> >>              try:
> >> -                node_id =3D next(edge['child'] for edge in graph['edg=
es'] \
> >> -                                             if edge['parent'] =3D=3D=
 node['id'] and
> >> -                                                edge['name'] =3D=3D c=
hild_name)
> >> +                node_id =3D next(edge['child'] for edge in graph['edg=
es']
> >> +                               if edge['parent'] =3D=3D node['id'] an=
d
> >> +                               edge['name'] =3D=3D child_name)
> >=20
> > I don=E2=80=99t mind the if alignment, but I do mind not aligning the t=
hird line
> > to the =E2=80=9Cedge=E2=80=9D above it (i.e. the third line is part of =
the condition, so
> > I=E2=80=99d align it to the =E2=80=9Cif=E2=80=9D condition).
> >=20
> > But then again it=E2=80=99s nothing new that I like to disagree with co=
mmonly
> > agreed-upon Python coding styles, so.
> >=20
> > [...]
> >=20
>=20
> OK, that can be addressed by highlighting the sub-expression with
> parentheses:
>=20
>         node_id =3D next(edge['child'] for edge in graph['edges']
>                        if (edge['parent'] =3D=3D node['id'] and
>                            edge['name'] =3D=3D child_name))

...here I must say that while I think Max's suggestions feel like an
improvement to me over the patch, I actually like the current code best
in both cases.

In fact, after scanning your patch, I feel it's actually the majority of
changes that pylint wants that aren't an improvement... Maybe this just
underlines the fact that I am the wrongest person to review such patches
and not Max. Though I'm surprised that I'm generally not the person who
introduces the code violating the rules, and I don't have the impression
in this thread that anyone is eager to defend pylint's opinion.

Now I ran pylint myself and it prints some even more ridiculous warnings
like variable names being too short for its liking. I guess this means
that if we want to run it without warnings or errors, we need to use a
config file anyway to disable the worst parts.

And if we have a config file anyway, maybe we can more selectively
enable the checks that we actually want?

Kevin


