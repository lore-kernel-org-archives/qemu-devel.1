Received: from eggs.gnu.org ([2001:4830:134:3::10]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5CO-0001Az-Ju
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5CN-0008HM-6o
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:09:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1df5CM-0008Gc-T5
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBD1B806C1
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 14:09:29 +0000 (UTC)
References: <1502175607-9531-1-git-send-email-peterx@redhat.com>
	<3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
	<20170808074915.GB13486@pxdev.xzpeter.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a4a3fd1-51d2-3bcb-a343-9acb87a19d99@redhat.com>
Date: Tue, 8 Aug 2017 09:09:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170808074915.GB13486@pxdev.xzpeter.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WcaQbU9AWKQ7wf6a29fmwjQmKSsh54kwp"
Subject: Re: [Qemu-devel] [PATCH for-2.11] rcu: init globals only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WcaQbU9AWKQ7wf6a29fmwjQmKSsh54kwp
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <6a4a3fd1-51d2-3bcb-a343-9acb87a19d99@redhat.com>
Subject: Re: [PATCH for-2.11] rcu: init globals only once
References: <1502175607-9531-1-git-send-email-peterx@redhat.com>
 <3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
 <20170808074915.GB13486@pxdev.xzpeter.org>
In-Reply-To: <20170808074915.GB13486@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 02:49 AM, Peter Xu wrote:
>> This doesn't work for error-checking mutexes: rcu_init_child has a
>> different PID than the parent, so the mutexes aren't unlocked.  It's
>> also true that right now we don't use error-checking mutexes (commit
>> 24fa90499f, "qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK",
>> 2015-03-10); however, that's also a bit sad.
>>
>> The reason for the undefined behavior is probably that some operating
>> systems allocate memory in pthread_mutex_init, and initializing twice
>> causes a memory leak.  One such operating system is OpenBSD. :(
>=20
> Good to know. :)
>=20
> I thought pthread_atfork() was designed to solve such a locking
> problem (in child hanlder, we unlock all the held locks).

What's also sad is that POSIX says that pthread_atfork() is rather
useless - there's no way it can be reliably used to do everything that
everyone wants (and I think this case of error-checking mutexes is just
ONE of those reasons).

> If
> PTHREAD_MUTEX_ERRORCHECK cannot coop well with it, not sure whether
> that means we should just avoid using PTHREAD_MUTEX_ERRORCHECK in such
> a use case (but we should be able to use the error checks in other
> mutexes that do not need extra fork handling)?
>=20
> Another idea is: can we just destroy the mutex first then re-init it
> in subprocess? A quick glance in libpthread code shows that at least
> pthread_mutex_destroy() won't check PTHREAD_MUTEX_ERRORCHECK.
>=20
> Thanks,
>=20
>>
>> Eric, you chimed in on the patch that became commit 24fa90499f, what d=
o
>> you suggest?

If, after forking, you can successfully destroy the mutex to then
reinitialize it (even though you can't unlock it), then that sounds as
good as anything I can come up with.

An alternative approach might be to add a new mutex that anyone obtains
just before forking; as long as you hold that mutex, you can then
release any other mutex, fork, and then reobtain in the parent - but it
still becomes tricky bookkeeping to know which locks need to be dropped
and reobtained, and I worry that gating fork performance with such a
heavy lock will have noticeable slowdowns.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WcaQbU9AWKQ7wf6a29fmwjQmKSsh54kwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJxhMACgkQp6FrSiUn
Q2rgWggAn7wygBQt1sXOv46ErmwlMI4EVjYeZnF3Qyd4XnVciDPmklJz9e3LF6wz
9jVmm6wKmFTjMPfJvlCdULifiAPUUychXvhmw9PzUP5XXuTDKTON20ce0/bTOQ2A
lCS4ezXRAbJ+r1Pqus4PH8ZHPIJBUjw3gjz2RcJp3UEEL3BfSxQZYuRKAjTOc7EU
nFmsaB03xNC5dFN3+UgV/p9fKmMIPo1FvhVlwU1t/HU0125kSbH7ywa1AVQ2lJlj
WCsUE/pce4BuNEqPa7rDd3ozok213nyinhkplM6J/htYCHBNs1H24/iTiGnnnqgX
oZbwnISZMv2CNj7nOAUBm77Psngtyw==
=Ifr1
-----END PGP SIGNATURE-----

--WcaQbU9AWKQ7wf6a29fmwjQmKSsh54kwp--
