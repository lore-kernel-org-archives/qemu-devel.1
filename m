Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D487C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCD024681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bc/VhzZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCD024681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQOe-000519-02
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwQNx-0004ES-6F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwQNu-0001ZZ-6z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:54:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwQNt-0001Y9-TH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580216064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81fRbXREOADLVyogpz/ZGWxZ7Y7NMXfiUqHL7bFwk70=;
 b=Bc/VhzZFMGHOIjh5oEZLgVo+/ze4bmnRvm36QTasyPptnxgoi85OcGv4F5HakabCcMLBOe
 yT3fde4t5FoElRYnugp4Ad2k/gnQ26MYSAOb0kkxFS5SMea5y0cObDqsYQ29TuvV9uClnE
 Y1um9asWXeelmF5bY9o5A741/8Di3/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-f8S6XeXuPIKw3gzeg8-Ehw-1; Tue, 28 Jan 2020 07:54:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AD4A10054E3;
 Tue, 28 Jan 2020 12:54:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC665DA7E;
 Tue, 28 Jan 2020 12:54:11 +0000 (UTC)
Date: Tue, 28 Jan 2020 13:54:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200128125409.GF6431@linux.fritz.box>
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box>
 <87mua7bvwf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mua7bvwf.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: f8S6XeXuPIKw3gzeg8-Ehw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.01.2020 um 13:36 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 27.01.2020 um 21:11 hat John Snow geschrieben:
> [...]
> >> (The argument here is: It's a little harder and a little longer to typ=
e,
> >> but the benefits from the schema organization may improve productivity
> >> of using QEMU directly instead of harming it.)
> >
> > I think this is a false dichotomy.
> >
> > You can have everything defined by the schema and properly documented
> > and still have a non-JSON command line. Translating the QAPI schema to
> > a command line option is a solved problem, this is exactly how
> > -blockdev works.
> >
> > The unsolved part is how to compatibly convert the existing options. If
> > you're willing to sacrifice compatibility, great. Then we can just
> > define stuff in the QAPI schema and still keep a command line syntax
> > that is usable for humans. The code for mapping a QAPI type to the
> > argument of an option is basically already there.
>=20
> Correct.
>=20
> Solving that problem took time, but that's sunk cost now.
>=20
> > The only question is "is compatibility important"? If the answer is no,
> > then we'll be there in no time.
>=20
> I doubt we'll be there in no time, but certainly much sooner than if we
> have to grapple with compatibility to a byzantine CLI nobody truly
> understands.
>=20
> There's one known issue caused by having "a non-JSON command line"
> (actually: dotted keys as sugar for JSON): pressure to reduce nesting.
>=20
> Consider chardev-add.  Example:
>=20
>     {"execute": "chardev-add",
>      "arguments": {"id": "bar",
>                    "backend": {"type": "file",
>                                "data": {"out": "/tmp/bar.log"}}}}
>=20
> The arguments as dotted keys:
>=20
>     id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log
>=20
> Observe there's quite some of nesting.  While that's somewhat cumbersome
> in JSON, it's a lot worse with dotted keys, because there nesting means
> repeated key prefixes.  I could give much worse examples, actually.

This is true, but even without the repeated keys (e.g. in a syntax that
would use brackets), it would still be unnecessarily verbose and
probably hard to remember:

    id=3Dbar,backend=3D{type=3Dfile,data=3D{out=3D/tmp/bar.log}}

> We'd rather have something like
>=20
>     id=3Dbar,type=3Dfile,out=3D/tmp/bar.log
>=20
> Back to JSON:
>=20
>     "arguments": {"id": "bar", "type": "file", "out": "/tmp/bar.log"}
>=20
> QAPI can do this, but it uses feature that predate chardev-add.
>=20
> We don't want to duplicate the chardev-add schema in modern, flattened
> form for the CLI.
>=20
> So the compatibility problem actually shifts to QMP: can we evolve the
> existing QMP command compatibly at a reasonable cost in design, coding
> and complexity to support flat arguments?

Well, first of all: Do we need compatibility? If we don't, then we can
just make the change.

Much of this threads plays with the though that maybe we don't need any
compatibility and make the radical conclusion that we don't need any
human-friendly interface at all. Keeping full compatibility is the other
extreme.

There might be some middle ground where we break compatibility where the
old way can't easily be maintained with the new infrastructure, but
don't give up on the idea of being used by humans.

Kevin


