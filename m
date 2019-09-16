Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8169FC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDDA214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtgKqjxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDDA214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9qD7-0005n0-79
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 08:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i9qAx-0005Hw-M1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i9qAu-0003dJ-Rn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:32:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i9qAq-0003ZW-SR
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:32:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id 5so4099570wmg.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SUwUwufL9lveL5uw9gb1pI6NBfSGRm/gnbrUYqvCrH0=;
 b=AtgKqjxyR2CjbNeBVe1AqH/isOwRWf0HREAKdHU4FlbajDnomz4DZ9sy5L4xyDGT1Q
 jNhxJjs4aSAZHL1EmtQg0ZrSaueDj+4HVWWVynLzHTO9CbK0e5zBim/Fag4Sz5I6Dy55
 BKfFqDxUxBWVdxAs7ppHCiriWQpEozr6RAbZeIUwrZ00bLCEpQhiU3UTJmLmtHSWXHXo
 IfKcSBEDAGyZ6WYXHV/8SpmrPYf3wtGm/haXCXhqRwXbmCYvux3qh0YaWxUo0SX67eeK
 Muj6L3XpqQS+mZQsoU5TabFjgsRoD8mmBVz8Em1thLDyz04I/gacW3yDJZDGQr0a8ZUy
 4Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SUwUwufL9lveL5uw9gb1pI6NBfSGRm/gnbrUYqvCrH0=;
 b=pFZZ7fyhLdSXwTvH9YfFI94RXBWcZVNGt3AeX66QUEVA0EUsQSrDI2dV2Tf2ct3d+S
 uiVAlSoZJeDNKNQKFS2uNKKIu5v3t83GeYfOoHsppERs+tGtEQaKrPPyNWlAWnBHz+VC
 9CGocC0LhHRBP6Tw8kRhX/kE9kXjkiqBWaCDAJPhBuQ79Z6JYiSqj4QIHJo6VdWpkFUU
 21rzqGDveZAmOQyWNLxf9C5TtlD04EHc0dtYWjSPPvoXWPQ0InYLaa/RfZz3tl1mGTN+
 RS4/HY8w7JXaNd2B/tdcK17ccAkaJDxoZCAmvPmQ6Kv34RgW7oIzXixvRZqJocUGKvpM
 lMdQ==
X-Gm-Message-State: APjAAAXxD26vRlQMhK7YnGtbt2nUMCS3Q4WCQO3Cg35gsB0gtTY0ZdZo
 f3y9702iMESQxgUQoYtKuacw6xzaHRizD9GMT/Y=
X-Google-Smtp-Source: APXvYqxZnAewbLn9wJerNJKGU87iV0wIfXJiAV2w7ldzogcfRd1A/O4bfDqNxNsvQnGWyMGsgU9Hrf/AwF4sE3K922Y=
X-Received: by 2002:a1c:a552:: with SMTP id o79mr13766065wme.91.1568637123870; 
 Mon, 16 Sep 2019 05:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
In-Reply-To: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Sep 2019 16:31:49 +0400
Message-ID: <CAJ+F1C+4M4pHA01S__55ZWm-pzQYD1o6=KYw640oR3GTEiQ8nw@mail.gmail.com>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: Re: [Qemu-devel] [PATCH] qga: add command guest-get-devices for
 reporting VirtIO devices
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Aug 29, 2019 at 8:06 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi=
@redhat.com> wrote:
>
> Add command for reporting devices on Windows guest. The intent is not so
> much to report the devices but more importantly the driver (and its
> version) that is assigned to the device.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c |  11 +++
>  qga/commands-win32.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/qapi-schema.json |  32 +++++++
>  3 files changed, 237 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dfc05f5b8a..9adf8bb520 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2709,6 +2709,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>
>      return 0;
>  }
> +
>  #endif /* CONFIG_FSFREEZE */

extra line


>
>  #if !defined(CONFIG_FSTRIM)
> @@ -2757,6 +2758,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
>  #endif
>
> +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices")=
);
> +
>      return blacklist;
>  }
>
> @@ -2977,3 +2980,11 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
> +

