Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F0E2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d68trrfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F0E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrpV-00085g-Re
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMron-0007ZH-Mw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMrom-00076V-Bm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:55:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMrom-00075o-8C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571741711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TfoqJkN0eEwDoYRLEqYXPEkr0a+BgLU5zGbmeD8OXE=;
 b=d68trrfS8t6JRVDy7Bc+bR7La+6/WckK3nMGOQ2vs2jbR5SR3Ns6eo43xOlBgXP9/qsLLy
 Hv+M4qRCjCdr7tJdOtLzXpxLX6WlB8MGncT05pZt9dNDkZ4u21bzZLmVS+dKg6gCt5Xr1p
 aNXpXZTgnCvg5TWw/1rk7cGOm4Xd+jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-rjh1hedaMViO8ewtmbbeTA-1; Tue, 22 Oct 2019 06:55:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F044B107AD31
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:55:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F275D6A5;
 Tue, 22 Oct 2019 10:55:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 243F21138619; Tue, 22 Oct 2019 12:55:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] runstate: ignore exit request in finish migrate state
References: <20191017101806.3644-1-lvivier@redhat.com>
 <ac941d4f-fd24-a84c-05d9-c0770a2fb088@redhat.com>
 <20191022101015.GD2815@work-vm>
Date: Tue, 22 Oct 2019 12:55:07 +0200
In-Reply-To: <20191022101015.GD2815@work-vm> (David Alan Gilbert's message of
 "Tue, 22 Oct 2019 11:10:15 +0100")
Message-ID: <87zhhthwxg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: rjh1hedaMViO8ewtmbbeTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 17/10/19 12:18, Laurent Vivier wrote:
>> > Trying to reboot a VM while a migration is running can
>> > move to the prelaunch state (because of the reset) while
>> > the runstate is in finish migrate state.
>> > As the logical step after the finish migrate is postmigrate,
>> > this can create an invalid state transition from prelaunch state
>> > to postmigrate state and this raises an error and aborts:
>> >=20
>> >     invalid runstate transition: 'prelaunch' -> 'postmigrate'
>> >=20
>> > As we are not able to manage reset in finish migrate state the
>> > best we can do is to ignore any changes and delay them until
>> > the next state which should be postmigrate and which should allow
>> > this kind of transition.
>> >=20
>> > Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> > ---
>> >  vl.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >=20
>> > diff --git a/vl.c b/vl.c
>> > index 0a295e5d77d6..dc71c822ba24 100644
>> > --- a/vl.c
>> > +++ b/vl.c
>> > @@ -1744,6 +1744,9 @@ static bool main_loop_should_exit(void)
>> >      RunState r;
>> >      ShutdownCause request;
>> > =20
>> > +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>> > +        return false;
>> > +    }
>> >      if (preconfig_exit_requested) {
>> >          if (runstate_check(RUN_STATE_PRECONFIG)) {
>> >              runstate_set(RUN_STATE_PRELAUNCH);
>> >=20
>>=20
>> Your patch makes sense, but I don't understand this function very much.
>>  In particular I don't understand why it returns true when
>> preconfig_exit_requested is true.  Wouldn't that cause main_loop() and
>> thus QEMU to exit?  Igor, can you help?
>
> It's because we now run main_loop() twice; once in the preconfig state
> and once the main main loop.
>
>
> 4323     /* do monitor/qmp handling at preconfig state if requested */
> 4324     main_loop();
>
> ....
>
> 4452     os_setup_post();
> 4453=20
> 4454     main_loop();
> 4455=20
> 4456     gdbserver_cleanup();

Commit 047f7038f5 "cli: add --preconfig option"

The whole thing is (in my opinion) a cheap hack we accepted for want of
better ideas we could get done in time.  Sometimes you have to hold you
nose and deliver.

https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg05584.html


