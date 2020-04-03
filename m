Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48AF206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf018+5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48AF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKH2v-0001OP-1L
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jKH1y-0000fu-1L
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jKH1w-0003Z1-Bu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:46:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jKH1w-0003Wa-6d
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585899979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRZXOkP3vDYNkrOMunGOZBhisjeKpPdYz/Rjacoouq4=;
 b=Yf018+5zBb7AicYAJEcXz0pBhNigIhB6rSvX3bcNohSWl+UCPQDj7BH5sEziRXDuMtDruQ
 aZKD9qlzfuDaTpAgXNMVIIkyzG/tE4ZDKEvC+tU5ZJJZaxNH3LujSWGN/U0lpNiZ7fuqXw
 U9TMbLcVv6QgXqmC92r3TKaGQq/Puf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-nY_DNvh2M1W0xniN81kwIA-1; Fri, 03 Apr 2020 03:46:17 -0400
X-MC-Unique: nY_DNvh2M1W0xniN81kwIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64306800D50;
 Fri,  3 Apr 2020 07:46:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-132.ams2.redhat.com [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E4A11147CE;
 Fri,  3 Apr 2020 07:46:14 +0000 (UTC)
Date: Fri, 3 Apr 2020 09:46:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v10 10/14] iotests: add hmp helper with logging
Message-ID: <20200403074613.GA5336@linux.fritz.box>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-11-jsnow@redhat.com>
 <88146808-4acc-247e-d34b-5dd16baad0b4@redhat.com>
 <c0efeb62-b121-74a2-1929-b41a0e47c1b8@redhat.com>
 <20200331173945.GL7030@linux.fritz.box>
 <0c8ce9c5-d8b4-4b24-a6e3-4b9863c52fe0@redhat.com>
 <449f8a5e-d8a0-1993-c30c-97d67a89df1e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <449f8a5e-d8a0-1993-c30c-97d67a89df1e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.04.2020 um 20:27 hat John Snow geschrieben:
> On 4/1/20 8:40 AM, Max Reitz wrote:
> > On 31.03.20 19:39, Kevin Wolf wrote:
> >> Am 31.03.2020 um 19:23 hat John Snow geschrieben:
> >>>
> >>>
> >>> On 3/31/20 6:21 AM, Max Reitz wrote:
> >>>> On 31.03.20 02:00, John Snow wrote:
> >>>>> Minor cleanup for HMP functions; helps with line length and consoli=
dates
> >>>>> HMP helpers through one implementation function.
> >>>>>
> >>>>> Although we are adding a universal toggle to turn QMP logging on or=
 off,
