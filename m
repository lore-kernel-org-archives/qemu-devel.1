Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFAB206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtLWD9kD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFAB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuDQ-0001tE-SE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1jxuCe-0001PR-6O
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:29:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1jxuCa-0006IU-QG
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595345347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utHBjzq740fCyvjGDpQ2eJIDVcfublzglWpU9LT9V10=;
 b=NtLWD9kDsmwrnqD7Ka5SKhn2erOcG9M66uDgOEt9nKaFHja+Zt0l8qA8dcfIDskbU/OR5L
 PDja1XEvGcZF4wTvp1e8mXwqAL3A8j0PJKZ5a1mIQlcLSxEPwK0kwxBGE2f0X8/WXrvIXN
 vldcvtoWBcYVWWOvvylyqyAjbkA+1po=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-nKlb3sp1ORq1JnwP4v2ynQ-1; Tue, 21 Jul 2020 11:28:59 -0400
X-MC-Unique: nKlb3sp1ORq1JnwP4v2ynQ-1
Received: by mail-wr1-f71.google.com with SMTP id 5so2125117wrc.17
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=IlMrRZ5NynCUTDROAB/9M0X1A8H2X4hYa/yECslg7y4=;
 b=MIusj7cWaEQIaBqy/Glj3D0aYh2UpXFX+/TOH6Njclh9ILYz4GURRs9T05cfshTRky
 eeS228yjXGQzxtYEnvEpbe/xKg/MWjzdJ/Lhy+T/q9mGFNvEpn4ReOwOBpFdMuKK3c4f
 lBl1axnTVtaa0inK2TviRPDBw8JkMK4UXCsTvm3iA0fvT5fDWhuyvk2+xiiEmzIDG/Tz
 5ISka5yE/vP7iRW9F4SHu7U9nUSKkM8ajGe4deFhVfc0G67c7iIUxLl/J0Utalae20ZW
 qzFumhq3sb0m7iCm5GRuk1eDDn8LFTQUD6cg6i5e/llPaJErGvGyKYScYqVgYBmhDsUF
 RCDQ==
X-Gm-Message-State: AOAM5311HCI65tFu8/uMfoYO3fV+/sWxaUsIauv/f8TrF8nIzdHdHMRB
 VO4eyJ24C4FS469UlDf7BSXfAMZJ7Vi+1p6HLDoDERZWPFEnanGM8mlcSdfFD8+FSNj3dcMEPhS
 +Q8XPy+YgHWDac+c=
X-Received: by 2002:a1c:e405:: with SMTP id b5mr4886640wmh.54.1595345338099;
 Tue, 21 Jul 2020 08:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytur6urg2KFebCwcuGlaSNubuEjxs7oEypRw1AeY2kvIoYSkaqoNlUCRAQ3oQEa+i42Ia02g==
X-Received: by 2002:a1c:e405:: with SMTP id b5mr4886612wmh.54.1595345337715;
 Tue, 21 Jul 2020 08:28:57 -0700 (PDT)
Received: from fiorina (ip-94-112-73-67.net.upcbroadband.cz. [94.112.73.67])
 by smtp.gmail.com with ESMTPSA id v5sm3613934wmh.12.2020.07.21.08.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 08:28:57 -0700 (PDT)
Date: Tue, 21 Jul 2020 17:28:54 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v9] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <20200721172854.4b5719d8@fiorina>
In-Reply-To: <20200721114335.GF843362@redhat.com>
References: <e4f1b62bedb243ec46351a264c4e08f800655daa.1578573547.git.tgolembi@redhat.com>
 <20200721100155.17c26c05@fiorina>
 <CAJ+F1CJgcwLiYWioPayiKXuoUSKAffLWaS_V-TTve2DJeoLu7Q@mail.gmail.com>
 <20200721114335.GF843362@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:58:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 12:43:35 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Jul 21, 2020 at 03:31:52PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Tue, Jul 21, 2020 at 12:03 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgo=
