Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5859C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02E121741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWHBA5tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02E121741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdhV-00036D-Qc
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izdem-00021M-Qb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izdea-0004gy-Vz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:41:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izdeZ-0004bR-Pq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580982055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+IVTqHJE/PCN5DfMbLi5xABXFRq3iNWjAylmhWtO8M=;
 b=DWHBA5tKGZdCQkxWk66tmJ9wVQ0+mVcz6a67lL3eMrjgqbqP7LWYoGJs95bjOV8FGsdTVS
 Aq2n9FcaQGDumwzgZwJMIUBnGZZcfUv4fqT7cu6mevo+u7bRawyFfxPgapMiP1Z1+s22S6
 8XzB9qosHFtWHX+KHsbJ8AHgRyFNJbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-bNZey8bXOyamC75KYF-x_A-1; Thu, 06 Feb 2020 04:40:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F26C218A6EC1;
 Thu,  6 Feb 2020 09:40:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A42F5C1B5;
 Thu,  6 Feb 2020 09:40:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DE4111386A7; Thu,  6 Feb 2020 10:40:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
References: <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm>
Date: Thu, 06 Feb 2020 10:40:37 +0100
In-Reply-To: <20200205194944.GP3210@work-vm> (David Alan Gilbert's message of
 "Wed, 5 Feb 2020 19:49:44 +0000")
Message-ID: <877e10xdd6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: bNZey8bXOyamC75KYF-x_A-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * John Snow (jsnow@redhat.com) wrote:
>> I'm forking the subject as I believe Markus wanted to focus on the
>> machine interface aspect.
>>=20
>> I feel that a new human interface is *related* to that goal: the
>> splitting of, and commitment to, separate human and machine interfaces
>> powered by a single root schema.

A bit of history.

QMP initially shared HMP's "schema": qemu-monitor.hx.  The command
handler was either a traditional HMP one, or a QMP-enabling pair (QMP
handler, HMP formatter).  The idea was to convert traditional HMP
handlers one by one, then ditch support for them.

With a QMP handler, HMP became a wrapper around QMP.  The input wrapping
was data-driven: @args_type specifies how to map HMP arguments to QMP.
The output wrapper was code, namely the HMP formatter.

This design turned out to tie QMP to HMP too tightly.  It assumes QMP
and HMP commands are identical apart from argument syntax and output
formatting.  They often should not be.  QMP wants building blocks:
simple commands with simple replies, in particular simple failure modes.
HMP wants convenience.  QMP wants rigor.  HMP has uses where that's a
painful and unnecessary.

So we split qemu-monitor.hx into hmp-commands.hx and qmp-commands.hx.
The former reverted back to the pre-QMP state, and the latter lost
support for HMP wrappers.  QMP was liberated from having to reimplement
HMP.  HMP was liberated from always having to do QMP first.

qmp-commands.hx was eventually replaced by the QAPI schema.

The lesson here is that to make "powered by a single root schema" work
well, we'll likely have to put in more smarts than we did back then.

More on that below in reply to David's reply.

>> I am a big believer in making QEMU usable directly to human users as I
>> feel the pipeline of "tinker to deployment" is important for a
>> successful project, for many reasons:
>>=20
>> - QEMU should be easy to pick up and learn.
>>=20
>> - Supporting QEMU's use directly as an "end-user" program increases
>> proficiency in the user population at large, which (can) lead to better
>> answers and engagement on e.g. Reddit, StackOverflow, IRC
>>=20
>> - Evolving deployments from QEMU-only to libvirt+ or above (RHV, oVirt,
>> kubevirt) should be a smooth and gradual process as additional
>> complexity is desired.
>>=20
>> - Focusing on QEMU's usability allows our project to be consumed easier
>> by new cloud-focused projects. If they are already familiar with (and
>> happy with) our project, it is more likely to be used instead of seeking
>> out alternatives. This is about reducing friction.
>>=20
>> So, for those reasons ... even though I feel that a machine-focused API
>> is our #1 priority as it caters to our existing users, we should also
>> focus on what it will take to grow mindshare for QEMU's value in the
>> ecosystem.
>>=20
>> Slick interfaces and documentation go a long, long way to doing that.
>>=20
>> So: I feel that any new machine-only paradigm or overhaul needs to be
>> accompanied with some new sugar to help the medicine go down, so-to-spea=
k.

