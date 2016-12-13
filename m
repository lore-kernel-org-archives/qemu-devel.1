Received: from eggs.gnu.org ([2001:4830:134:3::10]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGowW-0003Rc-1g
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGowP-0000o9-Ky
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:24:36 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:48184)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGowP-0000o5-BG
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:24:29 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161213150343.3g3fxjixbteum7ju@grep.be>
Date: Tue, 13 Dec 2016 15:24:25 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6B52260-6814-40CB-AA00-E79099B8ED56@alex.org.uk>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<2D482F67-8115-48CD-921D-5728BC1AD92B@alex.org.uk>
	<20161213150343.3g3fxjixbteum7ju@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V. Lunev" <den@openvz.org>

Wouter,

>> But actually, why do we need to be so mean? Why can't we assume
>> that if NBD_OPT_SET_META_CONTEXT is not sent, then all the metadata
>> contexts should be selected?
>=20
> No. If no metadata contexts have been negotiated, then no metadata
> context IDs were assigned to contexts, so there is no mapping to
> external names. As such, the data being sent in response to
> NBD_CMD_BLOCK_STATUS would have no meaning to the client.

Good point.

>>> +    commands during the transmission phase.
>>=20
>> "otherwise, the client MUST NOT send NBD_CMD_BLOCK_STATUS
>> messages."
>>=20
>> But actually isn't the telling question whether =
NBD_OPT_SET_META_CONTEXT
>> works?
>>=20
>> Actually, as this could be sent more than once, I think this whole
>> thing would be better phrased as:
>>=20
>> "A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unless
>> within the negotiation phase it sent `NBD_OPT_SET_META_CONTEXT`
>> at least once, and the final time it was sent, the server
>> responded without an error."
>=20
> ... and returned at least one metadata context (since we state =
elsewhere
> that sending a SET command which selects nothing is not an error).
>=20
>> obviously this would be better under _SET_ than _LIST_,
>> but the sentence can go entirely from here.

Yes

>> Equally obviously, if we are making _SET_ optional (as
>> lack of _SET_ means that all the contexts are selected)
>> we just gate this on `NBD_FLAG_SEND_BLOCK_STATUS`
>=20
> You can't, as per above.

Indeed.

>> "If specified, the server MUST return the zero or more contexts
>> whose names (including the namespace) consist of or start with
>> the query string. For instance a query string of 'nbd-server:'
>> would return all contexts within the 'nbd-server' namespace,
>> and a string 'base:a' would return all context within the
>> 'base' namespace that began with 'a'"
>=20
> NAK. This imposes a particular syntax for parsing query strings upon
> namespaces, which I explicitly do not wish to do.
>=20
> The spec should only specify how to select a particular namespace, and
> then leave all parsing rules of query strings up to the namespace
> specification.

I'm not quite sure why you want that, but if that's the case, I'd
suggest the easiest thing to do would be to pass (separately) a
namespace string, and a name-query, because you are prohibiting
queries that cover more than one namespace (though per our
separate conversation, you can select context from more than
one namespace with multiple queries). It does seem a bit odd
thought that if context 'foo:bar' is returned from _LIST_,
there is no guarantee that selecting it as 'foo:bar' will
work (as the matching is namespace dependent).

>>> +    The server MUST reply with a list of `NBD_REP_META_CONTEXT` =
replies,
>>> +    followed by `NBD_REP_ACK`. The metadata context ID in these =
replies
>>> +    is reserved and SHOULD be set to zero; clients SHOULD disregard =
it.
>>=20
>> Why is the context ID set to zero? Surely it would be really helpful
>> for this to be filled in with the ID?
>=20
> The ID could change depending on which contexts are actually selected:
>=20
> First, I could imagine a context namespace which allows the client to
> dynamically create a context (e.g., "create a snapshot now and use
> that"), but where that would only be actually done when the client
> actually chooses the metadata context.
>=20
> Second, a namespace could create symbolic context names (e.g., "the
> latest snapshot, whatever that may be"), whose ID could change between
> the LIST and SET options (presumably that's a very small race window,
> but a race is a race).
>=20
> Third, a valid (and simple) way to implement mapping could be to =
assign
> context IDs as array indices, where the array is dynamically created =
at
> SET time, and where the server side does a for loop over the array, =
and
> returns the metadata context ID as htonl() of its loop variable. This
> would mean that there must be no gaps between the IDs at run time.
>=20
> Perhaps another way to deal with that would be to specify that an
> implementation is not required to assign the same context IDs to the
> same metadata contexts from one call to SET (or LIST) to the next; but =
I
> thought it would be clearer if we were to explicitly make LIST return
> "invalid" context IDs. Then again, maybe not.

You're completely correct here and you should ignore my suggestion.

Perhaps you should be even clearer and explicitly state that
context IDs may change between sessions and even between successive
use of the _SET_ command.

>> These two probably belong in a different patch
>=20
> 3
>=20
> (number of people telling me that. Yes, I know :-)

Sorry, behind on mail :-)

>>> +##### Metadata contexts
>>> +
>>> +The `base:allocation` metadata context is the basic "allocated at =
all"
>>> +metadata context. If an extent is marked with `NBD_STATE_HOLE` at =
that
>>> +context, this means that the given extent is not allocated in the
>>> +backend storage, and that writing to the extent MAY result in the =
ENOSPC
>>> +error. This supports sparse file semantics on the server side. If a
>>> +server has only one metadata context (the default), then writing to =
an
>>> +extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC.
>>=20
>> Again I'm still confused by this. I *think* you mean "If a server
>> supports the `base:allocation` metadata context, then writing
>> to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail with =
ENOSPC.`
>>=20
>> I say that because as currently phrased:
>>=20
>> * If a server has one metadata context only, but it is not
>>  `base:allocation`, then you implying something about writing
>>  to an extent with a state that won't even exist.
>=20
> Yes, that's wrong indeed. We should replace the "the default" bit by
> "the base:allocation context".
>=20
>> * If a server has `base:allocation` AND another metadata context
>>  (for instance `qemu:dirty`) then the rule you set out will not
>>  apply.
>=20
> Yes, and this is intentional, as I've explained before. The other
> context's semantics should clarify whether that rule still applies or
> not. Implementations that do not know of the other context should
> however assume that it doesn't.

I think I must be being very stupid or am at least at cross-purposes.

Let's say the second context is (e.g.) =
'colour:records_information_about_blue'
(i.e. nothing at all to do with space or holes). Are you saying that the
presence of that context might affect the interpretation of
NBD_STATE_HOLE? Or just other contexts within the 'base:' space?
Or that another context (e.g. perhaps compression) could be an =
independent
cause of ENOSPC? If so should it be the responsibility of the other =
context
to document that it does not affect that?

How about:

"If a server supports the `base:allocation` metadata context, then =
writing
to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC
unless for reasons specified in the definition of another context."

>>> +For the `base:allocation` context, the remainder of the flags field =
is
>>> +reserved. Servers SHOULD set it to all-zero;
>>=20
>> Surely if we want to reserve them for extension, we need "Servers
>> MUST set it to all-zero"
>=20
> No, SHOULD, otherwise a future extension which adds meaning to those
> bits will suddenly become incompatible with this spec. Think about it
> ;-)

I did! If there is a future extension, it will change the spec to
incorporate those bits, so they won't be included within 'the
remainder' any more.

> (feel free to update the branch with those suggestions I've not NAK'd,
> as I think they make sense...)

OK. May take a look later.

--=20
Alex Bligh
