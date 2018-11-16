Received: from eggs.gnu.org ([2001:4830:134:3::10]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgfF-00062P-Rl
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgfE-0000pd-Sl
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:08:13 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <385711c5-0236-dea7-4990-1c3e6c175479@redhat.com>
Date: Fri, 16 Nov 2018 10:08:03 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6 for-3.1] nbd: stop waiting for a NBD
 response with NBD_CMD_DISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> When sending a NBD_CMD_DISC message there is no reply expected,
> however, the nbd_read_eof() coroutine is still waiting for a reply.
> In a plain NBD connection this doesn't matter as it will just get an
> EOF, however, on a TLS connection it will get an interrupted TLS data
> packet.

Does that depend on whether the server tried to gracefully close the TLS=20
connection (and flushed enough packets to do so)?  At any rate, while=20
it's nice to wait for the server to cleanly end TLS, we can't control=20
the behavior of all servers, and I agree with your analysis that having=20
the server silently deal with an abrupt shutdown is nicer than polluting=20
stderr, as it's not actually a data loss situation for either the client=20
or the server.

> The nbd_read_eof() will then print an error message on the
> console due to missing reply to NBD_CMD_DISC.
>=20
> This can be seen with qemu-img
>=20
>    $ qemu-img info \
>        --object tls-creds-x509,dir=3Dtlsdir,id=3Dtls0,endpoint=3Dclient=
 \
>        --image-opts driver=3Dnbd,host=3D127.0.0.1,port=3D9000,tls-creds=
=3Dtls0
>    qemu-img: Cannot read from TLS channel: Input/output error
>    image: nbd://127.0.0.1:9000
>    file format: nbd
>    virtual size: 10M (10485760 bytes)
>    disk size: unavailable
>=20
> Simply setting the 'quit' flag after sending NBD_CMD_DISC is enough to
> get the coroutine to stop waiting for a reply and thus supress the erro=
r

s/supress/suppress/

> message. This fixes a regression introduced in
>=20
>    commit be41c100c0d67f6072ddd4910c4b6f7d239f025f
>    Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>    Date:   Fri May 26 14:09:13 2017 +0300
>=20
>      nbd/client.c: use errp instead of LOG
>=20
>      Move to modern errp scheme from just LOGging errors.
>=20
>      Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.=
com>
>      Message-Id: <20170526110913.89098-1-vsementsov@virtuozzo.com>
>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   block/nbd-client.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Agree that this is 3.1 material; will queue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
