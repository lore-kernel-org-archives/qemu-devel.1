Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E8CC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C197E2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIWudsZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C197E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPPw-0003TT-Ql
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOP7E-0008Bw-4T
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOP7C-0003rp-TU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:12:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOLjm-0001oA-L0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YsfOzAvX5A1PpdTevpkBf/9GkxlvNPhfZaziVQBfagE=;
 b=hIWudsZRiLUg7zpVGsubMo2BMvev/9tCbJwoQZSeU6hqGHJmzGhr9b3mzatm0ACI958q92
 CnHQ2ABU8dfwTzZHJg1Q95lYfOxOrCAUN8M92x7c3Sfn6pfHyf7orGi8hLi6aQ1unZso/8
 EVpfV/v1wS1Ay8k+ZxdaBEiWZWP0fjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-v_fpdkhiMSiEWSWfEctKzg-1; Tue, 14 Apr 2020 09:36:22 -0400
X-MC-Unique: v_fpdkhiMSiEWSWfEctKzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1F991005509;
 Tue, 14 Apr 2020 13:36:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3769F60BE1;
 Tue, 14 Apr 2020 13:36:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 933E311385C8; Tue, 14 Apr 2020 15:36:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-2-armbru@redhat.com>
 <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com>
 <878siyxwir.fsf@dusky.pond.sub.org>
 <20200414131339.GE7747@linux.fritz.box>
Date: Tue, 14 Apr 2020 15:36:19 +0200
In-Reply-To: <20200414131339.GE7747@linux.fritz.box> (Kevin Wolf's message of
 "Tue, 14 Apr 2020 15:13:39 +0200")
Message-ID: <87v9m2p4to.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.04.2020 um 11:10 hat Markus Armbruster geschrieben:
>> Eric Blake <eblake@redhat.com> writes:
>>=20
>> > On 4/9/20 10:30 AM, Markus Armbruster wrote:
>> >> The two turn out to be inconsistent for "a,b,,help".  Test case
>> >> marked /* BUG */.
>> >>
>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >> ---
>> >>   tests/test-qemu-opts.c | 38 ++++++++++++++++++++++++++++++++++++++
>> >>   1 file changed, 38 insertions(+)
>> >>
>> >
>> >> +static void test_has_help_option(void)
>> >> +{
>> >> +    static const struct {
>> >> +        const char *params;
>> >> +        /* expected value of has_help_option() */
>> >> +        bool expect_has_help_option;
>> >> +        /* expected value of qemu_opt_has_help_opt() with implied=3D=
false */
>> >> +        bool expect_opt_has_help_opt;
>> >> +        /* expected value of qemu_opt_has_help_opt() with implied=3D=
true */
>> >> +        bool expect_opt_has_help_opt_implied;
>> >> +    } test[] =3D {
>> >> +        { "help", true, true, false },
>
> While we're talking about unintuitive, I feel the result for
> implied=3Dtrue is confusing, too. Never noticed it before, but are we
> really sure that it is the best possible behaviour that '-chardev help'
> and '-chardev id=3Dfoo,help' print two entirely different help texts?
>
> I'm not requesting to change anything about this in this series, but
> just making the point that maybe sometimes the existing behaviour is
> questionable.

The QEMU CLI may sometimes be confusing?!?  I'm shocked, sir, I'm
shocked!

>> >> +        { "helpme", false, false, false },
>> >> +        { "a,help", true, true, true },
>> >> +        { "a=3D0,help,b", true, true, true },
>> >> +        { "help,b=3D1", true, true, false },
>> >> +        { "a,b,,help", false /* BUG */, true, true },
>> >
>> > So which way are you calling the bug?  Without looking at the code but
>> > going off my intuition, I parse this as option 'a' and option
>> > 'b,help'. The latter is not a normal option name because it contains a
>> > ',', but is a valid option value.
>> >
>> > I agree that we have a bug, but I'm not yet sure in which direction
>> > the bug lies (should has_help_option be fixed to report true, in which
>> > case the substring ",help" has precedence over ',,' escaping; or
>> > should qemu_opt_has_help_opt be fixed to report false, due to treating
>> > 'b,help' after ',,' escape removal as an invalid option name).  So the
>> > placement of the /* BUG */ comment matters - where you placed it, I'm
>> > presuming that later in the series you change has_help_option to
>> > return true, even though that goes against my intuitive parse.
>>=20
>> In addition to the canonical QemuOpts parser opts_do_parse(), we have
>> several more, and of course they all differ from the canonical one for
>> corner cases.
>>=20
>> I treat the canonical one as correct, and fix the others by eliminating
>> the extra parsers.
>>=20
>> The others are:
>>=20
>> * has_help_option()
>>=20
>>   Fixed in PATCH 5 by reusing the guts of opts_do_parse().
>>=20
>> * is_valid_option_list()
>>=20
>>   Fixed in PATCH 8 by not parsing.
>>=20
>> * "id" extraction in opts_parse()
>>=20
>>   Lazy hack.  Fixed in PATCH 3 by reusing the guts of opts_do_parse().
>>=20
>> Back to your question: the value of has_help_option() differs from the
>> value of qemu_opt_has_help_opt().  The latter uses the canonical parser,
>> the former is one of the other parsers.  I therefore judge the latter
>> right and the former wrong.
>
> Shouldn't we also consider what users would reasonably expect?

Of course we should consider reasonable user expectations.

Grumpy aside: when I do, I commonly run into objections that users
reasonably expect things not to change.

> Getting it parsed as an empty option name (I assume with a default value
> of "on"?) certainly looks like something that would surprise most users
> and, as you can see, even some QEMU developers.

My preferred way to address QemuOpts parsing madness is replacing it
wholesale by keyval.c, but that's some time off, I'm afraid.

This series merely aims for more method to the same old madness.


