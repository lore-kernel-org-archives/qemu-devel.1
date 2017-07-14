Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dVzGR-000557-Ts
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dVzGN-0004Jn-2f
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:00:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:64801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dVzGM-0004JE-NB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:00:03 -0400
From: Kamil Rytarowski <n54@gmx.com>
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
	<910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Message-ID: <b9a66b29-60bf-5bd8-f19a-b32f3c5b0c39@gmx.com>
Date: Fri, 14 Jul 2017 13:50:46 +0200
MIME-Version: 1.0
In-Reply-To: <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="05Ct8qR1pk7B0sI1jObKwS0gDqDCdcDkF"
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--05Ct8qR1pk7B0sI1jObKwS0gDqDCdcDkF
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Blake <eblake@redhat.com>
Message-ID: <b9a66b29-60bf-5bd8-f19a-b32f3c5b0c39@gmx.com>
Subject: Re: [PATCH] tests: Handle $RANDOM not being supported by the shell
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
 <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
In-Reply-To: <910a8148-915a-ab66-1c6c-f18145c13e37@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.07.2017 13:27, Kamil Rytarowski wrote:
> On 14.07.2017 12:45, Peter Maydell wrote:
>> In various places in our test makefiles and scripts we use the
>> shell $RANDOM to create a random number. This is a bash
>> specific extension, and doesn't work on other shells.
>=20
> This is supported on other shells like ksh (Korn Shell), but still as a=
n
> extension.
>=20
>> With dash the shell doesn't complain, it just effectively
>> always evaluates $RANDOM to 0:
>>   echo $((RANDOM + 32768))     =3D> 32768
>>
>> However, on NetBSD the shell will complain:
>>   "-sh: arith: syntax error: "RANDOM + 32768"
>>
>=20
> I will make sure whether this behavior is correct in our sh(1).
>=20

This has been altered in NetBSD-current (+ 8.0BETA), sh(1) behaves like
dash.

>> which means that "make check" fails.
>>
>> Switch to using "${RANDOM:-0}" instead of $RANDOM,
>> which will portably either give us a random number or zero.
>> This means that on non-bash shells we don't get such
>> good test coverage via the MALLOC_PERTURB_ setting, but
>> we were already in that situation for non-bash shells.
>>
>> Our only other uses of $RANDOM (in tests/qemu-iotests/check
>> and tests/qemu-iotests/162) are in shell scripts which use
>> a #!/bin/bash line so they are always run under bash.
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
>=20
>> ---
>>  tests/Makefile.include | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 6d6cb74..f6310d2 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -826,7 +826,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): ch=
eck-qtest-%: $(check-qtest-y)
>>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)=

>>  	$(call quiet-command,QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \=

>>  		QTEST_QEMU_IMG=3Dqemu-img$(EXESUF) \
>> -		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
>> +		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1)=
)} \
>>  		gtester $(GTESTER_OPTIONS) -m=3D$(SPEED) $(check-qtest-$*-y) $(chec=
k-qtest-generic-y),"GTESTER","$@")
>>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generi=
c-y); do \
>>  	  echo Gcov report for $$f:;\
>> @@ -837,7 +837,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): ch=
eck-qtest-%: $(check-qtest-y)
>>  $(patsubst %, check-%, $(check-unit-y)): check-%: %
>>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)=

>>  	$(call quiet-command, \
>> -		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
>> +		MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1)=
)} \
>>  		gtester $(GTESTER_OPTIONS) -m=3D$(SPEED) $*,"GTESTER","$*")
>>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(=
gcov-files-generic-y); do \
>>  	  echo Gcov report for $$f:;\
>>
>=20
>=20



--05Ct8qR1pk7B0sI1jObKwS0gDqDCdcDkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZaLAdAAoJEEuzCOmwLnZsBTkP/3KksHm8t193x89y55KahSIQ
CdAqD9WYHT2N6YUfsH6i5VxeF9Z/xLjHLJy8xRJRdaTpu0dt/cDeAE2mXvu9Ny+S
3Hm1cEGDlWF4EipeYe7ivFD8Awl3P5hPUtBOSsnPWIcmMDQts9GR5oz0zcBlqRNd
+Om9b1XxMM+qVTP5FisXceYGcpniz5dAIF7g+MqU4shhcWlY5UinlO7uRYHaP+m1
pEJ1RYw83YZpOKlPbvujppiquRXV9lVnfDcu6IcaQVPnsO1G7sYnDYh/+jWJHgNH
CXJyaStFf2aD0ehHeE9jUMlPybEvoVkWCC1Slr6JXUF2pk2cidDSbJp3Jjsz9R7w
Pq65685ip3zj/72cUHQ4b+VDofnlg2v1JHDqQZF2d9gVCcSwx9TTRGCqybDcTyIH
LWADPzy7Qw/L4NTLEvacEE3y6XZ7JM0a/Y17j4yLDbHk5A8q/Uoy4aqCSe2TnM7x
wEkDCB7JoEGLtVWjufjoJbUxm0uiYGYbdhN+FbVedAm7noAReL/JscOTN1DpWmSE
UxQ6iaeh7nZt2puvA2LtWowZvLtr/bcoh5AKZkqkys3HL3Cx2xJ7blbDIVY5r4KO
tyN5SFeA3l4VaoL+8HQ+y9lzSVuw2jPYSBiityd/MgLrovTOS8ZhATkVWRo4h0/I
pR4LHKEja8NrI/UfgxEl
=k2jA
-----END PGP SIGNATURE-----

--05Ct8qR1pk7B0sI1jObKwS0gDqDCdcDkF--
