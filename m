Received: from eggs.gnu.org ([209.51.188.92]:35927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEeAB-0001e4-SB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEeAA-0000kt-LQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hEeAA-0000jt-9w
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:11:02 -0400
References: <20190411175931.29235-1-brijesh.singh@amd.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
Date: Thu, 11 Apr 2019 20:10:56 +0200
MIME-Version: 1.0
In-Reply-To: <20190411175931.29235-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Erik Skultety <eskultet@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 04/11/19 19:59, Singh, Brijesh wrote:
> There are limited numbers of the SEV guests that can be run concurrentl=
y.
> A management applications may need to know this limit so that it can pl=
ace
> SEV VMs on hosts which have suitable resources available.
>=20
> Currently, this limit is not exposed to the application. Add a new
> 'sev-max-guest' field in the query-sev-capabilities to provide this
> information.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  qapi/target.json  | 6 ++++--
>  target/i386/sev.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/qapi/target.json b/qapi/target.json
> index 1d4d54b600..b45121d30b 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -183,7 +183,8 @@
>    'data': { 'pdh': 'str',
>              'cert-chain': 'str',
>              'cbitpos': 'int',
> -            'reduced-phys-bits': 'int'},
> +            'reduced-phys-bits': 'int',
> +            'sev-max-guests': 'int'},

Would it be useful to make this new field optional? E.g. if it was
missing, libvirtd could assume "no limit".

Again, not sure if that's useful, but it's not hard to introduce the
field as optional now. Removing mandatory fields later is impossible.

Thanks
Laszlo

>    'if': 'defined(TARGET_I386)' }
> =20
>  ##
> @@ -200,7 +201,8 @@
>  #
>  # -> { "execute": "query-sev-capabilities" }
>  # <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
> -#                  "cbitpos": 47, "reduced-phys-bits": 5}}
> +#                  "cbitpos": 47, "reduced-phys-bits": 5,
> +#                  "sev-max-guests" : 15}}
>  #
>  ##
>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index cd77f6b5d4..bb0cd79acd 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -488,7 +488,7 @@ sev_get_capabilities(void)
>      guchar *pdh_data =3D NULL;
>      guchar *cert_chain_data =3D NULL;
>      size_t pdh_len =3D 0, cert_chain_len =3D 0;
> -    uint32_t ebx;
> +    uint32_t ebx, ecx, edx;
>      int fd;
> =20
>      fd =3D open(DEFAULT_SEV_DEVICE, O_RDWR);
> @@ -507,7 +507,7 @@ sev_get_capabilities(void)
>      cap->pdh =3D g_base64_encode(pdh_data, pdh_len);
>      cap->cert_chain =3D g_base64_encode(cert_chain_data, cert_chain_le=
n);
> =20
> -    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
> +    host_cpuid(0x8000001F, 0, NULL, &ebx, &ecx, &edx);
>      cap->cbitpos =3D ebx & 0x3f;
> =20
>      /*
> @@ -516,6 +516,8 @@ sev_get_capabilities(void)
>       */
>      cap->reduced_phys_bits =3D 1;
> =20
> +    /* the maximum number of SEV guests that can run simultaneously */
> +    cap->sev_max_guests =3D ecx - edx + 1;
>  out:
>      g_free(pdh_data);
>      g_free(cert_chain_data);
>=20
