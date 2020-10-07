Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C93C4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE242083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrfPmNDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE242083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4iV-0005Zy-OO
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQ4gY-0003yj-S2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:20:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQ4gW-0008Kb-Ev
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:20:30 -0400
Received: by mail-ej1-x644.google.com with SMTP id a3so1680894ejy.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FoYlNF0ZeC1mWa2Bb9mFQxF3pVglXZJnp7GH4u9e5xk=;
 b=DrfPmNDDH0TMz00mMfe4KkSjQ5CP5T7ySzxHxktCCS/A+/VvPmu7/u+pQ6VpSPhxMZ
 UpOG4MVmN+VkcIMRNsiISFzWI9jpHedTrYSE5icb6d1nv0TpwElgB1dZG6ITUP1Uih4h
 fV2gdpToyQJNYEBX9Ix6O8pFZ95XqQytRGJGActc7Ye4CGksMzs64hMOpvpShauPhvnY
 sW2DEQ3SSP8TDpoz/sFdyzgqZ2fVPi8OqL2s3pOCgtfDmIWacDRYUxNs9i6msP7vYUbv
 DSE3F72xPLU7hN5q1PctR9nvRBA5fsdYHb5CkLtMv1iaqaorpm+F+YWpQuefroZMSWVK
 NdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FoYlNF0ZeC1mWa2Bb9mFQxF3pVglXZJnp7GH4u9e5xk=;
 b=BPPvv8bnnnHbdbeuucogyZydDaC/Gh68xInJ9718AU+sNvUARZGFwyubCA5u+BQf2z
 vvvD0FQUiwBAm6Dnyd0veQzlQk1NUlJHIIpHZDB6ncPOUjMEaK8ZT8NICRlxRnutLfMa
 SEVSmMjwKgOnY0FhUFIkAgTy39xW4hEsMbz169L+p/iDp/rJ5gdmOJuLuVwvPgeggKH3
 CoqgSyffphj80+GhrWZznZV8Zx84NGJo1dK7lgPE3RFbarYNeUajL0bXnXpJ4Hbjs5q1
 yECEXOMgrGkwIrxc1IVHsP7x8qhRNx8SpadF0T1rN/L/5aLoY6CLwB3RnVYATZLU1n1Q
 ZX5A==
X-Gm-Message-State: AOAM5339mblQ1LFiEZPt/IV19N2zOlolo5L9Jbn5+6CjjvecP8BSwnY6
 JMH7KZoTPxf0JPTrb9mul5lLg1ozUVXV+uJmPCM=
X-Google-Smtp-Source: ABdhPJzRb6zDRuJXpaFpQrKbXuZrzLdB/M77XFqVuiW+WdJ5pj16yCWAGRIXPl5QrqlWXzEtQLHVDDTCiKBo2qwmC04=
X-Received: by 2002:a17:906:515:: with SMTP id
 j21mr2128924eja.105.1602058826478; 
 Wed, 07 Oct 2020 01:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602056784.git.tgolembi@redhat.com>
 <811a746b9a55adc0293ad80989dc9939e2490c1c.1602056784.git.tgolembi@redhat.com>
In-Reply-To: <811a746b9a55adc0293ad80989dc9939e2490c1c.1602056784.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Oct 2020 12:20:14 +0400
Message-ID: <CAJ+F1CLUzkQqc91LcZy5hc4tvvHLJeW0xZeuZJ0kQGTM3Sgxdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] qga: add implementation of guest-get-disks for
 Windows
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042f86d05b110630c"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000042f86d05b110630c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 7, 2020 at 11:46 AM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi=
@redhat.com>
wrote:

