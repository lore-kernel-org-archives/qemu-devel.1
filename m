Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506AC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B4720705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNll7wfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B4720705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixQ9q-000443-IU
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixQ93-0003Un-9d
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixQ90-0007vH-HI
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:51:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixQ90-0007up-5j
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580453469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlbTveGjVI26Xn0BtFhSlUZqLVf4FvYA+JxYa0oV7ac=;
 b=VNll7wfgWIsngAq25pozF6iCXoSWai04OMH6htgDGfYXO/89LUoshy3JZW46y2G6hcQwQ6
 Pj5MkmAlIG0RamiQ9JpdCMfx85N12v1sqyMJmUwBTA/htl7bJMRNsZWZb2RI1XqgiMYEhW
 GcEDN3kabMXqVmYnFI+g4JlxkAVtc/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-dFbeZIPtNxOO5CLyahGwdg-1; Fri, 31 Jan 2020 01:51:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D33FCA0CCF;
 Fri, 31 Jan 2020 06:51:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 333F860BE2;
 Fri, 31 Jan 2020 06:50:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B91E81138404; Fri, 31 Jan 2020 07:50:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
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
 <20200128125409.GF6431@linux.fritz.box>
Date: Fri, 31 Jan 2020 07:50:50 +0100
In-Reply-To: <20200128125409.GF6431@linux.fritz.box> (Kevin Wolf's message of
 "Tue, 28 Jan 2020 13:54:09 +0100")
Message-ID: <878sloi0fp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dFbeZIPtNxOO5CLyahGwdg-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.01.2020 um 13:36 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 27.01.2020 um 21:11 hat John Snow geschrieben:
>> [...]
>> >> (The argument here is: It's a little harder and a little longer to ty=
pe,
>> >> but the benefits from the schema organization may improve productivit=
y
>> >> of using QEMU directly instead of harming it.)
>> >
>> > I think this is a false dichotomy.
>> >
>> > You can have everything defined by the schema and properly documented
>> > and still have a non-JSON command line. Translating the QAPI schema to
>> > a command line option is a solved problem, this is exactly how
>> > -blockdev works.
>> >
>> > The unsolved part is how to compatibly convert the existing options. I=
f
>> > you're willing to sacrifice compatibility, great. Then we can just
>> > define stuff in the QAPI schema and still keep a command line syntax
>> > that is usable for humans. The code for mapping a QAPI type to the
>> > argument of an option is basically already there.
>>=20
>> Correct.
>>=20
>> Solving that problem took time, but that's sunk cost now.
>>=20
>> > The only question is "is compatibility important"? If the answer is no=
,
>> > then we'll be there in no time.
>>=20
>> I doubt we'll be there in no time, but certainly much sooner than if we
>> have to grapple with compatibility to a byzantine CLI nobody truly
>> understands.
>>=20
>> There's one known issue caused by having "a non-JSON command line"
>> (actually: dotted keys as sugar for JSON): pressure to reduce nesting.
>>=20
>> Consider chardev-add.  Example:
>>=20
>>     {"execute": "chardev-add",
>>      "arguments": {"id": "bar",
>>                    "backend": {"type": "file",
>>                                "data": {"out": "/tmp/bar.log"}}}}
>>=20
>> The arguments as dotted keys:
>>=20
>>     id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log
>>=20
>> Observe there's quite some of nesting.  While that's somewhat cumbersome
>> in JSON, it's a lot worse with dotted keys, because there nesting means
>> repeated key prefixes.  I could give much worse examples, actually.
>
> This is true, but even without the repeated keys (e.g. in a syntax that
> would use brackets), it would still be unnecessarily verbose and
> probably hard to remember:
>
>     id=3Dbar,backend=3D{type=3Dfile,data=3D{out=3D/tmp/bar.log}}

No argument.  It's unnecessarily verbose in JSON, too.

>> We'd rather have something like
>>=20
>>     id=3Dbar,type=3Dfile,out=3D/tmp/bar.log
>>=20
>> Back to JSON:
>>=20
>>     "arguments": {"id": "bar", "type": "file", "out": "/tmp/bar.log"}
>>=20
>> QAPI can do this, but it uses feature that predate chardev-add.
>>=20
>> We don't want to duplicate the chardev-add schema in modern, flattened
>> form for the CLI.
>>=20
>> So the compatibility problem actually shifts to QMP: can we evolve the
>> existing QMP command compatibly at a reasonable cost in design, coding
>> and complexity to support flat arguments?
>
> Well, first of all: Do we need compatibility? If we don't, then we can
> just make the change.

The trouble with flattening this one is QMP, where we promise stability.

> Much of this threads plays with the though that maybe we don't need any
> compatibility and make the radical conclusion that we don't need any
> human-friendly interface at all. Keeping full compatibility is the other
> extreme.
>
> There might be some middle ground where we break compatibility where the
> old way can't easily be maintained with the new infrastructure, but
> don't give up on the idea of being used by humans.

I'm not sure the connection between maintaining compatibility and
supporting human use is as strong as you seem to imply.

As far as I can tell, the "maybe we don't need any compatibility"
discussion is about the CLI.  I'd rephrase it as "maybe we need a
machine-friendly CLI on par with QMP more than we need compatibility to
the current CLI".

"We don't need any human-friendly interface at all" comes in not because
machine-friendly necessarily precludes human-friendly, but only if we're
unwilling (unable?) to do the extra work for it.

Compare the monitor:

* QMP is primarily for machines.  We promise stability: no incompatible
  changes without clear communicaton of intent and a grace period.  We
  provide machine clients tools to deal with the interface evolution,
  e.g. query-qmp-schema.

* HMP is exclusively for humans.  It may change at any time.

For the CLI, we don't have such a separation, and our offerings for
dealing with interface evolution are wholly inadequate.  We *need* to do
better for machines.

Now, the monitor also informs us about the cost of providing a
completely separate interface for humans.

Elsewhere in this thread, we discussed layering (a replacement for) HMP
on top of QMP cleanly, possibly in a separate process, possibly written
in a high-level language like Python.

HMP predates QMP.  We reworked it so the HMP commands are implemented on
top of the QMP commands, or at least on top of common helpers.  But this
is not quite the same as layering HMP on top of QMP.

If we decide to radically break the CLI so we can start over, we get to
decide whether and how to do a human-friendly CLI, in particular how it
relates to the machine-friendly CLI.


