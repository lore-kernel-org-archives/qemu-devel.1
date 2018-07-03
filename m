Received: from eggs.gnu.org ([2001:4830:134:3::10]:38565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEE1-00012T-Kt
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEDy-000187-Hk
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:51:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faEDy-00017f-C7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:51:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-3-eblake@redhat.com>
	<87r2kl8oey.fsf@dusky.pond.sub.org>
	<12e2f857-8052-3542-0475-b84f8f02c716@redhat.com>
Date: Tue, 03 Jul 2018 07:51:35 +0200
In-Reply-To: <12e2f857-8052-3542-0475-b84f8f02c716@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 14:55:37 -0500")
Message-ID: <87o9fo7tp4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Drop qapi-gen --unmask option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 01:48 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> Now that we have useful access to the type name as a comment
>>> in the generated qapi-introspect.c, we don't need to regenerate
>>> code with a temporary -u option just to get at type names.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> I occasionally feed output of query-qmp-schema to ad hoc Python scripts.
>> My last one searched for object types containing non-string members
>> (directly or indirectly).  -u remains useful there, and having to
>> recompile is not a problem.  I'd prefer to keep it.
>
> Would it be any easier to argue for the removal of -u if the generated
> output resembled:
>
> { "ret-type", QLIT_QSTR("1") /* Foo */ },
>
> that is, sticking in the comment everywhere the type name is mangled
> to an integer, rather than just once per type?

Doesn't help with my use case.  Let me elaborate on it.

My ad hoc Python script gets the output of query-qmp-schema like this:

    pipe = subprocess.Popen('socat %s STDIO' % qmp_socket,
                            shell=True,
                            stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    (out, err) = pipe.communicate('{ "execute": "qmp_capabilities" }\n'
                                  '{ "execute": "query-qmp-schema" }\n')
    # three lines: greeting, output of qmp_capabilities, query-qmp-schema
    return json.loads(out.split('\n')[2])['return']

This returns an abstract syntax tree, represented in Python the obvious
way.  I can then explore it in Python, say search for object types with
certain properties.  For example, commit 2860b2b2cb8:

    Thus, the flaw puts an artificial restriction on the QAPI schema: we
    can't have potentially empty objects and arrays within
    BlockdevOptions, except when they're optional and "empty" has the same
    meaning as "absent".

--> Our QAPI schema satisfies this restriction (I checked), but it's a
    trap for the unwary, and a temptation to employ awkward workarounds
    for the wary.  Let's get rid of it.

I checked with a Python script that read the schema as shown above.
Without -u, I'd have to revert the identifier hiding.  I could certainly
write some more Python to read the mapping from the generated C, but
that feels like busy work.
