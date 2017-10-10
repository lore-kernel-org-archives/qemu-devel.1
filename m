Received: from eggs.gnu.org ([2001:4830:134:3::10]:50589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e217D-0001I6-W0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e217A-0000Wl-S8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:27:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59613
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e217A-0000We-N7
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:26:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKNct7165869
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:26:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh31dqf51-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:26:52 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 16:26:51 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-29-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:26:49 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e1495d7f-3666-1251-f62f-30c345cb459a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 28/42] tpm-passthrough: don't save guessed
 cancel_path in options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> The value is later unneeded, and may leak if the free visitor doesn't
> consider it since has_cancel_path is false. And for consistency with
> "path" it shouldn't be returned in get_tpm_options().
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   hw/tpm/tpm_passthrough.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 8c002e4da6..048edb1a1a 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -226,9 +226,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPas=
sthruState *tpm_pt)
>           if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/c=
ancel",
>                        dev) < sizeof(path)) {
>               fd =3D qemu_open(path, O_WRONLY);
> -            if (fd >=3D 0) {
> -                tpm_pt->options->cancel_path =3D g_strdup(path);
> -            } else {
> +            if (fd < 0) {
>                   error_report("tpm_passthrough: Could not open TPM can=
cel "
>                                "path %s : %s", path, strerror(errno));
>               }
