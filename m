Received: from eggs.gnu.org ([2001:4830:134:3::10]:46528)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1f5gDn-00022N-Ck
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 19:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1f5gDk-0003pg-5d
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 19:29:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:42593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1f5gDj-0003p2-Qm
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 19:29:08 -0400
From: Kamil Rytarowski <n54@gmx.com>
References: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
	<ed5e0354-11e9-5778-128b-680bab83cbca@gmx.com>
Message-ID: <03fbcc73-c41b-e968-315a-d16cb99c55bb@gmx.com>
Date: Tue, 10 Apr 2018 01:31:05 +0200
MIME-Version: 1.0
In-Reply-To: <ed5e0354-11e9-5778-128b-680bab83cbca@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GrIh1SQfhKwpdOILQ6E7rV7t3pmBVwXgd"
Subject: Re: [Qemu-devel] qom-test on netbsd can be very slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GrIh1SQfhKwpdOILQ6E7rV7t3pmBVwXgd
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <03fbcc73-c41b-e968-315a-d16cb99c55bb@gmx.com>
Subject: Re: [Qemu-devel] qom-test on netbsd can be very slow
References: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
 <ed5e0354-11e9-5778-128b-680bab83cbca@gmx.com>
In-Reply-To: <ed5e0354-11e9-5778-128b-680bab83cbca@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.04.2018 22:51, Kamil Rytarowski wrote:
> On 09.04.2018 19:10, Peter Maydell wrote:
>> My NetBSD build system recently seems to have taken a nosedive
>> in how long it takes to finish "make check". This seems to be
>> because qom-test (and probably other things where the test interacts
>> with the QEMU process) can run very slowly.
>>
>> netbsdvm# for i in 1 2 3 4 5 6 7 8 9 10; do
>> (QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 time
>> tests/qom-test -p /x86_64/qom/pc-i440fx-2.0); done
>> /x86_64/qom/pc-i440fx-2.0: OK
>>         8.49 real         1.18 user         7.34 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>        10.41 real         1.32 user         9.09 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>         8.45 real         1.24 user         7.24 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>         9.88 real         1.10 user         8.31 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>        11.60 real         1.47 user         9.90 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>        10.94 real         1.28 user         9.68 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>        10.06 real         1.32 user         8.76 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>        13.38 real         1.37 user        12.04 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>        16.19 real         1.46 user        14.29 sys
>> /x86_64/qom/pc-i440fx-2.0: OK
>>         9.70 real         1.17 user         8.51 sys
>>
>> Admittedly this is running in a (KVM) VM, but still, there seems
>> something wrong with how long each of these is taking. On Linux
>> each run is less than a second, so there's an order-of-magnitude
>> slowdown here. Further, I've occasionally seen a run take 100 seconds!=

>>
>> Does anybody else see this, and any ideas why it might be running slow=
?
>> I'm not very familiar with debugging on netbsd; I had a look at
>> ktrace output, and the QEMU process seems to sometimes spend
>> quite a lot of time in a poll() loop not actually doing anything.
>> I couldn't figure out how to get the ktrace logs to annotate
>> which thread was making which syscall though, so they weren't
>> easy to interpret. If anybody's more experienced at debugging
>> things in the BSDs that would also be helpful.
>>
>> On OpenBSD, for comparison, each test run seems to fairly reliably
>> take 5 seconds give-or-take, there's much less run-to-run
>> variation, though it's still much slower than Linux is.
>> The OpenBSD and FreeBSD build VMs seem to complete more
>> reasonably quickly than the NetBSD one.
>>
>> One thing I noticed looking at ktrace output is that we do
>> all our reading of QMP input and output with a read syscall
>> per character. I don't think that's the cause of this slowness,
>> though.
>>
>> thanks
>> -- PMM
>>
>=20
> I'm running these tests natively and get apparently expected results:
>=20
> /x86_64/qom/pc-i440fx-2.0: OK
>         2,05 real         1,36 user         0,71 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,92 real         1,17 user         0,79 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,84 real         1,14 user         0,77 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,85 real         1,16 user         0,76 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,79 real         1,04 user         0,82 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,84 real         1,00 user         0,91 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,86 real         1,18 user         0,75 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,85 real         1,27 user         0,64 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,84 real         1,27 user         0,64 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         1,82 real         1,18 user         0,71 sys
>=20

There is a registered bug in the NetBSD database:

https://gnats.netbsd.org/52184
"Recent qemu performs badly on NetBSD hosts under load"

Could you please try to check if the following commit is culprit using
the reproducer in gnats or running qom-test?


commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Jul 21 16:07:53 2015 +0200

    AioContext: optimize clearing the EventNotifier

    It is pretty rare for aio_notify to actually set the EventNotifier.  =
It
    can happen with worker threads such as thread-pool.c's, but otherwise=
 it
    should never be set thanks to the ctx->notify_me optimization.  The
    previous patch, unfortunately, added an unconditional call to
    event_notifier_test_and_clear; now add a userspace fast path that
    avoids the call.

    Note that it is not possible to do the same with event_notifier_set;
    it would break, as proved (again) by the included formal model.

    This patch survived over 3000 reboots on aarch64 KVM.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    Reviewed-by: Fam Zheng <famz@redhat.com>
    Tested-by: Richard W.M. Jones <rjones@redhat.com>
    Message-id: 1437487673-23740-7-git-send-email-pbonzini@redhat.com
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


--GrIh1SQfhKwpdOILQ6E7rV7t3pmBVwXgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlrL97kMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsM+cQAJvch4Bns6rcfW1erKyy+T6ofnJoHCMwC4lfUy53
eKvXKCnmGj+QYyRGlB6+XmpjhR/U++0zzHFCSSeQQKhj9CHBskdXLm6uJn+Jiamc
rvCvcSj4a2Z2jjHUeq2xskRQuC0QEmiJk2VQdCPsxtBCQFF0kECiFndwzEENS2nB
IBnpVk1EFra7l+cTi0wm6LXpTFtUwF8TejiHGIvwFmGow70VURuieKdAvDKqiHdK
X49NyOpEbgDfHT2U/xsIrBNCGXCF5kKHrMoLNE0ppXR4pBzhFAqnX+0latXaS5Cs
v/NkI+ZyufV9uI+FeIUJPf8wIPLY9CMWmcbzyV4tiPlPh8wvBuTSscxHcRdxAefS
U30lVcmZPJqHArvTQ0lrGBW16ZaPoDI/5q/AYHdOGvzZDhwpiROnm1OlJtpWKgDs
rmukX9h3v1svQxCB/CsriOs5jvd1AC7mUJxetn1HowrOhnuSwsjAg0ms3kLNFwpS
jpMGLcXK4A7XvdeMyB1Etf/MyaO5fp85+dGpS9xGL4+lhXG9X/I4Nz7j/RJ9AVSX
u0LpHXfgsUK6fZuP12HjVTVg9wHdKNc3V7ZSRMtuse01Zfstvhj4DwU8GEOW/31p
dh2JzpSGVfd8QutdrsGbOpydnEhvjlhJBoOJlP3EdMVn9LTuq/XpPR17729n3E/G
CoaT
=z7pc
-----END PGP SIGNATURE-----

--GrIh1SQfhKwpdOILQ6E7rV7t3pmBVwXgd--
