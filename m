Received: from eggs.gnu.org ([2001:4830:134:3::10]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8UUX-0003SP-T5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8UUU-0006oG-PW
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:29:33 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d8UUU-0006nu-Ko
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:29:30 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so112692qkh.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 09:29:30 -0700 (PDT)
Date: Wed, 10 May 2017 12:29:27 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170510162927.GE19962@stefanha-x1.localdomain>
References: <1494369432-15418-1-git-send-email-anthony.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <1494369432-15418-1-git-send-email-anthony.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] trace: add sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 03:37:12PM -0700, Anthony Xu wrote:
> If trace backend is set to TRACE_NOP, trace_get_vcpu_event_count
> returns 0, cause bitmap_new call abort.
>=20
> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> ---
>  qom/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Please post steps for reproducing the abort.  I cannot reproduce this
with qemu-system-x86_64.

> diff --git a/qom/cpu.c b/qom/cpu.c
> index f02e9c0..f9111a0 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -382,6 +382,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, =
Error **errp)
> =20
>  static void cpu_common_initfn(Object *obj)
>  {
> +    uint32_t count;
>      CPUState *cpu =3D CPU(obj);
>      CPUClass *cc =3D CPU_GET_CLASS(obj);
> =20
> @@ -396,7 +397,10 @@ static void cpu_common_initfn(Object *obj)
>      QTAILQ_INIT(&cpu->breakpoints);
>      QTAILQ_INIT(&cpu->watchpoints);
> =20
> -    cpu->trace_dstate =3D bitmap_new(trace_get_vcpu_event_count());
> +    count =3D trace_get_vcpu_event_count();
> +    if (count) {
> +        cpu->trace_dstate =3D bitmap_new(count);
> +    }
> =20
>      cpu_exec_initfn(cpu);
>  }
> --=20
> 1.8.3.1
>=20
>=20

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEz/nAAoJEJykq7OBq3PISpQH/RybLIkBf0aHGxTjGR1zxhJu
geLq7nIPlRztLG8WHbNs5c7csA0sU8/YwE6Da+YBHbKCVVLW3OsYq2aiTrb+C23Z
He6PCJqJSpNNZ0K4/gR3hFqwUJBysfEDHL8CswApIEbIOLCJLHZb8aJ6bxADWZ5C
WbtMCdWtNQ53KL/Y9/cgBUi5R2rEbS+BF3cS1xj2eMZJgT+FB9VlZeLefn7+TnvE
e9vHrTYi26gc8KinnxORxaQBwc4n2VIHhnRXVclKc0ofPCT2A487QgJZNuR1emBg
FqjZceb1GdMx13kgqJoj8dDvCI+VyU3RhuWTwEh3CF/974EIpAVKb1MxLn6E0aQ=
=xyZO
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