extra EOF line

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..0bb93422c7 100644
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
> @@ -38,6 +39,36 @@
>  #include "qemu/host-utils.h"
>  #include "qemu/base64.h"
>
> +
> +/* The following should be in devpkey.h, but it isn't */
> +DEFINE_DEVPROPKEY(DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5, 0xf1, =
0x02,
> +    0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);  /* DEVPROP_TYPE_STRING */
> +DEFINE_DEVPROPKEY(DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c, 0x4efd=
, 0x80,
> +    0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> +    /* DEVPROP_TYPE_STRING_LIST */
> +DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d, 0x4094,=
 0xad,
> +    0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);  /* DEVPROP_TYPE_FILETI=
ME */
> +DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d, 0x40=
94,
> +    0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);

perhaps use a qemu prefix to avoid future clash?

> +    /* DEVPROP_TYPE_STRING */
> +/* The following should be in sal.h, but it isn't */
> +#ifndef _Out_writes_bytes_opt_
> +#define _Out_writes_bytes_opt_(s)
> +#endif

It got added in da215fcf5f001d1fdedf82e2f1407e8ff0b6d453
('include/sal: Update sal definitions').

#ifndef protects it, ok

> +/* The following shoud be in cfgmgr32.h, but it isn't */
> +#ifndef CM_Get_DevNode_Property
> +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> +    _In_  DEVINST               dnDevInst,
> +    _In_  CONST DEVPROPKEY    * PropertyKey,
> +    _Out_ DEVPROPTYPE         * PropertyType,
> +    _Out_writes_bytes_opt_(*PropertyBufferSize) PBYTE PropertyBuffer,
> +    _Inout_ PULONG              PropertyBufferSize,
> +    _In_  ULONG                 ulFlags
> +    );
> +#define CM_Get_DevNode_Property                  CM_Get_DevNode_Property=
W
> +#endif
> +

#ifndef should protect it from future clash, ok

Did you open bugs for mingw64 updates?

> +
>  #ifndef SHTDN_REASON_FLAG_PLANNED
>  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
>  #endif
> @@ -2234,3 +2265,165 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
> +    LPBYTE buffer =3D NULL;
> +    ULONG bufferLen =3D 0;
> +
> +    /* First query for needed space */
> +    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
> +        buffer, &bufferLen, 0);

I think qemu-ga win32 code generally prefers to be explicit about A()
vs W(), call the W function explicitely, remove the generic define.

> +    if ((cr !=3D CR_SUCCESS) && (cr !=3D CR_BUFFER_SMALL)) {


This file is not a good example, but in general we avoid the extra
parenthesis. Please drop them.

> +
> +        g_debug(
> +            "failed to get size of device property, device error code=3D=
%lx",
> +            cr);

That file uses a mix of slog and g_debug..

I think slog() is higher level and preferable here. At least, try to
make it fit on one line would be nice.

> +        return NULL;
> +    }
> +    buffer =3D (LPBYTE)g_malloc(bufferLen);

I'd suggest g_malloc0(len+1) to avoid surprises.

Drop the cast.

> +    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
> +        buffer, &bufferLen, 0);
> +    if (cr !=3D CR_SUCCESS) {
> +        g_free(buffer);

you could use g_auto declaration these days (I know, it wasn't there
when you started, but now it is ;).

> +        g_debug(
> +            "failed to get device property, device error code=3D%lx", cr=
);

same about slog

> +        return NULL;
> +    }
> +    return buffer;
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
> +    int i;
> +    GError *gerr =3D NULL;
> +    GRegex *device_pci_re =3D NULL;
> +
> +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> +        &gerr);
> +
> +    if (gerr) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> +        g_error_free(gerr);
> +        goto out;
> +    }

given that the rule is static, I think you could simplify error
handling and use g_assert(device_pci_re !=3D NULL) instead.

> +
> +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_ALLC=
LASSES);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg(errp, "failed to get device tree");
> +        goto out;
> +    }
> +
> +    g_debug("enumerating devices");
> +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
> +        LPWSTR name =3D NULL, hwIDs =3D NULL, lpValue;
> +        bool skip =3D true;
> +        DEVPROPTYPE cmType;
> +        SYSTEMTIME stUTC;
> +        LPFILETIME pfdDriverDate;
> +        LPWSTR driverVersion;
> +
> +        GuestDeviceInfo *device =3D g_new0(GuestDeviceInfo, 1);
> +
> +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst, &DEVPKEY=
_NAME,
> +            &cmType);
> +        if (name =3D=3D NULL) {
> +            g_debug("failed to get device description");
> +            goto next;
> +        }
> +        device->driver_name =3D guest_wctomb_dup(name);

