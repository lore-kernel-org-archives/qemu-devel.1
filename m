Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7414C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE620208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhHMqcoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE620208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJtmK-0006N6-RX
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 02:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJtlW-0005b3-2G
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJtlU-0000PF-6r
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:55:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJtlU-0000Or-1d
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585810547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwP1KFcbFh5gXb0r+rx7MYtZCbuKDCn8lA5qQkB7T/4=;
 b=FhHMqcoBSr+31369piSfgoA3AvTtFNhNSbrk/N/OKK0M/0ARQ/xMKCPVvmhy9rV+cTwCer
 RGyTd50T9FiDWBSJM5Ht+Wv826j6B5DRpL+3aOMKhaUGaedtZjv5oHur6Ja264s1zFTxLp
 h0fGNqDSp2/BqnyCke/FFwHD98DRyFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-w2t_pxsgN_C33xt4n5_liA-1; Thu, 02 Apr 2020 02:55:43 -0400
X-MC-Unique: w2t_pxsgN_C33xt4n5_liA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6531B107B28A;
 Thu,  2 Apr 2020 06:55:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8476B5E037;
 Thu,  2 Apr 2020 06:55:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FFA811385E2; Thu,  2 Apr 2020 08:55:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
 <87wo6zoku0.fsf@dusky.pond.sub.org>
 <CAFEAcA-mZ5nPOoPz0kafmEjUORYQj-DvieMeWqgbFarp1_DhNg@mail.gmail.com>
 <87tv23fepa.fsf@dusky.pond.sub.org>
 <CAFEAcA82AzhV3DSO=nogJg1YLwKk3RrGPVRe85ByhFbaW=YCJQ@mail.gmail.com>
Date: Thu, 02 Apr 2020 08:55:32 +0200
In-Reply-To: <CAFEAcA82AzhV3DSO=nogJg1YLwKk3RrGPVRe85ByhFbaW=YCJQ@mail.gmail.com>
 (Peter Maydell's message of "Wed, 1 Apr 2020 16:12:44 +0000")
Message-ID: <87d08qbcm3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Denis
 V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 1 Apr 2020 at 15:44, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > On Wed, 1 Apr 2020 at 06:07, Markus Armbruster <armbru@redhat.com> wro=
te:
>> > But then as a coccinelle script author I need to know which of
>> > the options I needed are standard, which are for-this-script-only,
>> > and which are just 'workflow'.
>>
>> If you're capable of writing a Coccinelle script that actually does what
>> you want, I bet you dollars to donuts that you can decide which options
>> actually affect the patch in comparably no time whatsoever ;)
>
> I use this thing maybe once a month at most, more likely once
> every three months, and the documentation is notoriously
> impenetrable. I really really don't want to have to start looking in it
> and guessing about how the original author ran the script, when
> they could have just told me.

I'm afraid we're talking part each other.

>> If you prefer to bother your reader with your personal choices, that's
>> between you and your reviewers.  Myself, I prefer less noise around the
>> signal.
>
>> If you got Coccinelle installed and know the very basics, then the
>> incantation in the script should suffice to use the script, and the
>> incantation in the commit message should suffice to reproduce the patch.
>
> So I need to now look in the git log for the script to find the commit
> message? Why not just put the command in the file and save steps?

I'm not opposed to usage comments in .cocci.

I *am* apposed to noise in usage comments.

>> Example:
>>
>>     commit 4e20c1becba3fd2e8e71a2663cefb9627fd2a6e0
>>     Author: Markus Armbruster <armbru@redhat.com>
>>     Date:   Thu Dec 13 18:51:54 2018 +0100
>>
>>         block: Replace qdict_put() by qdict_put_obj() where appropriate
>>
>>         Patch created mechanically by rerunning:
>>
>>           $  spatch --sp-file scripts/coccinelle/qobject.cocci \
>>                     --macro-file scripts/cocci-macro-file.h \
>>                     --dir block --in-place
>
> Yep, that command line would be great to see in the script file.

Except for the --dir block part, which is even worse than noise: it
suggests this is just for block/, which is wrong.

>> scripts/coccinelle/qobject.cocci has no usage comment.  I doubt it needs
>> one, but I'd certainly tolerate something like
>
>     // Usage:
>     // spatch --sp-file scripts/coccinelle/qobject.cocci \
>     //        --macro-file scripts/cocci-macro-file.h \
>     //        FILES ...
>
> I think that should be about the minimum. I think every
> .cocci file should say how it was used or is supposed to be used.

Fine with me.

> The least-effort way for the author of the script to do that is to
> simply give the command line they used to run it.

If you're capable of writing a Coccinelle script that actually does what
you want, you're certainly capable of doing better than blindly paste
from your shell history.  Kindly drop the options that are specific to
just this particular use of the script.  Keep the ones that future users
will actually need.

>> >       That's more work for the author *and* more work for the
>> > reader than just "put the command line you used into the script
>> > as a comment" -- so who's it benefiting?
>>
>> Anyone with basic Coccinelle proficiency benefits slightly from the
>> reduction of noise.
>
> How 'basic' is basic? I think that being specific is useful for
> anybody who's at my level or lower (ie, can write a script, doesn't
> do so often enough to be able to write a script or run spatch
> without looking at documentation and cribbing from other scripts
> as examples). How many people do we have at a higher level
> than that for whom this is noise? 2? 3? And people who do
> know Coccinelle well should have no difficulty in quickly
> looking at a command line and mentally filtering out the options
> that they don't feel they need.

Two proficiencies: using a script somebody else wrote, and writing
simple scripts.  Let me try to sketch just about the most basic of basic
levels for the former.  Note that I'm making *liberal* allowance for
reluctance to learn tools[*].

Understand

* that .cocci means Coccinelle
* how to install Coccinelle
* that you need to feed the .cocci to spatch
* that this produces a patch
* how to apply the patch to the tree

None of this I want to explain in every .cocci script.  All of this
I want be explained in scripts/coccinelle/README.


[*] Not a trait I like to see in craftsmen.