> The command lists all the physical disk drives. Unlike for Linux
> partitions and virtual volumes are not listed.
>
> Example output:
>
> {
>   "return": [
>     {
>       "name": "\\\\.\\PhysicalDrive0",
>       "partition": false,
>       "address": {
>         "serial": "QM00001",
>         "bus-type": "sata",
>         ...
>       },
>       "dependents": []
>     }
>   ]
> }
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 98 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 92 insertions(+), 6 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0dd16315d7..7fe5676785 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -979,6 +979,92 @@ out:
>      return list;
>  }
>
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
>

ERRP_GUARD?

+    GuestDiskInfoList *new =3D NULL, *ret =3D NULL;
> +    HDEVINFO dev_info;
> +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> +    int i;
> +
> +    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> +        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg_win32(errp, GetLastError(), "failed to get device
> tree");
> +        return NULL;
> +    }
> +
> +    g_debug("enumerating devices");
> +    dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);
> +    for (i =3D 0;
> +        SetupDiEnumDeviceInterfaces(dev_info, NULL,
> &GUID_DEVINTERFACE_DISK,
> +            i, &dev_iface_data);
> +        i++) {
> +        GuestDiskAddress *address =3D NULL;
> +        GuestDiskInfo *disk =3D NULL;
> +        Error *local_err =3D NULL;
> +        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
> +            pdev_iface_detail_data =3D NULL;
> +        STORAGE_DEVICE_NUMBER sdn;
> +        HANDLE dev_file;
> +        DWORD size =3D 0;
> +
> +        g_debug("  getting device path");
> +        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_dat=
a,
> +                pdev_iface_detail_data,
> +                size, &size,
> +                NULL)) {
> +            if (GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) {
> +                pdev_iface_detail_data =3D g_realloc(pdev_iface_detail_d=
ata,
> +                    size);
> +                pdev_iface_detail_data->cbSize =3D
> +                    sizeof(*pdev_iface_detail_data);
> +            } else {
> +                g_debug("failed to get device interface details");
> +                continue;
>

Is "continue" appropriate here? Looks like this may loop forever easily.

+            }
> +        }
> +
> +        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
> +        dev_file =3D CreateFile(pdev_iface_detail_data->DevicePath, 0,
> +            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> +        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
> +                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
> +            CloseHandle(dev_file);
> +            debug_error("failed to get storage device number");
> +            continue;
> +        }
> +        CloseHandle(dev_file);
> +
> +        disk =3D g_new0(GuestDiskInfo, 1);
> +        disk->name =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> +            sdn.DeviceNumber);
> +
> +        g_debug("  number: %lu", sdn.DeviceNumber);
> +        address =3D g_malloc0(sizeof(GuestDiskAddress));
> +        address->has_dev =3D true;
> +        address->dev =3D g_strdup(disk->name);
> +        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
> +        if (local_err) {
> +            g_debug("failed to get disk info: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            qapi_free_GuestDiskAddress(address);
> +            address =3D NULL;
> +        } else {
> +            disk->address =3D address;
> +            disk->has_address =3D true;
> +        }
> +
> +        new =3D g_malloc0(sizeof(GuestDiskInfoList));
> +        new->value =3D disk;
> +        new->next =3D ret;
> +        ret =3D new;
> +    }
> +
> +    SetupDiDestroyDeviceInfoList(dev_info);
> +    return ret;
> +}
> +
>  #else
>
>  static GuestDiskAddressList *build_guest_disk_info(char *guid, Error
> **errp)
> @@ -986,6 +1072,12 @@ static GuestDiskAddressList
> *build_guest_disk_info(char *guid, Error **errp)
>      return NULL;
>  }
>
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
>  #endif /* CONFIG_QGA_NTDDSCSI */
>
>  static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
> @@ -2457,9 +2549,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>      }
>      return head;
>  }
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> --
> 2.28.0
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000042f86d05b110630c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 7, 2020 at 11:46 AM Tom=
=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">t=
golembi@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The command lists all the physical disk drives. Unlike fo=
r Linux<br>
partitions and virtual volumes are not listed.<br>
<br>
Example output:<br>
<br>
{<br>
=C2=A0 &quot;return&quot;: [<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;\\\\.\\PhysicalDrive0&quot;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: false,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;address&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;serial&quot;: &quot;QM00001&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bus-type&quot;: &quot;sata&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 &quot;dependents&quot;: []<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 ]<br>
}<br>
<br>
Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgol=
embi@redhat.com" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 98 +++++++++++++++++++++++++++++++++++++++++--=
-<br>
=C2=A01 file changed, 92 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 0dd16315d7..7fe5676785 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -979,6 +979,92 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return list;<br>
=C2=A0}<br>
<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br></blockquote><div><br></div><div>ERRP_GUARD?</div><div> <br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 GuestDiskInfoList *new =3D NULL, *ret =3D NULL;<br>
+=C2=A0 =C2=A0 HDEVINFO dev_info;<br>
+=C2=A0 =C2=A0 SP_DEVICE_INTERFACE_DATA dev_iface_data;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 dev_info =3D SetupDiGetClassDevs(&amp;GUID_DEVINTERFACE_DISK=
, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);<br>
+=C2=A0 =C2=A0 if (dev_info =3D=3D INVALID_HANDLE_VALUE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to get device tree&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;enumerating devices&quot;);<br>
+=C2=A0 =C2=A0 dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);<=
br>
+=C2=A0 =C2=A0 for (i =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetupDiEnumDeviceInterfaces(dev_info, NULL, &a=
mp;GUID_DEVINTERFACE_DISK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, &amp;dev_iface_data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskAddress *address =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskInfo *disk =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_data =3D NULL;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 STORAGE_DEVICE_NUMBER sdn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HANDLE dev_file;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD size =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 getting device path&quot;=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (!SetupDiGetDeviceInterfaceDetail(dev_in=
fo, &amp;dev_iface_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_=
data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size, &amp;size,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetLastError() =3D=3D ERROR_=
INSUFFICIENT_BUFFER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_=
data =3D g_realloc(pdev_iface_detail_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_=
data-&gt;cbSize =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
of(*pdev_iface_detail_data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;fail=
ed to get device interface details&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br></blo=
ckquote><div><br></div><div>Is &quot;continue&quot; appropriate here? Looks=
 like this may loop forever easily.<br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 device: %s&quot;, pdev_if=
ace_detail_data-&gt;DevicePath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_file =3D CreateFile(pdev_iface_detail_data=
-&gt;DevicePath, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_SHARE_READ, NULL, OPEN_EXIS=
TING, 0, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoControl(dev_file, IOCTL_STORAGE_G=
ET_DEVICE_NUMBER,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, 0, &amp;sdn,=
 sizeof(sdn), &amp;size, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(dev_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug_error(&quot;failed to get =
storage device number&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(dev_file);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;name =3D g_strdup_printf(&quot;\\\\.\=
\PhysicalDrive%lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdn.DeviceNumber);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 number: %lu&quot;, sdn.De=
viceNumber);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 address =3D g_malloc0(sizeof(GuestDiskAddress)=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 address-&gt;has_dev =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 address-&gt;dev =3D g_strdup(disk-&gt;name);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_single_disk_info(sdn.DeviceNumber, address=
, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to get disk=
 info: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_get_pretty(l=
ocal_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestDiskAddress(addre=
ss);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;address =3D address;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;has_address =3D true;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D g_malloc0(sizeof(GuestDiskInfoList));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new-&gt;value =3D disk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new-&gt;next =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D new;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 SetupDiDestroyDeviceInfoList(dev_info);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#else<br>
<br>
=C2=A0static GuestDiskAddressList *build_guest_disk_info(char *guid, Error =
**errp)<br>
@@ -986,6 +1072,12 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
=C2=A0#endif /* CONFIG_QGA_NTDDSCSI */<br>
<br>
=C2=A0static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **er=
rp)<br>
@@ -2457,9 +2549,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-- <br>
2.28.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000042f86d05b110630c--

