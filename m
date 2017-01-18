Received: from eggs.gnu.org ([2001:4830:134:3::10]:48984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTtLd-0002TT-B3
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTtLa-00023u-1A
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:44:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTtLZ-00023E-Ov
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:44:29 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5A1D7CC30
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:44:29 +0000 (UTC)
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-11-pbonzini@redhat.com>
	<20170118154310.GK30347@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab2a2b6d-9796-d0e2-0d95-4eefa9c8ce36@redhat.com>
Date: Wed, 18 Jan 2017 17:44:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170118154310.GK30347@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="96JVqeu7LXjtEW9cs6XmWi8xR13TSahiJ"
Subject: Re: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext
 in timers that need it
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
--96JVqeu7LXjtEW9cs6XmWi8xR13TSahiJ
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
Message-ID: <ab2a2b6d-9796-d0e2-0d95-4eefa9c8ce36@redhat.com>
Subject: Re: [PATCH 10/16] block: explicitly acquire aiocontext in timers that
 need it
References: <20170113131731.1246-1-pbonzini@redhat.com>
 <20170113131731.1246-11-pbonzini@redhat.com>
 <20170118154310.GK30347@stefanha-x1.localdomain>
In-Reply-To: <20170118154310.GK30347@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/01/2017 16:43, Stefan Hajnoczi wrote:
> On Fri, Jan 13, 2017 at 02:17:25PM +0100, Paolo Bonzini wrote:
>> diff --git a/block/null.c b/block/null.c
>> index b300390..356209a 100644
>> --- a/block/null.c
>> +++ b/block/null.c
>> @@ -141,7 +141,11 @@ static void null_bh_cb(void *opaque)
>>  static void null_timer_cb(void *opaque)
>>  {
>>      NullAIOCB *acb =3D opaque;
>> +    AioContext *ctx =3D bdrv_get_aio_context(acb->common.bs);
>> +
>> +    aio_context_acquire(ctx);
>>      acb->common.cb(acb->common.opaque, 0);
>> +    aio_context_release(ctx);
>>      timer_deinit(&acb->timer);
>>      qemu_aio_unref(acb);
>=20
> Is qemu_aio_unref() thread-safe?

qemu_aio_ref()/qemu_aio_unref() is only used by bdrv_aio_cancel, which
in turn is not used by dataplane.  So in the multithreaded case
qemu_aio_unref() is effectively qemu_aio_free().

Probably needs more documentation, or a different implementation of
bdrv_aio_cancel (e.g. replacing the reference counting with a
NotifierList of some kind).  Let me know what you prefer for v2.

Paolo


--96JVqeu7LXjtEW9cs6XmWi8xR13TSahiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYf5toAAoJEL/70l94x66DvtgH/3NKxlyoN9nwXyBOChm1dbDv
uEesSBmqWJHiTkoktMcQwBDOOPvxm51sh7ujqEXOpwtfGOCrA67krjJfDUlaCHlN
pmulPiEgJ5WIdBafTm7kTkBxiPy4qm4DEPHxPiCW5ZV/NI9HJLYTljlIV3dIWrBo
B5s8B+eBOT0DrtA0dReuAW9GyKfIy2LzgGBw8ZFFrLU6z0dZVzZPfmh15+Tlv/AO
RzyQYWDym02sUrrG4Z+oKLeu1UPTICuw7eKR+S4Rkm/AlHlcmD1Yd7oDqdAa/J1K
3vrkkbU3DNxzGFxo3DmTNS3wijk1fXAqEW2W4Y3y5s+PSO42rJIATk96IjIhVbc=
=/4aj
-----END PGP SIGNATURE-----

--96JVqeu7LXjtEW9cs6XmWi8xR13TSahiJ--
