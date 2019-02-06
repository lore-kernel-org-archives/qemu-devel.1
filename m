Received: from eggs.gnu.org ([209.51.188.92]:42708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grQ4q-0005Pf-7L
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grQ4l-0000GC-JG
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grQ4l-0000CV-DY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:29:27 -0500
Date: Wed, 6 Feb 2019 16:29:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190206162901.GW12331@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190129062801.15799-1-pagupta@redhat.com>
	<CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
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

On Wed, Feb 06, 2019 at 05:08:25PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jan 29, 2019 at 7:36 AM Pankaj Gupta <pagupta@redhat.com> wrote=
:
> >
> > Hotplugging existing char chardev with qmp, dereferences(removes)
> > existing chardev. This patch avoids adding a chardev if a chardev
> > with same id exists.
>=20
> As you pointed out, if you attempt to add a chardev with an existing
> ID, you get an error:
>=20
> {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"t=
ype":"socket","data":{"addr":{"type":"unix",
> "data": {"path": "/tmp/helloworld1"}}}}}}
> {"return": {}}
> {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"t=
ype":"socket","data":{"addr":{"type":"unix",
> "data": {"path": "/tmp/helloworld1"}}}}}}
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate
> property 'charchannel1' to object (type 'container')"}}
>=20
>=20
> But the existing chardev is left untouched.
>=20
> However, since unix socket chardev will delete existing file and
> rebind (this is not always a good idea, but people seem to prefer
> that)
> the rebound socket is removed on error cleanup.
>=20
>=20
> I am not sure this is a bug tbh.
>=20
> Your solution to check for duplicate ID upfront is ok. But any other
> later error path could have the same "bug" effect of removing existing
> chardev because of the overwrite socket creation.

Checking the ID is not a useful fix IMHO. Someone could just as easily
send 2 commands with different IDs and the same socket path.

A more accurate fix would be to iterate over existing chardevs and check
whether any of them clash, but even that is useless if you have two
separate QEMU instances and both try to use the same UNIX socket path.
To deal with that you need to start taking out fcntl locks to ensure
real mutual exclusion.

I think I'd really just call this user error and do nothing

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
