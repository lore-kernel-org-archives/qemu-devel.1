Received: from eggs.gnu.org ([2001:4830:134:3::10]:35908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6ZDm-0008HN-5A
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6ZDk-0008TN-Rn
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:12:50 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
Date: Thu, 12 Apr 2018 12:12:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180412095157.GA5004@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 12/04/2018 11:51, Kevin Wolf wrote:
> Am 12.04.2018 um 10:37 hat Paolo Bonzini geschrieben:
>> On 11/04/2018 18:39, Kevin Wolf wrote:
>>> +bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
>>>  {
>>>      /* Execute pending BHs first and check everything else only afte=
r the BHs
>>>       * have executed. */
>>> -    while (aio_poll(bs->aio_context, false));
>>> +    if (top_level) {
>>> +        while (aio_poll(bs->aio_context, false));
>>> +    }
>>> +
>>> +    if (bdrv_parent_drained_poll(bs)) {
>>> +        return true;
>>> +    }
>>> +
>>>      return atomic_read(&bs->in_flight);
>>>  }
>>> =20
>>
>> Up until now I liked very much this series, but I like this patch a bi=
t
>> less for two reasons.
>>
>> 1) I think I would prefer to have the !top_level case in a separate
>> function---making the API easier to use in the BdrvChildRole callback
>> because there is no need to pass false.
>=20
> Basically just move the aio_poll() out to a different function that
> calls bdrv_drain_poll afterwards? Maybe it's a bit cleaner, yes.
> However, see below.

Yes.

>> In addition, the callback is not really polling anything, but rather
>> returning whether the children are quiescent.  So a better name would
>> be bdrv_children_drained and c->role->drained.
>=20
> Why isn't it polling? We're actively checking the state of the node, an=
d
> we keep calling the callback until it has the expected state. Would it
> only become polling for you if the loop were in this function rather
> than the its caller?

It's just checking the status, it's not invoking the event loop.  The
polling (in the sense of aio_poll or AIO_POLL_WHILE) is done elsewhere,
this function is just the condition.  It's just nomenclature I guess.

>> 2) Worse, the main idea behind the first drain restructuring was that
>> draining could proceed in topological order: first drain the roots' I/=
O,
>> then call bdrv_drain to send the last requests to their children, then
>> recurse.  It is not clear to me why you need to introduce this recursi=
ve
>> step, which is also O(n^2) in the worst case.
>=20
> I need to introduce it because it fixes the bug that we don't wait unti=
l
> the parents are actually quiesced and don't send new requests any more.
> I don't see how this could be fixed without going to the parents.

Yes, you do need to go to the parents.  I don't understand however why
you need more than a walk of the graph in parent-before-child order
(which is a topological order, so it is reverse depth-first order and
it's easy to do the walk in a recursive function).  If you're draining X
below:

     A
     |
     B   C
      \ /
       X

then you start by draining A/B/C in topological order (so A before B).
If B happens to be already quiescent, you can skip not only B but A too.
 If the nodes disappear or move elsewhere in the graph it's okay, you've
just done useless work.  When you're done you ensure that every parent
is quiescent, and if so you're done.  If it's not, , a new parent
appeared---drain that too, using the same parent-before-child order, and
loop.

Well, there is one gotcha: bdrv_ref protects against disappearance, but
bdrv_ref/bdrv_unref are not thread-safe.  Am I missing something else?

> Is the O(n=C2=B2) that you mean that we recursively iterate all childre=
n in
> bdrv_do_drained_begin() (or later in the series in bdrv_drain_poll()),
> and then come back from the children when they poll their parents?

Yes.

Paolo

> We could do the same thing as for bdrv_parent_drained_begin(), i.e. pas=
s
> the parent that we came from (BdrvChild *parent instead of bool
> top_level, NULL instead of top_level=3Dtrue) and then skip that parent
> while calling the BdrvChildRole .drain_poll callbacks. Would that
> address your concerns?
>=20
> In that solution, splitting the function by moving aio_poll() out
> wouldn't get rid of a parameter and simplify the API any more. It might
> still be cleaner, though?
>=20
> Kevin
>=20
