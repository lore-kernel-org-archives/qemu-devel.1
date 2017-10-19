Received: from eggs.gnu.org ([2001:4830:134:3::10]:45377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e50kd-0000rx-Bx
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 22:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e50ka-0007yU-6q
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 22:40:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171019013126.GR2776@umbus.fritz.box>
Date: Wed, 18 Oct 2017 22:39:57 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <73CB718C-E1F1-4028-9E64-55759471792A@gmail.com>
References: <20171018223116.6035-1-programmingkidx@gmail.com>
	<20171019013126.GR2776@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] fdt_ro.c: implement strnlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


> On Oct 18, 2017, at 9:31 PM, David Gibson =
<david@gibson.dropbear.id.au> wrote:
>=20
> On Wed, Oct 18, 2017 at 06:31:16PM -0400, John Arbuckle wrote:
>> Implement the strnlen() function if it isn't implemented.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>=20
> Nice idea, but this won't work.
>=20
>> ---
>> libfdt/fdt_ro.c | 24 ++++++++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>>=20
>> diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
>> index 3d00d2e..a7986fb 100644
>> --- a/libfdt/fdt_ro.c
>> +++ b/libfdt/fdt_ro.c
>> @@ -55,6 +55,30 @@
>>=20
>> #include "libfdt_internal.h"
>>=20
>> +/* if the current environment does not define strnlen */
>> +#ifndef strnlen
>=20
> This will only trigger if strnlen is defined as a macro.  The C
> library (or other environment) *might* do that, but there's no
> guarantee, whether or not it defines strnlen as a function.  With
> extra complications if the compiler has a strnlen builtin like gcc.

:(

>> +
>> +/* This eliminates the missing prototype warning */
>> +int strnlen(const char *string, int max_count);
>> +
>> +/*
>> + * strnlen: return the length of a string or max_count
>> + * which ever is shortest
>> + */
>> +
>> +int strnlen(const char *string, int max_count)
>=20
> Also strnlen is supposed to take and return size_t, not int.

Will change this.

>=20
>> +{
>> +    int count;
>> +    for(count =3D 0; count < max_count; count++) {
>> +        if (string[count] =3D=3D '\0') {
>> +            break;
>> +        }
>> +    }
>> +    return count;
>> +}
>> +
>> +#endif /* strnlen */
>> +
>> static int _fdt_nodename_eq(const void *fdt, int offset,
>> 			    const char *s, int len)
>> {
>=20
> In any case, this sort of compatibility munging is the job of
> libfdt_env.h.  It's purpose is to provide all the external things that
> libfdt needs - there's not that many of them and strnlen() is one.
> The included libfdt_env.h is intended for POSIXy userspace
> environments, which should already include strnlen() in string.h.

QEMU supports Mac OS 10.5 and higher. The strnlen() function might have =
been added to Mac OS X in version 10.7. libfdt prevents QEMU from =
compiling on Mac OS X because of the missing strnlen() function. This =
issue needs to be resolved. If libfdt_env.h is where you want a fix =
located, would something like this be good:

#ifdef __APPLE__

#if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
	size_t strnlen(const char *string, int max_count)
	{
		... // pretend this is implemented
	}
#endif=20

#endif
