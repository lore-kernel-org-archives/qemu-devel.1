Received: from eggs.gnu.org ([2001:4830:134:3::10]:43417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g83i9-0002LP-H7
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g83i6-0000ZH-4E
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:30:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g83i5-0000Tm-OI
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:30:34 -0400
Date: Thu, 4 Oct 2018 14:30:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181004133027.GP3667@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
	<20180903115406.GA14377@redhat.com>
	<ee81457c-5df4-974f-29fa-7fdcc6649ea7@redhat.com>
	<20180904081423.GA22349@redhat.com>
	<b78484df-00a2-3759-baad-ddb3825aae6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b78484df-00a2-3759-baad-ddb3825aae6a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org

On Thu, Sep 06, 2018 at 01:26:01PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B409=E6=9C=8804=E6=97=A5 16:14, Daniel P. Berrang=C3=A9 w=
rote:
> > On Tue, Sep 04, 2018 at 11:07:38AM +0800, Jason Wang wrote:
> > > On 2018=E5=B9=B409=E6=9C=8803=E6=97=A5 19:54, Daniel P. Berrang=C3=A9=
 wrote:
> > > > > + *
> > > > > + * This work is licensed under the terms of the GNU GPL, versi=
on 2 or later.
> > > > > + * See the COPYING file in the top-level directory.
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include <linux/bpf.h>
> > > > > +
> > > > > +#ifndef BPF_RSS_INSNS
> > > > > +#define BPF_RSS_INSNS
> > > > > +
> > > > > +/* bpf_insn array matching l3_l4 section. see tap_bpf_program.=
c file */
> > > > > +struct bpf_insn l3_l4_hash_insns[] =3D {
> > > > > +{0xbf , 0x6 , 0x1 , 0x0000 , 0x00000000},
> > > > > +{0x28 , 0x0 , 0x0 , 0x0000 , 0x0000000c},
> > > > > +{0xbf , 0x8 , 0x0 , 0x0000 , 0x00000000},
> > > > [snip]
> > > >=20
> > > > > +};
> > > > This massive array is presumably an auto-generated content.
> > > >=20
> > > > We shouldn't be storing this in GIT. We need to store the
> > > > original preferred source format, and providing makefile
> > > > rules to generate it.
> > > >=20
> > > >=20
> > > This is possible. But it depends on eBPF toolchain (e.g recent vers=
ion of
> > > LLVM) to work which is inflexible or impossible to make it work on =
some
> > > distributions. Providing compiled bytecode does not have such limit=
ation.
> > Those distros can fix their toolchain if they wish to have the BPF fe=
ature
> > enabled when building QEMU, just like they would for any other depend=
ancy
> > that is needed by QEMU.
> >=20
> > Regards,
>=20
> Well, since bytecode is architecture independent, it needs either emula=
tor
> or JIT to work. So having eBPF toolchain looks unnecessary since we're =
sure
> it will generate exactly the same bytecodes everywhere. I think we can =
just
> treat it like some kind of virtio-net firmware and ship with bytecodes.

I don't find this rational very compelling. Lots of our generated files
are architecture independant and so would have the same output everywhere=
.
We still aim to generate them all at build from the master source using
the relevant toolchain(s).

The main exception where we bundle pre-generated stuff is the various
architecture dependant ROMs, since those need many cross-compilers.
Most of the distro vendors will drop these pre-built ROMs and build
them from source again for license compliance purposes.=20

So I still believe we should be building BPF code from the master
source, not bundling any pre-generated content.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
