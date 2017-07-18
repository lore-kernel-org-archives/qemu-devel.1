Received: from eggs.gnu.org ([2001:4830:134:3::10]:59486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTTx-0001XS-IH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTTw-0006Mi-Dz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXTTw-0006Ls-4n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:28:12 -0400
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-6-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CLcHN1z-ODgvt-C2MT8h1JfbodG=bmBqq4MTj8P8m7ykg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da24db91-6279-d91c-c102-a5022c6bba10@redhat.com>
Date: Tue, 18 Jul 2017 09:28:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLcHN1z-ODgvt-C2MT8h1JfbodG=bmBqq4MTj8P8m7ykg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UQuddj6TEbFIqTrKE3BhswbwoxkIIPNpL"
Subject: Re: [Qemu-devel] [PATCH v6 5/8] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UQuddj6TEbFIqTrKE3BhswbwoxkIIPNpL
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Amarnath Valluri <amarnath.valluri@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Message-ID: <da24db91-6279-d91c-c102-a5022c6bba10@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 5/8] tmp backend: Add new api to read
 backend TpmInfo
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
 <1500367747-8992-6-git-send-email-amarnath.valluri@intel.com>
 <CAJ+F1CLcHN1z-ODgvt-C2MT8h1JfbodG=bmBqq4MTj8P8m7ykg@mail.gmail.com>
In-Reply-To: <CAJ+F1CLcHN1z-ODgvt-C2MT8h1JfbodG=bmBqq4MTj8P8m7ykg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 05:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jul 18, 2017 at 1:49 AM, Amarnath Valluri
> <amarnath.valluri@intel.com> wrote:
>> TPM configuration options are backend implementation details and shall=
 not be
>> part of base TPMBackend object, and these shall not be accessed direct=
ly outside
>> of the class, hence added a new interface method, get_tpm_options() to=

>> TPMDriverOps., which shall be implemented by the derived classes to re=
turn
>> configured tpm options.
>>
> One usually prefer to have the true case first.
>=20
>> +    } else {
>> +        tpm_pt->ops->has_path =3D true;
>>      }
>>
>> +    tpm_pt->ops->path =3D g_strdup(value);
>=20
> Interestingly, ops->path will be set even if ops->has_path =3D false. I=

> am not sure the visitors will handle that case properly (for visit or
> dealloc etc). Could you set ops->has_path =3D true uncondtionnally?

tmp_pt->opt->path is ignored if has_path is false; if it is assigned to
malloc'd memory, then you leak that memory when freeing tpm_pt.

>=20
>=20
>=20
>>      tpm_pt->tpm_dev =3D g_strdup(value);
>>
>> -    tb->path =3D g_strdup(tpm_pt->tpm_dev);
>> -
>>      tpm_pt->tpm_fd =3D qemu_open(tpm_pt->tpm_dev, O_RDWR);
>>      if (tpm_pt->tpm_fd < 0) {
>>          error_report("Cannot access TPM device using '%s': %s",
>> @@ -382,8 +389,8 @@ static int tpm_passthrough_handle_device_opts(Qemu=
Opts *opts, TPMBackend *tb)
>>      tpm_pt->tpm_fd =3D -1;
>>
>>   err_free_parameters:
>> -    g_free(tb->path);
>> -    tb->path =3D NULL;
>> +    g_free(tpm_pt->ops->path);
>> +    tpm_pt->ops->path =3D NULL;
>>
>=20
> Shouldn't it also free cancel_path?

Even better, don't open-code it.  Use
qapi_free_TPMPassthruState(tpm_pt), so that the generated code gets
everything for you.


>> +static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb=
)
>> +{
>> +    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
>> +    TpmTypeOptions *ops =3D NULL;
>> +    TPMPassthroughOptions *pops =3D NULL;
>> +
>> +    pops =3D g_new0(TPMPassthroughOptions, 1);
>> +    if (!pops) {
>> +        return NULL;
>> +    }
>> +
>=20
> There is no check for small allocation failure elsewhere, I would drop =
that.

In fact, g_new0() can't fail (if you're out of memory, it abort()s
instead of returning NULL).  Coverity will warn about dead code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UQuddj6TEbFIqTrKE3BhswbwoxkIIPNpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluGvkACgkQp6FrSiUn
Q2pH/Af+LtWJ9gpoo9KchXD65pZTxLx3GAPLWvObi1S70F3oinbDOLXJL+kYyfQR
7eb4ZY6ny0avj91rxdqq+47+rvBH0VbLdoUwMav0vHdYPwkU0BFljUmCSiRYgilK
4etc3arUABKky0w6FajPKTNrHuDQtpjnj619imcd7O4f6lLv5yCrSWfR7xBfQ7Qt
DgDqnT+X/xyI+fa4xwFsdpZL+wAntWKkVaSAQzJK+gxyINvZeAd5XkkOzRFjKo+Q
sKjUDXdxRa6ukhNXdkbjGG/obMYnI0mBF7ZTUkT5rXfkRKWYs24dWN+8woVAw8fV
heAoekiZPqYJEPMMEj2RO096iRF91A==
=v8ZV
-----END PGP SIGNATURE-----

--UQuddj6TEbFIqTrKE3BhswbwoxkIIPNpL--