lembi@redhat.com>
> > wrote:
> >  =20
> > > Ping. Can we get this merged finally?
> > > =20
> >=20
> > We missed the feature deadline by a week:
> > https://wiki.qemu.org/Planning/5.1 =20
>=20
> Note, if a patch series from a contributor is ready, the subsystem
> maintainer should queue it in their subsystem tree, so it is ready
> for a pull request when the main tree opens up again. ie the subsys
> maintainer is the one responsible for dealing with feature freeze
> coordination, not the individual contriubutors.
>=20
> In this case the "Since 5.0" tags need updating to 5.2 now. The
> maintainer could handle this, but since this series is over 6 months
> old now, it is probably worth rebasing & reposting.

Good point. I will rebase and post again.

    Tomas

>=20
> > > Thanks,
> > >
> > >     Tomas
> > >
> > > On Thu,  9 Jan 2020 13:39:36 +0100
> > > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
> > > =20
> > > > Add command for reporting devices on Windows guest. The intent is n=
ot so
> > > > much to report the devices but more importantly the driver (and its
> > > > version) that is assigned to the device. This gives caller the
> > > > information whether VirtIO drivers are installed and/or whether
> > > > inadequate driver is used on a device (e.g. QXL device with base VG=
A
> > > > driver).
> > > >
> > > > Example:
> > > > [
> > > >     {
> > > >       "driver-date": "2019-08-12",
> > > >       "driver-name": "Red Hat VirtIO SCSI controller",
> > > >       "driver-version": "100.80.104.17300",
> > > >       "address": {
> > > >         "type": "pci",
> > > >         "data": {
> > > >           "device-id": 4162,
> > > >           "vendor-id": 6900
> > > >         }
> > > >       }
> > > >     },
> > > >     ...
> > > > ]
> > > >
> > > > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.c=
om>
> > > > ---
> > > >
> > > > Changes in v9: fixed compilation errors
> > > >
> > > >  qga/commands-posix.c |   9 ++
> > > >  qga/commands-win32.c | 212 +++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  qga/qapi-schema.json |  51 +++++++++++
> > > >  3 files changed, 271 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > > index 93474ff770..bffee8ce48 100644
> > > > --- a/qga/commands-posix.c
> > > > +++ b/qga/commands-posix.c
> > > > @@ -2771,6 +2771,8 @@ GList *ga_command_blacklist_init(GList *black=
list)
> > > >      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"=
));
> > > >  #endif
> > > >
> > > > +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-dev=
ices"));
> > > > +
> > > >      return blacklist;
> > > >  }
> > > >
> > > > @@ -2991,3 +2993,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **er=
rp)
> > > >
> > > >      return info;
> > > >  }
> > > > +
> > > > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > > > +{
> > > > +    error_setg(errp, QERR_UNSUPPORTED);
> > > > +
> > > > +    return NULL;
> > > > +}
> > > > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > > > index 2461fd19bf..b18d89d7ad 100644
> > > > --- a/qga/commands-win32.c
> > > > +++ b/qga/commands-win32.c
> > > > @@ -21,10 +21,11 @@
> > > >  #ifdef CONFIG_QGA_NTDDSCSI
> > > >  #include <winioctl.h>
> > > >  #include <ntddscsi.h>
> > > > +#endif
> > > >  #include <setupapi.h>
> > > >  #include <cfgmgr32.h>
> > > >  #include <initguid.h>
> > > > -#endif
> > > > +#include <devpropdef.h>
> > > >  #include <lm.h>
> > > >  #include <wtsapi32.h>
> > > >  #include <wininet.h>
> > > > @@ -38,6 +39,36 @@
> > > >  #include "qemu/host-utils.h"
> > > >  #include "qemu/base64.h"
> > > >
> > > > +/*
> > > > + * The following should be in devpkey.h, but it isn't. The key nam=
es =20
> > > were =20
> > > > + * prefixed to avoid (future) name clashes. Once the definitions g=
et =20
> > > into =20
> > > > + * mingw the following lines can be removed.
> > > > + */
> > > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0x=
a5,
> > > > +    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
> > > > +    /* DEVPROP_TYPE_STRING */
> > > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf=
1c,
> > > > +    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> > > > +    /* DEVPROP_TYPE_STRING_LIST */
> > > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3=
d,
> > > > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
> > > > +    /* DEVPROP_TYPE_FILETIME */
> > > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x=
2e3d,
> > > > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> > > > +    /* DEVPROP_TYPE_STRING */
> > > > +/* The following shoud be in cfgmgr32.h, but it isn't */
> > > > +#ifndef CM_Get_DevNode_Property
> > > > +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> > > > +    DEVINST          dnDevInst,
> > > > +    CONST DEVPROPKEY * PropertyKey,
> > > > +    DEVPROPTYPE      * PropertyType,
> > > > +    PBYTE            PropertyBuffer,
> > > > +    PULONG           PropertyBufferSize,
> > > > +    ULONG            ulFlags
> > > > +);
> > > > +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> > > > +#endif
> > > > +
> > > >  #ifndef SHTDN_REASON_FLAG_PLANNED
> > > >  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
> > > >  #endif
> > > > @@ -92,6 +123,8 @@ static OpenFlags guest_file_open_modes[] =3D {
> > > >      g_free(suffix); \
> > > >  } while (0)
> > > >
> > > > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, =20
> > > qapi_free_GuestDeviceInfo) =20
> > > > +
> > > >  static OpenFlags *find_open_flag(const char *mode_str)
> > > >  {
> > > >      int mode;
> > > > @@ -2234,3 +2267,180 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **e=
rrp)
> > > >
> > > >      return info;
> > > >  }
> > > > +
> > > > +/*
> > > > + * Safely get device property. Returned strings are using wide =20
> > > characters. =20
> > > > + * Caller is responsible for freeing the buffer.
> > > > + */
> > > > +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY =
=20
> > > *propName, =20
> > > > +    PDEVPROPTYPE propType)
> > > > +{
> > > > +    CONFIGRET cr;
> > > > +    g_autofree LPBYTE buffer =3D NULL;
> > > > +    ULONG buffer_len =3D 0;
> > > > +
> > > > +    /* First query for needed space */
> > > > +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > > > +        buffer, &buffer_len, 0);
> > > > +    if (cr !=3D CR_SUCCESS && cr !=3D CR_BUFFER_SMALL) {
> > > > +
> > > > +        slog("failed to get property size, error=3D0x%lx", cr);
> > > > +        return NULL;
> > > > +    }
> > > > +    buffer =3D g_new0(BYTE, buffer_len + 1);
> > > > +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > > > +        buffer, &buffer_len, 0);
> > > > +    if (cr !=3D CR_SUCCESS) {
> > > > +        slog("failed to get device property, error=3D0x%lx", cr);
> > > > +        return NULL;
> > > > +    }
> > > > +    return g_steal_pointer(&buffer);
> > > > +}
> > > > +
> > > > +static GStrv ga_get_hardware_ids(DEVINST devInstance)
> > > > +{
> > > > +    GArray *values =3D NULL;
> > > > +    DEVPROPTYPE cm_type;
> > > > +    LPWSTR id;
> > > > +    g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(devInst=
ance,
> > > > +        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
> > > > +    if (property =3D=3D NULL) {
> > > > +        slog("failed to get hardware IDs");
> > > > +        return NULL;
> > > > +    }
> > > > +    if (*property =3D=3D '\0') {
> > > > +        /* empty list */
> > > > +        return NULL;
> > > > +    }
> > > > +    values =3D g_array_new(TRUE, TRUE, sizeof(gchar *));
> > > > +    for (id =3D property; '\0' !=3D *id; id +=3D lstrlenW(id) + 1)=
 {
> > > > +        gchar *id8 =3D g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
> > > > +        g_array_append_val(values, id8);
> > > > +    }
> > > > +    return (GStrv)g_array_free(values, FALSE);
> > > > +}
> > > > +
> > > > +/*
> > > > + * =20
> > > https://docs.microsoft.com/en-us/windows-hardware/drivers/install/ide=
ntifiers-for-pci-devices =20
> > > > + */
> > > > +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|=
$)"
> > > > +
> > > > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > > > +{
> > > > +    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =
=3D NULL;
> > > > +    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
> > > > +    SP_DEVINFO_DATA dev_info_data;
> > > > +    int i, j;
> > > > +    GError *gerr =3D NULL;
> > > > +    g_autoptr(GRegex) device_pci_re =3D NULL;
> > > > +    DEVPROPTYPE cm_type;
> > > > +
> > > > +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> > > > +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> > > > +        &gerr);
> > > > +    g_assert(device_pci_re !=3D NULL);
> > > > +
> > > > +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> > > > +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | =20
> > > DIGCF_ALLCLASSES); =20
> > > > +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> > > > +        error_setg(errp, "failed to get device tree");
> > > > +        return NULL;
> > > > +    }
> > > > +
> > > > +    slog("enumerating devices");
> > > > +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_dat=
a); =20
> > > i++) { =20
> > > > +        bool skip =3D true;
> > > > +        SYSTEMTIME utc_date;
> > > > +        g_autofree LPWSTR name =3D NULL;
> > > > +        g_autofree LPFILETIME date =3D NULL;
> > > > +        g_autofree LPWSTR version =3D NULL;
> > > > +        g_auto(GStrv) hw_ids =3D NULL;
> > > > +        g_autoptr(GuestDeviceInfo) device =3D g_new0(GuestDeviceIn=
fo, 1);
> > > > +        g_autofree char *vendor_id =3D NULL;
> > > > +        g_autofree char *device_id =3D NULL;
> > > > +
> > > > +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > > > +            &qga_DEVPKEY_NAME, &cm_type);
> > > > +        if (name =3D=3D NULL) {
> > > > +            slog("failed to get device description");
> > > > +            continue;
> > > > +        }
> > > > +        device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NU=
LL, =20
> > > NULL); =20
> > > > +        if (device->driver_name =3D=3D NULL) {
> > > > +            error_setg(errp, "conversion to utf8 failed (driver na=
me)");
> > > > +            continue;
> > > > +        }
> > > > +        slog("querying device: %s", device->driver_name);
> > > > +        hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
> > > > +        if (hw_ids =3D=3D NULL) {
> > > > +            continue;
> > > > +        }
> > > > +        for (j =3D 0; hw_ids[j] !=3D NULL; j++) {
> > > > +            GMatchInfo *match_info;
> > > > +            GuestDeviceAddressPCI *address;
> > > > +            if (!g_regex_match(device_pci_re, hw_ids[j], 0, =20
> > > &match_info)) { =20
> > > > +                continue;
> > > > +            }
> > > > +            skip =3D false;
> > > > +
> > > > +            address =3D g_new0(GuestDeviceAddressPCI, 1);
> > > > +            vendor_id =3D g_match_info_fetch(match_info, 1);
> > > > +            device_id =3D g_match_info_fetch(match_info, 2);
> > > > +            address->vendor_id =3D g_ascii_strtoull(vendor_id, NUL=
L, 16);
> > > > +            address->device_id =3D g_ascii_strtoull(device_id, NUL=
L, 16);
> > > > +
> > > > +            device->address =3D g_new0(GuestDeviceAddress, 1);
> > > > +            device->has_address =3D true;
> > > > +            device->address->type =3D GUEST_DEVICE_ADDRESS_KIND_PC=
I;
> > > > +            device->address->u.pci.data =3D address;
> > > > +
> > > > +            g_match_info_free(match_info);
> > > > +            break;
> > > > +        }
> > > > +        if (skip) {
> > > > +            continue;
> > > > +        }
> > > > +
> > > > +        version =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > > > +            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
> > > > +        if (version =3D=3D NULL) {
> > > > +            slog("failed to get driver version");
> > > > +            continue;
> > > > +        }
> > > > +        device->driver_version =3D g_utf16_to_utf8(version, -1, NU=
LL,
> > > > +            NULL, NULL);
> > > > +        if (device->driver_version =3D=3D NULL) {
> > > > +            error_setg(errp, "conversion to utf8 failed (driver =
=20
> > > version)"); =20
> > > > +            continue;
> > > > +        }
> > > > +        device->has_driver_version =3D true;
> > > > +
> > > > +        date =3D (LPFILETIME)cm_get_property(dev_info_data.DevInst=
,
> > > > +            &qga_DEVPKEY_Device_DriverDate, &cm_type);
> > > > +        if (date =3D=3D NULL) {
> > > > +            slog("failed to get driver date");
> > > > +            continue;
> > > > +        }
> > > > +        FileTimeToSystemTime(date, &utc_date);
> > > > +        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
> > > > +            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> > > > +        device->has_driver_date =3D true;
> > > > +
> > > > +        slog("driver: %s\ndriver version: %s,%s\n", device->driver=
_name,
> > > > +            device->driver_date, device->driver_version);
> > > > +        item =3D g_new0(GuestDeviceInfoList, 1);
> > > > +        item->value =3D g_steal_pointer(&device);
> > > > +        if (!cur_item) {
> > > > +            head =3D cur_item =3D item;
> > > > +        } else {
> > > > +            cur_item->next =3D item;
> > > > +            cur_item =3D item;
> > > > +        }
> > > > +        continue;
> > > > +    }
> > > > +
> > > > +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> > > > +        SetupDiDestroyDeviceInfoList(dev_info);
> > > > +    }
> > > > +    return head;
> > > > +}
> > > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > > index fb4605cc19..92ed76c419 100644
> > > > --- a/qga/qapi-schema.json
> > > > +++ b/qga/qapi-schema.json
> > > > @@ -1242,3 +1242,54 @@
> > > >  ##
> > > >  { 'command': 'guest-get-osinfo',
> > > >    'returns': 'GuestOSInfo' }
> > > > +
> > > > +##
> > > > +# @GuestDeviceAddressPCI:
> > > > +#
> > > > +# @vendor-id: vendor ID
> > > > +# @device-id: device ID
> > > > +#
> > > > +# Since: 5.0
> > > > +##
> > > > +{ 'struct': 'GuestDeviceAddressPCI',
> > > > +  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
> > > > +
> > > > +##
> > > > +# @GuestDeviceAddress:
> > > > +#
> > > > +# Address of the device
> > > > +# - @pci: address of PCI device, since: 5.0
> > > > +#
> > > > +# Since: 5.0
> > > > +##
> > > > +{ 'union': 'GuestDeviceAddress',
> > > > +  'data': { 'pci': 'GuestDeviceAddressPCI' } }
> > > > +
> > > > +##
> > > > +# @GuestDeviceInfo:
> > > > +#
> > > > +# @driver-name: name of the associated driver
> > > > +# @driver-date: driver release date in format YYYY-MM-DD
> > > > +# @driver-version: driver version
> > > > +#
> > > > +# Since: 5.0
> > > > +##
> > > > +{ 'struct': 'GuestDeviceInfo',
> > > > +  'data': {
> > > > +      'driver-name': 'str',
> > > > +      '*driver-date': 'str',
> > > > +      '*driver-version': 'str',
> > > > +      '*address': 'GuestDeviceAddress'
> > > > +  } }
> > > > +
> > > > +##
> > > > +# @guest-get-devices:
> > > > +#
> > > > +# Retrieve information about device drivers in Windows guest
> > > > +#
> > > > +# Returns: @GuestDeviceInfo
> > > > +#
> > > > +# Since: 5.0
> > > > +##
> > > > +{ 'command': 'guest-get-devices',
> > > > +  'returns': ['GuestDeviceInfo'] }
> > > > --
> > > > 2.24.1
> > > > =20
> > >
> > >
> > > --
> > > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > >
> > >
> > > =20
> >=20
> > --=20
> > Marc-Andr=C3=A9 Lureau =20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


