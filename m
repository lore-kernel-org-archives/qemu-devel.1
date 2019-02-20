Received: from eggs.gnu.org ([209.51.188.92]:60365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwQ5i-0005iQ-Qq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwQ5h-0003nF-KC
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:06 -0500
Date: Wed, 20 Feb 2019 11:30:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190220113016.GD21870@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
	<CAMxuvazRLabuNiGdKb9HSxyqJ+9NhxJkqkv824BTFj95j5u9rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazRLabuNiGdKb9HSxyqJ+9NhxJkqkv824BTFj95j5u9rA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/25] chardev: Convert qemu_chr_write()
 to take a size_t argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, qemu-s390x@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zhang Chen <zhangckid@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Prasad J Pandit <pjp@fedoraproject.org>, Cornelia Huck <cohuck@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>

On Wed, Feb 20, 2019 at 11:53:42AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Feb 20, 2019 at 2:02 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi,
> >
> > This series convert the chardev::qemu_chr_write() to take unsigned
> > length argument. To do so I went through all caller and checked if
> > there are no negative value possible.
>=20
>=20
> Changing signedness is problematic and can easily introduce bugs that
> are easy to miss during review.
>=20
> I agree with Cornelia about idiomatic use of int. Changing "int" for
> "size_t" isn't systematically a clear win.
>=20
> Even Google C++ style recommends to avoid unsigned types "(except for
> representing bitfields or modular arithmetic). Do not use an unsigned
> type merely to assert that a variable is non-negative."
> https://google.github.io/styleguide/cppguide.html#Integer_Types - see r=
ationale
>=20
> Since Paolo you suggested the change, could you give some convincing
> arguments that it's worth taking the plunge?

The chardev write/read methods will end up calling libc read/write
methods, whose parameters are "size_t count".

Thus if there is QEMU code that could currently (mistakenly) pass a
negative value for length to qemu_chr_write, unless something stops
it, this is going to be cast to a size_t when we finally call read/
write on the FD, leading to a large positive value & array out of
bounds read/write.=20

IOW we already have inconsistent use of signed vs unsigned in our code
which has potential to cause bugs. Converting chardev to use size_t
we get rid fo the mismatch with the underlying libc APIs we call,
which ultimately eliminates an area of risk longer term. There is a
chance it could uncover some pre-existing dormant bugs, but provided
we do due diligence to check callers I think its a win to be consistent
with libc APIs in size_t usage for read/write.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
