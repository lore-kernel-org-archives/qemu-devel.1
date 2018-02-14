Received: from eggs.gnu.org ([2001:4830:134:3::10]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1em18o-0003g1-21
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1em18k-0003z1-TP
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:46:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42140
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1em18k-0003yo-Mz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:46:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EHipwK097388
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 12:46:41 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4ptk11u3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 12:46:41 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 12:46:40 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-7-git-send-email-walling@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 12:46:36 -0500
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-7-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <a7e79b24-7baa-2a8b-0659-cb03c68c75fd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

I'm beginning to like the usage of splash-time to represent a timeout=20
for the boot menu
less and less.=C2=A0 It is really meant for how long a _splash_ _image_=20
should appear during boot.

I'd like to suggest adding a new boot option "menu-timeout".=C2=A0 An=20
alternative would be
documenting in qemu-options.hx that s390 treats "splash-time" as the=20
menu-timeout.

Thoughts?

On 02/05/2018 03:57 PM, Collin L. Walling wrote:
> Set boot menu options for an s390 guest and store them in
> the iplb. These options are set via the QEMU command line
> option:
>
>      -boot menu=3Don|off[,splash-time=3DX]
>
> or via the libvirt domain xml:
>
>      <os>
>        <bootmenu enable=3D'yes|no' timeout=3D'X'/>
>      </os>
>
> Where X represents some positive integer representing
> milliseconds.
>
> Any value set for loadparm will override all boot menu options.
> If loadparm=3DPROMPT, then the menu will be enabled without a
> timeout.
>
> The absence of any boot options on the command line will flag
> to later use the zipl boot loader values.
>
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> [...]
>
> +static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
> +{
> +    QemuOptsList *plist =3D qemu_find_opts("boot-opts");
> +    QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
> +    uint8_t *flags;
> +    uint16_t *timeout;
> +    const char *tmp;
> +    unsigned long result =3D 0;
> +
> +    switch (iplb->pbt) {
> +    case S390_IPL_TYPE_CCW:
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +        flags =3D &iplb->qipl.boot_menu_flags;
> +        timeout =3D &iplb->qipl.boot_menu_timeout;
> +        break;
> +    default:
> +        error_report("boot menu is not supported for this device type.=
");
> +        return;
> +    }
> +
> +    /* In the absence of -boot menu, use zipl parameters */
> +    if (!qemu_opt_get(opts, "menu")) {
> +        *flags =3D BOOT_MENU_FLAG_ZIPL_OPTS;
> +    } else if (boot_menu) {
> +        *flags =3D BOOT_MENU_FLAG_CMD_OPTS;
> +
> +        tmp =3D qemu_opt_get(opts, "splash-time");
> +
> +        if (tmp && qemu_strtoul(tmp, NULL, 10, &result)) {
> +            error_report("splash-time value is invalid, forcing it to =
0.");
> +            *timeout =3D 0;
> +            return;
> +        }
> +
> +        result =3D (result + 500) / 1000; /* Round and convert to seco=
nds */
> +
> +        if (result > 0xffff) {
> +            error_report("splash-time value is greater than 65535000,"
> +                         " forcing it to 65535000.");
> +            *timeout =3D 0xffff;
> +            return;
> +        }
> +
> +        *timeout =3D cpu_to_be16(result);
> +    }
> +}
> +
> [...]


--=20
- Collin L Walling
