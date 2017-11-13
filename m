Received: from eggs.gnu.org ([2001:4830:134:3::10]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEIIc-0008B8-37
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEIIX-00059E-Rr
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:13:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEIIX-00057W-Hp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:13:25 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADHCBcD105863
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 12:13:17 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e7dtty2mc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 12:13:17 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 12:13:16 -0500
References: <1510173421-19895-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 12:13:13 -0500
MIME-Version: 1.0
In-Reply-To: <1510173421-19895-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <acb8ccb5-ea02-cd5b-0f70-612dd5e1819b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] tpm_emulator: Add a caching layer for
 the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com

On 11/08/2017 03:37 PM, Stefan Berger wrote:
> Add a caching layer for the TPM established flag so that we don't
> need to go to the emulator every time the flag is read by accessing
> the REG_ACCESS register.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Can anyone have a look, please?

      Stefan

>
> v1->v2:
>   - move the caching to the backend layer since detecting the
>     TPM 1.2 TSC_ResetEstablishmentBit() command is easier to do
>     here.
> ---
>   hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 9aaec8e..507e2cb 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -71,6 +71,9 @@ typedef struct TPMEmulator {
>       ptm_cap caps; /* capabilities of the TPM */
>       uint8_t cur_locty_number; /* last set locality */
>       Error *migration_blocker;
> +
> +    unsigned int established_flag:1;
> +    unsigned int established_flag_cached:1;
>   } TPMEmulator;
>
>
> @@ -277,16 +280,22 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>       ptm_est est;
>
> -    DPRINTF("%s", __func__);
> +    if (tpm_emu->established_flag_cached) {
> +        return tpm_emu->established_flag;
> +    }
> +
>       if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLISHED, &est,
>                                0, sizeof(est)) < 0) {
>           error_report("tpm-emulator: Could not get the TPM established flag: %s",
>                        strerror(errno));
>           return false;
>       }
> -    DPRINTF("established flag: %0x", est.u.resp.bit);
> +    DPRINTF("got established flag: %0x", est.u.resp.bit);
> +
> +    tpm_emu->established_flag_cached = 1;
> +    tpm_emu->established_flag = (est.u.resp.bit != 0);
>
> -    return (est.u.resp.bit != 0);
> +    return tpm_emu->established_flag;
>   }
>
>   static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
> @@ -317,6 +326,8 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>           return -1;
>       }
>
> +    tpm_emu->established_flag_cached = 0;
> +
>       return 0;
>   }
>