Points taken.

>> On 2/5/20 8:09 AM, Kevin Wolf wrote:
>> > Am 28.01.2020 um 11:59 hat Kevin Wolf geschrieben:
>> >>>> The other part that it needs to solve is how to be available by def=
ault
>> >>>> without specifying anything on the command line. Basically, if I pr=
ess
>> >>>> Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
>> >>>> implemented internally or by an external Python process, I don't mi=
nd.
>> >>>
>> >>> That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mostly
>> >>> use HMP on stdin).
>> >>
>> >> I don't think it would be that hard, actually.
>> >>
>> >> If you have a -qmp-shell option that takes a chardev and defaults to =
vc,
>> >> you've solved the part with both stdio and Ctrl-Alt-2. Now all you ne=
ed
>> >> to do is launch the Python child process, pass it a pair of pipes for
>> >> communication and forward everything between the pipes and the charde=
v.
>> >>
>> >> (That's the theory anyway.)
>> >=20
>> > If someone is interested, I did a quick proof-of-concept hack:
>> >=20
>> >     https://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/qmp-shell
>> >=20
>> > It doesn't clean up anything properly (including the qmp-shell process=
es
>> > it starts), but it spawns a usable qmp-shell on a user-specified
>> > character device. stdio seems to work, though without readline
>> > functionality (I suppose I still have line-buffering somewhere), vc
>> > doesn't really work at all yet.
>> >=20
>> > Try it out like this:
>> >=20
>> >     $ ./qemu-storage-daemon --chardev stdio,id=3Dm --monitor m,mode=3D=
qmp-shell
>> >     monitor_qmp_event: 1
>> >     Welcome to the QMP low-level shell!
>> >     Connected to QEMU 4.2.50
>> >=20
>> >     (QEMU) query-version
>> >     {"return": {"qemu": {"micro": 50, "major": 4, "minor": 2}, "packag=
e": "v4.2.0-1188-gd95a3885a9"}}
>> >     (QEMU) quit
>> >=20
>> > (Or use x86_64-softmmu/qemu-system-x86_64, but it's based on the
>> > refactorings in the storage daemon branch, so why not try both at once=
?)
>> >=20
>> > Polishing this to make it mergable would still require substantial wor=
k,
>> > so at the moment I'm not planning to do this. But if someone wants to
>> > pick it up, feel free (just let us know).
>> >=20
>> > Hm, in fact... A qmp-shell GSoC project?
>> >=20
>>=20
>> That would be great. I worry that we should have a clear vision for the
>> syntax before we give this project to an intern, though. With a clear
>> vision and an outline for deliverables, it's an incredibly appropriate
>> project.
>>=20
>> Some things I think we want to define before we start:
>>=20
>> 1. What are we trying to achieve with a standalone shell?

Projects without a clear goal rarely succeed.  Success within three
months is even rarer.

>> 2. What syntax should it use?

Leaving that to a GSoC student amounts to setting up for failure.

>> I think those are the hardest parts.
>>
>> Below, some musings:
>>=20
>> - An integrated QMP shell would be a great usability boost to users of
>> bare QEMU.
>>=20
>> - It is undesirable in general to support two interfaces. Feature
>> disparity is a problem, as is needing to document and test two separate
>> interfaces. The quality disparity between the two is also an issue.
>>=20
>> - Offering HMP via the GTK interface but not QMP is a discoverability
>> problem. Unfamiliar users might assume that HMP is our flagship
>> interface. It is not.
>>=20
>> - We are unlikely to re-expand HMP to cover everything QMP does; writing
>> a QMP shell that makes QMP easy to interface with is a better solution
>> for removing redundancy and complexity.
>>=20
>> - I suspect that the target audience for users of naked QEMU are:
>>   - QEMU developers
>>   - Upper-layer developers (RHV, oVirt, KubeVirt, libvirt, kata, et al)
>> researching, testing, and debugging integration.
>>   - Devops professionals testing, implementing and debugging
>>     configuration & infrastructure
>>   - Security/infosec researchers
>>   - Embedded platform developers
>>   - Academic researchers
>>=20
>>=20
>>=20
>> So please correct me if I am off the mark;
>>=20
>> Design Goals:
>>   - The removal of HMP
>>   - An easy-to-use interface that remains reasonably "close" to the
>> machine API such that it provides a smooth transition to scripting QEMU.
>>   - Integration with our GTK interface for discoverability and convenien=
ce
>>=20
>> Syntax:
>>   - TBD? Do we agree that the current syntax in qmp-shell is "bad" and
>> should be replaced? If yes, what should it look like?
>
> I believe it should be a python shell with added commands.
>
> Simple things should be simple.
>   e.g. adding a disk from a local file should be trivial.
>
> Complex things can be complex - but it would be better if they were
> simple.
>
>   It's OK if the worst case of a blockdev is a bit hairy, but
>   watch out for cases where the hairyness creeps in unnecessarily.

Designing interfaces to complex machinery is hard.  Experience tells
that we do okay when we focus on the building blocks first.  That's
-blockdev.  When we start with trying to make simple things simple, we
end in swamps.  That's -drive.

Focus on building blocks is of course no excuse for unnecessary
hairiness.

It's also no reason not to build more convenient things on top of the
building blocks.  I doubt they should go into QMP, though.

> If the user screwsup, it should give an error that prompts the user
> to the parameter they got wrong.
>
> Output from commands should normally be pretty formatted (with an option
> to display raw json for those needing it).
>   e.g. that 'query-version' should give either just the package
>   version (as info version currently does) or:
>       4.2.50  Package: v4.2.0-1188-gd95a3885a9
>
> We shouldn't lose any HMP commands that some people find useful
>   Ditching HMP isn't an option until we've got almost all of it
>   covered.

In particular, we currently use HMP for debugging and monitoring
purposes, where we don't need or want QMP's rigor, neither its rigorous
interface stability, nor its structured I/O.  We want the "whipuptitude"
we get from monitor_printf().  This is actually a point David has made
several times.

To have a qmp-shell replace HMP, I think it needs to be able to

* Go beyond 1:1

  We tried a 1:1 mapping between HMP and QMP commands, and it didn't
  work out.  HMP's replacement should let us build convenient commands
  from QMP building blocks.

  We tried a 1:1 mapping between HMP and QMP command arguments, guided
  by @args_type.  Worked out for simple cases, but was too constricting.

* Preserve "whipuptitude" [David]

  I figure that means allowing some in QMP.  Without compromising its
  core mission, of course.

* As discoverable as HMP is now [Kevin]

* Help, completion and such at least on par with what HMP provides now

Highly desirable:

* Support transitioning to the machine interface [John]

  Let humans start playing with the human interface, and when they feel
  the need to automate, help them transition to QMP.

Back to John's question on qmp-shell syntax, which hasn't been answered
so far.

JSON is a data-interchange format.  It doesn't try to be a configuration
format or programming language syntax for human use.  It gets pressed
into these roles with entirely predictable poor results.

Pain points of JSON include having to count parenthesises and having to
quote so bloody much.  Additional QMP pain points include long names and
excessive nesting.

For the configuration format role, more usable alternatives exist.  YAML
is a popular one.

qmp-shell is a REPL.  It needs a REPL-friendly syntax.  I doubt YAML is
or even tries to be REPL-friendly.  I'd love to be wrong; the first rule
of language design is "don't".

Other language suggestions?

On making JSON suck less in this role:

LISP REPLs demonstrate that computers can assist effectively with
counting parenthesises, and with completing long names.

We could make quoting optional for sufficiently nice object member
names.  QAPI naming rules ensure niceness, actually.

We could make quoting optional for certain string literals.  Simple
enough for literals that can only be a string, like abc.  For literals
that could be something else like 123 or true, omitting quotes creates
ambiguity.  When the schema accepts only one of the possible types, the
ambiguity goes away.  Complexity stays, however.

Excessive nesting should ideally be attacked in QMP itself, but backward
compatibility makes that hard.


