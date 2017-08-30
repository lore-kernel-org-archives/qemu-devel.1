Received: from eggs.gnu.org ([2001:4830:134:3::10]:58080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn4eQ-0003MV-St
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn4eN-0000if-Ef
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:11:30 -0400
Date: Wed, 30 Aug 2017 17:11:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170830171120.190439f5.cohuck@redhat.com>
In-Reply-To: <52928093-36d5-89cf-bb89-ab5abf54b8f0@redhat.com>
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
	<b98a4c56-f386-f827-5aa7-9a00e6fdf790@amsat.org>
	<52928093-36d5-89cf-bb89-ab5abf54b8f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 30 Aug 2017 16:59:03 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 30.08.2017 16:53, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 08/30/2017 10:39 AM, Thomas Huth wrote: =20
> >> The "slow" ivshmem-tests currently fail when they are running on a
> >> big endian host:
> >>
> >> $ uname -m
> >> ppc64
> >> $ V=3D1 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
> >> tests/ivshmem-test -m slow
> >> /x86_64/ivshmem/single: OK
> >> /x86_64/ivshmem/hotplug: OK
> >> /x86_64/ivshmem/memdev: OK
> >> /x86_64/ivshmem/pair: OK
> >> /x86_64/ivshmem/server-msi: qemu-system-x86_64:
> >> =C2=A0 -device ivshmem-doorbell,chardev=3Dchr0,vectors=3D2: server sen=
t invalid
> >> ID message
> >> Broken pipe
> >>
> >> The problem is that the server side code in ivshmem_server_send_one_ms=
g()
> >> correctly translates all messages IDs into little endian 64-bit values,
> >> but the client side code in the ivshmem_recv_msg() function does not s=
wap
> >> the byte order back. Fix it by passing the value through le64_to_cpu()=
. =20
> >=20
> > Yes, we lack BE testing :( =20
>=20
> As far as I know, some people are already running the tests on s390x and
> ppc64 ... the problem is that apparently nobody is running with
> SPEED=3Dslow there - that's why this problem slipped through so far.
> Maybe we should switch to the SPEED=3Dslow by default in the Makefile?

Not sure whether that is a good idea. /me adding this to my s390x tests
should help, though.
