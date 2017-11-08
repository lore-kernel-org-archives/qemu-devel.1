Received: from eggs.gnu.org ([2001:4830:134:3::10]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCU6x-0005DS-Nw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCU6u-0004oM-G2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:25:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eCU6u-0004nZ-6V
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:25:56 -0500
Date: Wed, 8 Nov 2017 15:25:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171108172547.GP3111@localhost.localdomain>
References: <20171030040056.11780-1-f4bug@amsat.org>
	<20171030082029.GY2993@localhost.localdomain>
	<20171108132857.GT12670@redhat.com>
	<1ecb6a4b-465f-0949-e039-441038f1adf8@amsat.org>
	<20171108165905.GN3111@localhost.localdomain>
	<20171108170629.GD12670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171108170629.GD12670@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Nov 08, 2017 at 05:06:29PM +0000, Daniel P. Berrange wrote:
> On Wed, Nov 08, 2017 at 02:59:05PM -0200, Eduardo Habkost wrote:
> > On Wed, Nov 08, 2017 at 01:21:33PM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > > On 11/08/2017 10:28 AM, Daniel P. Berrange wrote:
> > > > On Mon, Oct 30, 2017 at 09:20:29AM +0100, Eduardo Habkost wrote:
> > > >> On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daud=E9=
 wrote:
> > > >>> examples configuring with '--enable-kvm --disable-tcg'
> > > >>>
> > > >>> - before
> > > >>>
> > > >>>   $ qemu-system-x86_64 -accel help
> > > >>>   Possible accelerators: kvm, xen, hax, tcg
> > > >>>
> > > >>>   $ qemu-system-x86_64 -accel tcg
> > > >>>   qemu-system-x86_64: -machine accel=3Dtcg: No accelerator foun=
d
> > > >>>
> > > >>>   # qemu-system-x86_64 -accel hax
> > > >>>   qemu-system-x86_64: -machine accel=3Dhax: No accelerator foun=
d
> > > >>>
> > > >>>   # qemu-system-x86_64 -accel xen
> > > >>>   xencall: error: Could not obtain handle on privileged command=
 interface: No such file or directory
> > > >>>   xen be core: xen be core: can't open xen interface
> > > >>>   can't open xen interface
> > > >>>   qemu-system-x86_64: failed to initialize Xen: Operation not p=
ermitted
> > > >>>
> > > >>> - after
> > > >>>
> > > >>>   $ qemu-system-x86_64 -accel help
> > > >>>   Possible accelerators: kvm
> > > >>>
> > > >>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > >>> ---
> > > >>> RFC because:
> > > >>>     - I don't think this is the nicest way, too much #ifdef'fer=
y in main()
> > > >>
> > > >> I suggest using object_class_get_list(TYPE_ACCEL, false).
> > > >=20
> > > > And check the result of the available() method on the returned cl=
asses
> > > > too, to filter the results.
> > >=20
> > > Good idea! I'll use that.
> >=20
> > It looks like QTest is the only accelerator that implements
> > ->available(), and its return value is a build-time constant that
> > depends only on CONFIG_POSIX.
> >=20
> > I wonder why we don't simply avoid compiling the qtest class if
> > CONFIG_POSIX is unset, making the ->available() method
> > unnecessary.
>=20
> Yeah that does seem simpler, though I'm surprised that Xen does not
> implement the available method. Xen is an accel I'd expect to see
> compiled into an x86 build, but is only available if the host is
> actually booted under a Xen hypervisor.  Likewise shouldn't kvm
> only report itself as available if the /dev/kvm actually exists.
> But maybe that's not the kind of semantics code using available()
> expects ?

Currently the only caller of ->available() calls ->init_machine()
immediately afterwards, so for the current code it doesn't matter
if the check is inside ->available() or ->init_machine().

That said, I'm not sure we should look for /dev/kvm or check for
the Xen hypervisor when handling "-accel help".  I expect help
text to tell the user what the QEMU binary supports, not what the
current host supports.

--=20
Eduardo
