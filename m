Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1AEC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D0821920
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWzJAOci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D0821920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAY4x-0004Oo-Lc
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1iAY3z-0003pt-TO
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1iAY3x-0004kW-Iq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:23:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1iAY3x-0004jl-4l
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568805835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOu8IwhnlZ1puU4teFopcoBO6+/kgvpHJLEtlMfLhZI=;
 b=eWzJAOcifEIIgEcI48ge2q/UKhb4X1uiCtZJqABgNsThC8C51Er3rdHdoZYhVyA07d4WBc
 7TVLBy/39QTqKXf45NXTntqzq3xsy6m92R/hCgpL2IndGqWyKlqdxApswrxf1DrmfSw/je
 bnIHht7eh3f1u1HYWTNRyeqIn8Jq+VU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-IFbOBQL2MgqxyjBpIAsq6w-1; Wed, 18 Sep 2019 07:23:54 -0400
Received: by mail-wm1-f70.google.com with SMTP id r21so848227wme.5
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=LEG/ua8oYsjsNKk0ErU/HBtVr81lWRoX7ScKZHLg37Y=;
 b=Czv3aMmjGXWDSFrwpPDi9BtZjicVWLxzScvVMGuuaskg3olb71DY4OQB//o7Lm4942
 PtvbDxJcNmFUqWEap5xkKHSOXaMmhYtT1zQNOIBs3RV6G714ClT+0gG4N/Nr26m6HFy5
 lnF3yuTkL0L2s8h+nRqB/iiAXb8rs1iUESueNzVNwXnw14QZgRwX5o1166UGJB3C/EIp
 MEUPY4Os+LT2hpz1NjGVMmQq5nnJEfa7yzgdmWQZjbTLpHjtpOY/vEEwq/Vu9VdNaBLg
 1wQAh1SxCKN23AGQIQfX4FMJjpCUAYdwcBpw3wttiuoAyYbTgVit2mDn6YEIcQEXSd7+
 idBw==
X-Gm-Message-State: APjAAAUUgeNa7BaFwNtmpJtatgfk12Ik1z42TDfabhs8Sm83wVVIMm+v
 wLI2pWwUzaQSFH8ktKmsp3ZvPIz8ZuFV5Y82+3J1U0K9CqAxWiznDPmDDA1u/Gnz7CTrshgPhsR
 no99n/B3hfvH5TXM=
X-Received: by 2002:adf:e392:: with SMTP id e18mr2829526wrm.87.1568805832798; 
 Wed, 18 Sep 2019 04:23:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2V/Oj84s+TkTvRmbGlTppsWLBgDHmGcT+T4XBaoRjoo9Ig0pcKFryHU9LYmHEejRrvDfgTQ==
X-Received: by 2002:adf:e392:: with SMTP id e18mr2829501wrm.87.1568805832451; 
 Wed, 18 Sep 2019 04:23:52 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 v6sm4980002wma.24.2019.09.18.04.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 04:23:51 -0700 (PDT)
Date: Wed, 18 Sep 2019 13:23:51 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190918112349.pjte7ldptu2fqjyx@auriga.localdomain>
References: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
 <CAJ+F1C+4M4pHA01S__55ZWm-pzQYD1o6=KYw640oR3GTEiQ8nw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+4M4pHA01S__55ZWm-pzQYD1o6=KYw640oR3GTEiQ8nw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: IFbOBQL2MgqxyjBpIAsq6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

