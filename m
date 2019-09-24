Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E1C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F14221783
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqYNDQFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F14221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmcD-0005vc-2N
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iClfF-0005eI-DC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iClfD-0002A0-3d
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:19:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iClfC-00029B-S9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:19:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id i18so2151544wru.11
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cSvyQQax4MWyETDM1Nt1Xzw11QyTHTOZvX4JslXUpv0=;
 b=OqYNDQFNY5nG3vS7ZkuQpbQwLFNQy6Y6SvHxl/l4kirEX1GzpyUiWYCjfgGLo5m0bO
 ucgvVCKswAA9RE1DINYVPdIznJW2iiGvGyAAteJZAYNP3sCJc3WIrVtw5rD/oaELOJ1a
 0Gnc30xKWNXzg4boS7xOqpDm8dnlC4Fy+GCkNdpWz2ADbeup1148aLTwiuNuCwl9M5Kk
 9+Q1Xhkl1No7sD1SfH8nYK2qCq+eQ64/OUe8JsEm0wuuXZrn7kUczRCVkUwvtmh2f/CQ
 +DGx0CgodwDZ6Kqk2taXW6z2A7HkcHXGDTYb6ut2/VNtj7nISZBecNNcnexnwIZhL1pz
 et4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cSvyQQax4MWyETDM1Nt1Xzw11QyTHTOZvX4JslXUpv0=;
 b=knSJpSuyoMJGai7IZZDzQzwGPc/MuwpmQRAdWlmR3t8Lv/x1cs8NlAMnEepHiqVbW+
 4FnxAK0WkiuNT32pB0dIFAbiWHKdwRXh23Hod9eiuVCnrQtahNNoepM3T/0xZJbNoXe0
 FM72jW1IXmusEuyCCp1VpVl7p1j8tUd7YQxKGNImLy8WcmvwZGj1tIgMb4OsX+/J20VB
 /vsllZGtChd1I9PhYunOrK7Y2nzhpCRMiWzPQkCMZcfw6yteko0qWMXhRCauIQJ+mBxt
 l1BEbHKWLHlUVFOZMx72t2vLFdR73RwNmA8ALKPmkggwa/edz6LofcSzJ21LI2NsXPVy
 FFgg==
X-Gm-Message-State: APjAAAUcDM3ZGtHjkEUx1NeQo5xjRcDxPYzNFBDE9nGnoTF3EwlILpLu
 M0vHzUveR9x1YG40iQ4GL6i298hkq715U2kZt+o=
X-Google-Smtp-Source: APXvYqxY8S4zG2DZxoaRKfUjX8WO9PYNvfJASBSy59QMoJ3ifjG9W/1XezH/al8CDR9xCrQSavL8jTmru1BaVarTREw=
X-Received: by 2002:a5d:408c:: with SMTP id o12mr2683823wrp.312.1569334771808; 
 Tue, 24 Sep 2019 07:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <95b2f9d76104ee09b43159528b35b96eb01bbd8c.1569329826.git.tgolembi@redhat.com>
In-Reply-To: <95b2f9d76104ee09b43159528b35b96eb01bbd8c.1569329826.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Sep 2019 18:19:19 +0400
Message-ID: <CAJ+F1CJWfS67ZXEDCq43q7F1wh+rVSfhTzgrxsnns2+s7_ezhA@mail.gmail.com>
Subject: Re: [PATCH v2] qga: add command guest-get-devices for reporting
 VirtIO devices
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Sep 24, 2019 at 5:57 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi=
@redhat.com> wrote:
>
> Add command for reporting devices on Windows guest. The intent is not so
> much to report the devices but more importantly the driver (and its
> version) that is assigned to the device. This gives caller the
> information whether VirtIO drivers are installed and/or whether
> inadequate driver is used on a device (e.g. QXL device with base VGA
> driver).
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c |   9 ++
>  qga/commands-win32.c | 209 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/qapi-schema.json |  32 +++++++
>  3 files changed, 249 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dfc05f5b8a..58e93feef9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2757,6 +2757,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
>  #endif
>
> +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices")=
);
> +
>      return blacklist;
>  }
>
> @@ -2977,3 +2979,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>
>      return info;
>  }
> +
> +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +
> +    return NULL;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..14c5607b66 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -21,10 +21,11 @@
>  #ifdef CONFIG_QGA_NTDDSCSI
>  #include <winioctl.h>
>  #include <ntddscsi.h>
> +#endif
>  #include <setupapi.h>
>  #include <cfgmgr32.h>
>  #include <initguid.h>
> -#endif
> +#include <devpropdef.h>
>  #include <lm.h>
>  #include <wtsapi32.h>
>  #include <wininet.h>
> @@ -38,6 +39,34 @@
>  #include "qemu/host-utils.h"
>  #include "qemu/base64.h"
>
> +/*
> + * The following should be in devpkey.h, but it isn't. The key names wer=
e
> + * prefixed to avoid (future) name clashes. Once the definitions get int=
o
> + * mingw the following lines can be removed.
> + */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5, 0x=
f1, 0x02,
> +    0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);  /* DEVPROP_TYPE_STRING */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c, 0x=
4efd, 0x80,
> +    0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> +    /* DEVPROP_TYPE_STRING_LIST */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d, 0x4=
094, 0xad,
> +    0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);  /* DEVPROP_TYPE_FILETI=
ME */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d, =
0x4094,
> +    0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> +    /* DEVPROP_TYPE_STRING */
> +/* The following shoud be in cfgmgr32.h, but it isn't */
> +#ifndef CM_Get_DevNode_Property
> +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> +    DEVINST          dnDevInst,
> +    CONST DEVPROPKEY *PropertyKey,
> +    DEVPROPTYPE      *PropertyType,
> +    PBYTE            PropertyBuffer,
> +    PULONG           PropertyBufferSize,
> +    ULONG            ulFlags
> +);
> +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> +#endif
> +
>  #ifndef SHTDN_REASON_FLAG_PLANNED
>  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
>  #endif
> @@ -92,6 +121,8 @@ static OpenFlags guest_file_open_modes[] =3D {
>      g_free(suffix); \
>  } while (0)
>
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, qapi_free_GuestDeviceInfo=
)

