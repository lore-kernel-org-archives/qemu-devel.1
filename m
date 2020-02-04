Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CCC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BF420674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aplDHwV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BF420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv6R-0005tX-7s
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iyuzF-0001h4-Nc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iyuzC-0003xq-4z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:59:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iyuzC-0003uc-0J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580810353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7Q4k4y3xdQA/G8nD9y+Rh8bPzRNiRKm9ezNN95PGDk=;
 b=aplDHwV6MCYWF7Z/fCkQ4XDrUZ/hV6ZA9UMq1zsdFetiYX62ceH8FD8XVoR3LeSulFYwVZ
 2PabHTy8iLmyLxxZhQl1UPUVuWKEkFCKhLJFkFv4EUB+oKdjOixEhZwp7rM0Ya/5qnAgLf
 28x30Zw0/bkurKbIyiR/myV2REjYas8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-zSI9R4_RMQqLxv1pJxsRhA-1; Tue, 04 Feb 2020 04:59:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E113A10CE783;
 Tue,  4 Feb 2020 09:59:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BD555D9C5;
 Tue,  4 Feb 2020 09:58:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1AE311386A7; Tue,  4 Feb 2020 10:58:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
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
 <878sloi0fp.fsf@dusky.pond.sub.org>
 <bc3e33efe9f4fe2447a964a86318856430e44d1a.camel@redhat.com>
