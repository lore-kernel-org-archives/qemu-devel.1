Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05521C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EE5206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyoAEQMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EE5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9i4-0000X4-SG
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ip9hA-0007v1-1o
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ip9h7-00009W-Rh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:40:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ip9h7-00008h-MI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578483612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCaPLL6lX+sD/EGaq7USj6iMTLgEOaSzBvafdPqyjLs=;
 b=LyoAEQMmdy83/7qEXbIWMhf68or7pLLCjzsqHELTGjdGeWRzYbKQGbu19r4CJbubsDJjD4
 3SRvNrVpTlqUKgmseiLTlFOoR9V529eW6xhathNcU03ZZZtvkUzNgGQ86uO13Yd8qDpJp3
 Kd8I944WCWFMda1l3H4dD9uQYvbYYy8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267--RUrC4gROTe-LidMJLifiA-1; Wed, 08 Jan 2020 06:40:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so1323162wrq.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 03:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=cikFrXApZDIOzlZrYLKa7HpqrCoGwXkWPIX04wcEaAQ=;
 b=BSByg9/OwG/bPaAqWmQMeLs+2oDSi5/+bzJMe+uqSkN1nxV8qWK95PraxyZof8ZszI
 mpk9/GgMhrf8cfR2zN9bRfjWv45jMiSaOX5TfSlBl5FrXeJOozDc8p0jU8vkwrcJxRi3
 mEiUyR0LA6ERKacNYH5r0ZVEOVkwyTk8mq+9YiK/pG9rTrEnfoLgTmiS1KFMcItTr3Z4
 yyxmCeUShKy7Gu60g+jrij5vViHp2WYGTSlNFZQdTGwIUx7ZTVMjUTbOo1ECafUkPWig
 uAZmVfNxpo6M4HuHs1Lwt5f2rLu7JvhKKR8vA7B6BNpeACbHJ6lQcBpPU2XsGLDdDL5C
 OmYQ==
X-Gm-Message-State: APjAAAVspeaPjk2Ri5OviG8ArGG4XwZEa+P/oA0CnEGhSa37q0nFTjSi
 cLWi+mUS21Vz1G1Bjwp96HnlCRWx8Sgv/dNVhnZ9STbO9RMslFTsahRPWXTjelKBVDITlT3BcSr
 3Q0tQ5d7/TPlWnSY=
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr3960069wrf.174.1578483608018; 
 Wed, 08 Jan 2020 03:40:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqweDDZ17pRwi47hRFp4K5jJd82eYbp6fkj8Bo/GFbQldn/LAFeDZ1PGvEfkc98ul2F1XbM5aw==
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr3960015wrf.174.1578483607443; 
 Wed, 08 Jan 2020 03:40:07 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1136:b5d4:147f:7046?
 ([2a01:e0a:466:71c0:1136:b5d4:147f:7046])
 by smtp.gmail.com with ESMTPSA id p17sm3497709wmk.30.2020.01.08.03.40.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 03:40:06 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Making QEMU easier for management tools and applications
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
Date: Wed, 8 Jan 2020 12:40:03 +0100
Message-Id: <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: -RUrC4gROTe-LidMJLifiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 8 Jan 2020, at 11:43, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 07.01.2020 um 18:11 hat Christophe de Dinechin geschrieben:
>> So I think that it might help, in the long run, to start defining the
>> language in question in some abstract way, and then to have rules
>> for how to transform that abstract language into concrete bindings.
>=20
> I think this abstract language is QAPI.

Currently, yes, that=E2=80=99s the closest we have to a well-defined langua=
ge,
I pointed it out in my mail, and there is qapi-code-gen.txt to prove it.

So it would certainly make sense for the language I=E2=80=99m describing to
be a forward evolution of QAPI, or something that is trivially transformed
to / from the existing json schema.

> The problem is that we're not even close to using QAPI for everything.

That=E2=80=99s the symptom of the problem. The problem as I see it is that
we could not. at least not with today=E2=80=99s QAPI (maybe I=E2=80=99m wro=
ng).
A good example is shortcut command-line options. I don=E2=80=99t think
you can, today, derive a user-friendly command-line syntax from
qapi-schema.json, and even less so one that is compatible with what
we have today.

> Adding a new language on top of QAPI instead isn't going to make the
> conversion process any faster.

