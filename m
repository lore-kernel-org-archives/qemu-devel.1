Received: from eggs.gnu.org ([2001:4830:134:3::10]:44803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT62b-0006Tk-7a
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT62a-0008FW-Co
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dT62a-0008FB-2i
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:37:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40A0E7C846
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 12:37:50 +0000 (UTC)
References: <20170704122325.25634-1-famz@redhat.com>
	<93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <866192b5-3f74-d3ce-33c0-cd7563d35fc9@redhat.com>
Date: Thu, 6 Jul 2017 14:37:38 +0200
MIME-Version: 1.0
In-Reply-To: <93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dB2tJBuh1w7nfS9m08o8VmC511aqIx9P3"
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dB2tJBuh1w7nfS9m08o8VmC511aqIx9P3
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <866192b5-3f74-d3ce-33c0-cd7563d35fc9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-thread: Assert locks are initialized
 before using
References: <20170704122325.25634-1-famz@redhat.com>
 <93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
In-Reply-To: <93dea10b-83f9-db95-107b-9da8cff3baa9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/07/2017 14:16, Eric Blake wrote:
> On 07/04/2017 07:23 AM, Fam Zheng wrote:
>> Not all platforms check whether a lock is initialized before used.  In=

>> particular Linux seems to be more permissive than OSX.
>>
>> Check initialization state explicitly in our code to catch such bugs
>> earlier.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  include/qemu/thread-posix.h |  4 ++++
>>  include/qemu/thread-win32.h |  5 +++++
>>  util/qemu-thread-posix.c    | 27 +++++++++++++++++++++++++++
>>  util/qemu-thread-win32.c    | 34 +++++++++++++++++++++++++++++++++-
>>  4 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h=

>> index 09d1e15..e5e3a0f 100644
>> --- a/include/qemu/thread-posix.h
>> +++ b/include/qemu/thread-posix.h
>> @@ -12,10 +12,12 @@ typedef QemuMutex QemuRecMutex;
>> =20
>>  struct QemuMutex {
>>      pthread_mutex_t lock;
>> +    bool initialized;
>>  };
>=20
> Are we worried about an object living on the stack and inheriting bit
> values that make the object already appear initialized?  Would a magic
> number a little less likely than '1' reduce the risk of inherited stack=

> garbage throwing us off?

It depends on whether the compiler handles a non-1, nonzero value as
true or false.  If it counts as true, using an uint32_t with a magic
value (0xacce55ed? ;)) would not be fooled by MALLOC_PERTURB_.  This
would be nice.

>> @@ -58,6 +61,7 @@ void qemu_mutex_lock(QemuMutex *mutex)
>>  {
>>      int err;
>> =20
>> +    assert(mutex->initialized);
>>      err =3D pthread_mutex_lock(&mutex->lock);
>>      if (err)
>>          error_exit(err, __func__);
>=20
> Are we sure this isn't going to penalize our code speed, by adding a
> conditional on every lock/unlock?

It should be well predicted, but if it comes up in profiles we can make
it conditional on release versions (or maybe you should use a spinlock
instead).

Paolo


--dB2tJBuh1w7nfS9m08o8VmC511aqIx9P3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlleLxUACgkQv/vSX3jH
roOrRggAorw6aeK+1BjMLQ5Lb2wLMwPJPIPv1hS2eald9adjKDRPWHaG/D51CmZl
13sUV+JMdtu8cV0sexz8MqsJbt3V9DR4xlYlY52TTGlKDLwxgphWPigJKBtxlMl/
yPh2G64dKpNjGPIgL3oVODMEWFW2YESFHfxMWLrk71fJKS8PalCrIOCyBgxISpGL
4S/NMH6hcTq0EbPnxqjALqd7490Aw0Jo9RKYooU/5C64STrtUNoX607AnkkOmDGJ
EqEY+IjSL7ory6J+7KqEmt17ipcushiX3tGTIairsxFPUyl+cRGXP1c46Cbm+wK5
Y0ne5QDqWmHnPQPC8D/fm+UfW6n1ew==
=/1YU
-----END PGP SIGNATURE-----

--dB2tJBuh1w7nfS9m08o8VmC511aqIx9P3--
