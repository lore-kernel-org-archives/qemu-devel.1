Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC41C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B70A2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDxd6cRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70A2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iutu3-0000Ce-4p
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 03:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iutsj-0007co-10
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iutsg-0003dG-V2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:59:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iutsg-0003cR-R1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579852793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/U7vFW7bMClkAl7JlRm+Hfg3MLpMMRFSpS4QP2mUWY=;
 b=VDxd6cRWNX0lgQ5Fl6pxkO0cnr1KbdnnaKbBaS+kaBLfh3Z5z7lDhqP0icrlR36G4TnqsQ
 QhLmA+zInQcUYCLf3Xp7lLRur8STEpaSXN5GPtJTIwhWPITouKEmwb9muLKgzkzbTHg8oh
 9DqkoQeeDCurqxHKxGDdDbcKZzoxurw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-Lf7HtcE_NKKQrIHGh6t_TA-1; Fri, 24 Jan 2020 02:59:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A16118AAFA3;
 Fri, 24 Jan 2020 07:59:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DBD186459;
 Fri, 24 Jan 2020 07:59:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 955041138600; Fri, 24 Jan 2020 08:59:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
Date: Fri, 24 Jan 2020 08:59:41 +0100
In-Reply-To: <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com> (John Snow's
 message of "Thu, 23 Jan 2020 16:07:09 -0500")
Message-ID: <871rrp474i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Lf7HtcE_NKKQrIHGh6t_TA-1
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 1/23/20 2:01 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Jan 23, 2020 at 12:58:45PM -0500, John Snow wrote:
>>> Yes, I agree: Scrap and start over.
>>>
>>> What SHOULD the syntax look like, though? Clearly the idea of qmp-shell
>>> is that it offers a convenient way to enter the top-level keys of the
>>> arguments dict. This works absolutely fine right up until you need to
>>> start providing nested definitions.
>>>
>>> For the nesting, we say: "Go ahead and use JSON, but you have to take
>>> all the spaces out."
>>>
>>> This... works, charitably, but is hardly what I would call usable.
>>>
>>> For the CLI, we offer a dot syntax notation that resembles nothing in
>>> particular. It often seems the case that it isn't expressive enough to
>>> map losslessly to JSON. I suspect it doesn't handle siblings very well.
>>>
>>> A proper HMP-esque TUI would likely have need of coming up with its own
>>> pet syntax for commands that avoid complicated nested JSON definitions,
>>> but for effort:value ratio, having a QMP shorthand shell that works
>>> arbitrarily with any command might be a better win.
>>>
>>> Do we still have a general-case problem of how to represent QAPI
>>> structures in plaintext? Will this need to be solved for the CLI, too?
>>=20
>> I don't know if you've ever looked at how Kubernetes/OpenShift exposes
>> its functionality on the command line ? I think it is interesting to

Yes, superficially.

>> note that they largely don't try to solve this problem of flattening
>> JSON for humans on the CLI using their client.

The fact that their users are happy with this proves it reasonable.

>> Everything in their world is an object described in JSON/YAML, and
>> there are a small set of generic commands that can act on any type
>> of object. These commands primarily input and output JSON or YAML
>> documents directly. As a user you can pick either format since it
>> can do a lossless conversion in both directions server side.

Like Kubernetes/OpenShift, our configuration / control language has an
abstract syntax that permits use of JSON/YAML as concrete syntax.  They
support both, we support just JSON.  We could support YAML, too.

Digression: JSON is a poor choice for configuration files.  YAML is a
complex and confusing beast (it's spec is printed 116 pages, and
yaml-0.2.2/src is ~7kSLOC).  XML is XML, 'nuff said.  TOML is much
simpler than either of the two.

>> So when configuring objects you'll always provide a JSON/YAML doc.
>> They've got some clever stuff for updating objects where you can
>> provide a JSON patch for only the bits which need changing.
>>=20
>> When querying/listing objects by default it displays only a small
>> subset of their config information in a human friendly-ish format.
>> If you want to see everything then you ask for it in JSON/YAML
>> format. There's also an expression language that lets you extract
>> particular pieces of information based on requested properties,
>> and you can filter the list of objects based on attributes and so
>> on.
>>=20
>> I think it is fair to say the structure of kubernetes object config
>> is on a par with hierarchical complexity of QEMU. The lack of a simple
>> human targetted data input format does not appear to have negatively
>> impacted the adoption of Kubernetes. It is worth questioning why this
>> is the case, while we feel the human CLI syntax for QEMU is so
>> critically important to QEMU's future ?

I consider human CLI syntax for QEMU a mostly solved *design* problem:
dotted keys.  It's an unsolved *implementation* problem: the CLI is a
tangled mess of almost two decades' worth of ideas, and only (some of)
the latest strands actually use dotted keys infrastructure.  The
proposed solution is CLI QAPIfication.  Gives us configuration file(s)
and introspection.

Dotted keys are merely yet another concrete syntax.  They're designed to
satisfy the CLI requirements we have, which include a measure of
compatibility to what's in the tangled mess.  They're reasonably usable
for simple stuff, but complex stuff can be too verbose to be readable.
They can't express all of the abstract syntax.  Tolerable, since they
provide an escape to JSON.  I recommend programs use the JSON escape
always.  Awkward for humans due to shell quoting.

