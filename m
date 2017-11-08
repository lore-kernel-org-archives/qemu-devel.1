Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT88-0000NZ-Ed
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eCT82-0001UV-Qb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:23:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eCT82-0001UH-Jo
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:23:02 -0500
Date: Wed, 8 Nov 2017 17:22:56 +0100
From: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20171108162256.GF13150@boraha>
References: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510016336-4086-6-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1510016336-4086-6-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] tpm: tpm_passthrough: Fail startup if
 FE buffer size < BE buffer size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, amarnath.valluri@intel.com

Hi Stefan,

On Mon, Nov 06, 2017 at 07:58:56PM -0500, Stefan Berger wrote:
> If the requested buffer size of the frontend is smaller than the fixed
> buffer size of the host's TPM, fail the startup_tpm() interface functio=
n,
> which will make the device unusable. We fail it because the backend TPM
> could produce larger packets than what the frontend could pass to the O=
S.
>=20
> The current combination of TIS frontend and either passthrough or emula=
tor
> backend will not lead to this case since the TIS can support any size o=
f
> buffer.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_passthrough.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index ec755fe..66d5098 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -304,6 +304,20 @@ static TPMBackend *tpm_passthrough_create(QemuOpts=
 *opts)
>      return TPM_BACKEND(obj);
>  }
> =20
> +static int tpm_passthrough_startup_tpm(TPMBackend *tb, uint32_t buffer=
size)
> +{
> +    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> +
> +    if (buffersize && buffersize < tpm_pt->tpm_buffersize) {
> +        error_report("Requested buffer size of %u is smaller than host=
 TPM's "
> +                     "fixed buffer size of %u",
> +                     buffersize, tpm_pt->tpm_buffersize);

Looks ok

> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
>  {
>      TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);
> @@ -362,6 +376,7 @@ static void tpm_passthrough_class_init(ObjectClass =
*klass, void *data)
>      tbc->opts =3D tpm_passthrough_cmdline_opts;
>      tbc->desc =3D "Passthrough TPM backend driver";
>      tbc->create =3D tpm_passthrough_create;
> +    tbc->startup_tpm =3D tpm_passthrough_startup_tpm;
>      tbc->reset =3D tpm_passthrough_reset;
>      tbc->cancel_cmd =3D tpm_passthrough_cancel_cmd;
>      tbc->get_tpm_established_flag =3D tpm_passthrough_get_tpm_establis=
hed_flag;
> --=20
> 2.5.5

Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
