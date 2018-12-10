Received: from eggs.gnu.org ([2001:4830:134:3::10]:37321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gWQcR-0002cn-E5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gWQRn-0002Je-Kp
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:38:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gWQRn-0002JW-Fy
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:38:27 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so7090936qki.7
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-22-marcandre.lureau@redhat.com>
	<87bm5y8sce.fsf@dusky.pond.sub.org>
	<CAMxuvaz6zpraY=1U0UJ6jvneTENk9HzvoGtztvbjQJWon0CuaA@mail.gmail.com>
	<87d0q9onoc.fsf@dusky.pond.sub.org> <87lg4xk7xq.fsf@dusky.pond.sub.org>
In-Reply-To: <87lg4xk7xq.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 10 Dec 2018 22:38:15 +0400
Message-ID: <CAMxuvaxSwPLGibjnFjaoOsc2xYpPxfWBsx8LwDt6HuwAwhDv=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 21/27] qapi: add #if conditions to
 generated code members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Mon, Dec 10, 2018 at 2:11 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Hi
> >> On Thu, Dec 6, 2018 at 9:42 PM Markus Armbruster <armbru@redhat.com> w=
rote:
> >>>
> >>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>>
> >>> > Wrap generated enum/struct members and code with #if/#endif, using =
the
> >>>
> >>> enum and struct members
> >>
> >> ok
> >>
> >>>
> >>> > .ifcond members added in the previous patches.
> >>> >
> >>> > Some types generate both enum and struct members for example, so a
> >>> > step-by-step is unnecessarily complicated to deal with (it would
> >>> > easily generate invalid intermediary code).
> >>>
> >>> Can you give an example of a schema definition that would lead to
> >>> complications?
> >>>
> >>
> >> Honestly, I don't remember well (it's been a while I wrote that code).
> >
> > I know...
> >
> >> It must be related to implicit enums, such as union kind... If there
> >> is no strong need to split this patch, I would rather not do that
> >> extra work.
> >
> > I'm not looking for reasons to split this patch, I'm looking for
> > stronger reasons to keep it just like it is :)
> >
> > Your hunch that complications would arise for simple unions plausible:
> > there the same conditional needs to be applied both to the C enum's
> > member and the C union member.
> >
> > For the generated C code to compile, each union tag enum member
> > conditional must imply the corresponding variant conditional.
> >
> > For flat unions, the two are separate.  The QAPI generator makes no
> > effort to check the enum member's if condition implies the union
> > variant's if condition; if you mess them up in the schema, you get to
> > deal with the C compilation errors.
> >
> > For simple unions, the two are one.
> >
> > If we separate the generator updates for enums and for union members,
> > and do enum members first, then unions with conditional tag members
> > can't compile.  Corrollary: simple unions with conditional variants
> > can't compile.
> >
> > What if we do union members first?
> >
> > Again, I'm not asking for patch splitting here, I'm just trying to
> > arrive at a clearer understanding to avoid making insufficiently
> > supported claims in the commit message.  The combined patch looks small
> > and clean enough to keep it combined.
> >
> > [...]
>
> What about this commit message:
>
>     qapi: Add #if conditions to generated code members
>
>     Wrap generated enum and struct members and their supporting code with
>     #if/#endif, using the .ifcond members added in the previous patches.
>
>     We do enum and struct in a single patch because union tag enum and th=
e
>     associated variants tie them together, and dealing with that to split
>     the patch doesn't seem worthwhile.

ack, thanks