On Mon, Sep 16, 2019 at 04:31:49PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Aug 29, 2019 at 8:06 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolem=
bi@redhat.com> wrote:
> >
> > Add command for reporting devices on Windows guest. The intent is not s=
o
> > much to report the devices but more importantly the driver (and its
> > version) that is assigned to the device.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c |  11 +++
> >  qga/commands-win32.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
> >  qga/qapi-schema.json |  32 +++++++
> >  3 files changed, 237 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index dfc05f5b8a..9adf8bb520 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -2709,6 +2709,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
> >
> >      return 0;
> >  }
> > +
> >  #endif /* CONFIG_FSFREEZE */
>=20
> extra line
>=20
>=20
> >
> >  #if !defined(CONFIG_FSTRIM)
> > @@ -2757,6 +2758,8 @@ GList *ga_command_blacklist_init(GList *blacklist=
)
> >      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
> >  #endif
> >
> > +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices=
"));
> > +
> >      return blacklist;
> >  }
> >
> > @@ -2977,3 +2980,11 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> >
> >      return info;
> >  }
> > +
> > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > +{
> > +    error_setg(errp, QERR_UNSUPPORTED);
> > +
> > +    return NULL;
> > +}
> > +
>=20
> extra EOF line
>=20
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 6b67f16faf..0bb93422c7 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -21,10 +21,11 @@
> >  #ifdef CONFIG_QGA_NTDDSCSI
> >  #include <winioctl.h>
> >  #include <ntddscsi.h>
> > +#endif
> >  #include <setupapi.h>
> >  #include <cfgmgr32.h>
> >  #include <initguid.h>
> > -#endif
> > +#include <devpropdef.h>
> >  #include <lm.h>
> >  #include <wtsapi32.h>
> >  #include <wininet.h>
> > @@ -38,6 +39,36 @@
> >  #include "qemu/host-utils.h"
> >  #include "qemu/base64.h"
> >
> > +
> > +/* The following should be in devpkey.h, but it isn't */
> > +DEFINE_DEVPROPKEY(DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5, 0xf1=
, 0x02,
> > +    0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);  /* DEVPROP_TYPE_STRING */
> > +DEFINE_DEVPROPKEY(DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c, 0x4e=
fd, 0x80,
> > +    0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> > +    /* DEVPROP_TYPE_STRING_LIST */
> > +DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d, 0x409=
4, 0xad,
> > +    0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);  /* DEVPROP_TYPE_FILE=
TIME */
> > +DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d, 0x=
4094,
> > +    0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
>=20
> perhaps use a qemu prefix to avoid future clash?

Yes, this looks like the only option.

>=20
> > +    /* DEVPROP_TYPE_STRING */
> > +/* The following should be in sal.h, but it isn't */
> > +#ifndef _Out_writes_bytes_opt_
> > +#define _Out_writes_bytes_opt_(s)
> > +#endif
>=20
> It got added in da215fcf5f001d1fdedf82e2f1407e8ff0b6d453
> ('include/sal: Update sal definitions').

Right, but that's still not available on CentOS. Anyway, I am dropping
all the _*_ keywords from the definition below in followup version.

>=20
> #ifndef protects it, ok
>=20
> > +/* The following shoud be in cfgmgr32.h, but it isn't */
> > +#ifndef CM_Get_DevNode_Property
> > +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> > +    _In_  DEVINST               dnDevInst,
> > +    _In_  CONST DEVPROPKEY    * PropertyKey,
> > +    _Out_ DEVPROPTYPE         * PropertyType,
> > +    _Out_writes_bytes_opt_(*PropertyBufferSize) PBYTE PropertyBuffer,
> > +    _Inout_ PULONG              PropertyBufferSize,
> > +    _In_  ULONG                 ulFlags
> > +    );
> > +#define CM_Get_DevNode_Property                  CM_Get_DevNode_Proper=
tyW
> > +#endif
> > +
>=20
> #ifndef should protect it from future clash, ok
>=20
> Did you open bugs for mingw64 updates?

It was stuck on my TODO list for some time, but yeah I already posted a
patch for that. Thanks for reminding me.

