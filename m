Received: from eggs.gnu.org ([2001:4830:134:3::10]:51513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1daQy6-0006le-AE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1daQy5-0003Ql-Ck
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:23:34 -0400
Date: Wed, 26 Jul 2017 21:23:20 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170726182320.cnqx3y64c7nmhvp3@postretch>
References: <20170726141924.qaqclberxsup5cdm@postretch>
	<20170726151221.GA3600@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zl2gdrxd5gom5kf"
Content-Disposition: inline
In-Reply-To: <20170726151221.GA3600@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--3zl2gdrxd5gom5kf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 04:12:21PM +0100, Stefan Hajnoczi wrote:
>On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
>> This proposal follows a discussion we had with Kevin and Stefan on filter
>> node management.
>>
>> With block filter drivers arises a need to configure filter nodes on run=
time
>> with QMP on live graphs. A problem with doing live graph modifications is
>> that some block jobs modify the graph when they are done and don't opera=
te
>> under any synchronisation, resulting in a race condition if we try to in=
sert
>> a filter node in the place of an existing edge.
>
>But maybe you are thinking about higher level race conditions between
>QMP commands.  Can you give an example of the race?

Exactly, synchronisation between the QMP/user actions. Here's an=20
example, correct me if I'm wrong:

User issues a block-commit to this tree to commit A onto B:
    BB -> A -> B

This inserts the dummy mirror node at the top since this is a mirror job=20
(active commit)
    BB -> dummy -> A -> B

User wants to add a filter node F below the BB. First we create the=20
node:
    BB -> dummy -> A -> B
       F /

Commit finishes before we do block-insert-node, dummy and A is removed=20
=66rom the BB's chain, mirror_exit calls bdrv_replace_node()

    BB ------------> B
                F -> /

Now inserting F under BB will error since dummy does not exist any more.

The proposal doesn't guard against the following:
User issues a block-commit to this tree to commit B onto C:
    BB -> A -> B -> C

The dummy node (commit's top bs is A):
    BB -> A -> dummy -> B -> C

blockdev-add of a filter we wish to eventually be between A and C:
    BB -> A -> dummy -> B -> C
             F/

if commit finishes before we issue block-insert-node (commit_complete()
calls bdrv_set_backing_hd() which only touches A)
    BB -> A --------------> C
           F -> dummy -> B /
    resulting in error when issuing block-insert-node,

else if we set the job to manual-delete and insert F:
    BB -> A -> F -> dummy -> B -> C
deleting the job will result in F being lost since the job's top bs=20
wasn't updated.


--3zl2gdrxd5gom5kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAll43hgACgkQc2J8L2kN
9xBD0hAApO6KgI6LSF+LRSCC72WQIrTq2r9BmhHzyxeZ2EGFmvdoBUhkp1eluytu
qPWC/duhrUXOQsGMR99ZWqFngp5kofsVRBFlO5OyxXrX4Vai+oOJ612YGnwwQa0D
qaQqyGDzWlDIOxYq55SwjHVrbxCxouIqzeW3ICrVgPXOHztsg0PNHFsJ7Qkdgr1R
xxCXIzRhfCwcYc8XhXclKLv9MnjMwTsR5rUAejz1/n96cIT55TjDS/y47Mtlxk67
o0Abs5y72ISYvVNSCRDE5sgzhPorMsIrUL3y+EbTIsF/KkPFIRJjDe0btYei58AF
mPlP5CxtGBHvc4Xpj/ppzCKTWhYI1u6IceWcxRXwNLStTVtXf1lHZG9shrLMBLJ4
XsDMPnZzTR0Wjr/ZVXOcxzGJt2Mw10BWZ0ykfNh6JBdHmiQGbnBNQ2GBXtxu+Uea
IYOL92bOo01c9EwVv86X5FSV5fKd19zcXDQRpKwxKE6B587gM8CB7BuCKP+r8PYt
fRNWQevTxeY6tZ+G1H2a6dEb8GR+zIiTMijBnvJbbFeS0HsRzROQB15ydgwkeq1Z
e8Vaj3rxToZy3dHhgNKxvIGBmdQoXlN3Z9EPxC56B0oXblCfuOs9IGvU5zb+nyab
GwT4JAyC2XH/wcHHdutNM3j1fhBqcuIlyYlaTpEqk2b6d7unGgU=
=7Uw7
-----END PGP SIGNATURE-----

--3zl2gdrxd5gom5kf--
