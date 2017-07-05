Received: from eggs.gnu.org ([2001:4830:134:3::10]:40849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSi6t-0005gF-S6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSi6p-0000m3-SX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSi6p-0000la-JT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:04:39 -0400
Date: Wed, 5 Jul 2017 12:04:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170705110431.GE22008@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499237876.3041.4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499237876.3041.4.camel@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Peng <chao.p.peng@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Tian, Kevin" <kevin.tian@intel.com>

On Wed, Jul 05, 2017 at 02:57:56PM +0800, Chao Peng wrote:
> Hi,
> =C2=A0
> Q35 has been in QEMU for quite a while. Compared to the current default
> i440FX, Q35 is probably not that mature and not widely used, however in
> some case, Q35 has advantages, for example, in supporting new features.
> For instance, we have some features require PCI-e support which is only
> available on Q35 and some others need it for EFI support. It is of
> course not necessary to change it as the default but if more and more
> features have dependencies on Q35 because of requiring much more modern
> features then I think it may be worth to do so. In such case we can hav=
e
> more people to use it and find problems we may know or not know. There
> are certainly some drawbacks:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Compatibility: current=
 code or script may need adjustment
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Quality: we may suffer=
 more bugs on Q35
>=20
> Any thoughts?

Changing the default machine will certainly break a large number of
apps / scripts / users of QEMU because it completely changes the ABI
exposed to guest OS. It will also invalidate documentation about
QEMU usage across countless websites / source repos.

If you're lucky QEMU may immediately fail to start because a command
line argument refers to some property / device that exists by default
in PIIX, but not in Q35.

If you're unlucky QEMU will successfully start, but expose a different
ABI to the guest. This will cause Windows guests to trigger license
reactivation. It will cause QEMU to fail to load any previously saved
snapshots, and will fail to process incoming migration.

Then there is the fact that some guest OS may not work with the chipset
exposed by Q35.

While you can say people should just add '-M pc' that isn't a nice
user experiance, because it makes the assumption that people actually
understand what caused their breakage. When the incompatibilities
arise the error messages are unlikely to give any hint to users that
the problems are caused by the machine type change. So unless someone
is very familiar with debugging QEMU, they're not going to realize
that '-M pc' will fix their problem. Documentation assuming the old
defaults will live on forever, meaning users suffer from the change
in defaults for years, probably decades into the future.

All these problems can be avoided if the change in defaults in done by
higher level applications. For example, OpenStack/oVirt know what guest
OS is being deployed, so they can intelligently choose between either
Q35 or PIIX4, depending on which the guest is known to work with. These
apps will also have a persistent record of full guest config (via libvirt=
)
to the change in defaults won't risk breaking existing deployed guests,
or their snapshots & ensure migration continues to work.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