Date: Tue, 04 Feb 2020 10:58:57 +0100
In-Reply-To: <bc3e33efe9f4fe2447a964a86318856430e44d1a.camel@redhat.com>
 (Andrea Bolognani's message of "Mon, 03 Feb 2020 21:07:53 +0100")
Message-ID: <87pneu8yhq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zSI9R4_RMQqLxv1pJxsRhA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrea Bolognani <abologna@redhat.com> writes:

> On Fri, 2020-01-31 at 07:50 +0100, Markus Armbruster wrote:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > Much of this threads plays with the though that maybe we don't need an=
y
>> > compatibility and make the radical conclusion that we don't need any
>> > human-friendly interface at all. Keeping full compatibility is the oth=
er
>> > extreme.
>> >=20
>> > There might be some middle ground where we break compatibility where t=
he
>> > old way can't easily be maintained with the new infrastructure, but
>> > don't give up on the idea of being used by humans.
>>=20
>> I'm not sure the connection between maintaining compatibility and
>> supporting human use is as strong as you seem to imply.
>>=20
>> As far as I can tell, the "maybe we don't need any compatibility"
>> discussion is about the CLI.  I'd rephrase it as "maybe we need a
>> machine-friendly CLI on par with QMP more than we need compatibility to
>> the current CLI".
>>=20
>> "We don't need any human-friendly interface at all" comes in not because
>> machine-friendly necessarily precludes human-friendly, but only if we're
>> unwilling (unable?) to do the extra work for it.
>>=20
>> Compare the monitor:
>>=20
>> * QMP is primarily for machines.  We promise stability: no incompatible
>>   changes without clear communicaton of intent and a grace period.  We
>>   provide machine clients tools to deal with the interface evolution,
>>   e.g. query-qmp-schema.
>>=20
>> * HMP is exclusively for humans.  It may change at any time.
>>=20
>> For the CLI, we don't have such a separation, and our offerings for
>> dealing with interface evolution are wholly inadequate.  We *need* to do
>> better for machines.
>>=20
>> Now, the monitor also informs us about the cost of providing a
>> completely separate interface for humans.
>>=20
>> Elsewhere in this thread, we discussed layering (a replacement for) HMP
>> on top of QMP cleanly, possibly in a separate process, possibly written
>> in a high-level language like Python.
>>=20
>> HMP predates QMP.  We reworked it so the HMP commands are implemented on
>> top of the QMP commands, or at least on top of common helpers.  But this
>> is not quite the same as layering HMP on top of QMP.
>>=20
>> If we decide to radically break the CLI so we can start over, we get to
>> decide whether and how to do a human-friendly CLI, in particular how it
>> relates to the machine-friendly CLI.
>
> Does a machine-friendly CLI need to exist at all? Once you decide
> that throwing away the current one is acceptable, you might as well
> reduce the maintainance burden by requiring that software only
> communicates with QEMU via QMP.

We need to provide a machine-friendly interface for initial
configuration.

To provide it, we can extend machine-friendly QMP, or make CLI
machine-friendly like QMP.

In both cases, we need to QAPIfy initial configuration.  I believe
that's going to be a big chunk of the work.

To extend QMP, we wrap the QAPIfied initial configuration in QMP
commands.  Many of them will only make sense during initial
configuration.  We'll want to express that in the schema, and enforce it
in the QMP core.

To improve the CLI, we wrap them in CLI options.  We'll want some
infrastructure to generate the boilerplate, just like we generate QMP
command boilerplate.

With an improved CLI, configuration files are just CLI options read from
a file instead of argv[].  We'll want a more suitable concrete syntax
there, of course.

With extended QMP, configuration files are just QMP commands from the
initial configuration subset read from a file instead of a chardev.
Again, we'll likely want more suitable concrete syntax there.

With an improved CLI, I'd expect machines to use configuration files so
they don't have to mess with shell quoting.  With extended QMP, they'd
perhaps rather reuse their existing QMP code to send the configuration
down a socket.  Less efficient, but I doubt it'll matter.

> Does a human-friendly CLI need to be part of QEMU? We have built so
> much amazing infrastructure on top of QEMU, and as of today none of
> that work is benefiting people who run it directly.

I think we do, for developers and for users who don't need the amazing
infrastructure we built on top of QEMU.  When you use QEMU for
virtualization in production, you generally need it, but there are
other, simpler uses, e.g. certain hardware emulation uses.

A human-friendly CLI can be built both as a wrapper around the
machine-friendly CLI and as a wrapper around the initial configuration
subset of QMP.

Once a machine-friendly replacement for the current CLI is in place, we
can relax the current CLI's compatibility requirements.  I figure we
need this to be able to turn it into a wrapper with reasonable effort.
Hopefully, we can generate much of the wrapping boilerplate.

> As a proof of concept, I have spent a couple of hours writing the
> attached shell script, which I hope will illustrate my point.
>
> Usage is extremely simple: just do something like
>
>   $ ./virt-run debian-10-openstack-amd64.qcow2
>
> and after a few seconds the guest display will appear on your screen.
>
> Behind the scenes, it uses a number of existing high-level tools:
>
>   * virt-inspector, to figure out what guest OS is installed in the
>     image;
>
>   * virt-install, to produce a domain XML tailored to that specific
>     guest OS and to create the corresponding libvirt domain;
>
>   * virt-viewer, to provide the UI.
>
> All these tools use libvirt under the hood, and additionally
> virt-install uses libosinfo to obtain information about the guest
> OS, such as whether or not it supports Virtio devices and how much
> memory it needs to run smoothly.
>
>
> The result is that, if you run
>
>   $ qemu-system-x86_64 -hda debian-10-openstack-amd64.qcow2
>
> you will get
>
>   * a single CPU emulated with TCG;
>
>   * 128 MiB of memory;
>
>   * emulated I/O devices;
>
> whereas the script will give you
>
>   * 2 CPUs accelerated with KVM;
>
>   * 1 GiB of memory;
>
>   * Virtio devices for pretty much everything, including a
>     virtio-rng device that will for example speed up the first boot
>     significantly if SSH keys need to be (re)created.
>
> Unsurprisingly, performance is different: when QEMU is invoked
> directly, the login prompt for this specific image shows up after
> ~40 seconds, whereas when we use the script it only takes ~13 seconds
> to get there. And the command line is just as simple, if not more so!
>
> All of the above was obtained by hastily cobbling together existing
> tools with <100 lines of shell scripting. Imagine how much better it
> could be if we actually put some serious work in!

I don't doubt that many, many users of QEMU are better off consuming it
via libvirt.  I've told a few of them over the years :)

> With my argument hopefully demonstrated: I think an architecture akin
> to the one Dan has outlined earlier[1] would be a great direction to
> take. QEMU can continue to focus on its core competency, that is,
> virtual hardware, and leave most of the user interaction up to the
> software interacting with its JSON-based API.
>
>
> Obviously QEMU developers, for their own use, could still benefit
> from having access to a user interface that doesn't require either
> rigging up libvirt support or messing with JSON directly, and such
> an interface could even look very similarly to the current CLI, but
> it could simply not be made user-facing and thus not subject to any
> compatibility concerns.

"Not user-facing" only for a particular value of "user".  But your point
is well taken: only the machine-friendly initial configuration interface
needs to be subject to a compatibility promise.

I believe the difference between providing it in QMP and providing it
separately isn't all that great.

> [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg06034.htm=
l


