Received: from eggs.gnu.org ([2001:4830:134:3::10]:53068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOOob-0005xj-0T
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOOoX-0001Fs-Pf
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:12:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eOOoX-0001FV-GW
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:12:13 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
	<CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
Date: Mon, 11 Dec 2017 08:11:44 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d3c6O3kBeXOJh4IaG9CHhhDg6WtpFVJQ7"
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d3c6O3kBeXOJh4IaG9CHhhDg6WtpFVJQ7
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>,
 Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
 <CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/2017 03:38 AM, Peter Maydell wrote:
> On 8 December 2017 at 19:40, Eric Blake <eblake@redhat.com> wrote:
>> On 12/08/2017 04:55 AM, Paolo Bonzini wrote:
>>> Likewise,
>>>
>>>     QEMU_WITH_LOCK(QemuMutex, guard_name, &some_mutex) {
>>>         ...
>>>     }
>>>
>>> is the same as
>>>
>>>     qemu_mutex_lock(&some_mutex);
>>>     ...
>>>     qemu_mutex_unlock(&some_mutex);
>>>
>>> except that any returns within the region will unlock the mutex.
>>
>> Not just returns, but ANY manner that you leave the scope, including a=

>> goto or just falling out of the end of the scope.
>=20
> How about longjmp()ing out of it?

Easy to test:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <stdio.h>
#include <setjmp.h>
#include <stdlib.h>

void my_cleanup (int *ptr) {
  int *i =3D ptr;
  printf("in my_cleanup(%d)\n", *i);
}

jmp_buf jmp;

void foo(int i) {
  while (1) {
    __attribute__((cleanup(my_cleanup))) int j =3D i;
    if (i =3D=3D 0) {
      printf("before leaving scope by return\n");
      return;
    }
    if (i =3D=3D 1) {
      goto label;
    }
    if (i =3D=3D 3) {
      longjmp(jmp, 1);
    }
    if (i =3D=3D 4) {
      printf("before leaving scope by exit\n");
      exit(0);
    }
    break;
  }
  printf("after leaving scope by break\n");
  return;
 label:
  printf("after leaving scope by return\n");
}

int main(void) {
  foo(0);
  foo(1);
  foo(2);
  if (!setjmp(jmp)) {
    foo(3);
  }
  printf("after leaving scope by longjmp\n");
  foo(4);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

But the results aren't necessarily nice, depending on how we currently
(ab)use longjmp. Under Fedora 27
gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)

I get

$ ./foo
before leaving scope by return
in my_cleanup(0)
in my_cleanup(1)
after leaving scope by return
in my_cleanup(2)
after leaving scope by break
after leaving scope by longjmp
before leaving scope by exit

I don't know if there is a way to make gcc insert stack-unwind
directives that are honored across longjmp (I know C++ does it for
exceptions; so there may be a way, and I just don't know it).
Conversely, I do know that pthread_cleanup_push/pop, which does
something similar, is permitted by POSIX to NOT work across longjmp:

       Calling longjmp(3) (siglongjmp(3)) produces undefined  results
if  any
       call  has  been made to pthread_cleanup_push() or
pthread_cleanup_pop()
       without the matching call of the pair since the jump buffer was
filled
       by   setjmp(3)  (sigsetjmp(3)).   Likewise,  calling  longjmp(3)
(sig=E2=80=90
       longjmp(3)) from inside a clean-up handler produces  undefined
results
       unless  the  jump  buffer  was  also filled by setjmp(3)
(sigsetjmp(3))
       inside the handler.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--d3c6O3kBeXOJh4IaG9CHhhDg6WtpFVJQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloukiAACgkQp6FrSiUn
Q2qLMQf+OYlTJPCtrXtGJ+xE5WebYwEJMWNTmR3jCGi8bM74aypOhJ+Z82uAsAFw
bFnIQmfW0MKjLeNN3Pr9z85/yXQZ/sg0j0WdX5CfJGHqhWRkTSPzeCnrqDDzX8qz
D5tlcP28zoUuw/C2xDeuIHqn/OeTpik0iL3fkDb+hurPYCs5ZlTu3hUMUicpFCGy
vSxMLqNWQIkKA/ehK5f1sjLpJRLKwkIfgjkHEPfPgx7KZ9VLoUoA3mZzh7waV5ly
BpXsTn8bVXwM3Lh6c8FISwdQm+x9GyH+zJuAbCB3Z2j7iIv8MQLLUpROoyi/LIbX
fBAYvm+zMQCy4QfQc5F97ugYgDyMXw==
=pJOq
-----END PGP SIGNATURE-----

--d3c6O3kBeXOJh4IaG9CHhhDg6WtpFVJQ7--
