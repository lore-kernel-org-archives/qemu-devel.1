Received: from eggs.gnu.org ([2001:4830:134:3::10]:41354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f81sL-0005ZR-6k
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f81sJ-0001Ku-8w
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:00:44 -0400
Date: Mon, 16 Apr 2018 12:00:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416110023.GJ17600@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-2-nirsof@gmail.com>
	<20180416103118.GH17600@redhat.com>
	<20180416105341.GF2209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416105341.GF2209@redhat.com>
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

On Mon, Apr 16, 2018 at 11:53:41AM +0100, Richard W.M. Jones wrote:
> On Mon, Apr 16, 2018 at 11:31:18AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > Essentially this is abusing the export name as a crude authentication
> > token. There are NBD servers that expect NBD_OPT_LIST to always succe=
eed
>=20
> I guess you mean "NBD clients" ...

Sigh, yes, of course.

> > when they detect that the new style protocol is available. I really h=
ate
> > the idea of making it possible to break the NBD_OPT_LIST functionalit=
y
> > via a command line arg like this.
>=20
> The specific use case I have in mind is virt-v2v forked an instance of
> =E2=80=98qemu-img convert=E2=80=99 which connects to the NBD server.
>=20
> Of course this does also reveal a flaw in the plan because ...
>=20
> > Furthermore, applications are *not* considering the export names to b=
e
> > security sensitive data, so will not be taking any precautions to ens=
ure
> > they remain secret, as they would do with authentication credentials.
> > Again I really hate the idea of using NBD exports an an auth credenti=
al.
>=20
> =E2=80=98ps ax=E2=80=99 on the conversion server will reveal the export=
 name/ticket
> from the qemu-img command line.

Yeah, exactly the kind of problem that hits when you mis-use a piece of
traditionally public info as a security credential.

>=20
> > So I don't think we should be suggesting that security through obscur=
ity of
> > the export name is a supported approach to securing NBD.
> >=20
> > I understand the desire to be able to secure NBD exports though, so t=
hink
> > we need to come up with some kind of supportable solution for this. T=
here
> > are two approaches we should take
> >=20
> >  - Add support for TLS client certification whitelisting. eg every cl=
ient
> >    has a unique identity based on the distinguished name (dname) in t=
he
> >    x509 cert they were issued. The NBD server can be told which of th=
ese
> >    dnames should be a permitted to connect. This is supported in VNC =
for
> >    years, and I've had patches pending to support this in a QEMU for =
chardevs
> >    NBD and migration for a while. These were stalled on way to conver=
t
> >    -object ... syntax into nested QOM objects.
> >
> >  - Define a mapping of the SASL protocol ontop NBD. SASL is a
> >    generic pluggable authentication mechanism for network
> >    protocols. It is already used in libvirt, VNC and SPICE, and
> >    would easily fit in with NBD from a conceptual POV. When used in
> >    combination with TLS, this offers a wide range of auth mechanisms
> >    from simple username+password, to full integration with Kerberos.
>=20
> The first one sounds heavyweight but at least implementable from the
> virt-v2v point of view.  The second one sounds like it would be
> impossible for mere humans to set it up.

You'll want TLS no matter what really. All SASL mechanisms, with the
exception of Kerberos, require that you have a secure data channel
first - which means either UNIX sockets, or TCP with TLS.

If you're using SASL for auth you can, however, avoid the need to
require x509 client certs.

> > If this need is urgent, I think we could partially unblock the TLS x5=
09
> > whitelisting support without much difficulty. We haven't been pushing=
 hard
> > to unblock it simply because no one was urgently blocked by its absen=
ce
> > so far. This provides a strong solution, but the difficulty is that t=
he
> > server may not know the x509 dname of the permitted client, which mak=
es
> > it hard to use in practice.
>=20
> Can you clarify what you mean by the last sentence above?  Can't we
> just create a client certificate in virt-v2v and pass that to
> qemu-img, and at the same time pass the server a list of permitted
> names? (likely only a single name in practice)

I just mean that at the time the mgmt app sets up the NBD export, it migh=
t
not know which client is going to use it, so it can't setup a x509 dname
whitelist at that time.=20

With SASL and username/password, you don't need to know who will use the
export at setup time - you can simply give up username/password at time
of use.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
