Received: from eggs.gnu.org ([2001:4830:134:3::10]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOCoc-0008Dq-SZ
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 21:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOCg7-0000CQ-U4
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 21:19:16 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d437d60-c422-b931-03a2-120e6c1912af@redhat.com>
Date: Sat, 17 Nov 2018 20:19:10 -0600
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
> packet. The nbd_read_eof() will then print an error message on the
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
> message.

Actually, it's not quite enough - once you actually start performing=20
I/O, enough coroutines are kicked off that the error still happens:

$  qemu-io -c 'r 1m 1m' -c 'w -P 0x22 1m 1m' --image-opts \
--object tls-creds-x509,dir=3Dscratch/tls/client1,endpoint=3Dclient,id=3D=
tls0\
  driver=3Dnbd,host=3Dlocalhost,port=3D10809,tls-creds=3Dtls0
read 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 0.0430 sec (23.204 MiB/sec and 23.2040 ops/sec)
wrote 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 0.0152 sec (65.479 MiB/sec and 65.4793 ops/sec)
Cannot read from TLS channel: Input/output error

Squashing this in on top of your patch helps, though:

diff --git i/block/nbd-client.c w/block/nbd-client.c
index 5f63e4b8f15..e7916c78996 100644
--- i/block/nbd-client.c
+++ w/block/nbd-client.c
@@ -79,7 +79,14 @@ static coroutine_fn void nbd_read_reply_entry(void=20
*opaque)
          assert(s->reply.handle =3D=3D 0);
          ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
          if (local_err) {
-            error_report_err(local_err);
+            /* If we are already quitting, either another error has
+             * already been reported, or we requested NBD_CMD_DISC and
+             * don't need to report anything further.  */
+            if (!s->quit) {
+                error_report_err(local_err);
+            } else {
+                error_free(local_err);
+            }
          }
          if (ret <=3D 0) {
              break;

But I want to do more testing to make sure I'm not missing out on=20
reporting an actual error if I add that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
