Received: from eggs.gnu.org ([2001:4830:134:3::10]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYgR-0005a1-Nm
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYgM-0003X3-Mh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYgM-0003WI-DR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:13:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 405A781F01
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:13:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-6-eblake@redhat.com>
	<87zibzl8py.fsf@dusky.pond.sub.org>
	<ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
	<9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com>
	<87379ql28s.fsf@dusky.pond.sub.org>
	<ac668b9d-3ee4-7e63-efed-4d092b2adb78@redhat.com>
Date: Fri, 21 Jul 2017 16:13:27 +0200
In-Reply-To: <ac668b9d-3ee4-7e63-efed-4d092b2adb78@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 07:08:57 -0500")
Message-ID: <87bmodho8o.fsf@dusky.pond.sub.org>
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

> On 07/21/2017 01:42 AM, Markus Armbruster wrote:
>>> But with json-lexer style, %s MODIFIES its input.
>>=20
>> Your assertion "MODIFIES its input" confused me briefly, because I read
>> it as "side effect on the argument string".  That would be bonkers.
>> What you mean is it doesn't emit the argument string unmodified.
>
> Yes. I'm not sure how I could have worded that better; maybe "does not
> do a straight passthrough of its input"
>
>>> So adding the format immediately causes lots of warnings, such as:
>>>
>>>   CC      tests/vhost-user-test.o
>>> tests/vhost-user-test.c: In function =E2=80=98test_migrate=E2=80=99:
>>> tests/vhost-user-test.c:668:5: error: format not a string literal and no
>>> format arguments [-Werror=3Dformat-security]
>>>      rsp =3D qmp(cmd);
>>>      ^~~
>>=20
>>     cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
>>                           "'arguments': { 'uri': '%s' } }",
>>                           uri);
>>     rsp =3D qmp(cmd);
>>     g_free(cmd);
>>     g_assert(qdict_haskey(rsp, "return"));
>>     QDECREF(rsp);
>>=20
>> For this to work, @uri must not contain funny characters.
>>=20
>> Shouldn't we simply use the built-in quoting here?
>
> We can - but there are a lot of tests that have to be updated.

Not that many, see "[PATCH 0/9] tests: Clean up around qmp() and hmp()".
Its PATCH 4/9 makes the case for built-in quoting:

    When you build QMP input manually like this

        cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
                              "'arguments': { 'uri': '%s' } }",
                              uri);
        rsp =3D qmp(cmd);
        g_free(cmd);

    you're responsible for escaping the interpolated values for JSON.  Not
    done here, and therefore works only for sufficiently nice @uri.  For
    instance, if @uri contained a single "'", qobject_from_jsonv() would
    fail, qmp_fd_sendv() would misinterpret the failure as empty input and
    do nothing, and the test would hang waiting for a response that never
    comes.

    Leaving interpolation into JSON to qmp() is more robust:

        rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }",=
 uri);

    It's also more concise.

In short, using printf() & similar to format JSON is a JSON injection
vulnerability waiting to happen.  Special case: g_strdup_printf() to
format input for qobject_from_jsonf() & friends.  Leaving the job to
qobject_from_jsonf() is more robust.

>>=20
>>     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", =
uri);
>>     g_assert(qdict_haskey(rsp, "return"));
>>     QDECREF(rsp);
>>=20
>>>
>>>   CC      tests/boot-order-test.o
>>> tests/boot-order-test.c: In function =E2=80=98test_a_boot_order=E2=80=
=99:
>>> tests/boot-order-test.c:46:26: error: zero-length gnu_printf format
>>> string [-Werror=3Dformat-zero-length]
>>>      qmp_discard_response("");   /* HACK: wait for event */
>>>                           ^~
>>=20
>> Should use qmp_eventwait().  Doesn't because it predates it.
>
> We can - but there are a lot of tests that have to be updated.

Also not that many, see same series.

>>> but we CAN'T rewrite those to qmp("%s", command).
>>=20
>> Got more troublemakers?
>
> When I worked on getting rid of qobject_from_jsonf(), I was able to
> reduce the tests down to JUST using %s, which I then handled locally in
> qmp() rather than relying on qobject_from_jsonf().  Going the opposite
> direction and more fully relying on qobject_from_jsonf() by fixing
> multiple tests that were using older idioms is also an approach (in the
> opposite direction I originally took) - but the more work it is, the
> less likely that this patch is 2.10 material.

No need to worry about 2.10, I think.

>>> Now you can sort-of understand why my larger series wanted to get rid of
>>> qobject_from_jsonf(), since our use of GCC_FMT_ATTR() there is a lie?
>>=20
>> I don't think it's a lie.  qobject_from_jsonf() satisfies the attribute
>> format(printf, ...) contract: it fetches varargs exactly like printf().
>> What it does with them is of no concern to this attribute.
>
> I still find it odd that you can't safely turn foo(var) into foo("%s", va=
r).

For me, the protection against JSON injection bugs is well worth it.
