Received: from eggs.gnu.org ([2001:4830:134:3::10]:40997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCUOv-000568-Fu
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCUOq-0004Tf-Go
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:44:33 -0500
References: <20171107223708.17935-1-eblake@redhat.com>
	<20171108154226.GC6118@stefanha-x1.localdomain>
	<462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
	<061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
	<20171108173621.GB8403@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9cee36dc-1e2a-c459-2748-ba8b2a1466e8@redhat.com>
Date: Wed, 8 Nov 2017 18:44:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171108173621.GB8403@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hebPesP0tI7RGqGHGRgKR3fQbk9hvC8qF"
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hebPesP0tI7RGqGHGRgKR3fQbk9hvC8qF
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-trivial@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9cee36dc-1e2a-c459-2748-ba8b2a1466e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
References: <20171107223708.17935-1-eblake@redhat.com>
 <20171108154226.GC6118@stefanha-x1.localdomain>
 <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
 <061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
 <20171108173621.GB8403@stefanha-x1.localdomain>
In-Reply-To: <20171108173621.GB8403@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 18:36, Stefan Hajnoczi wrote:
> On Wed, Nov 08, 2017 at 09:57:47AM -0600, Eric Blake wrote:
>> On 11/08/2017 09:47 AM, Paolo Bonzini wrote:
>>> On 08/11/2017 16:42, Stefan Hajnoczi wrote:
>>>>> In any case, co_aio_sleep_ns()
>>>>> + * does not affect the #AioContext where the current coroutine is =
running,
>>>>> + * as the coroutine will restart on the same #AioContext that it i=
s
>>>>> + * running on.
>>>> I cannot parse the second sentence.  What does "affecting" an AioCon=
text
>>>> mean?  Does "where the current coroutine is running" simply mean "th=
e
>>>> caller"?
>>>>
>>>> What is it trying to say?  My guess is: the caller will be resumed i=
n
>>>> the current AioContext, not the timer's AioContext.
>>>
>>> Yes, that is the intended meaning.  Perhaps just s/current//.
>>
>> How about:
>>
>> This function uses timers and hence needs to know the event loop
>> (#AioContext) to place the timer on.  After the time elapses, the
>> current coroutine will restart with the same #AioContext it is current=
ly
>> running in, even if that is different than the timer context passed to=

>> co_aio_sleep_ns().
>=20
> These complicated semantics are a clue that the API should be
> simplified.  QEMU has changed since this function was first introduced.=

> Now we can do the following:
>=20
>   void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
>   {
>       AioContext *ctx =3D qemu_get_current_aio_context();
>       CoSleepCB sleep_cb =3D {
>           .co =3D qemu_coroutine_self(),
>       };
>       sleep_cb.ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &=
sleep_cb);
>       timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
>       qemu_coroutine_yield();
>       timer_del(sleep_cb.ts);
>       timer_free(sleep_cb.ts);
>   }
>=20
> I don't see a reason for the caller to pass in an AioContext.

That should work, yes.

Paolo

>=20
> Any objections?  Will send a patch if this is okay.
>=20
> Stefan
>=20



--hebPesP0tI7RGqGHGRgKR3fQbk9hvC8qF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloDQmkACgkQv/vSX3jH
roNGCgf8C05DLd0tEvhz7mKbo1n1q99RCD4Po7/1JGVnMU421YvNnRsDOrJABaR3
7PNV4WvvOaxTatPL9kAtwkGgOOg2NgkNjt7lxeLB2YNPzrq7y4ul1ycfQ5YdCe7l
XRpRU2b857N0t4wAwFgkDF/Px/9+rh3nov733tw3h8Qpl8EuRy2L2NMRDUgl2Hih
sp2Ko726TeFjv6B/0dUx6ev++XyYQaB8O4z60ad+E9ImgRExF3g49vJC5br9Dbi3
2NGn/4Qcj2Rqs0wOWmV3uNLShoK1ZIcH5VnPGvH60DKfTJAxXNipjoZacnjPKdKK
d5pjggmFsv8/MJmmCYLNmItnYLfQNg==
=UXfe
-----END PGP SIGNATURE-----

--hebPesP0tI7RGqGHGRgKR3fQbk9hvC8qF--
