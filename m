Received: from eggs.gnu.org ([2001:4830:134:3::10]:36809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1f81le-0002Hk-Kd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1f81ld-0004eO-Gx
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:53:50 -0400
Date: Mon, 16 Apr 2018 11:53:41 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180416105341.GF2209@redhat.com>
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-2-nirsof@gmail.com>
	<20180416103118.GH17600@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416103118.GH17600@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd: Add option to disallow listing
 exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

On Mon, Apr 16, 2018 at 11:31:18AM +0100, Daniel P. Berrang=C3=A9 wrote:
> Essentially this is abusing the export name as a crude authentication
> token. There are NBD servers that expect NBD_OPT_LIST to always succeee=
d

I guess you mean "NBD clients" ...

> when they detect that the new style protocol is available. I really hat=
e
> the idea of making it possible to break the NBD_OPT_LIST functionality
> via a command line arg like this.

The specific use case I have in mind is virt-v2v forked an instance of
=E2=80=98qemu-img convert=E2=80=99 which connects to the NBD server.

Of course this does also reveal a flaw in the plan because ...

> Furthermore, applications are *not* considering the export names to be
> security sensitive data, so will not be taking any precautions to ensur=
e
> they remain secret, as they would do with authentication credentials.
> Again I really hate the idea of using NBD exports an an auth credential=
.

=E2=80=98ps ax=E2=80=99 on the conversion server will reveal the export n=
ame/ticket
from the qemu-img command line.

> So I don't think we should be suggesting that security through obscurit=
y of
> the export name is a supported approach to securing NBD.
>=20
> I understand the desire to be able to secure NBD exports though, so thi=
nk
> we need to come up with some kind of supportable solution for this. The=
re
> are two approaches we should take
>=20
>  - Add support for TLS client certification whitelisting. eg every clie=
nt
>    has a unique identity based on the distinguished name (dname) in the
>    x509 cert they were issued. The NBD server can be told which of thes=
e
>    dnames should be a permitted to connect. This is supported in VNC fo=
r
>    years, and I've had patches pending to support this in a QEMU for ch=
ardevs
>    NBD and migration for a while. These were stalled on way to convert
>    -object ... syntax into nested QOM objects.
>
>  - Define a mapping of the SASL protocol ontop NBD. SASL is a
>    generic pluggable authentication mechanism for network
>    protocols. It is already used in libvirt, VNC and SPICE, and
>    would easily fit in with NBD from a conceptual POV. When used in
>    combination with TLS, this offers a wide range of auth mechanisms
>    from simple username+password, to full integration with Kerberos.

The first one sounds heavyweight but at least implementable from the
virt-v2v point of view.  The second one sounds like it would be
impossible for mere humans to set it up.

> If this need is urgent, I think we could partially unblock the TLS x509
> whitelisting support without much difficulty. We haven't been pushing h=
ard
> to unblock it simply because no one was urgently blocked by its absence
> so far. This provides a strong solution, but the difficulty is that the
> server may not know the x509 dname of the permitted client, which makes
> it hard to use in practice.

Can you clarify what you mean by the last sentence above?  Can't we
just create a client certificate in virt-v2v and pass that to
qemu-img, and at the same time pass the server a list of permitted
names? (likely only a single name in practice)

> SASL with a simple username+password scheme
> is thus still very compelling to implement, but will obviously  take lo=
nger
> due to the amount of code/spec work required.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
