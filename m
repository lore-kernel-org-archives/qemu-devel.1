Received: from eggs.gnu.org ([2001:4830:134:3::10]:51690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCWmZ-00054Y-67
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCWmX-00027t-88
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 15:17:07 -0500
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
	<20171107142218.GC4706@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a527b5a7-9503-8f17-ab81-bb533b30afba@redhat.com>
Date: Wed, 8 Nov 2017 21:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <20171107142218.GC4706@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WAs3hID3xammq66GpAgMih498Uqn7Pi8U"
Subject: Re: [Qemu-devel] [Qemu-block] Drainage in
 bdrv_replace_child_noperm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WAs3hID3xammq66GpAgMih498Uqn7Pi8U
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <a527b5a7-9503-8f17-ab81-bb533b30afba@redhat.com>
Subject: Re: [Qemu-block] Drainage in bdrv_replace_child_noperm()
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
 <20171107142218.GC4706@localhost.localdomain>
In-Reply-To: <20171107142218.GC4706@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-11-07 15:22, Kevin Wolf wrote:
> Am 06.11.2017 um 19:49 hat Max Reitz geschrieben:
>> Hi everyone,
>>
>> On my quest to fix some flaky iotests, I came to a bit of a halt on 12=
9.
>>  (Details: Its issue is that block jobs now generally ignore throttlin=
g
>> in a BB (because they use their own), so we have to add a throttle nod=
e
>> instead.  However, when I added it, I got an abort.)
>>
>> My issue can be reproduced as follows:
>>
>> $ x86_64-softmmu/qemu-system-x86_64 \
>>     -qmp stdio \
>>     -object throttle-group,id=3Dtg0 \
>>     -blockdev "{'driver':'throttle','node-name':'drive0',
>>                 'throttle-group':'tg0','file':{'driver':'null-co'}}" \=