> Well, if the "human CLI syntax" is "Feed it YAML documents", that's
> perfectly peachy for me, too! We need a good, consistent interface.
> Exactly what that interface is isn't really a blocking concern.

Right.

> Configuring a VM is a complicated process and has a lot of moving
> widgets. Feeding it a YAML file is a reasonable thought.

We've grown used to configuring QEMU with gargantuan command lines.
D=C3=A9formation profesionelle.

> Having JSON and requiring people to type bastardized and differing
> versions of it in 8 places _is_ a concern. We can't document reasonably
> all of the different flavors and why they differ from one place to the
> next.

Yes.

>       We can unify it. If unifying it means using
> JSON/YAML/TOML/MAML[1]* everywhere and abandoning a CLI altogether,
> that's just as well.

I see no need to argue about whether to keep dotted keys human CLI
syntax or throw it away.

>> Part of it is that the machine oriented data input format via QMP
>> suffers from the fact that it came second in QEMU after HMP. As a
>> result, 90% of the documentation that illustrates QEMU will use the
>> human CLI syntax, varying vintages of that. Since all the docs are
>> focused on the HMP/CLI syntax, whenever there's a new feature we
>> feel pressured to expose it & document it in the human syntax too.
>>=20
>
> Decent observation; but there's often no reasonable way to NOT use the
> CLI, so I think it's not unreasonable that we try to expose features via
> the CLI still.
>
> However, the docs being badly out of date are a problem. We actively
> lead people towards harmful / difficult to support paradigms.
>
>> All this results in a situation where JSON is functionally the best
>> way to configure QEMU, but practically the worse, since very few
>> people understand how to actually use it. This is a vicious circle
>> holding back QMP/JSON and making the human syntax an ever greater
>> burden for users & maintainers
>>=20
>
> I do basically agree.

What to do about it?

Here's an idea that hasn't been mentioned in this thread: a -writeconfig
that actually works.  After you configured QEMU in whatever ways you
rustled up on the 'net, you can -writeconfig the resulting command line
into a *modern* configuration file.

>> IOW, the difficulty with configuring QEMU via JSON is not the fault
>> of JSON itself, it is the lack of knowledge amongst users and docs,
>> compounded by our never ending "improvements" to the human syntax.
>> There are other factors too, such as our only partial coverage of
>> config using JSON - some is only possible via the CLI still.
>
> I'm fine with getting rid of HMP entirely, I think. It's a weird
> interface with bizarre behavior that's hard to support.
>
> There's a few commands in there we just don't support at all, but maybe
> it's time to start deprecating one-by-one any of the individual commands
> that are better served by QMP these days, to send the message that HMP's
> days are numbered.
>
> Bye-bye!

Experience tells that no matter how weird and bizarre a feature is, once
you attempt to remove it, it *will* find champions willing to fight for
it to the death.  I'm not trying to tell you "don't go there", only "if
you go there, go armed and prepared".

> As for the CLI, well, that's part of the discussion at hand...
>
>>=20
>> I guess my point is that with a scrap & startover view point, we
>> should arguably completely ignore the design question of how to
>> flatten JSON for humans/command line, as it is the wrong problem.
>> Instead focus on the problem of making use of JSON the best way
>> to deal with QEMU both functionally and practically, for humans
>> and machines alike.
>>=20
>
> Well, sure. The context of this email was qmp-shell though, which is
> meant to help facilitate the entry of JSON commands so that you *can*
> indeed just forego the CLI/HMP entirely.
>
> If you are of the opinion that every user of QEMU should be copy/pasting
> JSON straight into a socket and we should delete qmp-shell, that's
> certainly a fine opinion.
>
> I'm coming from the side that I love qmp-shell; I find it useful, but it
> has some syntax problems. How do I solve them? Is there a way to solve
> them? QAPI is here to stay, and QAPI involves hierarchical data. That
> data is usually best represented by something like json or yaml, but
> those are hard to type in a shell.
>
> What do we do about that?

I acknowledge that pain in dealing with JSON without suitable tooling.
Worse when the wrong tooling gets in the way, e.g. shell quoting.

Dotted keys are differently awkward.

Daniel's point is (1) we've got bigger fish to fry, and (2) Kubernetes
has proven punting the complex part to JSON/YAML text files (where you
do have suitable tooling) is good enough.

He's right, and that's why I've aggressively ignored qmp-shell since
forever.

If you want to invest some cycles into reducing the pain, I recommend
investing in suitable tooling, not in creating yet another language,
which then needs suitable tooling.

If I wanted to invest, I'd consider creating an Emacs mode to talk to
QMP.  But I don't; see "bigger fish".

> [1]*: Markus Armbruster's Markup Language; I have written this joke with
> the explicit goal of tormenting Markus.

Ha!  Let's call it MarML for "Markus's Markup Language", spoken like
"Marmel", which means "marble" in some dialects of German.  Then we can
joke about me having lost my marbles in specifying my own markup
language.