This could be neatly auto-generated for all qapi types. Not necessary
for now, but if you feel like doing it, that would be great.

> +
>  static OpenFlags *find_open_flag(const char *mode_str)
>  {
>      int mode;
> @@ -2234,3 +2265,179 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>
>      return info;
>  }
> +
> +/*
> + * Safely get device property. Returned strings are using wide character=
s.
> + * Caller is responsible for freeing the buffer.
> + */
> +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propNam=
e,
> +    PDEVPROPTYPE propType)
> +{
> +    CONFIGRET cr;
> +    g_autofree LPBYTE buffer =3D NULL;
> +    ULONG buffer_len =3D 0;
> +
> +    /* First query for needed space */
> +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> +        buffer, &buffer_len, 0);
> +    if (cr !=3D CR_SUCCESS && cr !=3D CR_BUFFER_SMALL) {
> +
> +        slog("failed to get property size, error=3D0x%lx", cr);
> +        return NULL;
> +    }
> +    buffer =3D g_malloc(buffer_len+1);

I would still prefer g_new0() here.

> +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> +        buffer, &buffer_len, 0);
> +    if (cr !=3D CR_SUCCESS) {
> +        slog("failed to get device property, error=3D0x%lx", cr);
> +        return NULL;
> +    }
> +    return g_steal_pointer(&buffer);
> +}
> +
> +static GStrv ga_get_hardware_ids(DEVINST devInstance)
> +{
> +    GStrv hw_ids =3D NULL;
> +    g_autoptr(GSList) values =3D NULL;
> +    GSList *current =3D NULL;
> +    gsize count =3D 0, i =3D 0;
> +    DEVPROPTYPE cm_type;
> +    LPWSTR id;
> +    g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(devInstance,
> +        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
> +    if (property =3D=3D NULL) {
> +        slog("failed to get hardware IDs");
> +        return NULL;
> +    }
> +    if (*property =3D=3D '\0') {
> +        /* empty list */
> +        return NULL;
> +    }
> +    for (id =3D property; '\0' !=3D *id; id +=3D lstrlenW(id) + 1) {
> +        values =3D g_slist_append(values,
> +            g_utf16_to_utf8(id, -1, NULL, NULL, NULL));
> +        count++;
> +    }
> +    hw_ids =3D g_new(char*, count+1);
> +    current =3D values;
> +    i =3D 0;
> +    for (; current !=3D NULL; current =3D g_slist_next(current), i++) {
> +        hw_ids[i] =3D g_steal_pointer(&current->data);
> +    }

Instead of the glist dance, you could use zero-terminater GArray of
char *, you will have to cast (GStrv)g_array_free(ids, FALSE), but
that's expected.

> +    hw_ids[i] =3D NULL;
> +    return hw_ids;
> +}
> +
> +/*
> + * https://docs.microsoft.com/en-us/windows-hardware/drivers/install/ide=
ntifiers-for-pci-devices
> + */
> +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
> +
> +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> +{
> +    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =3D NU=
LL;
> +    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
> +    SP_DEVINFO_DATA dev_info_data;
> +    int i, j;
> +    GError *gerr =3D NULL;
> +    g_autoptr(GRegex) device_pci_re =3D NULL;
> +    DEVPROPTYPE cm_type;
> +
> +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> +        &gerr);
> +    g_assert(device_pci_re !=3D NULL);
> +
> +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_ALLC=
LASSES);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg(errp, "failed to get device tree");
> +        return NULL;
> +    }
> +
> +    slog("enumerating devices");
> +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
> +        bool skip =3D true;
> +        SYSTEMTIME utc_date;
> +        g_autofree LPWSTR name =3D NULL;
> +        g_autofree LPFILETIME date =3D NULL;
> +        g_autofree LPWSTR version =3D NULL;
> +        g_auto(GStrv) hw_ids =3D NULL;
> +        g_autoptr(GuestDeviceInfo) device =3D g_new0(GuestDeviceInfo, 1)=
;
> +        g_autofree char* vendor_id =3D NULL;
> +        g_autofree char* device_id =3D NULL;
> +
> +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &qga_DEVPKEY_NAME, &cm_type);
> +        if (name =3D=3D NULL) {
> +            slog("failed to get device description");
> +            continue;
> +        }
> +        device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NULL, NU=
LL);
> +        if (device->driver_name =3D=3D NULL) {
> +            error_setg(errp, "conversion to utf8 failed (driver name)");
> +            goto out;
> +        }
> +        slog("querying device: %s", device->driver_name);
> +        hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
> +        if (hw_ids =3D=3D NULL) {
> +            continue;
> +        }
> +        for (j=3D0; hw_ids[j] !=3D NULL; j++) {
> +            GMatchInfo *match_info;
> +            if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)=
) {
> +                continue;
> +            }
> +            skip =3D false;
> +            vendor_id =3D g_match_info_fetch(match_info, 1);
> +            device_id =3D g_match_info_fetch(match_info, 2);
> +            device->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16);
> +            device->device_id =3D g_ascii_strtoull(device_id, NULL, 16);
> +            g_match_info_free(match_info);
> +        }
> +        if (skip) {
> +            continue;
> +        }
> +
> +        version =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
> +        if (version =3D=3D NULL) {
> +            slog("failed to get driver version");
> +            continue;
> +        }
> +        device->driver_version =3D g_utf16_to_utf8(version, -1, NULL,
> +            NULL, NULL);
> +        if (device->driver_version =3D=3D NULL) {
> +            error_setg(errp, "conversion to utf8 failed (driver version)=
");
> +            goto out;
> +        }
> +
> +        date =3D (LPFILETIME)cm_get_property(dev_info_data.DevInst,
> +            &qga_DEVPKEY_Device_DriverDate, &cm_type);
> +        if (date =3D=3D NULL) {
> +            slog("failed to get driver date");
> +            continue;
> +        }
> +        FileTimeToSystemTime(date, &utc_date);
> +        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
> +            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> +
> +        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
> +            device->driver_date, device->driver_version);
> +        item =3D g_new0(GuestDeviceInfoList, 1);
> +        item->value =3D g_steal_pointer(&device);
> +        if (!cur_item) {
> +            head =3D cur_item =3D item;
> +        } else {
> +            cur_item->next =3D item;
> +            cur_item =3D item;
> +        }
> +        continue;
> +    }
> +
> +out:
> +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> +        SetupDiDestroyDeviceInfoList(dev_info);
> +    }
> +    return head;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index fb4605cc19..fe04ff2f39 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1242,3 +1242,35 @@
>  ##
>  { 'command': 'guest-get-osinfo',
>    'returns': 'GuestOSInfo' }
> +
> +##
> +# @GuestDeviceInfo:
> +#
> +# @vendor-id: vendor ID
> +# @device-id: device ID
> +# @driver-name: name of the associated driver
> +# @driver-date: driver release date in format YYYY-MM-DD
> +# @driver-version: driver version
> +#
> +# Since: 4.2
> +##
> +{ 'struct': 'GuestDeviceInfo',
> +  'data': {
> +      'vendor-id': 'uint16',
> +      'device-id': 'uint16',
> +      'driver-name': 'str',
> +      'driver-date': 'str',
> +      'driver-version': 'str'
> +      } }
> +
> +##
> +# @guest-get-devices:
> +#
> +# Retrieve information about device drivers in Windows guest
> +#
> +# Returns: @GuestDeviceInfo
> +#
> +# Since: 4.2
> +##
> +{ 'command': 'guest-get-devices',
> +  'returns': ['GuestDeviceInfo'] }
> --
> 2.23.0
>
>

Looks quite good overall, let see what others (and patchew) says about it :=
)

--=20
Marc-Andr=C3=A9 Lureau

