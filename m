Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkw9O-0000Pd-KL
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkw9N-00071Z-L3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:42:38 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-2-stefanha@redhat.com>
	<a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
	<12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26fee110-ce53-6c54-275c-5550dab6d3c4@redhat.com>
Date: Thu, 24 Aug 2017 19:42:20 +0200
MIME-Version: 1.0
In-Reply-To: <12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WQd7Nmb0794R7fVlqewd0rEEKmfAlxArs"
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WQd7Nmb0794R7fVlqewd0rEEKmfAlxArs
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <26fee110-ce53-6c54-275c-5550dab6d3c4@redhat.com>
Subject: Re: [PATCH 1/3] nbd-client: enter read_reply_co during init to avoid
 crash
References: <20170824153345.2244-1-stefanha@redhat.com>
 <20170824153345.2244-2-stefanha@redhat.com>
 <a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
 <12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
In-Reply-To: <12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/08/2017 19:37, Eric Blake wrote:
> On 08/24/2017 11:21 AM, Paolo Bonzini wrote:
>> On 24/08/2017 17:33, Stefan Hajnoczi wrote:
>>> This patch enters read_reply_co directly in
>>> nbd_client_attach_aio_context().  This is safe because new_context is=

>>> acquired by the caller.  This ensures that read_reply_co reaches its
>>> first yield point and its ctx is set up.
>>
>> I'm not very confident with this patch.  aio_context_acquire/release i=
s
>> going to go away, and this then becomes possible
>>
>> 	main context			new_context
>> 	qemu_aio_coroutine_enter
>> 					send request
>> 					wait for reply
>> 	read first reply
>> 	wake coroutine
>>
>> where the "wake coroutine" part thinks it's running in new_context, an=
d
>> thus simply enters the coroutine instead of using the bottom half.
>>
>> But blk_co_preadv() should need the read_reply_co itself, in order to =
be
>> woken up after reading the reply header.  The core issue here is that
>> nbd_co_receive_reply was never called, I suspect.  And if it was never=

>> called, read_reply_co should not be woken up by nbd_coroutine_end.
>>
>> So the fix is:
>>
>> 1) assign NULL to s->recv_coroutine[i] when nbd_co_send_request fails
>>
>> 2) move this to nbd_co_receive_reply:
>>
>>     s->recv_coroutine[i] =3D NULL;
>>
>>     /* Kick the read_reply_co to get the next reply.  */
>>     if (s->read_reply_co) {
>>         aio_co_wake(s->read_reply_co);
>>     }
>>
>> Does this make sense?  (Note that the read_reply_co idea actually came=

>> from you, or from my recollections of your proposed design :)).
>=20
> How much of this overlaps with Vladimir's proposal?
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00846.html

The above should be about 15 lines added, 10 removed. :)

Paolo



--WQd7Nmb0794R7fVlqewd0rEEKmfAlxArs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmfD/wACgkQv/vSX3jH
roOXqwgAhUkGPu/znKnjDmnTqK5JfUo7YBRRsKESFhawDuTWaqTmIiMTx2FMdwJC
/HiTgdgrSyzg+uxMiaElnt8VF/Ai87XplrZfe1lE2d+fcVpLs0gRrxAyjOD1K9gd
SHjXSCJ/0anB8ESlpogdoUYfz8OPCfPP9ZSjUjtmU+rtIfrTb5k+nkP9Wmqn4RB5
9m6UaSv+QwuIsRi2enPOsvtuDKYoVXuppKWodVOZzG4rKxWiHMyJwcdvr4OM2dp1
aM5WpwjZsTFyI1oL4BwzveaAqyJuUT83XWKC862PSt44JhSwqKY+pd0UFITqxvSd
P6ybt2Ic4i0l03Jgy5vGgJW7/wL3iw==
=YSif
-----END PGP SIGNATURE-----

--WQd7Nmb0794R7fVlqewd0rEEKmfAlxArs--
