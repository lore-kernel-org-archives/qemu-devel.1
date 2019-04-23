Received: from eggs.gnu.org ([209.51.188.92]:32954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0CH-0004VQ-RB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0CF-0002Gz-Ab
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:31:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0CF-0002DQ-1n
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:31:11 -0400
References: <20190417053225.27505-1-richard.henderson@linaro.org>
	<20190417053225.27505-2-richard.henderson@linaro.org>
	<fb4917eb-4ff3-7a93-cbcd-39d1800827e8@redhat.com>
	<20190423100101.GD6022@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cc1481bc-5f80-2792-2a36-a31a42357825@redhat.com>
Date: Tue, 23 Apr 2019 20:30:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190423100101.GD6022@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] util/path: Do not cache all filenames
 at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, evgreen@chromium.org, laurent@vivier.eu, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23.04.19 12:01, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 23, 2019 at 11:54:53AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Richard, Daniel,
>>
>> On 4/17/19 7:32 AM, Richard Henderson wrote:
>>> If one uses -L $PATH to point to a full chroot, the startup time
>>> is significant.  In addition, the existing probing algorithm fails
>>> to handle symlink loops.
>>>
>>> Instead, probe individual paths on demand.  Cache both positive
>>> and negative results within $PATH, so that any one filename is
>>> probed only once.
>>>
>>> Use glib filename functions for clarity.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  util/path.c | 211 ++++++++++++++------------------------------------=
--
>>>  1 file changed, 57 insertions(+), 154 deletions(-)
>=20
>=20
>>> +#if GLIB_CHECK_VERSION(2, 58, 0)
>>
>> Should we raise GLIB_VERSION_MAX_ALLOWED in "glib-compat.h"?
>>
>> Currently it is:
>>
>>   /* Ask for warnings if code tries to use function that did not
>>    * exist in the defined version. These risk breaking builds
>>    */
>>   #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
>=20
> Use of 2.40 is set in accordance with our targetted platform support
> policy. If Peter has stopped using the Ubuntu 14.04 build host, we
> could bump it to 2.42. Once our dev tree opens up we could in fact
> drop Jessie since we'll be supporting Buster by the time next QEMU
> is released. That would still only take us upto perhaps Glib 2.48
>=20
> Glib 2.58 is waaaay to new to rely on.
>=20
> commit e7b3af81597db1a6b55f2c15d030d703c6b2c6ac
> Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Date:   Fri May 4 15:34:46 2018 +0100
>=20
>     glib: bump min required glib library version to 2.40
>    =20
>     Per supported platforms doc[1], the various min glib on relevant di=
stros is:
>    =20
>       RHEL-7: 2.50.3
>       Debian (Stretch): 2.50.3
>       Debian (Jessie): 2.42.1
>       OpenBSD (Ports): 2.54.3
>       FreeBSD (Ports): 2.50.3
>       OpenSUSE Leap 15: 2.54.3
>       SLE12-SP2: 2.48.2
>       Ubuntu (Xenial): 2.48.0
>       macOS (Homebrew): 2.56.0
>    =20
>     This suggests that a minimum glib of 2.42 is a reasonable target.
>    =20
>     The GLibC compile farm, however, uses Ubuntu 14.04 (Trusty) which o=
nly
>     has glib 2.40.0, and this is needed for testing during merge. Thus =
an
>     exception is made to the documented platform support policy to allo=
w for
>     all three current LTS releases to be supported.
>    =20
>     Docker jobs that not longer satisfy this new min version are remove=
d.
>    =20
>     [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-plat=
forms
>    =20
>     Reviewed-by: Thomas Huth <thuth@redhat.com>
>     Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
>>
>> From commit e71e8cc035558eabd6b3e19f6d3254c754c027ef:
>>
>>  glib: enforce the minimum required version and warn about old APIs
>>
>>  There are two useful macros that can be defined before including
>>  glib.h that are related to the min required glib version
>>
>>   - GLIB_VERSION_MIN_REQUIRED
>>
>>     When this is defined, if code uses an API that was deprecated
>>     in this version, or older, a compiler warning will be emitted.
>>     This alerts maintainers to update their code to whatever new
>>     replacement API is now recommended best practice.
>>
>>   - GLIB_VERSION_MAX_ALLOWED
>>
>>     When this is defined, if code uses an API that was introduced
>>     in a version that is newer than the declared version, a compiler
>>     warning will be emitted. This alerts maintainers if new code
>>     accidentally uses functionality that won't be available on some
>>     supported platforms.
>>
>>  The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
>>  in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
>>  To workaround this Pragmas can be used to temporarily turn off the
>>  -Wdeprecated-declarations compiler warning, while a static inline
>>  compat function is implemented. This workaround is illustrated with t=
he
>>  implementation of the g_strv_contains method to satisfy the test suit=
e.
>>
>>> +    base =3D g_canonicalize_filename(prefix, NULL);
>>> +#else
>>> +    if (prefix[0] !=3D '/') {
>>> +        char *cwd =3D g_get_current_dir();
>>> +        base =3D g_build_filename(cwd, prefix, NULL);
>>> +        g_free(cwd);
>>> +    } else {
>>> +        base =3D g_strdup(prefix);
>>> +    }
>>> +#endif
>=20
> To use functionality from newer glib releases we can't put the #ifdef
> conditionals inline in the main source files.
>=20
> They have to be put into glib-compat.h instead. There's a detailed
> comment in that file illustrating how todo this without triggering
> the compile warnings about deprecations.
>=20
>=20
> Regards,
> Daniel
>=20

Trying to build (Richard's tcg-vec-next branch) on Fedora29 I get

util/path.c: In function 'init_paths':
util/path.c:24:5: error: 'g_canonicalize_filename' is deprecated: Not
available before 2.58 [-Werror=3Ddeprecated-declarations]
     base =3D g_canonicalize_filename(prefix, NULL);
     ^~~~
In file included from /usr/include/glib-2.0/glib.h:48,
                 from /home/dhildenb/git/qemu/include/glib-compat.h:32,
                 from /home/dhildenb/git/qemu/include/qemu/osdep.h:140,
                 from util/path.c:6:
/usr/include/glib-2.0/glib/gfileutils.h:176:8: note: declared here
 gchar *g_canonicalize_filename (const gchar *filename,
        ^~~~~~~~~~~~~~~~~~~~~~~
util/path.c: In function 'path':
util/path.c:60:9: error: 'g_canonicalize_filename' is deprecated: Not
available before 2.58 [-Werror=3Ddeprecated-declarations]
         full_name =3D g_canonicalize_filename(g_path_skip_root(name), ba=
se);
         ^~~~~~~~~
In file included from /usr/include/glib-2.0/glib.h:48,
                 from /home/dhildenb/git/qemu/include/glib-compat.h:32,
                 from /home/dhildenb/git/qemu/include/qemu/osdep.h:140,
                 from util/path.c:6:
/usr/include/glib-2.0/glib/gfileutils.h:176:8: note: declared here
 gchar *g_canonicalize_filename (const gchar *filename,
        ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
  CC      backends/rng-egd.o
make: *** [/home/dhildenb/git/qemu/rules.mak:69: util/path.o] Error 1
make: *** Waiting for unfinished jobs....
  CC      backends/rng-random.o


--=20

Thanks,

David / dhildenb
