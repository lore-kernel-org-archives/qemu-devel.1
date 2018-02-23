Received: from eggs.gnu.org ([2001:4830:134:3::10]:45063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHSB-0007BT-66
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHS7-0001he-8l
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:48:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHS7-0001eW-1D
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:48:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-24-armbru@redhat.com>
	<1011949b-ca28-3c9e-9aed-21f8af8d5f7e@redhat.com>
Date: Fri, 23 Feb 2018 18:47:59 +0100
In-Reply-To: <1011949b-ca28-3c9e-9aed-21f8af8d5f7e@redhat.com> (Eric Blake's
	message of "Mon, 12 Feb 2018 16:13:24 -0600")
Message-ID: <87bmgfk374.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/29] Include less of the generated
 modular QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/11/2018 03:36 AM, Markus Armbruster wrote:
>> In my "build everything" tree, a change to the types in
>> qapi-schema.json triggers a recompile of about 4800 out of 5100
>> objects.
>>
>> The previous commit split up qmp-commands.h, qmp-event.h, qmp-visit.h,
>> qapi-types.h.  Each of these headers still includes all its shards.
>> Reduce compile time by including just the shards we actually need.
>>
>> To illustrate the benefits: adding a type to qapi/migration.json now
>> recompiles some 2300 instead of 4800 objects.  The next commit will
>> improve it further.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   backends/cryptodev.c             |  1 -
>>   backends/hostmem.c               |  3 ++-
>
> How did you determine which shards to include where? Remove all
> shards, try compiling, and see what fails, then add back in the right
> includes? Or was it scripted somehow?  (Trying to figure out, in case
> I have to rebase this patch)

Remove the monolithic include, fix compilation failures in my
"everything" and my mingw configuration.  Additionally, verify headers
don't regress with an embarrassingly crude script (appended).

By "regress" I mean headers need more headers to be included first than
before.  Ideally, *no* headers need to be included first, but we aren't
there (yet?).

>> +++ b/block/crypto.c
>> @@ -24,9 +24,9 @@
>>   #include "sysemu/block-backend.h"
>>   #include "crypto/block.h"
>>   #include "qapi/opts-visitor.h"
>> +#include "qapi/qapi-visit-crypto.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "qapi/qobject-input-visitor.h"
>> -#include "qapi-visit.h"
>>   #include "qapi/error.h"
>
> Any rhyme or reason to the resulting include order that I should be
> looking for (we aren't alphabetical in general, but if your changes
> were trying to honor a particular pattern among the few affected
> lines, that's useful to know).

Sane headers can be include in any order.  Ours are almost sane, which
prevents me from wholesale sorting.  I still try to keep things locally
sorted.  Feel free not to bother :)

>> +++ b/scripts/qapi/commands.py
>
> The non-mechanical portion of the patch :)
>
>> @@ -241,6 +241,9 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularC=
Visitor):
>>         def _begin_module(self, name):
>>           self._visited_ret_types[self._genc] =3D set()
>> +        commands =3D self._module_basename('qapi-commands', name)
>> +        types =3D self._module_basename('qapi-types', name)
>> +        visit =3D self._module_basename('qapi-visit', name)
>>           self._genc.add(mcgen('''
>>   #include "qemu/osdep.h"
>>   #include "qemu-common.h"
>> @@ -251,18 +254,17 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModula=
rCVisitor):
>>   #include "qapi/qobject-input-visitor.h"
>>   #include "qapi/dealloc-visitor.h"
>>   #include "qapi/error.h"
>> -#include "%(prefix)sqapi-types.h"
>> -#include "%(prefix)sqapi-visit.h"
>> -#include "%(prefix)sqmp-commands.h"
>> +#include "%(visit)s.h"
>> +#include "%(commands)s.h"
>>     ''',
>> -                             prefix=3Dself._prefix))
>> +                             commands=3Dcommands, visit=3Dvisit))
>>           self._genh.add(mcgen('''
>> -#include "%(prefix)sqapi-types.h"
>> +#include "%(types)s.h"
>>   #include "qapi/qmp/dispatch.h"
>>     ''',
>> -                             prefix=3Dself._prefix))
>> +                             types=3Dtypes))
>
> Makes sense.
>
> The compiler will catch anything we did wrong.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