>=20
> > +
> >  #ifndef SHTDN_REASON_FLAG_PLANNED
> >  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
> >  #endif
> > @@ -2234,3 +2265,165 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> >
> >      return info;
> >  }
> > +
> > +/*
> > + * Safely get device property. Returned strings are using wide charact=
ers.
> > + * Caller is responsible for freeing the buffer.
> > + */
> > +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propN=
ame,
> > +    PDEVPROPTYPE propType)
> > +{
> > +    CONFIGRET cr;
> > +    LPBYTE buffer =3D NULL;
> > +    ULONG bufferLen =3D 0;
> > +
> > +    /* First query for needed space */
> > +    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
> > +        buffer, &bufferLen, 0);
>=20
> I think qemu-ga win32 code generally prefers to be explicit about A()
> vs W(), call the W function explicitely, remove the generic define.
>=20
> > +    if ((cr !=3D CR_SUCCESS) && (cr !=3D CR_BUFFER_SMALL)) {
>=20
>=20
> This file is not a good example, but in general we avoid the extra
> parenthesis. Please drop them.
>=20
> > +
> > +        g_debug(
> > +            "failed to get size of device property, device error code=
=3D%lx",
> > +            cr);
>=20
> That file uses a mix of slog and g_debug..
>=20
> I think slog() is higher level and preferable here. At least, try to
> make it fit on one line would be nice.
>=20
> > +        return NULL;
> > +    }
> > +    buffer =3D (LPBYTE)g_malloc(bufferLen);
>=20
> I'd suggest g_malloc0(len+1) to avoid surprises.
>=20
> Drop the cast.
>=20
> > +    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
> > +        buffer, &bufferLen, 0);
> > +    if (cr !=3D CR_SUCCESS) {
> > +        g_free(buffer);
>=20
> you could use g_auto declaration these days (I know, it wasn't there
> when you started, but now it is ;).
>=20
> > +        g_debug(
> > +            "failed to get device property, device error code=3D%lx", =
cr);
>=20
> same about slog
>=20
> > +        return NULL;
> > +    }
> > +    return buffer;
> > +}
> > +
> > +/*
> > + * https://docs.microsoft.com/en-us/windows-hardware/drivers/install/i=
dentifiers-for-pci-devices
> > + */
> > +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
> > +
> > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > +{
> > +    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =3D =
NULL;
> > +    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
> > +    SP_DEVINFO_DATA dev_info_data;
> > +    int i;
> > +    GError *gerr =3D NULL;
> > +    GRegex *device_pci_re =3D NULL;
> > +
> > +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> > +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> > +        &gerr);
> > +
> > +    if (gerr) {
> > +        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> > +        g_error_free(gerr);
> > +        goto out;
> > +    }
>=20
> given that the rule is static, I think you could simplify error
> handling and use g_assert(device_pci_re !=3D NULL) instead.
>=20
> > +
> > +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> > +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_AL=
LCLASSES);
> > +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> > +        error_setg(errp, "failed to get device tree");
> > +        goto out;
> > +    }
> > +
> > +    g_debug("enumerating devices");
> > +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); =
i++) {
> > +        LPWSTR name =3D NULL, hwIDs =3D NULL, lpValue;
> > +        bool skip =3D true;
> > +        DEVPROPTYPE cmType;
> > +        SYSTEMTIME stUTC;
> > +        LPFILETIME pfdDriverDate;
> > +        LPWSTR driverVersion;
> > +
> > +        GuestDeviceInfo *device =3D g_new0(GuestDeviceInfo, 1);
> > +
> > +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst, &DEVPK=
EY_NAME,
> > +            &cmType);
> > +        if (name =3D=3D NULL) {
> > +            g_debug("failed to get device description");
> > +            goto next;
> > +        }
> > +        device->driver_name =3D guest_wctomb_dup(name);
>=20
> QMP strings should be utf8 encoded.
>=20
> No idea why guest_wctomb_dup() was introduced in the first place to use A=
NSI CP.
>=20
> Imho, every strings returned by W() functions should go through
> g_utf16_to_utf8().

Great! guest_wctomb_dup() seemed fishy to me from the start.

