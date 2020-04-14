Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FCC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A11F2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2Q075oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A11F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOS2A-0008Cr-LP
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jORx1-0001LQ-0Y
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jORwy-0000rX-LY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:14:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jORwy-0000r4-IM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586895267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GO5pvUc2I7ExFscZ7MkTuU9csC4ae8aPXOk6PsIi5w=;
 b=E2Q075oaTs3gSz3bR9EuRQTSX4FG4i5iwBoWbBJhZiG8vCRGZVbHnzyit6f8o+LL0qnqcI
 LRgQYgp+Ozpj4MYOdj9mhBiS3TcC9+r5GgbscH/hCbgcPPN3ESmjRev0YhAWFh3K3++XlV
 jNqApgCGaFHwFXImZpiliEAS8jlndUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-iIwH4YhsPFSgXToYzmCENA-1; Tue, 14 Apr 2020 16:14:23 -0400
X-MC-Unique: iIwH4YhsPFSgXToYzmCENA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C72480258A;
 Tue, 14 Apr 2020 20:13:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2022126510;
 Tue, 14 Apr 2020 20:13:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DF3211385C8; Tue, 14 Apr 2020 22:13:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-2-armbru@redhat.com>
 <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com>
 <878siyxwir.fsf@dusky.pond.sub.org>
 <20200414131339.GE7747@linux.fritz.box>
 <87v9m2p4to.fsf@dusky.pond.sub.org>
 <20200414142954.GH7747@linux.fritz.box>
Date: Tue, 14 Apr 2020 22:13:57 +0200
In-Reply-To: <20200414142954.GH7747@linux.fritz.box> (Kevin Wolf's message of
 "Tue, 14 Apr 2020 16:29:54 +0200")
Message-ID: <874ktlomey.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.04.2020 um 15:36 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > Am 14.04.2020 um 11:10 hat Markus Armbruster geschrieben:
>> >> Eric Blake <eblake@redhat.com> writes:
>> >> > On 4/9/20 10:30 AM, Markus Armbruster wrote:
>> >> >> +        { "helpme", false, false, false },
>> >> >> +        { "a,help", true, true, true },
>> >> >> +        { "a=3D0,help,b", true, true, true },
>> >> >> +        { "help,b=3D1", true, true, false },
>> >> >> +        { "a,b,,help", false /* BUG */, true, true },
>> >> >
>> >> > So which way are you calling the bug?  Without looking at the code =
but
>> >> > going off my intuition, I parse this as option 'a' and option
>> >> > 'b,help'. The latter is not a normal option name because it contain=
s a
>> >> > ',', but is a valid option value.
>> >> >
>> >> > I agree that we have a bug, but I'm not yet sure in which direction
>> >> > the bug lies (should has_help_option be fixed to report true, in wh=
ich
>> >> > case the substring ",help" has precedence over ',,' escaping; or
>> >> > should qemu_opt_has_help_opt be fixed to report false, due to treat=
ing
>> >> > 'b,help' after ',,' escape removal as an invalid option name).  So =
the
>> >> > placement of the /* BUG */ comment matters - where you placed it, I=
'm
>> >> > presuming that later in the series you change has_help_option to
>> >> > return true, even though that goes against my intuitive parse.
>> >>=20
>> >> In addition to the canonical QemuOpts parser opts_do_parse(), we have
>> >> several more, and of course they all differ from the canonical one fo=
r
>> >> corner cases.
>> >>=20
>> >> I treat the canonical one as correct, and fix the others by eliminati=
ng
>> >> the extra parsers.
>> >>=20
>> >> The others are:
>> >>=20
>> >> * has_help_option()
>> >>=20
>> >>   Fixed in PATCH 5 by reusing the guts of opts_do_parse().
>> >>=20
>> >> * is_valid_option_list()
>> >>=20
>> >>   Fixed in PATCH 8 by not parsing.
>> >>=20
>> >> * "id" extraction in opts_parse()
>> >>=20
>> >>   Lazy hack.  Fixed in PATCH 3 by reusing the guts of opts_do_parse()=
.
>> >>=20
>> >> Back to your question: the value of has_help_option() differs from th=
e
>> >> value of qemu_opt_has_help_opt().  The latter uses the canonical pars=
er,
>> >> the former is one of the other parsers.  I therefore judge the latter
>> >> right and the former wrong.
>> >
>> > Shouldn't we also consider what users would reasonably expect?
>>=20
>> Of course we should consider reasonable user expectations.
>>=20
>> Grumpy aside: when I do, I commonly run into objections that users
>> reasonably expect things not to change.
>
> Fair point. It's not always easy to tell whether something should be
> considered a bug in the external interface (and consequently be fixed)
> or just an idiosyncrasy that people may have get used to (and therefore
> requires deprecation before improving it).
>
> In this specific case, I'm not aware of empty option names actually
> doing anything useful anywhere, so I think it might be clearer in this
> case that it's indeed a bug.

You're right in that backward compatibility is not a convincing argument
for stuff that has no known productive uses, and is bonkers to boot.

>> > Getting it parsed as an empty option name (I assume with a default val=
ue
>> > of "on"?) certainly looks like something that would surprise most user=
s
>> > and, as you can see, even some QEMU developers.
>>=20
>> My preferred way to address QemuOpts parsing madness is replacing it
>> wholesale by keyval.c, but that's some time off, I'm afraid.
>>=20
>> This series merely aims for more method to the same old madness.
>
> I understand. Though I think replacing with keyval will be potentially
> less problematic if QemuOpts already behaved more similar.
>
> If I were writing the code, I think I would use existing bugs and
> inconsistencies as an excuse to make QemuOpts behave more like what
> keyval can easily handle by declaring whatever is closest to keyval as
> the correct interpretation.

Fair enough.

However,

(1) is_valid_option_list()'s and opts_do_parse()'s parse of "a,b,,help"
    are equidistant from keyval_parse()'s:

    opts_do_parse() splits it into four parts:

        "a"     (desugared to a=3Don)
        "b"     (desugared to b=3Don)
        ""      (desugared to =3Don)
        "help"  (desugared to help=3Don)

    has_help_option() splits it into two:

        "a"
        "b,help"

    keyval_parse() fails:

        Expected '=3D' after parameter 'a'

    If I it implemented boolean sugar, then it would fail at the third
    comma, just like ",help" fails now:

        Invalid parameter ''

    Fails because ",help" does not start with a valid name.

    Thus, the answer to the question which of the two functions covered
    by the test are wrong would be "both".

(2) This series tries hard not to write QemuOpts parsing code.  It
    throws away QemuOpts parsing code.