#!/bin/sh
git-log -1 --oneline | cat

make -C bld qapi-types.h

cat >t.c <<EOF
#include "qemu/osdep.h"
#ifdef H
#include H
#endif
EOF

x=3D
for d in target/*
do
    t=3D${d#target/}
    bt=3D`ls -d bld/$t*-softmmu 2>/dev/null | head -n 1`
    [ "$bt" ] || continue
    h=3D`git-ls-files include/hw/$t`
    x=3D"$x|include/hw/$t"
    cd $bt
    for i in $h
    do
	echo "=3D $i =3D"
	gcc -I/home/armbru/work/qemu/tcg -I/home/armbru/work/qemu/tcg/$t -I/home/a=
rmbru/work/qemu/tcg/i386 -I/home/armbru/work/qemu/linux-headers -I/home/arm=
bru/work/qemu/bld/linux-headers -I. -I/home/armbru/work/qemu -I/home/armbru=
/work/qemu/include -I/home/armbru/work/qemu -I. -I/usr/include/pixman-1   -=
DHAS_LIBSSH2_SFTP_FSYNC -fPIE -DPIE -m64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wund=
ef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common  -=
Wendif-labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat=
-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declara=
tion -Wold-style-definition -Wtype-limits -fstack-protector-strong  -I/usr/=
include/p11-kit-1     -I/usr/include/libpng16  -I/usr/include/spice-server =
-I/usr/include/cacard -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/inclu=
de/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/in=
clude/spice-1  -I/usr/include/cacard -I/usr/include/nss3 -I/usr/include/nsp=
r4  -I/usr/include/libusb-1.0    -I../linux-headers -I.. -I/home/armbru/wor=
k/qemu/$d -DNEED_CPU_H -I/home/armbru/work/qemu/include -MMD -MP -MT t.o -M=
F ./t.d -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -g =
  -c -o t.o /home/armbru/work/qemu/t.c -H -DH=3D'"'$i'"'
    done
    cd - >/dev/null
done

x=3D${x#|}
h=3D`git-ls-files include | egrep -v "$x"`
cd bld
for i in $h
do
    echo "=3D $i =3D"
    gcc -I/home/armbru/work/qemu/tcg -I/home/armbru/work/qemu/tcg/i386 -I/h=
ome/armbru/work/qemu/linux-headers -I/home/armbru/work/qemu/bld/linux-heade=
rs -I. -I/home/armbru/work/qemu -I/home/armbru/work/qemu/include -I/home/ar=
mbru/work/qemu -I. -I/usr/include/pixman-1   -DHAS_LIBSSH2_SFTP_FSYNC -fPIE=
 -DPIE -m64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wst=
rict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-p=
rototypes -fno-strict-aliasing -fno-common  -Wendif-labels -Wmissing-includ=
e-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-=
self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -W=
type-limits -fstack-protector-strong  -I/usr/include/p11-kit-1     -I/usr/i=
nclude/libpng16  -I/usr/include/spice-server -I/usr/include/cacard -I/usr/i=
nclude/nss3 -I/usr/include/nspr4 -I/usr/include/glib-2.0 -I/usr/lib64/glib-=
2.0/include -I/usr/include/pixman-1 -I/usr/include/spice-1  -I/usr/include/=
cacard -I/usr/include/nss3 -I/usr/include/nspr4  -I/usr/include/libusb-1.0 =
  -I/home/armbru/work/qemu/tests -MMD -MP -MT t.o -MF ./t.d -pthread -I/usr=
/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -g   -c -o t.o /home/armbr=
u/work/qemu/t.c -H -DH=3D'"'$i'"'
done
exit 0
