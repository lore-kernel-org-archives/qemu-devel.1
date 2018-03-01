Received: from eggs.gnu.org ([2001:4830:134:3::10]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erQRC-0000EZ-Kr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erQRB-0005Q9-Mr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:48:06 -0500
Date: Thu, 1 Mar 2018 15:47:57 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180301154757.GK2787@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
	<20180301135856.22698-3-rjones@redhat.com>
	<20180301153438.GK14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180301153438.GK14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] block: curl: Allow Certificate
 Authority bundle to be passed in.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: jcody@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Thu, Mar 01, 2018 at 03:34:38PM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Mar 01, 2018 at 01:58:56PM +0000, Richard W.M. Jones wrote:
> > This allows a Certificate Authority bundle to be passed to the curl
> > driver, allowing authentication against servers that check
> > certificates.  For example this allows you to access a disk on an
> > oVirt node:
> >=20
> >   qemu-img create -f qcow2 \
> >       -b 'json:{ "file.driver": "https",
> >                  "file.url": "https://ovirt-node:54322/images/<disk-i=
d>",
> >                   "file.header": ["Authorization: <ticket>"] }' \
> >                   "file.cainfo": "/tmp/ca.pem" }' \
> >       test.qcow2
>=20
> I think we ought to be using the TLS creds object to provide this data
>=20
>    qemu-img create \
>        --object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-pe=
er=3Dyes,endpoint=3Dclient \
>        -b 'json:{ "file.driver": "https",
>                   "file.url": "https://ovirt-node:54322/images/<disk-id=
>",
>                    "file.header": ["Authorization: <ticket>"] }' \
>                    "file.tls-creds": "tls0" }' \
>        test.qcow2
>=20
> The /path/to/certs dir would contain ca-cert.pem, and optionally also a
> client-key.pem & client-cert.pem, which would let curl provide client
> certs to servers that mandate that. The 'verify-peer' option lets you
> control whether to ignore or enforce CA validation errors too.
>=20
> Take a look at block/vxhs.c and its vxhs_get_tls_creds() method.

Thanks, I'll have a look into this for the second revision.  It seems
like a better way to do it.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
