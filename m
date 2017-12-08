Received: from eggs.gnu.org ([2001:4830:134:3::10]:40631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOfp-0004WU-0I
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOfl-00073E-Tn
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:51:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNOfl-00071y-JS
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:51:01 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
	<20171208151306.GC8998@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0764f51b-05d5-c842-7c1b-0e588be630c2@redhat.com>
Date: Fri, 8 Dec 2017 13:50:52 -0600
MIME-Version: 1.0
In-Reply-To: <20171208151306.GC8998@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ubGAMHXgO3ScnB0Sivur85ApVIMm7pP31"
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ubGAMHXgO3ScnB0Sivur85ApVIMm7pP31
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <0764f51b-05d5-c842-7c1b-0e588be630c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <20171208105553.12249-6-pbonzini@redhat.com>
 <20171208151306.GC8998@stefanha-x1.localdomain>
In-Reply-To: <20171208151306.GC8998@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 09:13 AM, Stefan Hajnoczi wrote:
> On Fri, Dec 08, 2017 at 11:55:53AM +0100, Paolo Bonzini wrote:
>> @@ -88,9 +88,9 @@ static void *worker_thread(void *opaque)
>> =20
>>          do {
>>              pool->idle_threads++;
>> -            qemu_mutex_unlock(&pool->lock);
>> +            qemu_lock_guard_unlock(&pool_guard);
>>              ret =3D qemu_sem_timedwait(&pool->sem, 10000);
>> -            qemu_mutex_lock(&pool->lock);
>> +            qemu_lock_guard_lock(&pool_guard);
>=20
> Or:
>=20
>   QEMU_WITHOUT_LOCK_GUARD(pool_guard) {
>       ret =3D qemu_sem_timedwait(&pool->sem, 10000);
>   }
>=20
> Seems funny but I like it. :)
>=20
> Unfortunately it's tricky to come up with good semantics.  A 'return'
> statement inside QEMU_WITHOUT_LOCK_GUARD() should leave the lock
> unlocked.  But a 'break' statement may need to reacquire the lock...

But isn't that what happens already?

QEMU_WITH_LOCK_GUARD(guard) { // 1
  do {
    QEMU_WITHOUT_LOCK_GUARD(guard) {// 2
      if (cond1) {
        break;
      } else if (cond2) {
        goto endlock;
      } else {
        return;
      }
    } // 3
  } while (cond3);
} // 4
endlock:
  ; // 5

Point 2 introduces a new scope which says to unlock the guard at entry,
and to relock the guard at all exits from the scope.  If cond1 is true,
and we break, control flows to point 3, (because of we provided the
scope via a for loop - so the break exits only the lock guard!), and
relocks the guard, so the bulk of the do/while loop that is not
sub-scoped by the WITHOUT_LOCK_GUARD remains locked.  If cond2 is true,
then we leave the WITHOUT_LOCK_GUARD scope (and temporarily lock the
guard), then immediately leave the WITH_LOCK_GUARD scope (and unlock the
guard again) - the cleanup handlers ensure that unwinding out of
multiple scopes performs all of the proper cleanups, as we skip to point
5.  The same is true if cond2 is false and we return from the function -
the lock is temporarily restored then released.

Or did you want semantics where you can return with the lock still
locked in spite of the outer loop, and/or an optimization to avoid the
contention on temporarily re-locking/unlocking a loop when jumping out
of two nested scopes?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ubGAMHXgO3ScnB0Sivur85ApVIMm7pP31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloq7RwACgkQp6FrSiUn
Q2rrAAf+NAywGAkTEo3XTte5Q1+Bd75PsyUFtDn/xNdrgtddEoRrHCy+FmW2ls95
84kfCUiHIakFiAZBxLjoGBk84oqyOoRc/ak6kXzcZanUsg9e1kgltL2AI+FuI2PX
LTzIXMTlGP2Q0BRnYJm8OtKqA/6uQjWWhz9HlD2+6lfUoeYNAgIZ7kE974UCKppe
ycCefywtAFHZodGArEPZF1ghozxL+pTqicmIzCB9cgs95zcBlv+FUu9mlKDlHZDD
elPY+GcumB9ku6oUl/hGLHhEFstg3Hzy4C7hC/r0ofuCZewVXWBp2Ohvzb6u/pWX
EqS8xIBHb1R4bbUTafSGVtMbAPpt8A==
=I75g
-----END PGP SIGNATURE-----

--ubGAMHXgO3ScnB0Sivur85ApVIMm7pP31--