I fully agree that whatever language we select has to have an easy,
systematic forward path from QAPI, but also from the other
existing meta-languages, like the .def files used for options,
or build configuration (there is a hint of the connection between
the two in the option =E2=80=98if=E2=80=99 member in the .json files).

In other words, the language I have in mind would be something
that I could auto-generate from, say, the current qapi-schema.json
and the qemu-options.def. Maybe in the end, that would be simply
by having qemu-options.def being used to build qemu-options.json,
and then add the relevant entries in qemu-options.json. Maybe
there is a better way.

>=20
>> This definition itself is not obvious (at least not to me). For
>> example, do we have, anywhere but in the C code, the specification
>> of how one can add a disk to qemu, and what it means?
>> Say, looking at qemu-options.def, how do I tell that -hda has
>> anything to do with -device or -blockdev or -help?
>=20
> BlockdevOptions in the QAPI schema is what tells you how it _really_
> works.

Not really, IMO, in the sense that it gives me no clue as to how -hda
or -device relate to it.

An important point that you raise through your response, though, is
that the QAPI schema is only an IDL (interface definition language).
In other words, it can tell me what a BlockdevOptions look like on
the wire, but at least in the current state, it cannot tell me what happens
with it.

This is probably a good thing (it=E2=80=99s already complicated enough as i=
s),
but it=E2=80=99s worth pointing out that, even sticking to a declarative la=
nguage,
one could add constraints, as hinted by HAS_ARG in the .def file
(but we could have a richer constraints language, e.g. describing
-m option so that there can be at most one, the arg is a number,
can=E2=80=99t be negative or floating-point, and so on.

And of course, we could decide to not stick to a declarative language,
but to have a way to have some, possibly limited, processing
described in the language. I=E2=80=99m thinking notably of what is called
=E2=80=9Cdesugaring=E2=80=9D in other threads.

> The connection to the various command line syntaxes isn't defined
> in a declarative way because we don't have a QAPIfied command line yet.
> I know that Markus wants to work on this, but I don't know how much time
> he actually has to invest in it.

Agreed. As I said, that=E2=80=99s a symptom that QAPI is not the language
I am talking about, but at best a subset of it.

>=20
>> I think that the following piece of code from vl.c is revealing:
>>=20
>>            case QEMU_OPTION_hda:
>>            case QEMU_OPTION_hdb:
>>            case QEMU_OPTION_hdc:
>>            case QEMU_OPTION_hdd:
>>                drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, opta=
rg,
>>                          HD_OPTS);
>>                break;
>>            case QEMU_OPTION_blockdev:
>>                {
>>                    Visitor *v;
>>                    BlockdevOptionsQueueEntry *bdo;
>>=20
>>                    v =3D qobject_input_visitor_new_str(optarg, "driver",
>>                                                      &error_fatal);
>>=20
>>                    bdo =3D g_new(BlockdevOptionsQueueEntry, 1);
>>                    visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
>>                                               &error_fatal);
>>                    visit_free(v);
>>                    loc_save(&bdo->loc);
>>                    QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
>>                    break;
>>                }
>>            case QEMU_OPTION_drive:
>>                if (drive_def(optarg) =3D=3D NULL) {
>>                    exit(1);
>>                }
>>                break;
>>=20
>> Here, we have three cases related to disks in a way or another,
>> and three entirely different ways of doing things.
>=20
> I would say two different ways because drive_add() is just a small
> wrapper around drive_def() that overrides a few options.

Well, I stick to three, because one option has a test and an exit(1),
and the other does not. Which is the kind of inconsistencies a
well-defined language would get rid of.

>=20
> Describing the semantics of the -drive way is hard. This is one of the
> reasons why I would love to get rid of it and replace it with a new
> user-friendly option that has a more direct mapping to the -blockdev
> way, which in turn just is BlockdevOptions mapped 1:1 to the command
> line.

I would love that too :-)

>=20
>> AFAICT, qemu already created several meta-languages to define
>> several aspects of the API, from qemu-options.def to qapi-schema.json.
>> But maybe at some point we need to go meta once more, and define
>> a language defining the API from which we could automatically
>> derive the various bindings, including FFI-style bindings for Rust and G=
o,
>> as well as some internal data structures. Ideally, that meta-definition
>> is something that could be shared between libvirt and qemu so that they
>> literally speak the same language. Or that could be used to automaticall=
y
>> build a REST interface.
>=20
> I think adding an output for additional languages to the QAPI generator
> shouldn't be too hard. It already creates multiple things from a single
> schema (C data structures and command wrappers, schema introspection
> data, documentation, and probably other things that I forgot).

