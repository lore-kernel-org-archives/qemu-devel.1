Received: from eggs.gnu.org ([2001:4830:134:3::10]:45240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYReF-0005Sc-04
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYReB-0002uj-Qj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYReB-0002tz-HW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:42:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE5B57F772
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:42:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-6-eblake@redhat.com>
	<87zibzl8py.fsf@dusky.pond.sub.org>
	<ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
	<9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com>
Date: Fri, 21 Jul 2017 08:42:43 +0200
In-Reply-To: <9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com> (Eric Blake's
	message of "Thu, 20 Jul 2017 15:53:56 -0500")
Message-ID: <87379ql28s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/20/2017 03:37 PM, Eric Blake wrote:
>>>> + * @fmt...: QMP message to send to qemu; only recognizes formats
>>>> + * understood by json-lexer.c
>>>>   *
>>>>   * Sends a QMP message to QEMU and consumes the response.
>>>>   */
>>>
>>> These formats are chosen so that gcc can help us check them.  Please add
>>> GCC_FMT_ATTR().  Precedence: qobject_from_jsonf().
>>=20
>> Will do.  (This patch was originally part of my larger series trying to
>> get rid of qobject_from_jsonf() - I may still succeed at that, but
>> separating the easy stuff from the controversial means that the easy
>> stuff needs tweaking).
>
> Bleargh.  It's not that simple.
>
> With printf-style, hmp("literal") and hmp("%s", "literal") produce the
> same results.
>
> But with json-lexer style, %s MODIFIES its input.

Your assertion "MODIFIES its input" confused me briefly, because I read
it as "side effect on the argument string".  That would be bonkers.
What you mean is it doesn't emit the argument string unmodified.

> The original qmp("{'execute':\"foo\"}") sends a JSON object
>  {'execute':"foo"}
> but counterpart qmp("%s", "{'execute':'foo'}") sends a JSON string with
> added \ escaping:
>  "{'execute':\"foo\"}"
>
> So adding the format immediately causes lots of warnings, such as:
>
>   CC      tests/vhost-user-test.o
> tests/vhost-user-test.c: In function =E2=80=98test_migrate=E2=80=99:
> tests/vhost-user-test.c:668:5: error: format not a string literal and no
> format arguments [-Werror=3Dformat-security]
>      rsp =3D qmp(cmd);
>      ^~~

    cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
                          "'arguments': { 'uri': '%s' } }",
                          uri);
    rsp =3D qmp(cmd);
    g_free(cmd);
    g_assert(qdict_haskey(rsp, "return"));
    QDECREF(rsp);

For this to work, @uri must not contain funny characters.

Shouldn't we simply use the built-in quoting here?

    rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri=
);
    g_assert(qdict_haskey(rsp, "return"));
    QDECREF(rsp);

>
>   CC      tests/boot-order-test.o
> tests/boot-order-test.c: In function =E2=80=98test_a_boot_order=E2=80=99:
> tests/boot-order-test.c:46:26: error: zero-length gnu_printf format
> string [-Werror=3Dformat-zero-length]
>      qmp_discard_response("");   /* HACK: wait for event */
>                           ^~

Should use qmp_eventwait().  Doesn't because it predates it.

> but we CAN'T rewrite those to qmp("%s", command).

Got more troublemakers?

> Now you can sort-of understand why my larger series wanted to get rid of
> qobject_from_jsonf(), since our use of GCC_FMT_ATTR() there is a lie?

I don't think it's a lie.  qobject_from_jsonf() satisfies the attribute
format(printf, ...) contract: it fetches varargs exactly like printf().
What it does with them is of no concern to this attribute.
