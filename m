Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BABC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5947820857
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAyUmHO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5947820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvLo-0006Aj-Ht
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJvKw-0005j8-U3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJvKv-0000mv-T8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:36:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJvKv-0000mR-OW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585816589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpyYFRCzpQ7JOiQD+ibS712pt19uk0CwNIxGpafFWSo=;
 b=TAyUmHO4W5Tq2DoDswqWMpgDZFpCxJ9Yl81BuKtPSO88V4qrWD83twfS+Btp8B0DgyMMh0
 4LFJATtGjAfJmh5QNFCU0XqWik4MAvyCxowtOW73yIngxI7n4Yis8rYsWzDyXjol3ORbUf
 vbsxh04Ag95M6U5B+Pid2GxrEwKjwCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-KX5m2fSdOQqwgbpu8Ow4Rw-1; Thu, 02 Apr 2020 04:36:27 -0400
X-MC-Unique: KX5m2fSdOQqwgbpu8Ow4Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BBF78017F4;
 Thu,  2 Apr 2020 08:36:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B03289F0A;
 Thu,  2 Apr 2020 08:36:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A055511385E2; Thu,  2 Apr 2020 10:36:21 +0200 (CEST)
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
 <87d08qbcm3.fsf@dusky.pond.sub.org>
 <CAFEAcA82V5tMJs7jiuVov7-GFBG+4O037UkDngUKuKFqLj-6HA@mail.gmail.com>
Date: Thu, 02 Apr 2020 10:36:21 +0200
In-Reply-To: <CAFEAcA82V5tMJs7jiuVov7-GFBG+4O037UkDngUKuKFqLj-6HA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 2 Apr 2020 08:19:15 +0000")
Message-ID: <87d08q9tdm.fsf@dusky.pond.sub.org>
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

> On Thu, 2 Apr 2020 at 07:55, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > I use this thing maybe once a month at most, more likely once
>> > every three months, and the documentation is notoriously
>> > impenetrable. I really really don't want to have to start looking in i=
t
>> > and guessing about how the original author ran the script, when
>> > they could have just told me.
>>
>> I'm afraid we're talking part each other.
>
> Perhaps; but I think we're also genuinely disagreeing.
>
>> >>           $  spatch --sp-file scripts/coccinelle/qobject.cocci \
>> >>                     --macro-file scripts/cocci-macro-file.h \
>> >>                     --dir block --in-place
>> >
>> > Yep, that command line would be great to see in the script file.
>>
>> Except for the --dir block part, which is even worse than noise: it
>> suggests this is just for block/, which is wrong.
>
> It tells the reader that the original author only tested
> the script to work inside block/, which is useful information.
> (This is why scripts/coccinelle/cpu-reset.cocci specifies
> --dir target in its command.)
>
>> > The least-effort way for the author of the script to do that is to
>> > simply give the command line they used to run it.
>>
>> If you're capable of writing a Coccinelle script that actually does what
>> you want, you're certainly capable of doing better than blindly paste
>> from your shell history.  Kindly drop the options that are specific to
>> just this particular use of the script.  Keep the ones that future users
>> will actually need.
>
> I'm a future user; in fact I'm the future user whose needs I have
> the best information on. I want to see the whole command, please.

In that case, nothing seems to be left than agree to disagree.

[...]


