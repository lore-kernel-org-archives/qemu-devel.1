Received: from eggs.gnu.org ([2001:4830:134:3::10]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJwa0-0002K4-BZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gJwOV-0002St-7C
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:07:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gJwOU-0002HA-U6
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:07:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id j26-v6so12355958wre.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 00:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20181106052144.31841-1-ppandit@redhat.com>
In-Reply-To: <20181106052144.31841-1-ppandit@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Nov 2018 12:07:11 +0400
Message-ID: <CAJ+F1CK1epZGzC7ynjSh=5jsR7KjT-w_g+3M8L3S2WYQ=hbB-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Tue, Nov 6, 2018 at 9:25 AM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While performing mmio device r/w operations, guest could set 'addr'
> parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=3D5.
> Add check to avoid OOB access.
>

Unless memory_region_init_io() is broken, and the region size is >
TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT, I don't see how that
could happen. Do you have a reproducer?

Perhaps replace the conditions with an assert instead?

> Reported-by: Cheng Feng <PSIRT@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/tpm/tpm_tis.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 12f5c9a759..20126dd838 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -293,6 +293,10 @@ static void tpm_tis_request_completed(TPMIf *ti, int=
 ret)
>      uint8_t locty =3D s->cmd.locty;
>      uint8_t l;
>
> +    if (locty >=3D TPM_TIS_NUM_LOCALITIES) {
> +        return;
> +    }
> +
>      if (s->cmd.selftest_done) {
>          for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
>              s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> @@ -401,7 +405,8 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
>      uint32_t avail;
>      uint8_t v;
>
> -    if (tpm_backend_had_startup_error(s->be_driver)) {
> +    if (tpm_backend_had_startup_error(s->be_driver)
> +        || locty >=3D TPM_TIS_NUM_LOCALITIES) {
>          return 0;
>      }
>
> @@ -530,7 +535,8 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
>          return;
>      }
>
> -    if (tpm_backend_had_startup_error(s->be_driver)) {
> +    if (tpm_backend_had_startup_error(s->be_driver)
> +        || locty >=3D TPM_TIS_NUM_LOCALITIES) {
>          return;
>      }
>
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
