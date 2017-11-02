Received: from eggs.gnu.org ([2001:4830:134:3::10]:56055)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eAJFE-0001Vb-5G
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eAJF9-0002Hf-Uy
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:25:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:61168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eAJF9-0002H8-JO
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:25:27 -0400
References: <20171028194833.23858-1-n54@gmx.com>
	<CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <891b1cf9-6d6f-ace6-c6af-ec9ef4e83139@gmx.com>
Date: Thu, 2 Nov 2017 18:27:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s9I40pWX2j9RAr8pMHq1JXCUGidKSsxvM"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s9I40pWX2j9RAr8pMHq1JXCUGidKSsxvM
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <891b1cf9-6d6f-ace6-c6af-ec9ef4e83139@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
References: <20171028194833.23858-1-n54@gmx.com>
 <CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
In-Reply-To: <CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.11.2017 17:55, Peter Maydell wrote:
> On 28 October 2017 at 20:48, Kamil Rytarowski <n54@gmx.com> wrote:
>> NetBSD 8.0(beta) ships with KERN_PROC_PATHNAME in sysctl(2).
>> Older NetBSD versions can use argv[0] parsing fallback.
>>
>> This code section is partly shared with FreeBSD.
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
>>  util/oslib-posix.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 382bd4a231..77369c92ce 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -49,6 +49,10 @@
>>  #include <libutil.h>
>>  #endif
>>
>> +#ifdef __NetBSD__
>> +#include <sys/sysctl.h>
>> +#endif
>> +
>>  #include "qemu/mmap-alloc.h"
>>
>>  #ifdef CONFIG_DEBUG_STACK_USAGE
>> @@ -250,9 +254,14 @@ void qemu_init_exec_dir(const char *argv0)
>>              p =3D buf;
>>          }
>>      }
>> -#elif defined(__FreeBSD__)
>> +#elif defined(__FreeBSD__) \
>> +      || (defined(__NetBSD__) && defined(KERN_PROC_PATHNAME))
>>      {
>> +#if defined(__FreeBSD__)
>>          static int mib[4] =3D {CTL_KERN, KERN_PROC, KERN_PROC_PATHNAM=
E, -1};
>> +#else
>> +        static int mib[4] =3D {CTL_KERN, KERN_PROC_ARGS, -1, KERN_PRO=
C_PATHNAME};
>> +#endif
>>          size_t len =3D sizeof(buf) - 1;
>>
>>          *buf =3D '\0';
>=20
> It's a shame the BSDs can't agree on a single way to implement this :-(=

>=20
> I had a look at how Go implements this:
> https://github.com/golang/go/commit/2fc67e71af142bfa1e7662a4fde361f4350=
9d2d7
>=20
> and for NetBSD it uses readlink("/proc/curproc/exe"), which would be
> a better fallback for "sysctl not implemented" than the argv[0]
> stuff, perhaps (but then nobody's complained much so perhaps not
> worth the effort now). It also has /proc/curproc/file for OpenBSD, but
> my OpenBSD VM doesn't mount /proc/, which reduces my enthusiasm
> for trying for a "generic for BSDs try various /proc/ paths" approach.
>=20
> In any case, I think this is better than what we have today,
> so I've applied it to master.
>=20

It's better to assume that there is no such entity as a shared BSD code
in modern BSD Operating Systems. My opinion is to drop CONFIG_BSD
entirely from qemu and treat __NetBSD__, __FreeBSD__ and __OpenBSD__ as
diverse targets.

(I'm not sure how about bsd-user, whether it should be dropped and
reimplemented on per-OS basis? I think that in the current state of
affairs it's a reasonable move forwards.).

OpenBSD does not ship any interface except argv[0] to get executable
path. They have removed their procfs.

NetBSD and FreeBSD deprecate procfs and fallback to /proc shall not be
introduced into new code.

> thanks
> -- PMM
>=20



--s9I40pWX2j9RAr8pMHq1JXCUGidKSsxvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ+1WhAAoJEEuzCOmwLnZsfvsP/jCA+hkx1Nop2JpTrqqApBjK
i802/EYT2LLaC7sWsO4NZKR2pgUJVEvBIqmDaEnTFBsLwS+5y1sMZeZ8MO0hWTqq
BAHllOEavz7Yv+ZrIH275cLNGis0QkYpnMJ9vgJTOtI1dBhAsPKjkkqg3pXarG6L
VBAdoYwbAKMbJQNGFXPlJxh53o1wPzwFFC3Nj54tSyVVpH+TSXZFA3FwDIwgOVlP
SAdxYvtk3JWBYxCwbUZNQimGgHmgExvLXVO3mz7ReQrW0YmchD1AJfOsXhUOxO4U
CnuCJ1QUqWqobwYiH6Ru0pMJJl6m3CChWbq5u+kj2goszO2XemXvv8nH3thnzzlg
kULwYrj2VcYpelKnCNkmtExDNN6f2JlqUJbZBqyLhYdVnt6ld/0nxv54rdm4kpKv
7lOYvXOMna08vtj+zx3NHBs/kRXJu7eMpgcpfOs6+Z3oaFZdjiGljWyjfMDCj+/J
rcRL1R5uyRbIv/sxuYYBPEdGQeMUazFvGfeB/kT+r0SUnkNwpNsys8XQQJokx623
e/X8i2Ab2+cUGeEoFVqxnsSBs0YLyuo1gikNZoRYtAmj+22bmGEilh7ezeOPvgNO
Oz9cf2/CvmfGobhDUfeo7+iF7PsPCH6cnlM8DS3W9mvTsImaTZgPu7fOP8IcY9Hm
nFRgD2ha47Kl4z7J1UWl
=tJ6g
-----END PGP SIGNATURE-----

--s9I40pWX2j9RAr8pMHq1JXCUGidKSsxvM--
