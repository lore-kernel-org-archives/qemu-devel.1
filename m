Received: from eggs.gnu.org ([2001:4830:134:3::10]:33708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWIXM-0004ij-45
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWIXI-00047v-63
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWIXH-00047V-R3
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 05:11:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4113281F0E
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:11:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-22-marcandre.lureau@redhat.com>
	<87bm5y8sce.fsf@dusky.pond.sub.org>
	<CAMxuvaz6zpraY=1U0UJ6jvneTENk9HzvoGtztvbjQJWon0CuaA@mail.gmail.com>
	<87d0q9onoc.fsf@dusky.pond.sub.org>
Date: Mon, 10 Dec 2018 11:11:29 +0100
In-Reply-To: <87d0q9onoc.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 10 Dec 2018 08:17:55 +0100")
Message-ID: <87lg4xk7xq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Hi
>> On Thu, Dec 6, 2018 at 9:42 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>>
>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>
>>> > Wrap generated enum/struct members and code with #if/#endif, using the
>>>
>>> enum and struct members
>>
>> ok
>>
>>>
>>> > .ifcond members added in the previous patches.
>>> >
>>> > Some types generate both enum and struct members for example, so a
>>> > step-by-step is unnecessarily complicated to deal with (it would
>>> > easily generate invalid intermediary code).
>>>
>>> Can you give an example of a schema definition that would lead to
>>> complications?
>>>
>>
>> Honestly, I don't remember well (it's been a while I wrote that code).
>
> I know...
>
>> It must be related to implicit enums, such as union kind... If there
>> is no strong need to split this patch, I would rather not do that
>> extra work.
>
> I'm not looking for reasons to split this patch, I'm looking for
> stronger reasons to keep it just like it is :)
>
> Your hunch that complications would arise for simple unions plausible:
> there the same conditional needs to be applied both to the C enum's
> member and the C union member.
>
> For the generated C code to compile, each union tag enum member
> conditional must imply the corresponding variant conditional.
>
> For flat unions, the two are separate.  The QAPI generator makes no
> effort to check the enum member's if condition implies the union
> variant's if condition; if you mess them up in the schema, you get to
> deal with the C compilation errors.
>
> For simple unions, the two are one.
>
> If we separate the generator updates for enums and for union members,
> and do enum members first, then unions with conditional tag members
> can't compile.  Corrollary: simple unions with conditional variants
> can't compile.
>
> What if we do union members first?
>
> Again, I'm not asking for patch splitting here, I'm just trying to
> arrive at a clearer understanding to avoid making insufficiently
> supported claims in the commit message.  The combined patch looks small
> and clean enough to keep it combined.
>
> [...]

What about this commit message:

    qapi: Add #if conditions to generated code members

    Wrap generated enum and struct members and their supporting code with
    #if/#endif, using the .ifcond members added in the previous patches.

    We do enum and struct in a single patch because union tag enum and the
    associated variants tie them together, and dealing with that to split
    the patch doesn't seem worthwhile.
