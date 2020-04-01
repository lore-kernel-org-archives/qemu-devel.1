Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB731C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC33206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M48qbXmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC33206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJecP-0003Dz-O1
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJebl-0002jL-6H
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJebj-0006JB-R9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:44:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJebj-0006Gh-O3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585752283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxsiBbFCk7qrIbQmXSu6PO3jvxbmxG1HTNAHdxeRGnE=;
 b=M48qbXmjmqJmJXqunvuEs2uEKhznEx/dJm4i+9jj+DNSK9/UcGo3uInjeD203Y17MtI1hB
 E8n5va8uKEeWa2iZsuhCASauCl9HZaemH1g9ouMZ7hqjmXYNRpjyhSuE4b8fAMaLD64hrj
 e3h2IJubIsIJ5BeokI2BwfgOkA+S8jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-4gqFYkXKPiOwb5sW8qrmNg-1; Wed, 01 Apr 2020 10:44:39 -0400
X-MC-Unique: 4gqFYkXKPiOwb5sW8qrmNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7394F107ACC9;
 Wed,  1 Apr 2020 14:44:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54F4A19C69;
 Wed,  1 Apr 2020 14:44:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8949D11385E2; Wed,  1 Apr 2020 16:44:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
 <87wo6zoku0.fsf@dusky.pond.sub.org>
 <CAFEAcA-mZ5nPOoPz0kafmEjUORYQj-DvieMeWqgbFarp1_DhNg@mail.gmail.com>
Date: Wed, 01 Apr 2020 16:44:33 +0200
In-Reply-To: <CAFEAcA-mZ5nPOoPz0kafmEjUORYQj-DvieMeWqgbFarp1_DhNg@mail.gmail.com>
 (Peter Maydell's message of "Wed, 1 Apr 2020 11:04:41 +0000")
Message-ID: <87tv23fepa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Denis V. Lunev" <den@openvz.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 1 Apr 2020 at 06:07, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Generic instructions for using .cocci scripts should go into README.
>> Enough to get you started if you know nothing about Coccinelle.
>>
>> Options that should always be used with a certain script should be
>> documented in that script.
>>
>> Options that only affect work-flow, not the patch, I'd rather keep out
>> of the script.  If there are any we feel we should mention, do that in
>> README.  Example: --no-show-diff.
>
> But then as a coccinelle script author I need to know which of
> the options I needed are standard, which are for-this-script-only,
> and which are just 'workflow'.

If you're capable of writing a Coccinelle script that actually does what
you want, I bet you dollars to donuts that you can decide which options
actually affect the patch in comparably no time whatsoever ;)

If you prefer to bother your reader with your personal choices, that's
between you and your reviewers.  Myself, I prefer less noise around the
signal.

>                                And as a reader I *still* need to
> go and look through the README and look at this script and
> then try to reconstitute what command line might have been
> used.

You don't.  The "just work-flow" options by definition do not affect the
patch.

If you got Coccinelle installed and know the very basics, then the
incantation in the script should suffice to use the script, and the
incantation in the commit message should suffice to reproduce the patch.

If you know nothing about Coccinelle, the README should get you started.

Example:

    commit 4e20c1becba3fd2e8e71a2663cefb9627fd2a6e0
    Author: Markus Armbruster <armbru@redhat.com>
    Date:   Thu Dec 13 18:51:54 2018 +0100

        block: Replace qdict_put() by qdict_put_obj() where appropriate

        Patch created mechanically by rerunning:

          $  spatch --sp-file scripts/coccinelle/qobject.cocci \
                    --macro-file scripts/cocci-macro-file.h \
                    --dir block --in-place

        Signed-off-by: Markus Armbruster <armbru@redhat.com>
        Reviewed-by: Alberto Garcia <berto@igalia.com>
        Reviewed-by: Eric Blake <eblake@redhat.com>
        Signed-off-by: Kevin Wolf <kwolf@redhat.com>

scripts/coccinelle/qobject.cocci has no usage comment.  I doubt it needs
one, but I'd certainly tolerate something like

    // Usage:
    // spatch --sp-file scripts/coccinelle/qobject.cocci \
    //        --macro-file scripts/cocci-macro-file.h \
    //        FILES ...

I'd even tolerate throwing in --in-place.  But --use-gitgrep is too much
for my taste.

>       That's more work for the author *and* more work for the
> reader than just "put the command line you used into the script
> as a comment" -- so who's it benefiting?

Anyone with basic Coccinelle proficiency benefits slightly from the
reduction of noise.

Coccinelle noobs benefit from the more verbose instructions in the
README.  Duplicating those in every script is not maintainable.

Maintainers benefit slightly from less redundancy.

>> Brief instructions for how a patch was created should be included in the
>> commit message.  They should suffice for readers familiar with
>> Coccinelle.  Yes, there's a bit of redundancy with README and the
>> script.