QMP strings should be utf8 encoded.

No idea why guest_wctomb_dup() was introduced in the first place to use ANS=
I CP.

Imho, every strings returned by W() functions should go through
g_utf16_to_utf8().


> +        g_free(name);
> +        g_debug("querying device: %s", device->driver_name);
> +
> +        hwIDs =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &DEVPKEY_Device_HardwareIds, &cmType);
> +        if (hwIDs =3D=3D NULL) {
> +            g_debug("failed to get hardware IDs");
> +            goto next;
> +        }
> +        for (lpValue =3D hwIDs;
> +            '\0' !=3D *lpValue;
> +            lpValue +=3D lstrlenW(lpValue) + 1) {

ok (alternatively, introduce a function that returns a GStrv to make
caller life easier.

> +            GMatchInfo *match_info;
> +            char *hwID =3D guest_wctomb_dup(lpValue);
> +            /* g_debug("hwID: %s", hwID); */
> +            if (!g_regex_match(device_pci_re, hwID, 0, &match_info)) {
> +                continue;

leaks hwID

> +            }
> +            skip =3D false;
> +            device->vendor_id =3D g_match_info_fetch(match_info, 1);
> +            device->device_id =3D g_match_info_fetch(match_info, 2);
> +            g_match_info_free(match_info);
> +        }
> +        free(hwIDs);

Let's stick to g_free() as you g_malloc()

> +
> +        if (skip) {
> +            goto next;
> +        }
> +
> +        driverVersion =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &DEVPKEY_Device_DriverVersion, &cmType);
> +        if (driverVersion =3D=3D NULL) {
> +            g_debug("failed to get driver version");
> +            goto next;
> +        }
> +        device->driver_version =3D guest_wctomb_dup(driverVersion);

I'd use g_utf16_to_utf8()

> +        free(driverVersion);

g_free()

> +
> +        pfdDriverDate =3D (LPFILETIME)cm_get_property(dev_info_data.DevI=
nst,
> +            &DEVPKEY_Device_DriverDate, &cmType);
> +        if (driverVersion =3D=3D NULL) {
> +            g_debug("failed to get driver date");
> +            goto next;
> +        }
> +        FileTimeToSystemTime(pfdDriverDate, &stUTC);
> +        free(pfdDriverDate);

g_free()

> +        device->driver_date =3D g_strdup_printf("%02d/%02d/%04d",
> +            stUTC.wMonth, stUTC.wDay, stUTC.wYear);
> +        g_debug("Driver Version: %s,%s\n", device->driver_date,
> +            device->driver_version);
> +
> +        item =3D g_new0(GuestDeviceInfoList, 1);
> +        item->value =3D device;
> +        if (!cur_item) {
> +            head =3D cur_item =3D item;
> +        } else {
> +            cur_item->next =3D item;
> +            cur_item =3D item;
> +        }
> +        continue;
> +
> +next:
> +        g_free(device->vendor_id);
> +        g_free(device->device_id);
> +        g_free(device->driver_date);
> +        g_free(device->driver_name);
> +        g_free(device->driver_version);
> +        g_free(device);

Please switch to g_auto

> +    }
> +
> +out:
> +
> +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> +        SetupDiDestroyDeviceInfoList(dev_info);
> +    }
> +    g_regex_unref(device_pci_re);
> +
> +    return head;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index fb4605cc19..ed73b0b1c6 100644
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
> +# @vendor-id: vendor ID as hexadecimal string in uper case without 0x pr=
efix
> +# @device-id: device ID as hexadecimal string in uper case without 0x pr=
efix
> +# @driver-name: name of the associated driver
> +# @driver-date: driver release date in format MM/DD/YY
> +# @driver-version: driver version
> +#
> +# Since: 4.1.1
> +##
> +{ 'struct': 'GuestDeviceInfo',
> +  'data': {
> +      'vendor-id': 'str',
> +      'device-id': 'str',
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
> +# Returns: @GuestOSInfo

@GuestDeviceInfo

> +#
> +# Since: 4.1.1
> +##
> +{ 'command': 'guest-get-devices',
> +  'returns': ['GuestDeviceInfo'] }
> --
> 2.22.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