>>     -blockdev node-name=3Dtarget,driver=3Dnull-co
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 10, "major": 2},
>> "package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
>> {'execute':'qmp_capabilities'}
>> {"return": {}}
>> {'execute':'blockdev-mirror','arguments':{
>>     'device':'drive0','job-id':'job0','target':'target','sync':'full',=

>>     'filter-node-name':'mirror-node' }}
>> qemu-system-x86_64: block/throttle.c:213: throttle_co_drain_end:
>> Assertion `tgm->io_limits_disabled' failed.
>> [1]    3524 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qm=
p
>> stdio -object throttle-group,id=3Dtg0
>>
>> Here's what happens:
>>
>> (1) bdrv_drained_begin(bs) in mirror_start_job() starts draining drive=
0.
>>
>> (2) bdrv_append(...) puts mirror-node above drive0.  Through
>> bdrv_replace_child_noperm(), this will invoke
>> bdrv_child_cb_drained_begin() on mirror-node.  This is necessary becau=
se
>> drive0 is drained, so the new parent needs to be drained as well.
>> However, note that drive0 is not yet attached to mirror-node.
>> Therefore, mirror-node cannot drain drive0 recursively.
>=20
> Important context: We're talking about bdrv_set_backing_hd() here.
>=20
> It's also not quite correct to say that drive0 is not yet attached, but=

> we're in a weird half-attached state. The BdrvChild is already
> initialised and in the parent list of drive0, but it's not yet assigned=

> to mirror_node->backing nor in mirror_node's child list.
>=20
> For this specific case it looks like this is indeed the same as not
> being attached, but I wouldn't be surprised if we saw stranger effects
> at some point.
>=20
>> This is seemingly fine because drive0 is drained anyway.  However, thi=
s
>> is different from what would happen if we would have drained drive0 wi=
th
>> mirror-node already attached to it as its parent: Then, we would have
>> drained drive0 twice; once by itself, and another time recursively
>> through mirror-node.
>>
>> This will be important in a second...
>>
>> (3) ...and this second is now: We invoke bdrv_drained_end() on drive0.=

>> Now, through bdrv_parent_drained_end() and bdrv_child_cb_drained_end()=

>> that goes up to mirror-node which recursively un-drains drive0.  Fine =
so
>> far.  But once that parent un-drain is done, we un-drain drive0 by
>> itself: And this fails the assertion in the throttle driver because we=

>> attempt to un-drain it twice, although we've drained it only once.
>>
>>
>> So the issue has two parts:
>>
>> (A) (Un-)Draining a parent from a child will always (?[1]) (un-)drain
>> that child, too.  This seems a bit superfluous to me and I would guess=

>> that it results in worst-case O(n^2) function calls to drain a block
>> graph consisting of n nodes.
>>
>> (B) In bdrv_replace_child_noperm() we try to drain the parent if the n=
ew
>> child is drained; specifically, we want it to be in a state as if it h=
ad
>> been a parent when the child was originally drained.  However, we fail=

>> at this because we drain the parent without the child attached, so we
>> don't drain the child twice.  This bites us when we undrain everything=
=2E
>=20
> I think the issue is much simpler, even though it still has two parts.
> It's the old story of bdrv_drain mixing two separate concepts:
>=20
> 1. Wait synchronously for the completion of all my requests to this
>    node. This needs to be propagated down the graph to the children.

So, flush without flushing protocol drivers? :-)

> 2. Make sure that nobody else sends new requests to this node. This
>    needs to be propagated up the graph to the parents.
>=20
> Some callers want only 1. (usually callers of bdrv_drain_all() without =
a
> begin/end pair), some callers want both 1. and 2. (that's the begin/end=

> construction for getting exclusive access). Not sure if there are
> callers that want only 2., but possibly.
>=20
> If we actually take this separation serious, the first step to a fix
> could be that BdrvChildRole.drained_begin shouldn't be propagated to th=
e
> children.

That seems good to me, but considering that the default was to just
propagate it to every child, I thought that I was missing something.

>           We may still need to drain the requests at the node itself:
> > Imagine a drained backing file of qcow2 node. Making sure that the qc=
ow2
> node doesn't get new requests isn't enough, we also must make sure that=

> in-flight requests don't access the backing file any more. This means
> draining the qcow2 node, though we don't care whether its child nodes
> still have requests in flight.

If you want to stop the qcow2 node from generating further requests, you
can either flush them (as you said) or pause them (whatever that means...=
).

However, if you flush them, you also need to flush the children you have
flushed them to...  So what I wrote was technically wrong ("don't pass
parent drainage back to the child because the child is already
drained"), instead it should be "don't pass parent drainage back to the
child because the child is going to be drained (flushed) anyway".

So, pause requests first (either by parking them or flushing them,
driver's choice), then flush the tree.

Of course that's easier said than done...  First, we would need a
non-recursive flush.  Then, every node that is visited by the drain
would (*after* recursing to its parents) need to flush itself.

(Note that I'm completely disregarding nodes which are below the
original node that is supposed to be drained, and which therefore do not
drain their parents (or do they?) because I'd like to retain at least
some of my sanity for now.)

Secondly we have exactly the issue you describe below...

> The big question is whether bdrv_drain() would still work for a single
> node without recursing to the children, but as it uses bs->in_flight, I=

> think that should be okay these days.
>=20
>> (Most importantly, ideally we'd want to attach the new child to the
>> parent and then drain the parent: This would give us exactly the state=

>> we want.  However, attaching the child first and then draining the
>> parent is unsafe, so we cannot do it...)
>>
>> [1] Whether the parent (un-)drains the child depends on the
>> BdrvChildRole.drained_{begin,end}() implementation, strictly speaking.=

>> We cannot say it generally.
>>
>> OK, so how to fix it?  I don't know, so I'm asking you. :-)
>=20
> The conclusion from what I wrote above would be to add a non-recursive
> drain function (probably a version of bdrv_drained_begin/end with a boo=
l
> parameter) and call that from bdrv_child_cb_drained_begin/end.
>=20
> This would still only be a partial solution because we still maintain
> the single interface for two different purposes, but it should be a ste=
p
> in the right direction and fix the problem at hand.

Well, except...

>> I have two ideas:
>>
>> One is to assume that (un-)draining a parent will always (un-)drain al=
l
>> children, including the one the (un-)drain comes from.  This assumptio=
n
>> seems wrong, see [1], but maybe it isn't.  Anyway, if so, we could jus=
t
>> explicitly drain the new child in bdrv_replace_child_noperm() after
>> having drained the parent and thus get a consistent state again.
>=20
> I agree that this is wrong.
>=20
>> The other is to declare (A) wrong.  Maybe when
>> BdrvChildRole.drained_{begin,end}() is invoked, we should not drain th=
at
>> child because we can declare it the caller's responsibility to make su=
re
>> it's drained.  This seems logical to me because usually those methods
>> are invoked when the child is drained anyway.  But maybe I'm wrong. :-=
)
>=20
> Looks like a similar resolution as I suggest, though I like my reasonin=
g
> for it better. ;-)
>=20
>> So, any ideas?
>=20
> Just an additional thought (aka "alles kaputt"): The throttle driver
> will respond to BlockDriver.bdrv_drained_begin() by completing all of
> the queued requests (ignoring the I/O limits) before it returns. This i=
s
> great when the drain request comes from a parent because it just want t=
o
> get everything completed. It's kind of a problem when the drain request=

> comes from a child which is already drained...
>=20
> To be more specific, you pointed at bdrv_replace_child_noperm(). This
> replaces child->bs first and only then calls the .drained_begin callbac=
k
> of the parent. So if the parent wants to implement draining by just
> submiting its queue, we're submitting requests to a child where this
> isn't allowed.

=2E..exactly this. :-/

So a non-recursive drain would just fix the assert, but not this issue.
And I'm not sure whether this is reasonable.  Fixing the assert but
allowing the driver to submit requests to a drained node is just wrong.

> If we had separated the two operations, we could have two BlockDriver
> callbacks, one triggering the queue flush, and the other one requiring
> that no new requests from the queue be submitted.

Yes.  Then we could require that every driver implements a way to park
requests instead of only pausing request submissions through flushing.

=2E..I guess I'll leave 129 just broken for now. :-/

Max


--WAs3hID3xammq66GpAgMih498Uqn7Pi8U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloDZjcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AF3EH/0qLgXnI0Y0ICO0A5gd6MX07nN1SMfbL
jKZMeWd12qSP/azYLl8pSZQNiJgwX3aSo5X8t4FycnsqjZEXW47o2eY8rmAI1Df6
EOPNUCsgu+vb9Ug5msz1BomkL09JRSg8sWNNsQhP1Jwf+d5s6lfIRVageBfyNHnS
BpeBDFKURfSOuziq6p08OLTCDVzs/+dIooUVsE6dD/HSZPtJ8tnNa7kvLzn64ZKS
27UAnlS2DMzi7U2krl3PKuzZ4mlkyrYHfvEbbP/KNN4p10Ak0JdpjsUTsAzFoxhi
yssWpmAJbUpEh3kyDpmwe7/ilG0UjsBfkNY9SMmJWUeNBgzGVrpNHPA=
=nVEs
-----END PGP SIGNATURE-----

--WAs3hID3xammq66GpAgMih498Uqn7Pi8U--
