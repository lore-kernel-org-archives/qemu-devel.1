Received: from eggs.gnu.org ([209.51.188.92]:36181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hK1Z2-00012P-8S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hK1Z1-0005KP-0K
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:10:56 -0400
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457]:35692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@alien8.de>) id 1hK1Yy-0005H4-9W
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:10:54 -0400
Date: Fri, 26 Apr 2019 16:10:42 +0200
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20190426141042.GF4608@zn.tnic>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424160942.13567-2-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV
 SEND_START command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Joerg Roedel <joro@8bytes.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 24, 2019 at 04:09:59PM +0000, Singh, Brijesh wrote:
> The command is used to create an outgoing SEV guest encryption context.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  .../virtual/kvm/amd-memory-encryption.rst     |  24 +++++
>  arch/x86/kvm/svm.c                            | 101 ++++++++++++++++++
>  include/uapi/linux/kvm.h                      |  12 +++
>  3 files changed, 137 insertions(+)
>=20
> diff --git a/Documentation/virtual/kvm/amd-memory-encryption.rst b/Docu=
mentation/virtual/kvm/amd-memory-encryption.rst
> index 659bbc093b52..340ac4f87321 100644
> --- a/Documentation/virtual/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virtual/kvm/amd-memory-encryption.rst
> @@ -238,6 +238,30 @@ Returns: 0 on success, -negative on error
>                  __u32 trans_len;
>          };
> =20
> +10. KVM_SEV_SEND_START
> +----------------------
> +
> +The KVM_SEV_SEND_START command can be used by the hypervisor to create=
 an
> +outgoing guest encryption context.
> +
> +Parameters (in): struct kvm_sev_send_start
> +
> +Returns: 0 on success, -negative on error
> +
> +::
> +        struct kvm_sev_send_start {
> +                __u32 policy;                 /* guest policy */
> +
> +                __u64 pdh_cert_uaddr;         /* platform Diffie-Hellm=
an certificate */
> +                __u32 pdh_cert_len;
> +
> +                __u64 plat_cert_uaddr;        /* platform certificate =
chain */
> +                __u32 plat_cert_len;
> +
> +                __u64 amd_cert_uaddr;         /* AMD certificate */
> +                __u32 amd_cert_len;

        __u64 session_uaddr;
        __u32 session_len;

too, right?

> +        };
> +
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 406b558abfef..4c2a225ba546 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6955,6 +6955,104 @@ static int sev_launch_secret(struct kvm *kvm, s=
truct kvm_sev_cmd *argp)
>  	return ret;
>  }
> =20
> +static int sev_send_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +	struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
> +	void *amd_cert =3D NULL, *session_data =3D NULL;
> +	void *pdh_cert =3D NULL, *plat_cert =3D NULL;
> +	struct sev_data_send_start *data =3D NULL;
> +	struct kvm_sev_send_start params;
> +	int ret;
> +
> +	if (!sev_guest(kvm))
> +		return -ENOTTY;
> +
> +	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
> +				sizeof(struct kvm_sev_send_start)))
> +		return -EFAULT;
> +
> +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* userspace wants to query the session length */
> +	if (!params.session_len)
> +		goto cmd;
> +
> +	if (!params.pdh_cert_uaddr || !params.pdh_cert_len ||
> +	    !params.session_uaddr)
> +		return -EINVAL;
> +
> +	/* copy the certificate blobs from userspace */
> +	pdh_cert =3D psp_copy_user_blob(params.pdh_cert_uaddr, params.pdh_cer=
t_len);
> +	if (IS_ERR(pdh_cert)) {
> +		ret =3D PTR_ERR(pdh_cert);
> +		goto e_free;
> +	}
> +
> +	data->pdh_cert_address =3D __psp_pa(pdh_cert);
> +	data->pdh_cert_len =3D params.pdh_cert_len;
> +
> +	plat_cert =3D psp_copy_user_blob(params.plat_cert_uaddr, params.plat_=
cert_len);
> +	if (IS_ERR(plat_cert)) {
> +		ret =3D PTR_ERR(plat_cert);
> +		goto e_free_pdh;
> +	}
> +
> +	data->plat_cert_address =3D __psp_pa(plat_cert);
> +	data->plat_cert_len =3D params.plat_cert_len;
> +
> +	amd_cert =3D psp_copy_user_blob(params.amd_cert_uaddr, params.amd_cer=
t_len);
> +	if (IS_ERR(amd_cert)) {
> +		ret =3D PTR_ERR(amd_cert);
> +		goto e_free_plat_cert;
> +	}
> +
> +	data->amd_cert_address =3D __psp_pa(amd_cert);
> +	data->amd_cert_len =3D params.amd_cert_len;
> +
> +	ret =3D -ENOMEM;
> +	session_data =3D kmalloc(params.session_len, GFP_KERNEL);

If the user is supposed to query the session length first, you could
save it in a global variable perhaps and use that value instead of
trusting the user to give you the correct one in params.session_len for
the allocation...

> +	if (!session_data)
> +		goto e_free_amd_cert;
> +
> +	data->session_address =3D __psp_pa(session_data);
> +	data->session_len =3D params.session_len;
> +cmd:
> +	data->handle =3D sev->handle;
> +	ret =3D sev_issue_cmd(kvm, SEV_CMD_SEND_START, data, &argp->error);
> +
> +	/* if we queried the session length, FW responded with expected data =
*/

<--- ... here you have the session length from the fw.

--=20
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
