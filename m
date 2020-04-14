Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3520BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0183720767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrHx0PQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0183720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOP5k-0005u7-2T
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOP0v-0007Ex-S4
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOP0u-0006X3-J7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:06:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jOMZd-0007hM-68
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586874600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXQtC47q0STZGOLZvFnPSNQMBtuugVaAY967ayU1nnw=;
 b=PrHx0PQ7DE1YNl9ABQkJsC7MMGTSjB/peaR3SF0vd5XtEGz7DXvYQEaorbBbfC0CNnM4UW
 s7Kpx0EwTvBvyqw1h2XhVZA08bnR2q0yVuXRazRga2php615T5zSXlyDlEEA0SKTyeN0Ix
 +RIitcJ9se1x5Qe9nvsseFewkmfd7zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-wvsn2xwEMNW_tqwWpfhS-g-1; Tue, 14 Apr 2020 10:29:58 -0400
X-MC-Unique: wvsn2xwEMNW_tqwWpfhS-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CBCD1060DB1;
 Tue, 14 Apr 2020 14:30:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44CD196B93;
 Tue, 14 Apr 2020 14:29:56 +0000 (UTC)
Date: Tue, 14 Apr 2020 16:29:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
Message-ID: <20200414142954.GH7747@linux.fritz.box>
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-2-armbru@redhat.com>
 <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com>
 <878siyxwir.fsf@dusky.pond.sub.org>
 <20200414131339.GE7747@linux.fritz.box>
 <87v9m2p4to.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87v9m2p4to.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Am 14.04.2020 um 15:36 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> > Am 14.04.2020 um 11:10 hat Markus Armbruster geschrieben:
> >> Eric Blake <eblake@redhat.com> writes:
> >> > On 4/9/20 10:30 AM, Markus Armbruster wrote:
> >> >> +        { "helpme", false, false, false },
> >> >> +        { "a,help", true, true, true },
> >> >> +        { "a=3D0,help,b", true, true, true },
> >> >> +        { "help,b=3D1", true, true, false },
> >> >> +        { "a,b,,help", false /* BUG */, true, true },
> >> >
> >> > So which way are you calling the bug?  Without looking at the code b=
ut
> >> > going off my intuition, I parse this as option 'a' and option
> >> > 'b,help'. The latter is not a normal option name because it contains=
 a
> >> > ',', but is a valid option value.
> >> >
> >> > I agree that we have a bug, but I'm not yet sure in which direction
> >> > the bug lies (should has_help_option be fixed to report true, in whi=
ch
> >> > case the substring ",help" has precedence over ',,' escaping; or
> >> > should qemu_opt_has_help_opt be fixed to report false, due to treati=
ng
> >> > 'b,help' after ',,' escape removal as an invalid option name).  So t=
he
> >> > placement of the /* BUG */ comment matters - where you placed it, I'=
m
> >> > presuming that later in the series you change has_help_option to
> >> > return true, even though that goes against my intuitive parse.
> >>=20
> >> In addition to the canonical QemuOpts parser opts_do_parse(), we have
> >> several more, and of course they all differ from the canonical one for
> >> corner cases.
> >>=20
> >> I treat the canonical one as correct, and fix the others by eliminatin=
g
> >> the extra parsers.
> >>=20
> >> The others are:
> >>=20
> >> * has_help_option()
> >>=20
> >>   Fixed in PATCH 5 by reusing the guts of opts_do_parse().
> >>=20
> >> * is_valid_option_list()
> >>=20
> >>   Fixed in PATCH 8 by not parsing.
> >>=20
> >> * "id" extraction in opts_parse()
> >>=20
> >>   Lazy hack.  Fixed in PATCH 3 by reusing the guts of opts_do_parse().
> >>=20
> >> Back to your question: the value of has_help_option() differs from the
> >> value of qemu_opt_has_help_opt().  The latter uses the canonical parse=
r,
> >> the former is one of the other parsers.  I therefore judge the latter
> >> right and the former wrong.
> >
> > Shouldn't we also consider what users would reasonably expect?
>=20
> Of course we should consider reasonable user expectations.
>=20
> Grumpy aside: when I do, I commonly run into objections that users
> reasonably expect things not to change.

Fair point. It's not always easy to tell whether something should be
considered a bug in the external interface (and consequently be fixed)
or just an idiosyncrasy that people may have get used to (and therefore
requires deprecation before improving it).

In this specific case, I'm not aware of empty option names actually
doing anything useful anywhere, so I think it might be clearer in this
case that it's indeed a bug.

> > Getting it parsed as an empty option name (I assume with a default valu=
e
> > of "on"?) certainly looks like something that would surprise most users
> > and, as you can see, even some QEMU developers.
>=20
> My preferred way to address QemuOpts parsing madness is replacing it
> wholesale by keyval.c, but that's some time off, I'm afraid.
>=20
> This series merely aims for more method to the same old madness.

I understand. Though I think replacing with keyval will be potentially
less problematic if QemuOpts already behaved more similar.

If I were writing the code, I think I would use existing bugs and
inconsistencies as an excuse to make QemuOpts behave more like what
keyval can easily handle by declaring whatever is closest to keyval as
the correct interpretation.

Kevin


