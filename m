Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1g9tXr-0001xc-13
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1g9tXm-0000Za-16
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:03:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:36635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1g9tXi-0000Ux-NI
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:03:27 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
Date: Tue, 9 Oct 2018 17:04:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lue5N0xLzA3GSOaXCXeM5lV9MKheidkvU"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lue5N0xLzA3GSOaXCXeM5lV9MKheidkvU
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>
Message-ID: <933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
References: <20181007153731.GA32288@humpty.home.comstyle.com>
 <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
 <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
In-Reply-To: <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.10.2018 16:12, Peter Maydell wrote:
> On 9 October 2018 at 14:52, Kamil Rytarowski <n54@gmx.com> wrote:
>> On 07.10.2018 17:37, Brad Smith wrote:
>>> Use MAP_STACK in qemu_alloc_stack() on OpenBSD.
>>>
>>> Added to -current and will be in our soon to be 6.4 release.
>>>
>>> MAP_STACK      Indicate that the mapping is used as a stack.  This
>>>                flag must be used in combination with MAP_ANON and
>>>                MAP_PRIVATE.
>>>
>>> Implement MAP_STACK option for mmap().  Synchronous faults (pagefault=
 and
>>> syscall) confirm the stack register points at MAP_STACK memory, other=
wise
>>> SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are m=
odified
>>> to create a MAP_STACK sub-region which satisfies alignment requiremen=
ts.
>>> Observe that MAP_STACK can only be set/cleared by mmap(), which zeroe=
s the
>>> contents of the region -- there is no mprotect() equivalent operation=
, so
>>> there is no MAP_STACK-adding gadget.
>>>
>>>
>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>>
>>>
>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>> index fbd0dc8c57..51e9a012c2 100644
>>> --- a/util/oslib-posix.c
>>> +++ b/util/oslib-posix.c
>>> @@ -611,7 +611,11 @@ void *qemu_alloc_stack(size_t *sz)
>>>      *sz +=3D pagesz;
>>>
>>>      ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE,
>>> -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> +               MAP_PRIVATE | MAP_ANONYMOUS
>>> +#ifdef MAP_STACK
>>> +               | MAP_STACK
>>> +#endif
>>> +               , -1, 0);
>>>      if (ptr =3D=3D MAP_FAILED) {
>>>          perror("failed to allocate memory for stack");
>>>          abort();
>>>
>>
>> Can we handle it differently, storing MAP_* flags in a variable:
>>
>> int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
>> #ifdef MAP_STACK
>> flags |=3D MAP_STACK;
>> #endif
>>
>> ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
>>
>> This way it will look nicer as we won't ifdef the middle of a function=
 call.
>=20
> The other nice way to handle that is to have osdep.h do
> #ifndef MAP_STACK
> #define MAP_STACK 0
> #endif
> and then you can just unconditionally use MAP_STACK in your
> expression for the mmap flags.
>=20

I assume that this is a cleaner solution.

>=20
> I note that Linux also defines a MAP_STACK, about which the
> manpage says:
>        MAP_STACK (since Linux 2.6.27)
>               Allocate the mapping at an address suitable for a
> process or thread  stack.
>               This  flag  is currently a no-op, but is used in the
> glibc threading imple=E2=80=90
>               mentation so that if some architectures require special
> treatment for stack
>               allocations, support can later be transparently
> implemented for glibc.
>=20
> So this patch would be opting Linux QEMU builds into whatever that
> potential future behaviour change is. That sounds I guess like
> it's more likely to be the right thing than the wrong thing,
> but it would be useful if some Linux expert could confirm...
>=20
> thanks
> -- PMM
>=20

There is a similar description on NetBSD:

MAP_STACK

Allocate a memory segment that can be used
either for a process or thread stack.  This
currently has no effect, but its use is
reserved for architectures that might require
special treatment of that address space.
Unimplemented.

Apparently OpenBSD started to overload it for some hardening.


--lue5N0xLzA3GSOaXCXeM5lV9MKheidkvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlu8w3sMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsJqwQAL/qcVmqn6Ok9WvyMZpMC1nMtmE+sd5B6k+ii3xA
5P1jCmyJmLH20a1lbwV/K6nWpqvKGI03JFuB2/hHhUbp4YJElk9ywnbqxJBEQb0Q
omdsFPLRSoI89jSlX+lrGCcBAG8TwAypw9wQqC/cf9ZKm2g2rw93Faqzm/Xw0vSc
xQiKXC20AE4ElUXl8E09b003uEgArNi8FYV1nI4KaJPvAL+bA7phv4hPqTKWmusb
5MrorEhl9omGc+UPXJBCqbwtPIsGTMhcYFzdzfyyfc3lvZq3WTWvoX6ul2rmxvjf
haTVLyIhL7h1/7xKSVl69XQBsiqYpU540w2aV0ZKYIn0rgDWm5WAIn83tLzK0Eok
FNxJwDJpr04SJ1GWwMw8d390J4jUtkKXYxfM0VYbmxTb/mUPWBGscByy5RrffqhK
X5GVBzgRp9WqqRklIh0l8UXUlNHXkWmOhxjXhtP3lPSqgkcKk+DLThdGPwl/LPIr
HyLJ00MENfYk5Dx5jcdl4zFNJD4ryWD/Wthz225o6t6metFu7bduEQBLQMaZqwjd
3ym809qeA0NzbhKJ7OxHHl8KKO8i2jQwcxTcHTHvnUUpul1SEO0eksNP5z1iMhke
4oz9lAr8LspW7O8YPzQnYbME4R3d1sqayRouV8Y5sDkNfQu41Ff8xftJfqjzBNf0
3V8g
=9iTT
-----END PGP SIGNATURE-----

--lue5N0xLzA3GSOaXCXeM5lV9MKheidkvU--
