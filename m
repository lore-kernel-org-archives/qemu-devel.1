Received: from eggs.gnu.org ([2001:4830:134:3::10]:49007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgiS-0001MJ-7B
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgiQ-0002vp-Q2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:23:40 -0500
Date: Mon, 19 Nov 2018 10:23:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119102326.GB19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-3-berrange@redhat.com>
	<0d437d60-c422-b931-03a2-120e6c1912af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d437d60-c422-b931-03a2-120e6c1912af@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Sat, Nov 17, 2018 at 08:19:10PM -0600, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > When sending a NBD_CMD_DISC message there is no reply expected,
> > however, the nbd_read_eof() coroutine is still waiting for a reply.
> > In a plain NBD connection this doesn't matter as it will just get an
> > EOF, however, on a TLS connection it will get an interrupted TLS data
> > packet. The nbd_read_eof() will then print an error message on the
> > console due to missing reply to NBD_CMD_DISC.
> >=20
> > This can be seen with qemu-img
> >=20
> >    $ qemu-img info \
> >        --object tls-creds-x509,dir=3Dtlsdir,id=3Dtls0,endpoint=3Dclie=
nt \
> >        --image-opts driver=3Dnbd,host=3D127.0.0.1,port=3D9000,tls-cre=
ds=3Dtls0
> >    qemu-img: Cannot read from TLS channel: Input/output error
> >    image: nbd://127.0.0.1:9000
> >    file format: nbd
> >    virtual size: 10M (10485760 bytes)
> >    disk size: unavailable
> >=20
> > Simply setting the 'quit' flag after sending NBD_CMD_DISC is enough t=
o
> > get the coroutine to stop waiting for a reply and thus supress the er=
ror
> > message.
>=20
> Actually, it's not quite enough - once you actually start performing I/=
O,
> enough coroutines are kicked off that the error still happens:

Hmm, does the client not send requests synchronously  ? I expected that
any other I/O operations would have already received their reply by the
time we sent the DISC command.

>=20
> $  qemu-io -c 'r 1m 1m' -c 'w -P 0x22 1m 1m' --image-opts \
> --object tls-creds-x509,dir=3Dscratch/tls/client1,endpoint=3Dclient,id=3D=
tls0\
>  driver=3Dnbd,host=3Dlocalhost,port=3D10809,tls-creds=3Dtls0
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 0.0430 sec (23.204 MiB/sec and 23.2040 ops/sec)
> wrote 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 0.0152 sec (65.479 MiB/sec and 65.4793 ops/sec)
> Cannot read from TLS channel: Input/output error
>=20
> Squashing this in on top of your patch helps, though:
>=20
> diff --git i/block/nbd-client.c w/block/nbd-client.c
> index 5f63e4b8f15..e7916c78996 100644
> --- i/block/nbd-client.c
> +++ w/block/nbd-client.c
> @@ -79,7 +79,14 @@ static coroutine_fn void nbd_read_reply_entry(void
> *opaque)
>          assert(s->reply.handle =3D=3D 0);
>          ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>          if (local_err) {
> -            error_report_err(local_err);
> +            /* If we are already quitting, either another error has
> +             * already been reported, or we requested NBD_CMD_DISC and
> +             * don't need to report anything further.  */
> +            if (!s->quit) {
> +                error_report_err(local_err);
> +            } else {
> +                error_free(local_err);
> +            }
>          }
>          if (ret <=3D 0) {
>              break;
>=20
> But I want to do more testing to make sure I'm not missing out on repor=
ting
> an actual error if I add that.

Yes, I'd be a little concerned about missing reporting of an error from
a command other than NBD_CMD_DISC if we did this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
