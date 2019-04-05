Received: from eggs.gnu.org ([209.51.188.92]:56297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRtt-0007tC-H4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRtm-0003uC-6l
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:41:06 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hCRt6-0002MD-NU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:40:56 -0400
Received: by mail-wm1-f49.google.com with SMTP id 4so7393840wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:40:11 -0700 (PDT)
References: <20190326131822.GD15011@stefanha-x1.localdomain>
	<55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
Date: Fri, 05 Apr 2019 18:33:18 +0200
Message-ID: <877ec8mmy9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] QEMU event loop optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini writes:

> On 26/03/19 14:18, Stefan Hajnoczi wrote:
>> Hi Sergio,
>> Here are the forgotten event loop optimizations I mentioned:
>>=20
>>   https://github.com/stefanha/qemu/commits/event-loop-optimizations
>>=20
>> The goal was to eliminate or reorder syscalls so that useful work (like
>> executing BHs) occurs as soon as possible after an event is detected.
>>=20
>> I remember that these optimizations only shave off a handful of
>> microseconds, so they aren't a huge win.  They do become attractive on
>> fast SSDs with <10us read/write latency.
>>=20
>> These optimizations are aggressive and there is a possibility of
>> introducing regressions.
>>=20
>> If you have time to pick up this work, try benchmarking each commit
>> individually so performance changes are attributed individually.
>> There's no need to send them together in a single patch series, the
>> changes are quite independent.
>
> I reviewed the patches now:
>
> - qemu_bh_schedule_nested should not be necessary since we have=20
> ctx->notify_me to also avoid the event_notifier_set call.  However, it=20
> is possible to avoid the smp_mb at the beginning of aio_notify, since=20=
=20
> atomic_xchg already implies it.  Maybe add a "static void=20
> aio_notify__after_smp_mb"?

try_poll_mode() is called with ctx->notify_me !=3D 0, so we get at least
one event_notifier_set() call while working in polling mode.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyng04ACgkQ9GknjS8M
AjUZvg//TMdHOS1Jgl7VNfIUbkinWzxCi4BFfzIO8hbJO6qHUCvHUKr/bp3DZy3Z
wMEelRuHLDju+MMGAYYKCf2Tird1TlWQ7mPWfENfLWOZ3uslyX0KsKVTzV0ns81t
sqHkqxvFX9clINIeVFaCxRsDTITmjwKCMvYpO/bRMvUoOl6uL5jNJ6qC/POotANq
OmdwzF93SUbWK1AIDUEFIw+ORW2lZKYs6hIbXbEXbDTMACKI8NNAcqK8Z9Fk3YkM
bteGL4TFqgG2y2SdH2xOGxrprQLMy45zNTgz4hEQRpEcOSWbfYhuO7uv0JFexfBa
rBbOZQ+QT799l3J0mSr2ertdFH29nKXliSbd1TYmw8LhPASmnoOSavk2bAcvJ6L3
cmRuL80eDEeWwjSzxdIvWrEMkMU3uPHtiMThKmZ3Lo/5XBuTb7alOeZxZ5/NTSnH
FNGx3wJHbu1+Kgz6w+j69XZAQcRnCWdv6M6we3Q2bM9OARLVu1+rKCu7g6sTWBDW
B643B/myW+11kHY1iQeqsTh7RpUUJN3zr2Z2EtcrE6yEma5DMJBvavU55sE0Ysa9
bB2ulP2f52KsttkSd1h+vqFVu4lP9uOUxUTUYv19zP4QKpHa5Tuv3nfFfkjOcK/Y
7P55bxSoKSRCVb9StLsntYi3l9kYO3djNx3FUFb7F906YnO30C8=
=8OCT
-----END PGP SIGNATURE-----
--=-=-=--
