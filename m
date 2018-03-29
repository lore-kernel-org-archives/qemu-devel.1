Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1WhG-00068h-Ux
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f1WhC-0001fT-MH
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:30:26 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f1WhC-0001f0-Bg
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:30:22 -0400
Received: by mail-wr0-x244.google.com with SMTP id s18so5229923wrg.9
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 05:30:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522270761-29646-5-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522270761-29646-5-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Mar 2018 14:30:20 +0200
Message-ID: <CAJ+F1CKiR=NSaAX+FMDc8H_pJix4aazmnx94737+AKadwtEBCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] tests: Tests more flags of the CRB
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, Mar 28, 2018 at 10:59 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Test and modify more flags of the CRB interface.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  tests/tpm-crb-test.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 72 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
> index e1513cb..d8f9569 100644
> --- a/tests/tpm-crb-test.c
> +++ b/tests/tpm-crb-test.c
> @@ -28,6 +28,10 @@ static void tpm_crb_test(const void *data)
>      uint64_t caddr =3D readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
>      uint32_t rsize =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
>      uint64_t raddr =3D readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
> +    uint8_t locstate =3D readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
> +    uint32_t locctrl =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
> +    uint32_t locsts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> +    uint32_t sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
>
>      g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), =3D=
=3D, 1);
>      g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), =
=3D=3D, 1);
> @@ -45,9 +49,47 @@ static void tpm_crb_test(const void *data)
>      g_assert_cmpint(caddr, >, TPM_CRB_ADDR_BASE);
>      g_assert_cmpint(raddr, >, TPM_CRB_ADDR_BASE);
>
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished),=
 =3D=3D, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), =
=3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality),=
 =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), =3D=
=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts),=
 =3D=3D, 1);
> +
> +    g_assert_cmpint(locctrl, =3D=3D, 0);
> +
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), =3D=3D, 0)=
;
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), =3D=3D,=
 0);
> +
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 1);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
> +
> +    /* request access to locality 0 */
> +    writeb(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +
> +    /* granted bit must be set now */
> +    locsts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), =3D=3D, 1)=
;
> +    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), =3D=3D,=
 0);
> +
> +    /* we must have an assigned locality */
> +    locstate =3D readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished),=
 =3D=3D, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), =
=3D=3D, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality),=
 =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), =3D=
=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts),=
 =3D=3D, 1);
> +
> +    /* set into ready state */
> +    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 1);
> +
> +    /* TPM must not be in the idle state */
> +    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
> +
>      memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
>
> -    uint32_t sts, start =3D 1;
> +    uint32_t start =3D 1;
>      uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECON=
D;
>      writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
>      do {
> @@ -58,12 +100,40 @@ static void tpm_crb_test(const void *data)
>      } while (g_get_monotonic_time() < end_time);
>      start =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
>      g_assert_cmpint(start & 1, =3D=3D, 0);
> +
> +    /* TPM must still not be in the idle state */
>      sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(sts & 1, =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
>
>      struct tpm_hdr tpm_msg;
>      memread(raddr, &tpm_msg, sizeof(tpm_msg));
>      g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tp=
m_msg));
> +
> +    /* set TPM into idle state */
> +    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 2);
> +
> +    /* idle state must be indicated now */
> +    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 1);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
> +
> +    /* relinquish locality */
> +    writel(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 2);
> +
> +    /* Granted flag must be cleared */
> +    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), =3D=3D, 0)=
;
> +
> +    /* no locality may be assigned */
> +    locstate =3D readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished),=
 =3D=3D, 1);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), =
=3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality),=
 =3D=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), =3D=
=3D, 0);
> +    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts),=
 =3D=3D, 1);
> +
>  }
>
>  int main(int argc, char **argv)
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
