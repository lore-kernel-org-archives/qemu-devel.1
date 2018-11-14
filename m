Received: from eggs.gnu.org ([2001:4830:134:3::10]:35693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gMt2W-0007LA-JG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gMt2R-0004fd-P2
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:08:56 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:35010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dfaggioli@suse.com>) id 1gMt2R-0004co-FF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:08:51 -0500
Message-ID: <cce56aa63fe36bca59f1f6a6872d43ea11435f25.camel@suse.com>
From: Dario Faggioli <dfaggioli@suse.com>
Date: Wed, 14 Nov 2018 12:08:42 +0100
In-Reply-To: <154219299016.19470.9372139354280787961.stgit@wayrath>
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-IjF3I1mleClamsq28G2o"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Series short description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


--=-IjF3I1mleClamsq28G2o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wow... Mmm, not sure what went wrong... Anyway, this is the cover
letter I thought I had sent. Sorry :-/
--
Hello everyone,

This is Dario, from SUSE, and this is the first time I touch QEMU. :-D

So, basically, while playing with an AMD EPYC box, we came across a weird
performance regression between host and guest. It was happening with the
STREAM benchmark, and we tracked it down to non-temporal stores _not_ being
used, inside the guest.

More specifically, this was because the glibc version we were dealing with =
had
heuristics for deciding whether or not to use NT instructions. Basically, i=
t
was checking is how big the L2 and L3 caches are, as compared to how many
threads are actually sharing such caches.

Currently, as far as cache layout and size are concerned, we only have the
following options:
- no L3 cache,
- emulated L3 cache, which means the default cache layout for the chosen CP=
U
  is used,
- host L3 cache info, which means the cache layout of the host is used.

Now, in our case, 'host-cache-info' made sense, because we were pinning vcp=
us
as well as doing other optimizations. However, as the VM had _less_ vcpus t=
han
the host had pcpus, the result of the heuristics was to avoid non-temporal
stores, causing the unexpectedly high drop in performance. And, as you can
imagine, we could not fix things by using 'l3-cache=3Don' either.

This made us think this could be a general problem, and not only an issue f=
or
our benchmarks, and here it comes this series. :-)

Basically, while we can, of course, control the number of vcpus a guest has
already --as well as how they are arranged within the guest topology-- we c=
an't
control how big are the caches the guest sees. And this is what this series
tries to implement: giving the user the ability to tweak the actual size of=
 the
L2 and L3 caches, to deal with all those cases when the guest OS or userspa=
ce
do check that, and behave differently depending on what they see.

Yes, this is not at all that common, but happens, and hece the feature can
be considered useful, IMO. And yes, it is definitely something meant for th=
ose
cases where one is carefully tuning and highly optimizing, with things like
vcpu pinning, etc.

I've tested with many CPU models, and the cahce info from inside the guest
looks consistent. I haven't re-run the benchmarks that triggered all this w=
ork,
as I don't have the proper hardware handy right now, but I'm planning to
(although, as said, this looks like a general problem to me).

I've got libvirt patches for exposing these new properties in the works, bu=
t
of course they only make sense if/when this series is accepted.

As I said, it's my first submission, and it's RFC because there are a coupl=
e
of things that I'm not sure I got right (details in the single patches).

Any comment or advice more than welcome. :-)

Thanks and Regards,
Dario
---
Dario Faggioli (3):
      i386: add properties for customizing L2 and L3 cache sizes
      i386: custom cache size in CPUID2 and CPUID4 descriptors
      i386: custom cache size in AMD's CPUID descriptors too

 include/hw/i386/pc.h |    8 ++++++++
 target/i386/cpu.c    |   50 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 target/i386/cpu.h    |    3 +++
 3 files changed, 61 insertions(+)

--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-IjF3I1mleClamsq28G2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlvsAjoACgkQFkJ4iaW4
c+4dohAAh0JWKGNW+abaM3GHFdWMiWNVMvHSM1YafbipRqg37rMIzrJ4ua7MdrFz
7FRvXrLISs60J/ijE/eES4/uYFWku/3AgvzHsppiBnRgqPeNd7+eFcvy2RcLaBgf
RgRPo23u/gwhx/9jGXKmfHKdMseREDyOzf5wNs+OACWOzUERFgFgr7Z2oF4h4C8c
g7uI9xTu/q/VuGWiw31quKUbGsxFASunmXkQQmihk1WhGD4BPDxSXrxcWmEPHzIb
TjlovcAQTFoJZKpH1Uksr/dpbfTJoZsoDdTmwOeDxpaffE/2+AjDnGPEamz4/EOB
DfBdcyvr/9xO6mwpIpWCS06mgx01maeYZWx1IrNSZiCiEFFqIps2dliNcMse27kr
4wLdUAhdNMDbXaihmH2wMSyegdm1CtxEFrO+PrO+qiz61Ho1EqYDwfT3fQRdLP+5
FSsFcUgWj5stblgFe6kcv0GPZov0c0ivivB1CE45a3Tjwi/Nl7Dos2A9jNjGqs3D
SgW1TZodRDtFOuRt6oM0/hNtaW2QLCzdnlNdyj/GYZV3ERK17VOLroqeZ2K3IEx1
dkRS7wTuHNIcaxN4inl4OUs3frWNmMQD0dSXVspp/bOi/coVkA0E7wd7F7bBU7ry
+5LB1KzLQ4WqJr67vlV86n+pc/65VC7AGz2ersomEb82EivN29I=
=f5xO
-----END PGP SIGNATURE-----

--=-IjF3I1mleClamsq28G2o--
