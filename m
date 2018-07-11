Received: from eggs.gnu.org ([2001:4830:134:3::10]:58761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFde-0006Lq-Ep
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFdb-000394-TU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:58:38 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFdb-00038m-LP
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:58:35 -0400
Received: by mail-qk0-x243.google.com with SMTP id u21-v6so13589583qku.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:58:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
	<878t6ke7qh.fsf@linaro.org>
	<CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
	<52a7f5d4-7264-9411-98a4-9f59e813e9d3@amsat.org>
	<CAGF1vyEEez4v+N2VZVULsiaR7_cdn-u0Z1RZ3Y+P-9q2NBV4aw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89df2b98-0c84-3bb5-1d8d-dceab6c3ad63@amsat.org>
Date: Wed, 11 Jul 2018 10:58:28 -0300
MIME-Version: 1.0
In-Reply-To: <CAGF1vyEEez4v+N2VZVULsiaR7_cdn-u0Z1RZ3Y+P-9q2NBV4aw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="YCyAvyeFcQIP6b0oeyrB7NfsMzGxYQK4K"
Subject: Re: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stephane duverger <stephane.duverger@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YCyAvyeFcQIP6b0oeyrB7NfsMzGxYQK4K
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: stephane duverger <stephane.duverger@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Message-ID: <89df2b98-0c84-3bb5-1d8d-dceab6c3ad63@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
 <878t6ke7qh.fsf@linaro.org>
 <CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
 <52a7f5d4-7264-9411-98a4-9f59e813e9d3@amsat.org>
 <CAGF1vyEEez4v+N2VZVULsiaR7_cdn-u0Z1RZ3Y+P-9q2NBV4aw@mail.gmail.com>
In-Reply-To: <CAGF1vyEEez4v+N2VZVULsiaR7_cdn-u0Z1RZ3Y+P-9q2NBV4aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Stephane,

On 07/11/2018 04:52 AM, stephane duverger wrote:
> To reach gdb_set_stop_cpu() with gdbserver_state =3D=3D NULL, you previ=
ously
>> entered gdb_vm_state_change() with and use CPUState *cpu =3D
>> gdbserver_state->c_cpu =3D NULL deref, which shouldn't happen.
>> Also in gdb_set_stop_cpu() you finally call cpu_single_step(cpu=3Dcrap=
)
>> which then deref crap->singlestep_enabled.
>>
>> So I think this is not the correct fix.
>>
>=20
> I think you are wrong. You can enter gdb_vm_state_change() only if it h=
as
> been registered through qemu_add_vm_change_state_handler(). And this
> happens in gdbserver_start() which is called only when you start the
> gdbserver stub.
>=20
> This is exactly what we don't want to do here: use qemu breakpoints and=

> debug events forwarding without the need to enable a gdb stub.

Well, at least we agree the gdb stub code is not straightforward.

And apparently without seeing the bigger picture about how you are using
this, I am missing something.

> There might be an historical reason that vCPU debug events are always
> forwarded to the gdbserver (from cpu_handle_guest_debug()) but this
> should not be mandatory.
>=20
> One could consider a check to the gdbserver state right before:
>=20
> if (gdbserver_enabled())
>     gdb_set_stop_cpu(cpu);
>=20
> As found in other part of qemu code: kvm_enabled, hax_enabled, ...
>=20
>=20
>> Since this shouldn't happen, I'd add an assert(gdbserver_state) in
>> gdb_set_stop_cpu(), and clean gdb_vm_state_change()'s code flow to not=

>> reach this.
>>
>=20
> Correct if you previously add the gdbserver_enabled() check. Else this
> would abort the qemu instance each time a debug event is triggered
> and forwarded to a vm_change_state handler.
>=20
>>>>  void gdb_set_stop_cpu(CPUState *cpu)
>>>>>  {
>>>>> +    if (!gdbserver_state) {
>>>>> +        return;
>>>>> +    }
>>>>>      gdbserver_state->c_cpu =3D cpu;
>>>>>      gdbserver_state->g_cpu =3D cpu;
>>
>> I find it safer the opposite way, if (s) { s-> ... }
>>
>=20
> Sincerely, this argument is subjective. If it's part of Qemu coding
> standard,
> i would agree. Again there is a lot of situations in the Qemu code wher=
e
> exit conditions are checked first and then lead to a return, preventing=
 an
> unneeded level of indentation. Seriously, we are talking about a 2 line=
s
> function.

This is indeed a personal subjective suggestion, not part of QEMU Coding
standard. Rational is, if in the future someone needs to modify
gdb_set_stop_cpu(), it would be easier/safer for him.

No worries ;)

Regards,

Phil.


--YCyAvyeFcQIP6b0oeyrB7NfsMzGxYQK4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltGDQQACgkQ4+MsLN6t
wN6GYA//c09dxzrg9rETPt8fVYIH7ILl7SvGwzsX7SdTDBJOZu8n7MBpl8neWgbu
T+1bTWqZ/bEHebexS0M12MhcC9t/yq/8OaUjV6kpWtos3Wn8pIZ7ncGffwRPD5Qx
dtHgBP+rA7cMy8svi2iAu4jHGqLkSKDITIBb4ZCBA8ng6kQwUaLLygUl2OMHq+/L
O+evcLehKIjbXb6CD8ZyWIsvv2k70BmygGkyS8PobOKt0/IlIUV1YpEhTkE72wWe
ZZUAk3l02WrdCXGm9Aqun38yVc8zjvz5tZ3OkzyP+bHSxGPPGuyd50CAmJ22esOD
PXmDX88UVTvC5K9cF+I/soUnw358+LYV60p3xo75qK314rHmFovQCHQFjclwVfEK
NoPWVyNagLAdFVKTyRWMHOunJCNzlvt/ZYY5EJxUVtxl1TFJ1TB2THugD1OiBsqI
+tfpLoZxLivdDHvo5/x4eJ4UEFP3nO///6TiOeASOti90flaEJCz5F6UdU2nJzDj
wOqZI7DIkh77XOVKGjYs9IRAnCA8WkLxXwiyihU3/MUZXJWoaJhZxLOmwWDCDrp2
2NTGOdFUxXNq7ZpL+aDoCOhKXTfLtFPiLyMXh0phM0VQlrjWYCLRrKOWSfWhcVoc
eb2SbKFiTVOzTVQaLmO2vNuZ9VDHAYx7jxCrNpbyEXR9kbovAQk=
=iIIE
-----END PGP SIGNATURE-----

--YCyAvyeFcQIP6b0oeyrB7NfsMzGxYQK4K--
