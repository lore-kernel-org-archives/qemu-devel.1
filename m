Received: from eggs.gnu.org ([209.51.188.92]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjRCJ-0002As-If
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjRCH-0001eX-LJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:04:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjRCD-0001b5-Sw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:04:11 -0500
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-3-xiaoguangrong@tencent.com>
	<20190115075154.GI24343@xz-x1> <20190115102404.GA2135@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2caebc3a-ccd0-d8c6-0368-4f339f326cdf@redhat.com>
Date: Tue, 15 Jan 2019 10:03:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190115102404.GA2135@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IMyc29XdVyJwXxfEmJ3gg0CcK8m7WTgPC"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] migration: fix memory leak when
 updating tls-creds and tls-hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMyc29XdVyJwXxfEmJ3gg0CcK8m7WTgPC
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 wei.w.wang@intel.com, quintela@redhat.com, cota@braap.org,
 Xiao Guangrong <xiaoguangrong@tencent.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <2caebc3a-ccd0-d8c6-0368-4f339f326cdf@redhat.com>
Subject: Re: [PATCH v2 2/3] migration: fix memory leak when updating tls-creds
 and tls-hostname
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
 <20190111063732.10484-3-xiaoguangrong@tencent.com>
 <20190115075154.GI24343@xz-x1> <20190115102404.GA2135@work-vm>
In-Reply-To: <20190115102404.GA2135@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 4:24 AM, Dr. David Alan Gilbert wrote:

> I think the problem is that
> migrate_params_check checks a MigrationParameters
>=20
> while the QMP command gives us a MigrateSetParameters; but we also use
> migrate_params_check for the global check you added (8b0b29dc) which is=

> against migrationParameters; so that's why migrate_params_check takes
> a MigrationParameters.
>=20
> It's horrible we've got stuff duped so much.

Indeed.

>=20
> However, I don't like this fix because if someone later was to add
> a test for tls parameters to migrate_params_check, then they would be
> confused why the hostname/creds weren't checked.
> So while we have migrate_params_test_apply, it should cover all
> parameters.
>=20
> I think a cleaner check would be to write a MigrateParameters_free
> that free'd any strings, and call that in qmp_migrate_set_parameters
> on both exit paths.

We already have it; it's named qapi_free_MigrationParameters(),
generated in qapi-types-migration.h.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IMyc29XdVyJwXxfEmJ3gg0CcK8m7WTgPC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+BGkACgkQp6FrSiUn
Q2rangf9EQ9Dyg76gDPabR8OQn3EnpNce0s6+cD1nVGHqZGUl+ZSF2Ex+orkaAWg
ftBgBzXFqqnoFEynweXvuGtf6/w9gb6V6yEPpxVp/qwB1lAT9TYu5j/bedYoITae
FVy4/ippcudesUKXPC0HxXLebFu0iAfmVRZZEwI952vL0Oloqe7jFAz2awhoUJTe
zQDFTaE2dNHt9WSb5S2mB2Ue0pTSC21iidyHXLfP2Bg04rNzs9sY+7HMx1njfQ80
dy6gV+84zu0BsjF/6QMUzFuAa0KJavbRT9hIPZtDSxhZyMQ1HfmES6knSrOZcwb+
DaSJ7lb2JKKsP6OHmqGYcoR2LuXkrQ==
=1t6r
-----END PGP SIGNATURE-----

--IMyc29XdVyJwXxfEmJ3gg0CcK8m7WTgPC--
