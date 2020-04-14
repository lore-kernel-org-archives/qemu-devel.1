Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D1C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647702063A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4gXrqGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647702063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHdO-0007HG-Hq
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOHat-00067T-FJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOHar-0002fT-Sp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:10:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOHar-0002f7-NH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586855456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rjim4lb/ADNrO0+52UOe4CpPDmYvuUcle0wR4f8ohgY=;
 b=R4gXrqGE/ioXGi5L+/80ELTX3PpQAPzZTn5WaCnv9FbJxBS7F30AgOXO4esRSa2p1tfyli
 bqrDY3FgpTfdiX1JqHkSOFw8Z9BbApY6vmjwMra9befIdxFEgMIDFoiq46jr0y3DhgVMPy
 S1T+/htuCWOmVLIDjwpia1nPu5rF0Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Fa173O6xNeyxOsOZNov9Jg-1; Tue, 14 Apr 2020 05:10:55 -0400
X-MC-Unique: Fa173O6xNeyxOsOZNov9Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2460C107B0E1;
 Tue, 14 Apr 2020 09:10:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E334410016EB;
 Tue, 14 Apr 2020 09:10:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FE8C11385C8; Tue, 14 Apr 2020 11:10:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 1/8] tests-qemu-opts: Cover has_help_option(),
 qemu_opt_has_help_opt()
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-2-armbru@redhat.com>
 <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com>
Date: Tue, 14 Apr 2020 11:10:52 +0200
In-Reply-To: <8ea167d6-2784-1ab9-cf55-52eb7553cb4d@redhat.com> (Eric Blake's
 message of "Thu, 9 Apr 2020 12:50:13 -0500")
Message-ID: <878siyxwir.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/9/20 10:30 AM, Markus Armbruster wrote:
>> The two turn out to be inconsistent for "a,b,,help".  Test case
>> marked /* BUG */.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/test-qemu-opts.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>
>> +static void test_has_help_option(void)
>> +{
>> +    static const struct {
>> +        const char *params;
>> +        /* expected value of has_help_option() */
>> +        bool expect_has_help_option;
>> +        /* expected value of qemu_opt_has_help_opt() with implied=3Dfal=
se */
>> +        bool expect_opt_has_help_opt;
>> +        /* expected value of qemu_opt_has_help_opt() with implied=3Dtru=
e */
>> +        bool expect_opt_has_help_opt_implied;
>> +    } test[] =3D {
>> +        { "help", true, true, false },
>> +        { "helpme", false, false, false },
>> +        { "a,help", true, true, true },
>> +        { "a=3D0,help,b", true, true, true },
>> +        { "help,b=3D1", true, true, false },
>> +        { "a,b,,help", false /* BUG */, true, true },
>
> So which way are you calling the bug?  Without looking at the code but
> going off my intuition, I parse this as option 'a' and option
> 'b,help'. The latter is not a normal option name because it contains a
> ',', but is a valid option value.
>
> I agree that we have a bug, but I'm not yet sure in which direction
> the bug lies (should has_help_option be fixed to report true, in which
> case the substring ",help" has precedence over ',,' escaping; or
> should qemu_opt_has_help_opt be fixed to report false, due to treating
> 'b,help' after ',,' escape removal as an invalid option name).  So the
> placement of the /* BUG */ comment matters - where you placed it, I'm
> presuming that later in the series you change has_help_option to
> return true, even though that goes against my intuitive parse.

In addition to the canonical QemuOpts parser opts_do_parse(), we have
several more, and of course they all differ from the canonical one for
corner cases.

I treat the canonical one as correct, and fix the others by eliminating
the extra parsers.

The others are:

* has_help_option()

  Fixed in PATCH 5 by reusing the guts of opts_do_parse().

* is_valid_option_list()

  Fixed in PATCH 8 by not parsing.

* "id" extraction in opts_parse()

  Lazy hack.  Fixed in PATCH 3 by reusing the guts of opts_do_parse().

Back to your question: the value of has_help_option() differs from the
value of qemu_opt_has_help_opt().  The latter uses the canonical parser,
the former is one of the other parsers.  I therefore judge the latter
right and the former wrong.

Clear now?


