Received: from eggs.gnu.org ([2001:4830:134:3::10]:54858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1daNAe-00038S-5L
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1daNAZ-0007BK-G7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:20:16 -0400
Date: Wed, 26 Jul 2017 17:19:24 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170726141924.qaqclberxsup5cdm@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dskopslbi3nkafyq"
Content-Disposition: inline
Subject: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>


--dskopslbi3nkafyq
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This proposal follows a discussion we had with Kevin and Stefan on=20
filter node management.

With block filter drivers arises a need to configure filter nodes on=20
runtime with QMP on live graphs. A problem with doing live graph=20
modifications is that some block jobs modify the graph when they are=20
done and don't operate under any synchronisation, resulting in a race=20
condition if we try to insert a filter node in the place of an existing=20
edge.

The race can be overcome if we introduce an optional manual-delete flag=20
in the creation of a block job to indicate that they will not be deleted=20
automatically, but rather wait until the user explicitly calls=20
block-job-delete to remove the block job and apply the graph=20
modifications. This makes filter insertion require that there are no=20
active block jobs with manual-delete set to false. The graph operations=20
will be synchronous unlike block-job-complete; the=20
BlockJobDeferToMainLoopFn completion callback will be executed from QMP=20
instead of using block_job_defer_to_main_loop.

block-job-delete will be defined as=20
{ 'command': 'block-job-delete', 'data': { 'device': 'str' } }

With this change we can define block-insert-node. New nodes will be=20
created with blockdev-add with the appropriate children nodes. On=20
calling block-insert-node we specify the node to add, and the edge we=20
wish to replace:
{ 'command': 'block-insert-node',
    'data' : { '*parent' :  'str', 'child' : 'str', 'node' : 'str',=20
    '*device' : 'str' } }

This will be similar to x-blockdev-change, but instead of bdrv_add_child=20
the parent driver must implement bdrv_reopen_* to change the child. If=20
instead of parent we specify device, the node will be inserted as the=20
root bs of the specified BlockBackend device. If 'child' is not in the=20
bs->children of 'node', we should abort. I'm not certain if there's need=20
to implement an option between bs->file/bs->backing.

In the following example we insert a throttle filter node (T) between A=20
and B:

    A
    |
    B

{ "execute": "blockdev-add",
  "arguments": {
    "driver": "throttle",
    "node-name": "T",
    "throttling-group": "foobar",
    "limits" : {
      "iops-total" : 1000,
    },
    "file": "B"
  }
}

  A  T
  \ /
   B

{ "execute" : "block-insert-node",
 "arguments" : {
  "parent" : "A",
  "child" : "B",
  "node" : "T"
  }
}
  A
  |
  T
  |
  B

If bdrv_reopen is ever introduced to QMP this command, except for the BB=20
root case, might be obsolete.

--dskopslbi3nkafyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAll4pOwACgkQc2J8L2kN
9xAMcw/7BUvu3Brcxp8huxOkowZIv0qA84pttrq8NDWv7zvCNDD3OzgiPOVRU3IT
GLRRnaADSK5BCTtssgOmbXMqVEZGgjQ4rTS8Sjm0ChPnTB1BiswU/1Pwl9rNhxdh
fWqspjtA599HudQ6AVEqacWb4MG+qN9/pasjt6JI8E2KopvhrXw4f5seg5mOLeU/
nnoOFX+IOEkQk98lpq2poPenfcBcyIx8KxdVQ46iwcHffaINEiy/XnI55CbfL8ug
8MhnTffBubwl869Fn1naEm1o2JKF7mKd4Y5i0LVhqF4gWzQp17zgFh9uxajoQi/K
kyvWiGXRAUsqPSN5crx5pzY2IYZFWDPg5f+dVGXm+HAUEpFbnBwOWGy2/4RsJMT0
/CjZ4tLCBuC7fr3xGDyZBClotT7hfVsfRCwCFuaG0nJYxuG63gHC8LtfvNE2Ebce
R8LtWrHOg7UiQLZPStfGSxazv6YUwg4WCZ4LoDFiqLWbW9QG08VcL+V1p6994M/E
f4YdEkgBb16SrJXkOV4EfvNNDk/k89Qnur2MK5cyvIwLr7QrNCRIZJJ2jgktHwzw
+6OSXKfWjLLPWLGVCYPPWd8Tuj0Kf2yqCBXoWvXo45709LQ08kExcI5HDBjUd4cr
szNGx9aj9P6Bc+Dvgribjwoin6+6pAF43DLFRDZu03AKnHAypDo=
=DK7t
-----END PGP SIGNATURE-----

--dskopslbi3nkafyq--
