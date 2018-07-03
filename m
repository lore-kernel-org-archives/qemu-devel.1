Received: from eggs.gnu.org ([2001:4830:134:3::10]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faJJO-0005O1-LR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faJJN-00025k-DS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:17:34 -0400
Date: Tue, 3 Jul 2018 12:17:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180703111723.GA24516@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180703080303.17355-1-rjones@redhat.com>
	<20180703080303.17355-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703080303.17355-2-rjones@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org

On Tue, Jul 03, 2018 at 09:03:03AM +0100, Richard W.M. Jones wrote:
> Pre-Shared Keys (PSK) is a simpler mechanism for enabling TLS
> connections than using certificates.  It requires only a simple secret
> key:
>=20
>   $ mkdir -m 0700 /tmp/keys
>   $ psktool -u rjones -p /tmp/keys/keys.psk
>   $ cat /tmp/keys/keys.psk
>   rjones:d543770c15ad93d76443fb56f501a31969235f47e999720ae8d2336f6a13fc=
bc
>=20
> The key can be secretly shared between clients and servers.  Clients
> must specify the directory containing the "keys.psk" file and a
> username (defaults to "qemu").  Servers must specify only the
> directory.
>=20
> Example NBD client:
>=20
>   $ qemu-img info \
>     --object tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Drjones,=
endpoint=3Dclient \
>     --image-opts \
>     file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D10809,file.tls-=
creds=3Dtls0,file.export=3D/
>=20
> Example NBD server using qemu-nbd:
>=20
>   $ qemu-nbd -t -x / \
>     --object tls-creds-psk,id=3Dtls0,endpoint=3Dserver,dir=3D/tmp/keys =
\
>     --tls-creds tls0 \
>     image.qcow2
>=20
> Example NBD server using nbdkit:
>=20
>   $ nbdkit -n -e / -fv \
>     --tls=3Don --tls-psk=3D/tmp/keys/keys.psk \
>     file file=3Ddisk.img
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  crypto/Makefile.objs           |   1 +
>  crypto/tlscredspsk.c           | 308 +++++++++++++++++++++++++++++++++
>  crypto/tlssession.c            |  56 +++++-
>  crypto/trace-events            |   3 +
>  include/crypto/tlscredspsk.h   | 106 ++++++++++++
>  qemu-doc.texi                  |  37 ++++
>  qemu-options.hx                |  24 +++
>  tests/Makefile.include         |   4 +-
>  tests/crypto-tls-psk-helpers.c |  50 ++++++
>  tests/crypto-tls-psk-helpers.h |  29 ++++
>  tests/test-crypto-tlssession.c | 185 +++++++++++++++++---
>  11 files changed, 777 insertions(+), 26 deletions(-)

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


I'll send a pull request with it shortly


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
