Received: from eggs.gnu.org ([2001:4830:134:3::10]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTtKl-0001ms-NT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTtKh-0001Yo-PB
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTtKh-0001Xw-H4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:43:35 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87984BE8B9
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:43:35 +0000 (UTC)
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
	<20170118145833.GF30347@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b370689f-e600-bde7-bc42-917fc72585f9@redhat.com>
Date: Wed, 18 Jan 2017 17:43:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170118145833.GF30347@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8RwSw6JSrR4a5RqVPiwKdGD4nP92trNII"
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8RwSw6JSrR4a5RqVPiwKdGD4nP92trNII
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
Message-ID: <b370689f-e600-bde7-bc42-917fc72585f9@redhat.com>
Subject: Re: [PATCH 05/16] io: make qio_channel_yield aware of AioContexts
References: <20170113131731.1246-1-pbonzini@redhat.com>
 <20170113131731.1246-6-pbonzini@redhat.com>
 <20170118145833.GF30347@stefanha-x1.localdomain>
In-Reply-To: <20170118145833.GF30347@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/01/2017 15:58, Stefan Hajnoczi wrote:
> On Fri, Jan 13, 2017 at 02:17:20PM +0100, Paolo Bonzini wrote:
>>  /**
>> + * qio_channel_set_aio_context:
>> + * @ioc: the channel object
>> + * @ctx: the #AioContext to set the handlers on
>> + *
>> + * Request that qio_channel_yield() sets I/O handlers on
>> + * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
>> + * uses QEMU's main thread event loop.
>> + */
>> +void qio_channel_set_aio_context(QIOChannel *ioc,
>> +                                 AioContext *ctx);
>> +
>> +/**
>> + * qio_channel_detach_aio_context:
>> + * @ioc: the channel object
>> + *
>> + * Disable any I/O handlers set by qio_channel_yield().  With the
>> + * help of aio_co_schedule(), this allows moving a coroutine that was=

>> + * paused by qio_channel_yield() to another context.
>> + */
>> +void qio_channel_detach_aio_context(QIOChannel *ioc);
>=20
> The block layer's bdrv_set_aio_context() has different semantics.  It
> invokes .detach()/.attach() callbacks and does AioContext locking so th=
e
> function can be called safely even while the block driver is waiting fo=
r
> events.
>=20
> It's unfortunate to that the block and io channel APIs act differently
> despite having similar names.  Was there a reason to choose different
> semantics?

Hmm, it's true.  I had forgotten that bdrv_set_aio_context exists.

set_aio_context can be called from the block layer attach callback, but
it's not enough alone (you need aio_co_schedule too) so I didn't want to
call the function qio_channel_attach_aio_context.  But maybe it *is* a
better name, I'll go for it in v2.

By the way, v2 will have a better comment on how to use the API:

+ * You can move a #QIOChannel from an #AioContext to another even if
+ * I/O handlers are set for a coroutine.  However, #QIOChannel provides
+ * no synchronization between the calls to qio_channel_yield() and
+ * qio_channel_set_aio_context().
+ *
+ * Therefore you should first call qio_channel_detach_aio_context()
+ * to ensure that the coroutine is not entered concurrently.  Then,
+ * while the coroutine has yielded, call qio_channel_set_aio_context(),
+ * and then aio_co_schedule() to place the coroutine on the new
+ * #AioContext.  The calls to qio_channel_detach_aio_context()
+ * and qio_channel_set_aio_context() should be protected with
+ * aio_context_acquire() and aio_context_release().

The "while the coroutine has yielded" part is currently handled with
aio_context_acquire/aio_context_release (the coroutine cannot run at all
between aio_context_acquire and release).

When they will be gone, some kind of BDRV_POLL_WHILE at the end of
bdrv_detach_aio_context should be enough to ensure that the event loop
is quiescent.

Paolo

>> +
>> +/**
>>   * qio_channel_yield:
>>   * @ioc: the channel object
>>   * @condition: the I/O condition to wait for
>>   *
>> - * Yields execution from the current coroutine until
>> - * the condition indicated by @condition becomes
>> - * available.
>> + * Yields execution from the current coroutine until the condition
>> + * indicated by @condition becomes available.  @condition must
>> + * be either %G_IO_IN or %G_IO_OUT; it cannot contain both.  In
>> + * addition, no two coroutine can be waiting on the same condition
>=20
> s/coroutine/coroutines/
>=20


--8RwSw6JSrR4a5RqVPiwKdGD4nP92trNII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYf5sxAAoJEL/70l94x66DaooH/RFJcHTjbScCVxEtp6IKQ3rj
YlG8NPzLJJC5NWO0FX2ajjfbIRLYIzP793bNaVpUomjgvDptL89xzMXiBDrgB1l7
Ms64U0zfs4rIe5OOGR2sF9O2HWCCAtmP0EfOVYtg67od95Ptd1gB/vrHfwNfgEdX
AoMRcmjo17v3OXbtkgH2JG8uht4xIjPvwZb3fmXI7JoSkWL9+AxQQ3l0XjmxsfXK
Q/w0hmA2yYDW8me0UO1PR3f2VbjdCK122Yt7OZdFc2jmzHQxB6sjdxOh9/aqgO7t
swjCcMA68FLZvd3lYTxhW1Exg6Lspy+oFluJ/oe0w79UYN8lpH7Dl5Pa1C4yw9g=
=0Nrq
-----END PGP SIGNATURE-----

--8RwSw6JSrR4a5RqVPiwKdGD4nP92trNII--
