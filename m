Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ1I0-00026K-Si
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eZ1I0-0008WE-57
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:18:32 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eZ1Hz-0008V1-TD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:18:32 -0500
Date: Tue, 9 Jan 2018 22:18:28 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180109211828.jfsogktfdxbrj2kp@var.youpi.perso.aquilenet.fr>
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-5-f4bug@amsat.org>
	<5d8097eb-3300-56b5-adc4-94fb8de9c0ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d8097eb-3300-56b5-adc4-94fb8de9c0ba@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] slirp: add in6_multicast() and use
 it instead of IN6_IS_ADDR_MULTICAST()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Richard Henderson, on mar. 09 janv. 2018 08:33:22 -0800, wrote:
> On 01/08/2018 09:28 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Host: Mac OS 10.12.5
> > Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
> >=20
> >   slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'i=
p_src' of class or
> >         structure 'ip6' may result in an unaligned pointer value
> >         [-Waddress-of-packed-member]
> >       if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
> >                                  ^~~~~~~~~~
> >   /usr/include/netinet6/in6.h:299:36: note: expanded from macro 'IN6_=
IS_ADDR_MULTICAST'
> >   #define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xf=
f)
>=20
> The fact that you replace a macro with a function of exactly the same c=
ode in
> order to avoid a diagnostic sure looks like a compiler bug to me.

The compiler could be smarter to realize that it's actually a byte access=
 indeed.

There are two things for me:

- The OS-provided implementation of IN6_IS_ADDR_MULTICAST could be doing
  32bit accesses and whatnot, so we are not supposed to use it on packed
  fields.

- With the proposal patch, the compiler could still emit the warning,
  since we are basically still passing the address of the packed field
  to a function which the compiler might not see either.  We are however
  sure that the function makes an aligned access.

So I'd say we should still rather do it to be on the safe side. With
Thomas Huth's comments applied.

BTW,

Thomas Huth <thuth@redhat.com> wrote:
> I think this might also be a bug in the macro definitions.

> > > #define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xf=
f)

> On Linux, it is defined like this:
>=20
> #define IN6_IS_ADDR_MULTICAST(a) (((const uint8_t *) (a))[0] =3D=3D 0xf=
f)

Well, the standard says that IN6_IS_ADDR_MULTICAST takes a struct
in6_addr*, so it can use the s6_addr field.

Samuel
