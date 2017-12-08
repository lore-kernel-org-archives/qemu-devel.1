Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOr8-0001W2-95
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOr3-0006fN-O3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:02:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNOr3-0006dF-E7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:02:41 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
	<20171208151306.GC8998@stefanha-x1.localdomain>
	<9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a53f2cc7-9da4-bd8e-4d0b-bb3c32c9d4a9@redhat.com>
Date: Fri, 8 Dec 2017 14:02:32 -0600
MIME-Version: 1.0
In-Reply-To: <9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cjLTpkqbJC29po50j3sdjR5pTiEdx0Jns"
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cjLTpkqbJC29po50j3sdjR5pTiEdx0Jns
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <a53f2cc7-9da4-bd8e-4d0b-bb3c32c9d4a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <20171208105553.12249-6-pbonzini@redhat.com>
 <20171208151306.GC8998@stefanha-x1.localdomain>
 <9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
In-Reply-To: <9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 12:12 PM, Paolo Bonzini wrote:
> On 08/12/2017 16:13, Stefan Hajnoczi wrote:
>>> -    qemu_mutex_lock(&pool->lock);
>>> +    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
>>>      if (pool->idle_threads =3D=3D 0 && pool->cur_threads < pool->max=
_threads) {
>>>          spawn_thread(pool);
>>>      }
>>>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
>>> -    qemu_mutex_unlock(&pool->lock);
>>> +    qemu_lock_guard_unlock(&pool_guard);
>> Why not QEMU_WITH_LOCK()?  Then you can get rid of the explicit unlock=
=2E
>=20
> I agree that QEMU_WITH_LOCK_GUARD is better in this case. (IIRC I wrote=

> this patch before coming up with the is_taken trick!).
>=20
> My main question for the series is what you think the balance should be=

> between a more widely applicable API and a simpler one.

If you require the user to provide the scope, this could be:

@@ -258,12 +254,12 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPool *pool=
,

     trace_thread_pool_submit(pool, req, arg);

-    qemu_mutex_lock(&pool->lock);
-    if (pool->idle_threads =3D=3D 0 && pool->cur_threads < pool->max_thr=
eads) {
-        spawn_thread(pool);
-    QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
+    {
+        QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
+        if (pool->idle_threads =3D=3D 0 && pool->cur_threads <
pool->max_threads) {
+            spawn_thread(pool);
+        }
+        QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
     }
-    qemu_mutex_unlock(&pool->lock);
     qemu_sem_post(&pool->sem);
     return &req->common;
 }

In other words, I don't see what 'QEMU_WITH_LOCK_GUARD() {}' buys us
over '{ QEMU_LOCK_GUARD() }'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cjLTpkqbJC29po50j3sdjR5pTiEdx0Jns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloq79gACgkQp6FrSiUn
Q2puRwf/ZML3ZA3pSPQZf79TR1rZeSmCvBOEfS1Hw2yAXLuJmwJvRdeq70IdwauA
TFMp9CnPwqN3Ls8+qU9p1iaEC3t8IgYAZJcKgR796SiHjht7d5MAa1UJNk6Y1hMK
oJzp9cOzC/bM1/kVS768YBa0jBszxrxvPGnmEjoVpACzpFUbif3YT7y0MpTeXsRC
VFzElAQbUlksayahIO7vfx3yXLFdVp039k0Z/vv+loV2Pt04QaZjfqw3ZkKTTG/d
4rujc6rc48vqAWGggRjBC/wc81URNE6MRFI1UJlyruHMbJPOC8Jeo2n1K23eJrq5
Ibifuh5ptDOmtl/KikwCDyUfNTzlqQ==
=3qJg
-----END PGP SIGNATURE-----

--cjLTpkqbJC29po50j3sdjR5pTiEdx0Jns--
