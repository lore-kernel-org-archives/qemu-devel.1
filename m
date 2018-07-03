Received: from eggs.gnu.org ([2001:4830:134:3::10]:35385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faE1Q-0006u1-2S
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faE1M-0002OF-WC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:38:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faE1M-0002O3-Qj
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:38:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-2-eblake@redhat.com>
	<ed5d831b-2035-74b5-b12a-01f443c8a896@redhat.com>
	<87va9x8omh.fsf@dusky.pond.sub.org>
	<d0f625bb-54f3-364a-4f47-9ff38fc97935@redhat.com>
Date: Tue, 03 Jul 2018 07:38:35 +0200
In-Reply-To: <d0f625bb-54f3-364a-4f47-9ff38fc97935@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 14:59:38 -0500")
Message-ID: <87sh507uas.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 01:43 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 06/29/2018 02:55 PM, Eric Blake wrote:
>>>> We consciously chose in commit 1a9a507b to hide QAPI type names
>>>> from the generated introspection output, but added a command line
>>>> option -u to unmask the type name when doing a debug build.  At
>>>> that time, we generated a monolithic C string, so there was no
>>>> better way to do things (we could not really inject comments).
>>>>
>>>> Later, in commit 7d0f982b, we switched the generation to output
>>>> a QLit object, in part to make it easier for future addition of
>>>> conditional compilation.  But this switch has also made it easier
>>>> to interject strategic comments.  That commit also forgot to
>>>> delete some now-stale comments about long generated line lengths.
>>>>
>>>> For now, type name debug aid comments are only output once per
>>>> meta-type, rather than at all uses of the number used to encode
>>>> the type to the introspection data.  But this is still a lot
>>>> more convenient than having to regenerate the file with the
>>>> unmask operation temporarily turned on.
>>> ...
>
>> to_qlit() converts from a natural representation of JSON in Python to
>> JSON text.
>>
>> Your patch breaks it for JSON objects that have a member named
>> 'comment'.
>
> Hmm.  None do, presently.  And I don't see where it would be permitted
> in the QAPI schema for query-qmp-schema.

So far, to_qlit() is completely oblivious of the schema; it just
crunches JSON.  I'd like to keep it that way, if practical.

>> Related work: Marc-Andr=C3=A9's "[PATCH v6 09/15] qapi-introspect: add
>> preprocessor conditions to generated QLit" uses tuples to augment JSON.
>> He uses them for conditionals, but the technique could be generalized,
>> say from his (jobj, ifcond) to (jobj, { 'if': ifcond, '#': comment }.
>
> Yeah, I can probably rebase on top of that (and at this point, it's
> late enough to probably have missed 3.0 anyways, so I'm not
> time-crunched for getting it done right now).

It's a lovely improvement for developers, but it'll be just as lovely in
3.1 :)