>=20
>=20
> > +        g_free(name);
> > +        g_debug("querying device: %s", device->driver_name);
> > +
> > +        hwIDs =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > +            &DEVPKEY_Device_HardwareIds, &cmType);
> > +        if (hwIDs =3D=3D NULL) {
> > +            g_debug("failed to get hardware IDs");
> > +            goto next;
> > +        }
> > +        for (lpValue =3D hwIDs;
> > +            '\0' !=3D *lpValue;
> > +            lpValue +=3D lstrlenW(lpValue) + 1) {
>=20
> ok (alternatively, introduce a function that returns a GStrv to make
> caller life easier.

I don't think I follow. Which part would you like to move into a
function?

>=20
> > +            GMatchInfo *match_info;
> > +            char *hwID =3D guest_wctomb_dup(lpValue);
> > +            /* g_debug("hwID: %s", hwID); */
> > +            if (!g_regex_match(device_pci_re, hwID, 0, &match_info)) {
> > +                continue;
>=20
> leaks hwID
>=20
> > +            }
> > +            skip =3D false;
> > +            device->vendor_id =3D g_match_info_fetch(match_info, 1);
> > +            device->device_id =3D g_match_info_fetch(match_info, 2);
> > +            g_match_info_free(match_info);
> > +        }
> > +        free(hwIDs);
>=20
> Let's stick to g_free() as you g_malloc()
>=20
> > +
> > +        if (skip) {
> > +            goto next;
> > +        }
> > +
> > +        driverVersion =3D (LPWSTR)cm_get_property(dev_info_data.DevIns=
t,
> > +            &DEVPKEY_Device_DriverVersion, &cmType);
> > +        if (driverVersion =3D=3D NULL) {
> > +            g_debug("failed to get driver version");
> > +            goto next;
> > +        }
> > +        device->driver_version =3D guest_wctomb_dup(driverVersion);
>=20
> I'd use g_utf16_to_utf8()
>=20
> > +        free(driverVersion);
>=20
> g_free()
>=20
> > +
> > +        pfdDriverDate =3D (LPFILETIME)cm_get_property(dev_info_data.De=
vInst,
> > +            &DEVPKEY_Device_DriverDate, &cmType);
> > +        if (driverVersion =3D=3D NULL) {
> > +            g_debug("failed to get driver date");
> > +            goto next;
> > +        }
> > +        FileTimeToSystemTime(pfdDriverDate, &stUTC);
> > +        free(pfdDriverDate);
>=20
> g_free()
>=20
> > +        device->driver_date =3D g_strdup_printf("%02d/%02d/%04d",
> > +            stUTC.wMonth, stUTC.wDay, stUTC.wYear);
> > +        g_debug("Driver Version: %s,%s\n", device->driver_date,
> > +            device->driver_version);
> > +
> > +        item =3D g_new0(GuestDeviceInfoList, 1);
> > +        item->value =3D device;
> > +        if (!cur_item) {
> > +            head =3D cur_item =3D item;
> > +        } else {
> > +            cur_item->next =3D item;
> > +            cur_item =3D item;
> > +        }
> > +        continue;
> > +
> > +next:
> > +        g_free(device->vendor_id);
> > +        g_free(device->device_id);
> > +        g_free(device->driver_date);
> > +        g_free(device->driver_name);
> > +        g_free(device->driver_version);
> > +        g_free(device);
>=20
> Please switch to g_auto

Aye, aye, captain!

>=20
> > +    }
> > +
> > +out:
> > +
> > +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> > +        SetupDiDestroyDeviceInfoList(dev_info);
> > +    }
> > +    g_regex_unref(device_pci_re);
> > +
> > +    return head;
> > +}
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index fb4605cc19..ed73b0b1c6 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1242,3 +1242,35 @@
> >  ##
> >  { 'command': 'guest-get-osinfo',
> >    'returns': 'GuestOSInfo' }
> > +
> > +##
> > +# @GuestDeviceInfo:
> > +#
> > +# @vendor-id: vendor ID as hexadecimal string in uper case without 0x =
prefix
> > +# @device-id: device ID as hexadecimal string in uper case without 0x =
prefix
> > +# @driver-name: name of the associated driver
> > +# @driver-date: driver release date in format MM/DD/YY
> > +# @driver-version: driver version
> > +#
> > +# Since: 4.1.1
> > +##
> > +{ 'struct': 'GuestDeviceInfo',
> > +  'data': {
> > +      'vendor-id': 'str',
> > +      'device-id': 'str',
> > +      'driver-name': 'str',
> > +      'driver-date': 'str',
> > +      'driver-version': 'str'
> > +      } }
> > +
> > +##
> > +# @guest-get-devices:
> > +#
> > +# Retrieve information about device drivers in Windows guest
> > +#
> > +# Returns: @GuestOSInfo
>=20
> @GuestDeviceInfo
>=20
> > +#
> > +# Since: 4.1.1
> > +##
> > +{ 'command': 'guest-get-devices',
> > +  'returns': ['GuestDeviceInfo'] }
> > --
> > 2.22.0
> >
> >
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


