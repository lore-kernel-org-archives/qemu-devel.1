Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA377C352B6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 13:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773BA2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 13:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxVHPaKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773BA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOLPy-0007Gm-JI
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 09:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOLNr-0005JZ-V2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOLNq-0000qG-AA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:13:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOLNq-0000q3-2t
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586870025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBnnOFBSemn/BN7E0K4FWFIpUV+6Zyn7G1T3/Q72ZTY=;
 b=XxVHPaKRYnmC7oobupPp9MeiixXkfdpMzeN4xJjtt+F5ObyuritDAenplkZvjkWUNdLg6g
 joMIKTXBNdm8pV4z0IIUzFCZKpvWRGmBbrYecCJszzrehlrW2pm6tPwH7uet4kidguEOcp
 FHu27wGuX4pvd7DM21d8330rLN5YI4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-vq8xt5OQN_GBwF538pD1gw-1; Tue, 14 Apr 2020 09:13:42 -0400
X-MC-Unique: vq8xt5OQN_GBwF538pD1gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9F4A13F7;
 Tue, 14 Apr 2020 13:13:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B3CB5D9E2;
 Tue, 14 Apr 2020 13:13:40 +0000 (UTC)
Date: Tue, 14 Apr 2020 15:13:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
Message-ID: <20200414131339.GE7747@linux.fritz.box>
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-2-armbru@redhat.com>
 <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com>
 <878siyxwir.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <878siyxwir.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.04.2020 um 11:10 hat Markus Armbruster geschrieben:
> Eric Blake <eblake@redhat.com> writes:
>=20
> > On 4/9/20 10:30 AM, Markus Armbruster wrote:
> >> The two turn out to be inconsistent for "a,b,,help".  Test case
> >> marked /* BUG */.
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>   tests/test-qemu-opts.c | 38 ++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 38 insertions(+)
> >>
> >
> >> +static void test_has_help_option(void)
> >> +{
> >> +    static const struct {
> >> +        const char *params;
> >> +        /* expected value of has_help_option() */
> >> +        bool expect_has_help_option;
> >> +        /* expected value of qemu_opt_has_help_opt() with implied=3Df=
alse */
> >> +        bool expect_opt_has_help_opt;
> >> +        /* expected value of qemu_opt_has_help_opt() with implied=3Dt=
rue */
> >> +        bool expect_opt_has_help_opt_implied;
> >> +    } test[] =3D {
> >> +        { "help", true, true, false },

While we're talking about unintuitive, I feel the result for
implied=3Dtrue is confusing, too. Never noticed it before, but are we
really sure that it is the best possible behaviour that '-chardev help'
and '-chardev id=3Dfoo,help' print two entirely different help texts?

I'm not requesting to change anything about this in this series, but
just making the point that maybe sometimes the existing behaviour is
questionable.

> >> +        { "helpme", false, false, false },
> >> +        { "a,help", true, true, true },
> >> +        { "a=3D0,help,b", true, true, true },
> >> +        { "help,b=3D1", true, true, false },
> >> +        { "a,b,,help", false /* BUG */, true, true },
> >
> > So which way are you calling the bug?  Without looking at the code but
> > going off my intuition, I parse this as option 'a' and option
> > 'b,help'. The latter is not a normal option name because it contains a
> > ',', but is a valid option value.
> >
> > I agree that we have a bug, but I'm not yet sure in which direction
> > the bug lies (should has_help_option be fixed to report true, in which
> > case the substring ",help" has precedence over ',,' escaping; or
> > should qemu_opt_has_help_opt be fixed to report false, due to treating
> > 'b,help' after ',,' escape removal as an invalid option name).  So the
> > placement of the /* BUG */ comment matters - where you placed it, I'm
> > presuming that later in the series you change has_help_option to
> > return true, even though that goes against my intuitive parse.
>=20
> In addition to the canonical QemuOpts parser opts_do_parse(), we have
> several more, and of course they all differ from the canonical one for
> corner cases.
>=20
> I treat the canonical one as correct, and fix the others by eliminating
> the extra parsers.
>=20
> The others are:
>=20
> * has_help_option()
>=20
>   Fixed in PATCH 5 by reusing the guts of opts_do_parse().
>=20
> * is_valid_option_list()
>=20
>   Fixed in PATCH 8 by not parsing.
>=20
> * "id" extraction in opts_parse()
>=20
>   Lazy hack.  Fixed in PATCH 3 by reusing the guts of opts_do_parse().
>=20
> Back to your question: the value of has_help_option() differs from the
> value of qemu_opt_has_help_opt().  The latter uses the canonical parser,
> the former is one of the other parsers.  I therefore judge the latter
> right and the former wrong.

Shouldn't we also consider what users would reasonably expect?

Getting it parsed as an empty option name (I assume with a default value
of "on"?) certainly looks like something that would surprise most users
and, as you can see, even some QEMU developers.

Kevin


