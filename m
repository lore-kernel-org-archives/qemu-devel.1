Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABAAC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835CA2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLsl0EwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835CA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPAW-0003S9-J8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isP9Y-0002Y3-Lo
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isP9U-0006IU-QJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:47:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isP9U-0006I5-MI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579258016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyAvnUeYswLLtEBDxwTqXTeGfzbMGUI0R61l+DVWL3A=;
 b=dLsl0EwEW0/32JmB6Cyl7AoDaVvIR8jbOsCE6XGKb0EPYtTwBryg6gN/Pg8d+fV53IrYqf
 tChUO6C6GCBRJG1meAedEpInVxDu4InBppmvzA4onsdJGWjp7gUAoVyGjDSGqRCMejlBN3
 U695htfrNDvn58O2i/b+lcH6jPINd1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-i_rcEvNQOEq38Y3vv4dDqw-1; Fri, 17 Jan 2020 05:46:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85E2800D41;
 Fri, 17 Jan 2020 10:46:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28FDB272A5;
 Fri, 17 Jan 2020 10:46:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B170B1138600; Fri, 17 Jan 2020 11:46:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 4/4] block: Mark 'block_resize' as coroutine
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-5-kwolf@redhat.com>
 <87tv4vzqd7.fsf@dusky.pond.sub.org>
 <20200116101333.GA9470@linux.fritz.box>
 <875zhbtox2.fsf@dusky.pond.sub.org>
 <20200116152312.GI9470@linux.fritz.box>
 <871rryr60a.fsf@dusky.pond.sub.org>
 <20200117092421.GB5646@dhcp-200-226.str.redhat.com>
Date: Fri, 17 Jan 2020 11:46:47 +0100
In-Reply-To: <20200117092421.GB5646@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 17 Jan 2020 10:24:21 +0100")
Message-ID: <87y2u6l5rc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: i_rcEvNQOEq38Y3vv4dDqw-1
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 17.01.2020 um 06:44 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 16.01.2020 um 16:13 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >>=20
>> >> > Am 16.01.2020 um 10:45 hat Markus Armbruster geschrieben:
[...]
>> >> >> Pardon my ignorant question: what exactly makes a function a
>> >> >> coroutine_fn?
>> >> >
>> >> > When Stefan requested adding the coroutine_fn marker, it seemed to =
make
>> >> > sense to me because the QMP dispatcher will always call it from
>> >> > coroutine context now, and being always run in coroutine context ma=
kes a
>> >> > function a coroutine_fn.
>> >> >
>> >> > However, it's also called from hmp_block_resize(), so at least for =
now
>> >> > coroutine_fn is actually wrong.
>> >>=20
>> >> This answers the question when we mark a function a coroutine_fn.  I
>> >> meant to ask what conditions the function itself must satisfy to be
>> >> eligible for this mark.
>> >
>> > The requirement is actually not about the function itself, it's about
>> > the callers, as stated above.
>> >
>> > But being a coroutine_fn allows the function to call other functions
>> > that only work in coroutine context (other coroutine_fns). In the end
>> > the reason why a function only works in coroutine context is usually
>> > that it (or any other coroutine_fns called by it) could yield, which
>> > obviously doesn't work outside of coroutine contest.
>>=20
>> Thanks.
>>=20
>> I think "being always run in coroutine context makes a function a
>> coroutine_fn" is inaccurate.  It's "calling a coroutine_fn without
>> switching to coroutine context first when not already in coroutine
>> context".  The induction terminates at basic coroutine_fn like
>> qemu_coroutine_yield().
>
> I think we would tend to mark things as coroutine_fn even if they don't
> call other coroutine_fns (yet), but would be allowed to. But this is now
> really splitting hairs.

Your hair-splitting is my education :)

> Maybe I should just have referred to the documentation in the source:
>
> /**
>  * Mark a function that executes in coroutine context
>  *
>  * Functions that execute in coroutine context cannot be called directly =
from
>  * normal functions.  In the future it would be nice to enable compiler o=
r
>  * static checker support for catching such errors.  This annotation migh=
t make
>  * it possible and in the meantime it serves as documentation.
>  *
>  * For example:
>  *
>  *   static void coroutine_fn foo(void) {
>  *       ....
>  *   }
>  */
> #define coroutine_fn

I had read that, of course, but it didn't quite enlighten me, so I
asked.

Perhaps it would have if it said "Mark a function that expects to run in
coroutine context".


