Received: from eggs.gnu.org ([2001:4830:134:3::10]:57319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgAaA-0001XI-MG
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgAa8-0003IP-3Q
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dgAa7-0003GX-TO
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:32 -0400
References: <alpine.DEB.2.20.1708102139310.8101@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2af0f225-48f7-5def-60a1-4b4b0be71132@redhat.com>
Date: Fri, 11 Aug 2017 16:06:28 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1708102139310.8101@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix pcmpxstrx substring search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com

On 10/08/2017 23:40, Joseph Myers wrote:
> One of the cases of the SSE4.2 pcmpestri / pcmpestrm / pcmpistri /
> pcmpistrm instructions does a substring search.  The implementation of
> this case in the pcmpxstrx helper is incorrect.  The operation in this
> case is a search for a string (argument d to the helper) in another
> string (argument s to the helper); if a copy of d at a particular
> position would run off the end of s, the resulting output bit should
> be 0 whether or not the strings match in the region where they
> overlap, but the QEMU implementation was wrongly comparing only up to
> the point where s ends and counting it as a match if an initial
> segment of d matched a terminal segment of s.  Here, "run off the end
> of s" means that some byte of d would overlap some byte outside of s;
> thus, if d has zero length, it is considered to match everywhere,
> including after the end of s.  This patch fixes the implementation to
> correspond with the proper instruction semantics.  This fixes four gcc
> test failures in my GCC 6-based testing.
>=20
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
>=20
> ---
>=20
> diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
> index 16509d0..9f1b351 100644
> --- a/target/i386/ops_sse.h
> +++ b/target/i386/ops_sse.h
> @@ -2037,10 +2040,14 @@ static inline unsigned pcmpxstrx(CPUX86State *e=
nv, Reg *d, Reg *s,
>          }
>          break;
>      case 3:
> -        for (j =3D valids; j >=3D 0; j--) {
> +        if (validd =3D=3D -1) {
> +            res =3D (2 << upper) - 1;
> +            break;
> +        }
> +        for (j =3D valids - validd; j >=3D 0; j--) {
>              res <<=3D 1;
>              v =3D 1;
> -            for (i =3D MIN(valids - j, validd); i >=3D 0; i--) {
> +            for (i =3D validd; i >=3D 0; i--) {
>                  v &=3D (pcmp_val(s, ctrl, i + j) =3D=3D pcmp_val(d, ct=
rl, i));
>              }
>              res |=3D v;

Ah, so j=3Dvalids-validd was correct before commit 54c54f8b56
("target-i386: fix pcmpxstrx equal-ordered (strstr) mode", 2015-11-04),
it was the upper bound of i that was incorrect in ignoring validd.

Queued, thanks.

Paolo
