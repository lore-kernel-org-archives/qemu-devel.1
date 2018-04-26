Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhSy-0005lu-IJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhSu-0007CB-Il
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:01:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBhSu-0007Bs-Cn
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:01:40 -0400
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
Date: Thu, 26 Apr 2018 09:01:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180426091519.26934-1-xiaoguangrong@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="opeqXK21rullJa4zyyqWejjp6ao6ytJBc"
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--opeqXK21rullJa4zyyqWejjp6ao6ytJBc
From: Eric Blake <eblake@redhat.com>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com
Cc: kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com,
 wei.w.wang@intel.com, jiang.biao2@zte.com.cn
Message-ID: <32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
In-Reply-To: <20180426091519.26934-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 04:15 AM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>=20
> QEMU 2.13 enables strict check for compression & decompression to
> make the migration more robuster, that depends on the source to fix

s/robuster/robust/

> the internal design which triggers the unexpected error conditions

2.13 hasn't been released yet.  Why do we need a knob to explicitly turn
off strict checking?  Can we not instead make 2.13 automatically smart
enough to tell if the incoming stream is coming from an older qemu
(which might fail if the strict checks are enabled) vs. a newer qemu
(the sender gave us what we need to ensure the strict checks are
worthwhile)?

>=20
> To make it work for migrating old version QEMU to 2.13 QEMU, we
> introduce this parameter to disable the error check on the
> destination
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---

> +++ b/qapi/migration.json
> @@ -455,6 +455,17 @@
>  #          compression, so set the decompress-threads to the number ab=
out 1/4
>  #          of compress-threads is adequate.
>  #
> +# @decompress-error-check: check decompression errors. When false, the=
 errors
> +#                          triggered by memory decompression are ignor=
ed.

What are the consequences of such an error?  Is it a security hole to
leave this at false, when a malicious migration stream can cause us to
misbehave by ignoring the errors?

> +#                          When true, migration is aborted if the erro=
rs are
> +#                          detected. For the old QEMU versions (< 2.13=
) the
> +#                          internal design will cause decompression to=
 fail
> +#                          so the destination should completely ignore=
 the
> +#                          error conditions, i.e, make it be false if =
these
> +#                          QEMUs are going to be migrated. Since 2.13,=
 this
> +#                          design is fixed, make it be true to avoid c=
orrupting
> +#                          the VM silently (Since 2.13)

Rather wordy; I'd suggest:

@decompress-error-check: Set to true to abort the migration if
        decompression errors are detected at the destination. Should be
        left at false (default) for qemu older than 2.13, since only
        newer qemu sends streams that do not trigger spurious
        decompression errors. (Since 2.13)

But that's if we even need it (it SHOULD be possible to design something
into the migration stream so that you can detect this property
automatically instead of relying on the user to set the property).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--opeqXK21rullJa4zyyqWejjp6ao6ytJBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrh27MACgkQp6FrSiUn
Q2ojTgf5AdBJ2mXB+pyA5Yj/4PX+LC6U6d7rrRoj+H/7IgT90NPGB85h3ehZGIij
9kb/SOb5cxQZGjd2HO5W3GgtRlD7eE1auRiwRNlYM5gMS7JcblGS1n2igsPR8LZY
nh6z7R337stDSvIFtWpAKahrDNFX6EuX8K0cGjhv3ycnQkj2hSaHXbp29FyQRfG8
SPOQjtP74coOcKJQAp85duq1pCT/LsTzjwuJp05FjeRaPOcOYfCR1Dmw5+UucoJ1
oECf+gTHTkb82y7wW2K7uRu5g7Fx09oHfehAAF6NsmBQJKf/4+FD93yU9khaLqqA
eqCcnbH1a7y8E+q16B3XGJ28WMnTtA==
=X40i
-----END PGP SIGNATURE-----

--opeqXK21rullJa4zyyqWejjp6ao6ytJBc--
