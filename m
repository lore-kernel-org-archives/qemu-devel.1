Received: from eggs.gnu.org ([2001:4830:134:3::10]:57165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYYl2-00068r-9w
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYYky-0004lj-BL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:22:52 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYYky-0004k3-3A
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:22:48 -0400
Received: by mail-pf0-x244.google.com with SMTP id h20-v6so831308pfn.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:22:48 -0700 (PDT)
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-3-richard.henderson@linaro.org>
	<20180628034955.GB23134@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15d41b89-b239-c082-f3c7-9c28a0c54958@linaro.org>
Date: Thu, 28 Jun 2018 08:22:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180628034955.GB23134@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JkQatx0DCUCgSrpBicU6JM1JBoco7XLaX"
Subject: Re: [Qemu-devel] [PATCH 02/13] target/ppc: Use atomic load for LQ
 and LQARX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JkQatx0DCUCgSrpBicU6JM1JBoco7XLaX
From: Richard Henderson <richard.henderson@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <15d41b89-b239-c082-f3c7-9c28a0c54958@linaro.org>
Subject: Re: [PATCH 02/13] target/ppc: Use atomic load for LQ and LQARX
References: <20180626161921.27941-1-richard.henderson@linaro.org>
 <20180626161921.27941-3-richard.henderson@linaro.org>
 <20180628034955.GB23134@umbus.fritz.box>
In-Reply-To: <20180628034955.GB23134@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2018 08:49 PM, David Gibson wrote:
>> +    /* High part of 128-bit helper return.  */
>> +    uint64_t retxh;
>> +
>=20
> Adding a temporary here is kind of gross.  I guess the helper
> interface doesn't allow for 128-bit returns, but couldn't you pass a
> register number into the helper and have it update the right GPR
> without going through a temp?

I could pass a pointer, but that would cause ...

>> +#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
>> +DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)=

>> +DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)=


=2E.. the helper definitions to lose TCG_CALL_NO_WG, because they *would*=
 write
to a global register.  Which would cause TCG to discard all of the global=
 guest
registers cached within host registers.

I've used this secondary memory return before, in target/s390,
and to me it seems cleaner than pointers.


r~


--JkQatx0DCUCgSrpBicU6JM1JBoco7XLaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFEBAEBCAAuFiEEnLGN2vjoSa0q/BakrRJwzE3QJ5sFAls0/UQQHHJ0aEB0d2lk
ZGxlLm5ldAAKCRCtEnDMTdAnm5sxB/sFoLJeFnCX7SOdmXC+IgQToRy3gJznmQEQ
UJeZoOuIrEkUNN/JMrbWScfuAMqJE2b3XI558lzSPDOxPKy/dTSoNXdQZVp27Iug
jrHTCzAtxahuXtlP4uiJXyYzFIaDPsI1Jchs2gqfzhYpdHoyJ70HhlrsdqrIaVcI
C9lUPAypk9z/wOKcTiRADzrsRsHwZ7fcnrSmvs3J62twMS2/JAOZM/JRKpfajnL1
6HAF9OmmC8M2tmfSlBuOytN4Vo6Vipfb5A0A+hg4AB/obns000wCQOpX4YUX9/u+
tfE8gbZzo/KqoqjpSNJIBdV+RXDkxbkAcbBSGADWyj3poO+Pcgx6
=rC2V
-----END PGP SIGNATURE-----

--JkQatx0DCUCgSrpBicU6JM1JBoco7XLaX--
