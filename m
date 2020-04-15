Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C477C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69C2206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccWq/Ov3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69C2206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObYh-000838-07
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jObIs-000714-VQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jObIq-0005Pl-Qb
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:13:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jObIq-0005PY-JU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586931219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zf088sJhE9oY4AFzHAkOHlJ4lon/P0g7XykIEaXPNw=;
 b=ccWq/Ov32s8KDxrRwX9lIPGKTuAq+pRIQexcdj34hqQji+QqDDBNsab/RjILhdVloagjBB
 hX9hvOhDOrXvtK+v4pCEl5esPNNVVTb8QJMvoXe9KNhEIAyCUebr/AOedDp4fbWETbow46
 qTYWvRf3SeTlOv8xZb0IDaEx2mmfmmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-nwcilXuVOuGGHCAliVI48A-1; Wed, 15 Apr 2020 02:13:37 -0400
X-MC-Unique: nwcilXuVOuGGHCAliVI48A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2998D1403;
 Wed, 15 Apr 2020 06:13:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE1B5D9E5;
 Wed, 15 Apr 2020 06:13:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F32C11385C8; Wed, 15 Apr 2020 08:13:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 for-5.0] configure: warn if not using a separate build
 directory
References: <20200406153326.806024-1-berrange@redhat.com>
 <CAFEAcA8rXBty2tHZOoqQA+mEcxEYiBntjeKj07-NUiPH+NWxmg@mail.gmail.com>
Date: Wed, 15 Apr 2020 08:13:34 +0200
In-Reply-To: <CAFEAcA8rXBty2tHZOoqQA+mEcxEYiBntjeKj07-NUiPH+NWxmg@mail.gmail.com>
 (Peter Maydell's message of "Tue, 14 Apr 2020 20:25:36 +0100")
Message-ID: <87zhbdl1ip.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 6 Apr 2020 at 16:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>>
>> Running configure directly from the source directory is a build
>> configuration that will go away in future. It is also not currently
>> covered by any automated testing. Display a deprecation warning if
>> the user attempts to use an in-srcdir build setup, so that they are
>> aware that they're building QEMU in an undesirable manner.

The warning text has evolved since v5, but the commit message hasn't
quite kept up, I think.

>>
>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>
> Given where we are in the release cycle, I think this isn't
> going to go in for 5.0; and it's not really that urgent now
> we've decided we don't want to actually deprecate in-tree builds.

Have we?

We had a Aleksandar assert that out-of-tree builds can't do certain
things, which led to the decision to soften this patch's warning from
"deprecated; better use the grace period to adjust, and here's how to"
to "not recommended; here's the recommended way".  Since we know in-tree
builds are more fragile, we owe our users such a warning.  We should've
added it long ago.

We also had a few people telling us that in-tree builds are so much more
convenient for them that we doing extra work to keep them working for
them is totally worth it for them.  SCNR.

Whether we want to keep sinking time & energy into an extra way to build
will become irrelevant once we move to Meson, unless Meson deviates from
its "this is an opinionated build tool, not a 'give users all the rope
they may possibly want, and then some'" approach in a surprising lapse
of judgement.

> I've removed the text I put into the changelog about this earlier.

Pity.

If we can't reach consensus in time for 5.0, that's regrettable, but I
accept it.  Our decision making process is open and slow.  Hard to get
one without the other.

Much harder to accept is us once again defaulting to do nothing because
deciding what to do involves a tradeoff.


