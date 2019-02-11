Received: from eggs.gnu.org ([209.51.188.92]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gt7SX-0004aM-7I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gt7SV-00083w-T5
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:01:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:43660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gt7SU-0007xN-3J
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:00:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gt7SH-0003nB-Qd
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:00:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3BDA2E80C7
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2019 08:50:20 -0000
From: Vasily Dybala <1815423@bugs.launchpad.net>
Reply-To: Bug 1815423 <1815423@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154987502048.21937.8846396923018937713.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815423] [NEW] Incorrect floating point cast to
 int.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I used exaample from:
https://stackoverflow.com/questions/3986795/what-is-the-result-of-casting-f=
loat-inf-inf-and-nan-to-integer-in-c

#include <stdio.h>
#include <math.h>

int main(int argc, char** argv) {
  float a =3D INFINITY;
  float b =3D -INFINITY;
  float c =3D NAN;

  printf("float %f %f %f\n", a, b, c); =

  printf("int %d %d %d\n", (int) a, (int) b, (int) c); =

  printf("uint %u %u %u\n", (unsigned int) a, (unsigned int) b, (unsigned i=
nt) c); =

  printf("lint %ld %ld %ld\n", (long int) a, (long int) b, (long int) b); =

  printf("luint %lu %lu %lu\n", (unsigned long int) a, (unsigned long int) =
b, (unsigned long int) c); =


  return 0;
}

And got different results on real computer and on qemu.

output from real HW is the same as on stackoverflow:

$ gcc test.c && ./a.out =

float inf -inf nan
int -2147483648 -2147483648 -2147483648
uint 0 0 0
lint -9223372036854775808 -9223372036854775808 -9223372036854775808
luint 0 9223372036854775808 9223372036854775808


But on qemu I got another results:

float inf -inf nan
int 2147483647 -2147483648 2147483647
uint 4294967295 0 4294967295
lint 9223372036854775807 -9223372036854775808 -9223372036854775808
luint 18446744073709551615 9223372036854775808 9223372036854775807

qemu launch string:
/qemu-system-x86_64 -m 1024 -cpu core2duo -serial stdio -netdev user,id=3Dn=
etwork0 -device e1000,netdev=3Dnetwork0 -kernel my_kernel


qemu version:
x86_64-softmmu/qemu-system-x86_64 --version
QEMU emulator version 3.1.50 (v3.1.0-1676-ge47f81b617-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers


This bug affect some javascript (surprise) calculations:

var conversion =3D "01234567890";
var x;
var result =3D conversion[x & 42];
console.log(result)


In example, var x is "undefined"
and when do calculation "x & 42" on js we should get 0 (it is documented fe=
ature), but actually got "42"

and "result" sould be "0" but actually we got "undefined"

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: javascript js softfp

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815423

Title:
  Incorrect floating point cast to int.

Status in QEMU:
  New

Bug description:
  I used exaample from:
  https://stackoverflow.com/questions/3986795/what-is-the-result-of-casting=
-float-inf-inf-and-nan-to-integer-in-c

  #include <stdio.h>
  #include <math.h>

  int main(int argc, char** argv) {
    float a =3D INFINITY;
    float b =3D -INFINITY;
    float c =3D NAN;

    printf("float %f %f %f\n", a, b, c); =

    printf("int %d %d %d\n", (int) a, (int) b, (int) c); =

    printf("uint %u %u %u\n", (unsigned int) a, (unsigned int) b, (unsigned=
 int) c); =

    printf("lint %ld %ld %ld\n", (long int) a, (long int) b, (long int) b); =

    printf("luint %lu %lu %lu\n", (unsigned long int) a, (unsigned long int=
) b, (unsigned long int) c); =


    return 0;
  }

  And got different results on real computer and on qemu.

  output from real HW is the same as on stackoverflow:

  $ gcc test.c && ./a.out =

  float inf -inf nan
  int -2147483648 -2147483648 -2147483648
  uint 0 0 0
  lint -9223372036854775808 -9223372036854775808 -9223372036854775808
  luint 0 9223372036854775808 9223372036854775808

  =

  But on qemu I got another results:

  float inf -inf nan
  int 2147483647 -2147483648 2147483647
  uint 4294967295 0 4294967295
  lint 9223372036854775807 -9223372036854775808 -9223372036854775808
  luint 18446744073709551615 9223372036854775808 9223372036854775807

  qemu launch string:
  /qemu-system-x86_64 -m 1024 -cpu core2duo -serial stdio -netdev user,id=
=3Dnetwork0 -device e1000,netdev=3Dnetwork0 -kernel my_kernel

  =

  qemu version:
  x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 3.1.50 (v3.1.0-1676-ge47f81b617-dirty)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  =

  This bug affect some javascript (surprise) calculations:

  var conversion =3D "01234567890";
  var x;
  var result =3D conversion[x & 42];
  console.log(result)

  =

  In example, var x is "undefined"
  and when do calculation "x & 42" on js we should get 0 (it is documented =
feature), but actually got "42"

  and "result" sould be "0" but actually we got "undefined"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815423/+subscriptions