Agreed.

> libvirt already speaks QAPI, however without reusing the schema and the
> generator from QEMU.

That=E2=80=99s another thread ;-)

>=20
>> A big issue, though, is that of compatibility. Doing the above starting
>> from scratch does not seem that complicated. Doing it in a way that
>> preserves a minimum of interoperability with earlier-generation
>> software is another ordeal.
>=20
> Indeed, this is the major reason why QAPI isn't as pervasive as it
> should be.

Probably, but also because QAPI does not address the needs of
some of the things a slightly more general language could do.

>=20
>> So I think that Daniel is right. We may need at some point to start
>> a NEMU-style offshoot that does not attempt to be compatible,
>> but explores describing an increasing surface of the API using a
>> new meta-language from which we can generate, in a consistent
>> way, at least:
>>=20
>> - C bindings
>> - Command-line options
>> - Shell bindings (or =E2=80=9CHMP=E2=80=9D)
>> - JSON schema or qom description
>> - Bindings in other languages (Rust, Go, Python)
>> - Networked versions of the API (socket, REST)
>> - Client-side code e.g. for libvirt.
>> - Serialization / deserialization, e.g. for configuration files
>> - Documentation, including man page and API docs
>> - Command-line help
>=20
> I think the only thing in this list that can't obviously be covered
> easily by QAPI is QOM. Or rather, it's covered by passing through
> key=3Dvalue lists without describing their structure

That=E2=80=99s close enough to me. (In my mind, that part was already =E2=
=80=9Cdone=E2=80=9D
by QAPI, even if in the convoluted way you describe)

> - which, as far as I
> understand, is mainly because QOM properties aren't necessarily static,
> so we can't provide a statically defined interface for them. Probably
> solvable in QEMU, but not without a major effort.

Or maybe extend the language so that it=E2=80=99s internal semantics
knows about this aspect of QOM?

> In a fork that doesn=E2=80=99t care about compatibility, it should be eas=
ier.
>=20
>> At the most fundamental level, I think we need to describe:
>>=20
>> - Values, e.g. how we represent names, sizes, paths, etc, possibly
>> with some user-friendly aspects, e.g. path shortcuts, memory units,
>> spelling shortcuts (e.g. being able to consistently say -blo for -blockd=
ev
>> if that=E2=80=99s the shortest option that matches)
>=20
> I don't think user-friendly shortcuts on the command line are "most
> fundamental".

I agree, my phrasing was poor. What I meant is that the language in
question should include a user-convenience dimension that is
not necessary (and not present) in QAPI. Agree the details are not
fundamental, I meant them as an illustration.

> Whether to accept -blo is an implementation detail of the
> command line parser which translates a bunch of strings into QAPI
> objects.

Yes.

>=20
>> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=80=9C=
derives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
>> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=9Catt=
aches to=E2=80=9D=E2=80=A6
>> - States, e.g. how do we represent the machine configuration,
>> or the desired new disk setting
>> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconnect=
=E2=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
>> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we descr=
ibe the kind of input they need.
>> - Possibly more subtle things like support for transactions, commit/roll=
back,
>> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, but i=
f anything
>> along the way fails, I=E2=80=99d like all the cleanup to happen automati=
cally)
>=20
> This sounds like a different approach from our current QAPI command set

Well, except for purposefully trying to use a different wording to avoid
the risk of getting your mind stuck in one of the particular existing
meta-languages in QEMU, the approach is not very different.

- Relations already exist in QAPI for example: =E2=80=99struct=E2=80=99, =
=E2=80=98union=E2=80=99, =E2=80=98alternate=E2=80=99

- States exist, today represented using JSON

- Verbs are called =E2=80=9Ccommands=E2=80=9D in the QAPI json files, and a=
re what
follows DEF( in the .def file

- Transactions do not exist today that I know of, although we see
signs of them in discussions about the fact that this options destroys
that back end but that option does not.

> (use a smaller set of operations that can work with a greater variety of
> objects).

More like trying to find terminology that lets you reason about it
without being too mind-constrainted by existing stuff.


> Does it actually provide more functionality, though?

It=E2=80=99s not intended to provide more, but to require less to do the sa=
me thing.


Thanks,
Christophe


