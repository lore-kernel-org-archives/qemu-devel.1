Received: from eggs.gnu.org ([2001:4830:134:3::10]:36135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecXj9-0000Pw-Q0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecXj4-0002De-Pi
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:33:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50604
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ecXj4-0002AN-KS
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:33:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JESOgD047188
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:33:00 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkhn8tgvb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:33:00 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 19 Jan 2018 09:32:59 -0500
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-2-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 09:32:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180119141105.29095-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7bac4338-c0e0-6b48-aaa2-2cd4654025fd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] tpm: lookup cancel path under tpm
 device class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 01/19/2018 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> Since Linux commit 313d21eeab9282e, tpm devices have their own device
> class "tpm" and the cancel path must be looked up under
> /sys/class/tpm/ instead of /sys/class/misc/.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_passthrough.c | 34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 29142f38bb..f2563ac668 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -216,7 +216,8 @@ static size_t tpm_passthrough_get_buffer_size(TPMBa=
ckend *tb)
>    * Unless path or file descriptor set has been provided by user,
>    * determine the sysfs cancel file following kernel documentation
>    * in Documentation/ABI/stable/sysfs-class-tpm.
> - * From /dev/tpm0 create /sys/class/misc/tpm0/device/cancel
> + * From /dev/tpm0 create /sys/class/tpm/tpm0/device/cancel
> + * before 4.0: /sys/class/misc/tpm0/device/cancel
>    */
>   static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt=
)
>   {
> @@ -227,26 +228,35 @@ static int tpm_passthrough_open_sysfs_cancel(TPMP=
assthruState *tpm_pt)
>       if (tpm_pt->options->cancel_path) {
>           fd =3D qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
>           if (fd < 0) {
> -            error_report("Could not open TPM cancel path : %s",
> +            error_report("tpm_passthrough: Could not open TPM cancel p=
ath: %s",
>                            strerror(errno));
>           }
>           return fd;
>       }
>
>       dev =3D strrchr(tpm_pt->tpm_dev, '/');
> -    if (dev) {
> -        dev++;
> -        if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/ca=
ncel",
> -                     dev) < sizeof(path)) {
> -            fd =3D qemu_open(path, O_WRONLY);
> -            if (fd < 0) {
> -                error_report("tpm_passthrough: Could not open TPM canc=
el "
> -                             "path %s : %s", path, strerror(errno));
> +    if (!dev) {
> +        error_report("tpm_passthrough: Bad TPM device path %s",
> +                     tpm_pt->tpm_dev);
> +        return -1;
> +    }
> +
> +    dev++;
> +    if (snprintf(path, sizeof(path), "/sys/class/tpm/%s/device/cancel"=
,
> +                 dev) < sizeof(path)) {
> +        fd =3D qemu_open(path, O_WRONLY);
> +        if (fd < 0) {
> +            if (snprintf(path, sizeof(path), "/sys/class/misc/%s/devic=
e/cancel",
> +                         dev) < sizeof(path)) {
> +                fd =3D qemu_open(path, O_WRONLY);
>               }
>           }
> +    }
> +
> +    if (fd < 0) {
> +        error_report("tpm_passthrough: Could not guess TPM cancel path=
");
>       } else {
> -       error_report("tpm_passthrough: Bad TPM device path %s",
> -                    tpm_pt->tpm_dev);
> +        tpm_pt->options->cancel_path =3D g_strdup(path);
>       }
>
>       return fd;
