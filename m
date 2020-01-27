Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7280214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnhNlyKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7280214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0Mr-00087k-ST
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iw0MH-0007gN-Fr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iw0MF-00005a-1Y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:07:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iw0ME-0008VL-R5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580116017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9AFEWdiRXfRPCdQ/5HXfvyjbwcaOra1jkJk2OAgcEg=;
 b=JnhNlyKsaF4FKjJ49XbtP3CAux+GryV1i3V45RhZJ65qYCGn+rsbAmmi16Djj1L+XxDAYl
 ZnBgzEEpdfzZ+tgI72nDslVTWEP5FbBu62dhQLli33kK7B++qSb4QzEjvv1VoXVeYQv2WN
 QD3DZi6vYjuN9xlTMfM7zX9z41fEf0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-crj07tLINDi2xtB-l8Ie1A-1; Mon, 27 Jan 2020 04:06:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCBAC8010D6;
 Mon, 27 Jan 2020 09:06:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1913686E22;
 Mon, 27 Jan 2020 09:06:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6DD01138600; Mon, 27 Jan 2020 10:06:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
Date: Mon, 27 Jan 2020 10:06:45 +0100
In-Reply-To: <20200124095027.GA824327@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Fri, 24 Jan 2020 09:50:27 +0000")
Message-ID: <87a769s1y2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: crj07tLINDi2xtB-l8Ie1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jan 23, 2020 at 04:07:09PM -0500, John Snow wrote:
>>=20
>>=20
>> On 1/23/20 2:01 PM, Daniel P. Berrang=C3=A9 wrote:
[...]
>> > I guess my point is that with a scrap & startover view point, we
>> > should arguably completely ignore the design question of how to
>> > flatten JSON for humans/command line, as it is the wrong problem.
>> > Instead focus on the problem of making use of JSON the best way
>> > to deal with QEMU both functionally and practically, for humans
>> > and machines alike.

Note: I understand "JSON" to stand for "JSON and possibly another
concrete syntax better suited for humans".  Your examples below show
YAML in that role.

[...]
> Here's one conceptual vision of how a better QEMU might look:
>
>   * qemu-runtime-$TARGET
>
>     A binary that contains the implementation for the machine
>     emulator for $TARGET.
>
>     This has no command line arguments except for a UNIX
>     socket path which is a QMP server
>
>
>   * qemu-launcher-$TARGET
>
>     A binary that is able to launch qemu-runtime-$TARGET
>     with jailers active.
>
>     This has no command line arguments except for a pair
>     of UNIX socket paths. One is a QMP server, the other
>     is the path for the QMP of qemu-runtime-$TARGET.
>
>     Commands it processes will be in automatically proxied
>     through to the qemu-runtime-$TARGET QMP, with appropriate
>     jailer updates being done in between.

See Paolo's reply.

>   * qemu-client
>
>     A binary that speaks QMP, connects, runs a single command,
>     disconnects.

The single command is specified how?

Ah, "Example usage" below shows it's taken from a file argument.

>     It is used to talk to either qemu-runtime-$TARGET or
>     qemu-launcher-$TARGET, depending on whether the mgmt app
>     or user wants to be making use of the jailer facilities
>     or not. =20

Effectively ditches the CLI in favor of QMP.  One major external host
interface instead of two.

The connection to "making use of JSON the best way to deal with QEMU
both functionally and practically, for humans and machines alike" is
"make it possible to use just QMP for *everything*".  Correct?

We've toyed with the "Just QMP" idea almost since QMP exists.  We never
went beyond "wouldn't it be nice if".

The main chunk of work is providing the CLI functionality we need in
QMP.  Requires QAPIfication of the parts that aren't QAPIfied, yet.

Since parts of CLI overlap with QMP, providing CLI functionality need
not require new QMP commands.  For instance, CLI does cold plug, QMP
does hot plug.  The existing QMP interface could do both: hot while the
machine runs, else cold.

Some functionality makes sense only during initial startup.  Implied in
CLI.  In QMP, it has to be tied to the run state.  No big deal.

"Just QMP" is of course not the only way to do "JSON first".  Another
one is bringing JSON to the CLI.  I explored that: CLI QAPIfication.

Requires the same QAPIfication as "Just QMP" does.

Where "Just QMP" is a hard compatibility break by design, "JSON in CLI"
gives us a choice: we can choose to break compatibility, e.g. by
creating the exact same set of new executables you propose.  Or we can
try to evolve the existing CLI compatibly.  The latter is a tar pit,
because the existing CLI is.  But it's a tar pit *we* get to choose.  We
can't blame "JSON in CLI" for it, only ourselves.

Even though I've worked on "JSON in CLI", I'm not overly attached to it.
If we decide "Just QMP" is the better path forward, I'll happily go
along.  I believe the bulk of the work will be the same: QAPIfying
stuff.

>   * qemu-system-$TARGET
>
>     The current binaries that exist today.
>
>     qemu-system-$TARGET should not be part of our formal
>     stability promise. We won't gratuitously / knowingly
>     break without good reason, but we will accept that
>     breakage can happen. Stability is only offered by
>     the qemu-{runtime,launcher}-$TARGET.
>
>     Several choices for their future in long term:
>
>       - Leave them as-is and basically ignore them
>         whereever practical going forward, so we
> =09minimally worry about backcompat breakage
>
>       - Plan to re-write them so that they are simply
>         a shim the forks+execs qemu-runtime-$TARGET
> =09and does syntax translation from CLI/HMP/QMP.
>
>       - Deprecate them with a view to deletion entirely
>         in $NNN years. For some large-ish value of NNN,
> =09given how well known they are

How do the other complex executables like qemu-img, qemu-nbd fit into
this picture?

Do they become redundant somehow for non-human users?

If not, will they get a QMP-only sibling, like qemu-system-$TARGET gets
qemu-runtime-$TARGET?

> Example usage:
>
> 1. Launch the QEMU runtime for the desired target
>
>      $ qemu-runtime-x86_64 myvm.sock
>
> 2. Load the configuration to define the VM
>
>    $ cat myvm.yaml
>    commands:
>      - machine_declare:
>          name: pc-q35-5.0
> =09 ...
>      - blockdev_add:
>          ...
>      - device_add:
>          ...
>      - blockdev_add:
>          ...
>      - device_add:
>          ...
>    $ qemu-client myvm.sock myvm.yaml
>
>
> 3. Hotplug a disk
>
>    $ cat mynewdisk.yaml
>    commands:
>      - blockdev_add:
>          ...
>      - device_add:
>          ...
>    $ qemu-client myvm.sock mynewdisk.yaml
>
>
> 3. Hotunplug a disk
>
>    $ cat myolddisk.yaml
>    commands:
>      - device_del:
>          ...
>      - blockdev_del:
>          ...
>    $ qemu-client myvm.sock myolddisk.yaml
>
> Using jailers, just means adding in a use of qemu-launcher-$TARGET
> at the start.
>
>
> Regards,
> Daniel


