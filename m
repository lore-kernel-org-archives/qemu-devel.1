Received: from eggs.gnu.org ([2001:4830:134:3::10]:50899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dcQ2R-0001Qm-Ql
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dcQ2O-00012g-NC
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dcQ2O-00012B-Gf
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:48:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
	<eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
	<7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
	<871soxaumw.fsf@dusky.pond.sub.org>
	<8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
	<42893913-795b-afb8-b87f-66d0be3abc75@redhat.com>
Date: Tue, 01 Aug 2017 07:48:07 +0200
In-Reply-To: <42893913-795b-afb8-b87f-66d0be3abc75@redhat.com> (Eric Blake's
	message of "Mon, 31 Jul 2017 13:56:06 -0500")
Message-ID: <8760e7zvmw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/31/2017 07:34 AM, Eric Blake wrote:
>> On 07/31/2017 03:16 AM, Markus Armbruster wrote:
>> 
>>>>>> qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?
>>>>>
>> 
>>>> So given the clean bill of health from valgrind, we definitely DO turn
>>>> over responsibility for freeing on object to its new wrapper, once it is
>>>> passed through %p.  Documentation could be improved to make that clear.
>>>>
>>>> Eww, what happens if qobject_from_jsonf() can fail halfway through?
>
> Hmm. What if we assert that qobject_from_jsonf() can never fail halfway
> through?  Given my research on the other thread, gcc -Wformat will NOT
> flag "['%s', %p]",str,obj as a mismatch, although our current code will
> try to associate %p with str and probably die horribly when
> dereferencing char* as QObject* (and if it does NOT die, we don't even
> know that 'obj' was passed as a parameter).  Since the primary usage of
> qobject_from_jsonf() is the testsuite, an assertion failure (forcing all
> clients to use the interface correctly) is probably simpler than even
> trying to have to worry about cleanup after partial failure (regardless
> of whether we like the 'none' or 'all' approach).

I don't buy the "primarily for the testsuite argument".  It's for
whatever finds it useful.  Safer than formatting the JSON text (no JSON
injection accidents), much easier to read than building a QObject to
pass to the JSON output visitor.

I'd be willing to buy a "passing syntactically incorrect JSON to
qobject_from_jsonf() is a programming error" argument.  Assertion
failure is the appropriate way to deal with programming errors.  Needs
to be spelled out in function contracts, of course, starting with
json_parser_parse_err(), which (scandalously!) has none.
