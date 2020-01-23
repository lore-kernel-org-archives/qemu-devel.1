Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9DFC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF99217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8W9Bh5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF99217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWqr-00056w-PN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuWmD-000835-36
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuWmB-0000IS-O2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:19:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuWmB-0000Hy-KG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kL23piCn6CSYOijVgkfnXFzXGCqMp3ot929AE+d8bC8=;
 b=c8W9Bh5sCnV54N9djH+oEG94D4TYghuRcOGfPFFa1VhHuhYuvpm2XjhtArDGq6OLUBgf1/
 ZhutCaSonhtk7PR/zhA5JoQg0zte2AySEqTPFf4b/fJ1f7VJKlCj/pB55ccI6Cb9jQ4gzI
 LNBh7nhHxyaty+iLXaogttmrGxNgbZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-T51CMk1SNa2GxG4xq4u9Iw-1; Thu, 23 Jan 2020 02:19:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75821107ACC7;
 Thu, 23 Jan 2020 07:19:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B005E5C545;
 Thu, 23 Jan 2020 07:19:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FE771138600; Thu, 23 Jan 2020 08:19:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
Date: Thu, 23 Jan 2020 08:19:26 +0100
In-Reply-To: <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com> (John Snow's
 message of "Wed, 22 Jan 2020 17:28:18 -0500")
Message-ID: <878slyej29.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: T51CMk1SNa2GxG4xq4u9Iw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Denis V.
 Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 12/24/19 8:41 AM, Daniel P. Berrang=C3=A9 wrote:
>>> * scripts/qmp/qmp-shell
>>>
>>>   Half-hearted attempt at a human-friendly wrapper around the JSON
>>>   syntax.  I have no use for this myself.
>> I use this fairly often as its a useful debugging / experimentation
>> / trouble shooting tool. There's similar ish functionality in
>> virsh qemu-monitor-command. I think there's scope of a supported
>> tool here that can talk to libvirt or a UNIX socket for doing
>> QMP commands, with a friendlier syntax & pretty printing.=20
>>=20
>
> qmp-shell is one of my go-to tools for working through bitmap workflows
> where we don't have convenience commands yet, as some of the setups
> required for fleecing et al involve quite a number of steps.
>
> I can copy-paste raw JSON into a socket, but personally I like seeing my
> commands neatly organized in a format where I can visually reduce them
> to their components at a glance.
>
> (What I mean is: It's hard to remember which QMP commands you've barfed
> into a terminal because JSON is hard to read and looks very visually
> repetitive.)
>
> I tried to rewrite qmp-shell late last year, actually. I wanted to write
> a new REPL that was json-aware in some manner such that you could write
> multi-line commands like this:
>
>> example-command arg=3D{
>   "hello": "world"
> }
>
> This requires, sadly, a streamable JSON parser. Most JSON parsers built
> into Python as-is simply take a file pointer and consume the entirety of
> the rest of the stream -- they don't play very nice with incomplete
> input or input that may have trailing data, e.g.:
>
>> example-command arg=3D{
>   "hello": "world"
> } arg2=3D{
>   "oops!": "more json!"
> }

QMP is in the same boat: it needs to process input that isn't
necessarily full expressions (JSON-text in the RFC's grammar).

Any conventional parser can be made streaming by turning it into a
coroutine.  This is probably the simplest solution for handwritten
streaming LL parsers, because it permits recursive descent.  In Python,
I'd try a generator.

Our actual solution for QMP predates coroutine support in QEMU, and is
rather hamfisted:

* Streaming lexer: it gets fed characters one at a time, and when its
  state machine says "token complete", it feeds the token to the
  "streamer".

* "Streamer": gets fed tokens one at a time, buffers them up counting
  curly and square bracket nesting until the nesting is zero, then
  passes the buffered tokens to the parser.

* Non-streaming parser: it gets fed a sequence of tokens that constitute
  a full expression.

The best I can say about this is that it works.  The streamer's token
buffer eats a lot of memory compared to a real streaming parser, but in
practice, it's a drop in the bucket.

> Also, due to the nature of JSON as being a single discrete object and
> never a stream of objects, no existing JSON parser really supports the
> idea of ever seeing more than one object per buffer.

That plainly sucks.

> ...So I investigated writing a proper grammar for qmp-shell.

Any parser must start with a proper grammar.  If it doesn't, it's a toy,
or a highway to madness.

> Unfortunately, this basically means including the JSON grammar as a
> subset of the shell grammar and writing your own parser for it entirely.

Because qmp-shell is a half-hearted wrapper: we ran out of wrapping
paper, so JSON sticks out left and right.

Scrap and start over.

> I looked into using Python's own lexer; but it's designed to lex
> *python*, not *json*. I got a prototype lexer working for this purpose
> under a grammar that I think reflects JSON, but I got that sinking
> feeling that it was all more trouble than it was worth, and scrapped
> working on it any further.

Parsing JSON is pretty simple.  Data point: QAPISchemaParser parses our
weird derivative of JSON in 239 SLOC.

> I did not find any other flex/yacc-like tools that seemed properly
> idiomatic or otherwise heavily specialized. I gave up on the idea of
> writing a new parser.

While I recommend use of tools for parsing non-trivial grammars (you'll
screw up, they won't), they're massive overkill for JSON.

> I'd love to offer a nice robust QMP shell that is available for use by
> end users, but the syntax of the shell will need some major consideration=
s.

Scrap and start over.

[...]


