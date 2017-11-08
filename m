Received: from eggs.gnu.org ([2001:4830:134:3::10]:58785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCToJ-0004hp-LS
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCToD-0005kE-Fj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCToD-0005jU-6m
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:06:37 -0500
Date: Wed, 8 Nov 2017 17:06:29 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108170629.GD12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171030040056.11780-1-f4bug@amsat.org>
	<20171030082029.GY2993@localhost.localdomain>
	<20171108132857.GT12670@redhat.com>
	<1ecb6a4b-465f-0949-e039-441038f1adf8@amsat.org>
	<20171108165905.GN3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171108165905.GN3111@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Nov 08, 2017 at 02:59:05PM -0200, Eduardo Habkost wrote:
> On Wed, Nov 08, 2017 at 01:21:33PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > On 11/08/2017 10:28 AM, Daniel P. Berrange wrote:
> > > On Mon, Oct 30, 2017 at 09:20:29AM +0100, Eduardo Habkost wrote:
> > >> On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > >>> examples configuring with '--enable-kvm --disable-tcg'
> > >>>
> > >>> - before
> > >>>
> > >>>   $ qemu-system-x86_64 -accel help
> > >>>   Possible accelerators: kvm, xen, hax, tcg
> > >>>
> > >>>   $ qemu-system-x86_64 -accel tcg
> > >>>   qemu-system-x86_64: -machine accel=3Dtcg: No accelerator found
> > >>>
> > >>>   # qemu-system-x86_64 -accel hax
> > >>>   qemu-system-x86_64: -machine accel=3Dhax: No accelerator found
> > >>>
> > >>>   # qemu-system-x86_64 -accel xen
> > >>>   xencall: error: Could not obtain handle on privileged command i=
nterface: No such file or directory
> > >>>   xen be core: xen be core: can't open xen interface
> > >>>   can't open xen interface
> > >>>   qemu-system-x86_64: failed to initialize Xen: Operation not per=
mitted
> > >>>
> > >>> - after
> > >>>
> > >>>   $ qemu-system-x86_64 -accel help
> > >>>   Possible accelerators: kvm
> > >>>
> > >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >>> ---
> > >>> RFC because:
> > >>>     - I don't think this is the nicest way, too much #ifdef'fery =
in main()
> > >>
> > >> I suggest using object_class_get_list(TYPE_ACCEL, false).
> > >=20
> > > And check the result of the available() method on the returned clas=
ses
> > > too, to filter the results.
> >=20
> > Good idea! I'll use that.
>=20
> It looks like QTest is the only accelerator that implements
> ->available(), and its return value is a build-time constant that
> depends only on CONFIG_POSIX.
>=20
> I wonder why we don't simply avoid compiling the qtest class if
> CONFIG_POSIX is unset, making the ->available() method
> unnecessary.

Yeah that does seem simpler, though I'm surprised that Xen does not
implement the available method. Xen is an accel I'd expect to see
compiled into an x86 build, but is only available if the host is
actually booted under a Xen hypervisor.  Likewise shouldn't kvm
only report itself as available if the /dev/kvm actually exists.
But maybe that's not the kind of semantics code using available()
expects ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
