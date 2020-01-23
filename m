Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CCC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E2624125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeyiVGmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E2624125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuX4M-000139-Jd
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuX3Q-0000Zf-9I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuX3N-0001f1-O9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:37:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuX3N-0001eO-K8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579765044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOF87p7w1HWP1UCZobH0sFRKSoW6878YVTG/S6KvZd0=;
 b=OeyiVGmZE9pNS0/YfzpamfdTSZynhHWfO8N9u4Ac+pz8yFdzeVxLHvq66+mwnJ+DcygzrV
 r5LOjsIqDlXva/9EvAGo50kAwFyimLJFiM7GugVuF2lA1LfqdiGinj3K0kmbZGE2dHxG81
 ZxmOp7blB3UdPltNp/1kZ7BSfZJmnnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-IzZFNyqGP9SUN0XeD61tSQ-1; Thu, 23 Jan 2020 02:37:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F83D107ACCA;
 Thu, 23 Jan 2020 07:37:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6D85DA7C;
 Thu, 23 Jan 2020 07:37:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF67E1138600; Thu, 23 Jan 2020 08:37:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: Integrating QOM into QAPI
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
 <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
 <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
Date: Thu, 23 Jan 2020 08:37:14 +0100
In-Reply-To: <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 22 Jan 2020
 16:42:13 +0400")
Message-ID: <87lfpyd3o5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: IzZFNyqGP9SUN0XeD61tSQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Jan 22, 2020 at 4:25 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> >> Actually, we are not that far off from being able to use GObject
>> >> altogether (I hacked something like that to play with), but I
>> >> disgress...
>> >
>> > As a mostly hands off observer who mainly c&p's QOM code when he has t=
o
>> > I have to ask is this a long term plan?
>> >
>> > I've always found having our own hand rolled object system a little
>> > incongruous given we lean heavily on the rest of glib.
>>
>> I vaguely remember claims that GObject falls short of our needs.  Sadly,
>> I don't remember the details.  This is why major features should come
>> with a design document.
>>
>> https://wiki.qemu.org/Features/QOM ain't: it does not mention GObject.
>> I'm afraid that page has fallen too far behind the code to be useful to
>> anyone not familiar with the code.
>
>>From the top of my mind, this is the pain point when trying to use GObjec=
t:
> - static/inlined object, not supported by GObject, unlikely to ever be

Lame.

Okay for us as long as the pointer chasing stays off the hot paths.  But
that's not obvious.

> - few users in qemu, transition possible.

Peter challenged this idea.

> - 64k limit of GObject, for some reason, unlikely to change but I will
> take a look. Some users in qemu, code adaptation possible.

Also lame.  I figure code adaption will involve pointer chasing.  Again,
beware of hot paths.  This one feels less likely to be a problem,
though.

> - dynamic properties, possible in GObject with hacks, but not
> recommended and going to be deprecated from what I remember

Never understood our need for them for longer than half a day after
getting it explained to me.  I guess that's my fault.  Anyway, the less
we use them, the better.

Hacks exploiting deprecated GObject features would be a bad idea.
Perhaps we can hack something up that doesn't.

> - "array" properties - would need extra layer/tweaks for compatibility

I hated them from day one, tried to kill them, lost the argument.

> - link properties - would need special handling

Hard or not?

> - different limitations for type names and properties names

What to do?

Our naming rules and conventions are weakly documented.

> A possible initial approach is to have all the type system and object
> allocation done by GObject under the hood (what I hacked), while
> keeping all the properties handled by QOM. Then, figure out a
> migration to GObject properties (which are also being refactored a bit
> upstream).

So most QOM properties would be based on a GObject property, but some
wouldn't be, correct?

>            If there is enough interest, I will keep investigating. But
> for now, helping with meson seems more urgent.

Yes.

/me warily eyes the monster lurking in the review queue...

[...]