> >>>>> many existing callers to hmp functions don't expect that output to =
be
> >>>>> logged, which causes quite a few changes in the test output.
> >>>>>
> >>>>> For now, offer a use_log parameter.
> >>>>>
> >>>>>
> >>>>> Typing notes:
> >>>>>
> >>>>> QMPResponse is just an alias for Dict[str, Any]. It holds no specia=
l
> >>>>> meanings and it is not a formal subtype of Dict[str, Any]. It is be=
st
> >>>>> thought of as a lexical synonym.
> >>>>>
> >>>>> We may well wish to add stricter subtypes in the future for certain
> >>>>> shapes of data that are not formalized as Python objects, at which =
point
> >>>>> we can simply retire the alias and allow mypy to more strictly chec=
k
> >>>>> usages of the name.
> >>>>>
> >>>>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>>>> ---
> >>>>>  tests/qemu-iotests/iotests.py | 35 ++++++++++++++++++++++---------=
----
> >>>>>  1 file changed, 22 insertions(+), 13 deletions(-)
> >>>>
> >>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>>>
> >>>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iot=
ests.py
> >>>>> index b08bcb87e1..dfc753c319 100644
> >>>>> --- a/tests/qemu-iotests/iotests.py
> >>>>> +++ b/tests/qemu-iotests/iotests.py
> >>>>> @@ -37,6 +37,10 @@
> >>>>> =20
> >>>>>  assert sys.version_info >=3D (3, 6)
> >>>>> =20
> >>>>> +# Type Aliases
> >>>>> +QMPResponse =3D Dict[str, Any]
> >>>>> +
> >>>>> +
> >>>>>  faulthandler.enable()
> >>>>> =20
> >>>>>  # This will not work if arguments contain spaces but is necessary =
if we
> >>>>> @@ -540,25 +544,30 @@ def add_incoming(self, addr):
> >>>>>          self._args.append(addr)
> >>>>>          return self
> >>>>> =20
> >>>>> -    def pause_drive(self, drive, event=3DNone):
> >>>>> -        '''Pause drive r/w operations'''
> >>>>> +    def hmp(self, command_line: str, use_log: bool =3D False) -> Q=
MPResponse:
> >>>>> +        cmd =3D 'human-monitor-command'
> >>>>> +        kwargs =3D {'command-line': command_line}
> >>>>> +        if use_log:
> >>>>> +            return self.qmp_log(cmd, **kwargs)
> >>>>> +        else:
> >>>>> +            return self.qmp(cmd, **kwargs)
> >>>>
> >>>> Hm.  I suppose I should take this chance to understand something abo=
ut
> >>>> mypy.  QEMUMachine.qmp() isn=E2=80=99t typed, so mypy can=E2=80=99t =
check that this
> >>>> really returns QMPResponse.  Is there some flag to make it?  Like
> >>>> --actually-check-types?
> >>>>
> >>>
> >>> One of --strict's implied options, I'm not sure which. Otherwise, myp=
y
> >>> is geared towards a 'gradual typing' discipline.
> >>>
> >>> In truth, I'm a little thankful for that because it helps avoid yak
> >>> shaving marathons.
> >=20
> > Sure.  I was just looking into the different options.  I was interested
> > in whether I could come up with a mode that leaves wholly untyped code
> > alone, but warns for code that mixes it.  Or something.
> >=20
> >>> It does mean that sometimes the annotations don't "do anything" yet,
> >>> apart from offering hints and documentation in e.g. pycharm. Which do=
es
> >>> mean that sometimes they can be completely wrong...
> >>>
> >>> The more we add, the more we'll catch problems.
> >>>
> >>> Once this series is dusted I'll try to tackle more conversions for
> >>> iotests, qmp, etc. I've got a few WIP patches to tackle conversions f=
or
> >>> tests/qemu-iotests/*.py but I am trying to shepherd this one in first
> >>> before I go bananas.
> >=20
> > Sure, sure.
> >=20
> >>>> (--strict seems, well, overly strict?  Like not allowing generics, I
> >>>> don=E2=80=99t see why.  Or I suppose for the time being we want to a=
llow untyped
> >>>> definitions, as long as they don=E2=80=99t break type assertions suc=
h as it kind
> >>>> of does here...?)
> >>>>
> >>>
> >>> "disallow-any-generics" means disallowing `Any` generics, not
> >>> disallowing generics ... in general. (I think? I've been using mypy i=
n
> >>> strict mode for a personal project a lot lately and I use generics in=
 a
> >>> few places, it seems OK.)
> >>
> >> --disallow-any-generics
> >>       disallow usage of generic types that do not specify explicit typ=
e parameters
> >>
> >> So it will complain if you say just List, and you need to be explicit =
if
> >> you really want List[Any]. Which I think is a reasonable thing to
> >> require.
> >=20
> > OK.  So it=E2=80=99s =E2=80=9Cdisallow =E2=80=98any=E2=80=99 generics=
=E2=80=9D, not =E2=80=9Cdisallow any =E2=80=98generic=E2=80=99s=E2=80=9D.
> > Not easy to parse.  (Yes, yes, I should=E2=80=99ve actually read the ma=
n page...)
> >=20
> > Good to know that mypy and me actually do seem to loosely agree on what
> > a generic is. :)
> >=20
> > Max
> >=20
>=20
> Are we squared up for this series? I am actually not sure.

I had a comment in patch 14 which you may or may not want to address (my
R-b was unconditional). I think everything else was just tangential
discussion.

Kevin


