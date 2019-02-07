Received: from eggs.gnu.org ([209.51.188.92]:55014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grg4N-0007gE-IH
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grg4M-0007ix-Cf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grg4M-0007iQ-4S
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:34:06 -0500
Date: Thu, 7 Feb 2019 09:34:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207093400.GB19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190129062801.15799-1-pagupta@redhat.com>
	<CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
	<20190206162901.GW12331@redhat.com>
	<1385614518.70345867.1549524112156.JavaMail.zimbra@redhat.com>
	<CAJ+F1CKia-RCF=oDcKoLAQapD8pRYd4vXhztDspmww+bi-H-AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKia-RCF=oDcKoLAQapD8pRYd4vXhztDspmww+bi-H-AQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, QEMU <qemu-devel@nongnu.org>, xiaohli@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 07, 2019 at 10:11:29AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Feb 7, 2019 at 8:21 AM Pankaj Gupta <pagupta@redhat.com> wrote:
> >
> >
> > Hi Daniel, Marc-Andre,
> >
> > Thanks for your reply. Please find my reply inline.
> >
> > > > > Hotplugging existing char chardev with qmp, dereferences(remove=
s)
> > > > > existing chardev. This patch avoids adding a chardev if a chard=
ev
> > > > > with same id exists.
> > > >
> > > > As you pointed out, if you attempt to add a chardev with an exist=
ing
> > > > ID, you get an error:
> > > >
> > > > {"execute":"chardev-add","arguments":{"id":"charchannel1","backen=
d":{"type":"socket","data":{"addr":{"type":"unix",
> > > > "data": {"path": "/tmp/helloworld1"}}}}}}
> > > > {"return": {}}
> > > > {"execute":"chardev-add","arguments":{"id":"charchannel1","backen=
d":{"type":"socket","data":{"addr":{"type":"unix",
> > > > "data": {"path": "/tmp/helloworld1"}}}}}}
> > > > {"error": {"class": "GenericError", "desc": "attempt to add dupli=
cate
> > > > property 'charchannel1' to object (type 'container')"}}
> > > >
> > > >
> > > > But the existing chardev is left untouched.
> > > >
> > > > However, since unix socket chardev will delete existing file and
> > > > rebind (this is not always a good idea, but people seem to prefer
> > > > that)
> > > > the rebound socket is removed on error cleanup.
> > > >
> > > >
> > > > I am not sure this is a bug tbh.
> > > >
> > > > Your solution to check for duplicate ID upfront is ok. But any ot=
her
> > > > later error path could have the same "bug" effect of removing exi=
sting
> > > > chardev because of the overwrite socket creation.
> > >
> > > Checking the ID is not a useful fix IMHO. Someone could just as eas=
ily
> > > send 2 commands with different IDs and the same socket path.
> > >
> > > A more accurate fix would be to iterate over existing chardevs and =
check
> > > whether any of them clash, but even that is useless if you have two
> > > separate QEMU instances and both try to use the same UNIX socket pa=
th.
> > > To deal with that you need to start taking out fcntl locks to ensur=
e
> > > real mutual exclusion.
> >
> > The reason we are already throwing error "attempt to add duplicate pr=
operty"
> > implies we are considering "id" as primary key? Even if we throw the =
error
> > existing chardev should work as before. But this is not the case righ=
t now,
> > it just deletes the existing chardev after error.
>=20
> It deletes the socket "file" (since it overwrites it on chardev
> creation). The existing chardev is not deleted:

I think this is yet another example of why it is a bad idea for the
qemu_chardev_new API to also open the backend. We should have a
qemu_chardev_new that only does the arg parsing, object creation
and registration. Then have a separate API for actually opening
it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
