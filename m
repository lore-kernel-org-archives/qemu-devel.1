Received: from eggs.gnu.org ([2001:4830:134:3::10]:43551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1db0yL-0005ub-Qx
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1db0yK-0001qs-RS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:50:13 -0400
Date: Fri, 28 Jul 2017 11:49:53 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170728084953.rpo5ohpf6gibchi2@postretch>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
	<20170726182320.cnqx3y64c7nmhvp3@postretch>
	<11af0732-e024-6651-5b65-07eb98d8bb17@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltccw6m5exvkwjks"
Content-Disposition: inline
In-Reply-To: <11af0732-e024-6651-5b65-07eb98d8bb17@redhat.com>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Jeff Cody <jcody@redhat.com>


--ltccw6m5exvkwjks
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 06:09:04PM -0400, John Snow wrote:
>
>
>On 07/26/2017 02:23 PM, Manos Pitsidianakis wrote:
>>On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
>>>On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
>>>>This proposal follows a discussion we had with Kevin and Stefan=20
>>>>on filter
>>>>node management.
>>>>
>>>>With block filter drivers arises a need to configure filter=20
>>>>nodes on runtime
>>>>with QMP on live graphs. A problem with doing live graph=20
>>>>modifications is
>>>>that some block jobs modify the graph when they are done and=20
>>>>don't operate
>>>>under any synchronisation, resulting in a race condition if we=20
>>>>try to insert
>>>>a filter node in the place of an existing edge.
>>>
>>>But maybe you are thinking about higher level race conditions between
>>>QMP commands.  Can you give an example of the race?
>>
>>Exactly, synchronisation between the QMP/user actions. Here's an=20
>>example, correct me if I'm wrong:
>>
>>User issues a block-commit to this tree to commit A onto B:
>>    BB -> A -> B
>>
>>This inserts the dummy mirror node at the top since this is a mirror=20
>>job (active commit)
>>    BB -> dummy -> A -> B
>>
>>User wants to add a filter node F below the BB. First we create the node:
>>    BB -> dummy -> A -> B
>>       F /
>>
>>Commit finishes before we do block-insert-node, dummy and A is=20
>>removed from the BB's chain, mirror_exit calls bdrv_replace_node()
>>
>>    BB ------------> B
>>                F -> /
>>
>>Now inserting F under BB will error since dummy does not exist any more.
>>
>
>Exactly how much of a problem is this? You, the user, have instructed=20
>QEMU to do two conflicting things:
>
>(1) Squash A down into B, and
>(2) Insert a filter above A
>
>Shame on you for deleting the node you were trying to reference, no?=20
>And as an added bonus, QEMU will even error out on your command=20
>instead of trying to do something and getting it wrong.
>
>Is this a problem?


>
>>The proposal doesn't guard against the following:
>>User issues a block-commit to this tree to commit B onto C:
>>    BB -> A -> B -> C
>>
>>The dummy node (commit's top bs is A):
>>    BB -> A -> dummy -> B -> C
>>
>>blockdev-add of a filter we wish to eventually be between A and C:
>>    BB -> A -> dummy -> B -> C
>>             F/
>>
>>if commit finishes before we issue block-insert-node (commit_complete()
>>calls bdrv_set_backing_hd() which only touches A)
>>    BB -> A --------------> C
>>           F -> dummy -> B /
>>    resulting in error when issuing block-insert-node,
>
>Because "B" and "dummy" have already actually been deleted, I assume.=20
>(The diagram is confusing.)

because we have an edge (A, C) and C is not a child of F, so we cannot=20
insert it as a child to A.  (I rotated the usual ascii art by 90 deg to=20
save me from handling whitespace, but I might have done it worse)
>>
>>else if we set the job to manual-delete and insert F:
>>    BB -> A -> F -> dummy -> B -> C
>>deleting the job will result in F being lost since the job's top bs=20
>>wasn't updated.
>>
>
>Seems like a fairly good reason not to pursue this avenue then, yes?

I think this is just a different problem, not a race but of broadcasting=20
graph operations to affected parties (block jobs).
>
>I think I agree with Stefan's concerns that this is more of a=20
>temporary workaround for the benefit of jobs, but that there may well=20
>be other reasons (especially in the future) where graph manipulations=20
>may occur invisibly to the user.
>
>Do you have any use cases for failure here that don't involve the user=20
>themselves asking for two conflicting things? That is, QEMU doing some=20
>graph reorganization without the user's knowledge coupled with the=20
>user asking for a new filter node?
>
>Are there any failures that result in anything more dangerous or bad=20
>than a "404: node not found" style error where we simply reject the=20
>premise of what the user was attempting to accomplish?
>

I couldn't come up with a case that caused catastrophic failure, no=20
(though I lack familiarity with block jobs). If this isn't a problem=20
after all, good news.

block-insert-node needs to work with no dangerous conflicts to other=20
graph operations, basically. Is there a case where there's not just an=20
error and we can't recover?

--ltccw6m5exvkwjks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAll6+rEACgkQc2J8L2kN
9xCQ1hAAhjKrgFBnh4TwSUZ+eATumVpft9Yiy12PpUbxiijNi+8v4R9SLWQHCHkl
xvnlhzUXRGPlQ7Xhf0btqT0DChZVDIEaMhzzmsBol3G6slZRSFNN6aap6vMeBWzr
1cC8yx6NhD4AQIZ1+Z2JHIFO8/RAbEFrQapweK4N732Q06sXbpMUDafj+BbExPQs
b0HCF1wR6r64xWzItkIXuXyqV6+fgaRiOOt6bl5HSBvCnNNS3eBXQInfiZXV1iZt
dIllF1ylTbAEoI/3c1Q5i9trv35YbjoWY/Ig3z19Q32uFwlQsy4LwP9IV5avKJpq
wtG6hPAC+cexIsK6VWStzqDuESrWxA2AcNoewBLCTDsjg7rfabwoQ0+Z/2UbKciL
YCuYTS/0IFcxayOv/syIkb5PZLQHLqrsoSIQw5XW/kUwBl1AahCf1jJUGeBuYema
fgrXk+JokiVUfhW2g9yAotsdS5ui4ACzhtH+B8a1/dJAmkPRGIdMhMdeQYEaPKFb
YxpjdlOhaCJIfN7eG4rXTW3hEl5wmIB5PkGtIbBKIxkDO/5MHpT/AJuPg1gk1wys
amzNkQTlJNnJem65DPKPNaEFn9BNvoRa1RfAUmXdFYtreP4D6Hp/4jHLIim96YD7
e4VdXdkLBaag50KfhkkETEzRvY0SqJl1l81D+Zdqxz1oRcvbeh4=
=q0Kj
-----END PGP SIGNATURE-----

--ltccw6m5exvkwjks--
