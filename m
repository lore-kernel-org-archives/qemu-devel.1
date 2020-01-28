Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E60C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDA32173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCdy58YF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDA32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQ7I-00035c-I7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwQ6Y-0002dU-3Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwQ6X-0001qT-7W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:36:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwQ6X-0001pq-3z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580214988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sz5UVMoRatoB92wHBSz5/fiCOTNHGZnXdT93yO686UU=;
 b=NCdy58YFdsRADuG14lofU8XliXkUrGc+qRMb5szcZAICursyfHslt+Vfn05YUB6Cet9DPS
 WF0ymsG5i3CWxHQE0t7w+k13NxeYDfW1PSUSe1stWUfdKsA80u/lZZkwCibYAdZLdsq2B2
 K4qoixgSOh02aTN4Einp/DA3YcxsUiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-gu5NJtC6PXWDw3uJ4fNgLA-1; Tue, 28 Jan 2020 07:36:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AFB9DB62;
 Tue, 28 Jan 2020 12:36:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97DDA5C219;
 Tue, 28 Jan 2020 12:36:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24E521138600; Tue, 28 Jan 2020 13:36:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box>
Date: Tue, 28 Jan 2020 13:36:16 +0100
In-Reply-To: <20200128102855.GA6431@linux.fritz.box> (Kevin Wolf's message of
 "Tue, 28 Jan 2020 11:28:55 +0100")
Message-ID: <87mua7bvwf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: gu5NJtC6PXWDw3uJ4fNgLA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Denis V.
 Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.01.2020 um 21:11 hat John Snow geschrieben:
[...]
>> (The argument here is: It's a little harder and a little longer to type,
>> but the benefits from the schema organization may improve productivity
>> of using QEMU directly instead of harming it.)
>
> I think this is a false dichotomy.
>
> You can have everything defined by the schema and properly documented
> and still have a non-JSON command line. Translating the QAPI schema to
> a command line option is a solved problem, this is exactly how
> -blockdev works.
>
> The unsolved part is how to compatibly convert the existing options. If
> you're willing to sacrifice compatibility, great. Then we can just
> define stuff in the QAPI schema and still keep a command line syntax
> that is usable for humans. The code for mapping a QAPI type to the
> argument of an option is basically already there.

Correct.

Solving that problem took time, but that's sunk cost now.

> The only question is "is compatibility important"? If the answer is no,
> then we'll be there in no time.

I doubt we'll be there in no time, but certainly much sooner than if we
have to grapple with compatibility to a byzantine CLI nobody truly
understands.

There's one known issue caused by having "a non-JSON command line"
(actually: dotted keys as sugar for JSON): pressure to reduce nesting.

Consider chardev-add.  Example:

    {"execute": "chardev-add",
     "arguments": {"id": "bar",
                   "backend": {"type": "file",
                               "data": {"out": "/tmp/bar.log"}}}}

The arguments as dotted keys:

    id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log

Observe there's quite some of nesting.  While that's somewhat cumbersome
in JSON, it's a lot worse with dotted keys, because there nesting means
repeated key prefixes.  I could give much worse examples, actually.

We'd rather have something like

    id=3Dbar,type=3Dfile,out=3D/tmp/bar.log

Back to JSON:

    "arguments": {"id": "bar", "type": "file", "out": "/tmp/bar.log"}

QAPI can do this, but it uses feature that predate chardev-add.

We don't want to duplicate the chardev-add schema in modern, flattened
form for the CLI.

So the compatibility problem actually shifts to QMP: can we evolve the
existing QMP command compatibly at a reasonable cost in design, coding
and complexity to support flat arguments?


