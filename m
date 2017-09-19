Received: from eggs.gnu.org ([2001:4830:134:3::10]:42159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duQNt-0002eZ-89
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duQNp-00036A-Bg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duQNp-00035g-2X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:48:45 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-8-git-send-email-peterx@redhat.com>
	<5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd2bfb4d-2899-fad1-00a0-ffb833588618@redhat.com>
Date: Tue, 19 Sep 2017 16:48:35 -0500
MIME-Version: 1.0
In-Reply-To: <5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="goeLLfjMWXDnDLQ2uB5feWBwaHb9D0jNA"
Subject: Re: [Qemu-devel] [RFC 07/15] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Stefan Hajnoczi <shajnocz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--goeLLfjMWXDnDLQ2uB5feWBwaHb9D0jNA
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 mdroth@linux.vnet.ibm.com, Stefan Hajnoczi <shajnocz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <dd2bfb4d-2899-fad1-00a0-ffb833588618@redhat.com>
Subject: Re: [Qemu-devel] [RFC 07/15] monitor: unify global init
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-8-git-send-email-peterx@redhat.com>
 <5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
In-Reply-To: <5c8217a4-c169-c580-f461-e7173a772e31@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 04:35 PM, Eric Blake wrote:
> On 09/14/2017 02:50 AM, Peter Xu wrote:
>> There are many places for monitor init its globals, at least:
>>

> Are we sure that this new function is called sooner than any access to
> monitor_lock,
>=20
>> -static void __attribute__((constructor)) monitor_lock_init(void)
>> -{
>> -    qemu_mutex_init(&monitor_lock);
>> -}
>=20
> especially since the old code initialized the lock REALLY early?

(Partially) answering myself:

>=20
> Pre-patch, a breakpoint on main() and on monitor_lock_init() fires on
> monitor_lock_init() first, prior to main.
>=20
> Breakpoint 2, monitor_lock_init () at /home/eblake/qemu/monitor.c:4089
> 4089	    qemu_mutex_init(&monitor_lock);
> (gdb) c
> Continuing.
> [New Thread 0x7fffce225700 (LWP 26380)]
>=20
> Thread 1 "qemu-system-x86" hit Breakpoint 1, main (argc=3D5,
>     argv=3D0x7fffffffdc88, envp=3D0x7fffffffdcb8) at vl.c:3077
> 3077	{

Also, pre-patch, 'watch monitor_lock.initialized' and 'watch
monitor_lock.lock.__data.__lock' show that the lock is first utilized at:=


(gdb) bt
#0  0x00007fffdac59e12 in __GI___pthread_mutex_lock
(mutex=3D0x555556399340 <monitor_lock>) at ../nptl/pthread_mutex_lock.c:8=
0
#1  0x0000555555ce01ed in qemu_mutex_lock (mutex=3D0x555556399340
<monitor_lock>)
    at util/qemu-thread-posix.c:65
#2  0x00005555557bc8b8 in monitor_init (chr=3D0x55555690bf70, flags=3D4)
    at /home/eblake/qemu/monitor.c:4126
#3  0x000055555591ae80 in mon_init_func (opaque=3D0x0,
opts=3D0x55555688e3d0, errp=3D0x0) at vl.c:2482
#4  0x0000555555cf3e63 in qemu_opts_foreach (list=3D0x555556225200
<qemu_mon_opts>, func=3D0x55555591ad33 <mon_init_func>, opaque=3D0x0, err=
p=3D0x0)
    at util/qemu-option.c:1104
#5  0x0000555555920128 in main (argc=3D5, argv=3D0x7fffffffdc88,
envp=3D0x7fffffffdcb8) at vl.c:4670

and double-checking qemu_mutex_lock, our .initialized member provides
NICE runtime checking that we don't use an uninitialized lock.  So the
fact that your patch doesn't assert means your later initialization is
still fine.

[TIL: the gdb 'watch' command is cool, but it's better if you watch only
4 or 8 bytes at a time; I first tried 'watch monitor_lock', but that's
hundreds of times slower as hardware can't watch that much data at once,
at which point gdb emulates it by single-stepping the entire program]

>=20
> Post-patch, the mutex is not initialized until well after main().  So
> the real question is what (if anything) is using the lock in between
> those two points?

According to gdb watchpoints, no.

>=20
> Hmm - it may be that we needed it back before commit 05875687, when we
> really did depend on MODULE_INIT_QAPI, but it is something we forgot to=

> cleanup in the meantime?

So what I didn't debug was whether the constructor attribute was
mandatory in the past, and if so, which commit made it no longer
mandatory (my mention of commit 05875687 is only a guess).

>=20
> If nothing else, the commit message should call out that dropping
> __attribute__((constructor)) nonsense is intentional (if it was indeed
> nonsense).
>=20

This part is still true.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--goeLLfjMWXDnDLQ2uB5feWBwaHb9D0jNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBkLMACgkQp6FrSiUn
Q2ps7AgAm6uOdTqsyAHJ0MYbHubisKKLGeHaXZ3vjydmO1hhp4oVNfso2ygNQDmu
hRIW9NEeEVDLXSw3V16cFOBSTMLTDQ8TenSgPukclc2q41XcLN7wxtngcdMpe0m+
LahHeqD2/in2FPT7QWiwLOhub9ALMt3d8XYIdfPZpRPNsP2IlvqBMZanCTkPBO71
AsX9PKCwNoCU6ZfwcNqZ/eYxfhHZqPl6M3h4hvZ8XAplhYvd4VsHjjJ+La1qLejD
02j66t5t7z/9aN/6pCsNS/VgTB4QAp45rhhSH/HdD8gVz095zcGbXV0eJLGb7EvB
ihgh6yq/Z5P0BEj7W1Xx6MHpgzGq9w==
=kbpc
-----END PGP SIGNATURE-----

--goeLLfjMWXDnDLQ2uB5feWBwaHb9D0jNA--
