Received: from eggs.gnu.org ([2001:4830:134:3::10]:59426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dl0Sl-0004sf-N2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dl0Sh-0002oj-OV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:18:55 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dl0Sh-0002oV-Jg
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:18:51 -0400
Received: by mail-io0-x242.google.com with SMTP id m40so488032ioi.5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 15:18:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
Date: Thu, 24 Aug 2017 18:18:49 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <230513EB-08AB-41E9-97A6-69C646A5D205@gmail.com>
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org


> On Aug 24, 2017, at 4:41 PM, Cleber Rosa <crosa@redhat.com> wrote:
>=20
>=20
>=20
> On 08/24/2017 03:10 PM, Programmingkid wrote:
>> I think 'make test' is an abandoned testing option for QEMU so this =
report might be unimportant. Here is my results for running 'make test':
>>=20
>> $ make test
>> make -C tests/tcg test
>>  LINK    test_path
>> Undefined symbols for architecture x86_64:
>>  "_buffer_is_zero", referenced from:
>>      _qemu_iovec_is_zero in test_path.o
>> ld: symbol(s) not found for architecture x86_64
>> clang: error: linker command failed with exit code 1 (use -v to see =
invocation)
>> make[1]: *** [test_path] Error 1
>> make: *** [test] Error 2
>>=20
>>=20
>=20
> I went through the same experience, and reported it (in the form of
> patches) here:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg00378.html
>=20
> Although it looks like you're clang, so it'd be nice to check if these
> fixes work for you too.
>=20
> Regards,
>=20
> --=20
> Cleber Rosa
> [ Sr Software Engineer - Virtualization Team - Red Hat ]
> [ Avocado Test Framework - avocado-framework.github.io ]
> [  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
>=20

After applying the patches I saw this error:

$ make test
make -C tests/tcg test
  CC      test_path.o
  LINK    test_path
./test_path
cc -m32 -nostdlib -Wall -O2 -g -fno-strict-aliasing -static  -o =
hello-i386 hello-i386.c
hello-i386.c:1:10: fatal error: 'asm/unistd.h' file not found
#include <asm/unistd.h>
         ^
1 error generated.
make[1]: *** [hello-i386] Error 1
make: *** [test] Error 2


The path to this header file is /usr/include/unistd.h and =
/usr/include/sys/unistd.h on my computer. Maybe you could add this to =
your patches to make them more Mac-friendly:

#ifdef __MACH__ /* Mach kernel - what's used in Mac OS X */
	#include <unistd.h>
#endif

http://pubs.opengroup.org/onlinepubs/7908799/xsh/unistd.h.html
Then again this page states you should be able to do a "#include =
<unistd.h>" on your posix compatible platform.

Thank you.=
