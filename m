Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA8AC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B8720716
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLAuVWWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B8720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ZOy-0007Tg-7g
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 03:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1k7ZOQ-00073g-Ov
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1k7ZON-0002V2-Bw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597648633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4K4rw2CUbkpB7I3RE7r+kYdJ0DzT5SFYagQdLZDn0/I=;
 b=fLAuVWWd9H7/VpkA9zc0R15WoHIyEJR9DPUk6sacpasZ73NM0rezEZTfQibkr+4YAYpL8F
 Dh+XpNK/NKC16GGq6RbGvIUu/aBB2gu1/YWE3AzDMKLqGIMvX+W6VEVqT+arML9pt+Gn4z
 l0a4qnzcAA8O6fAEV97HFh8L98D+ifI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-uYdF2TKAPD-pA5RrlkqNpw-1; Mon, 17 Aug 2020 03:17:11 -0400
X-MC-Unique: uYdF2TKAPD-pA5RrlkqNpw-1
Received: by mail-ej1-f69.google.com with SMTP id g18so5206026ejm.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 00:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=gbWphpk9r6Zn+D64DMmQSFQDPIdnTwdbcRym0+PrlDE=;
 b=tKB+/cH1BsN/L4JvZOgLnDLQiggZXDs61e7k1Cpv0Dja0P+wvT+mJmRQOVIhT/EyNh
 IIpq9bWTJPE64RSSMWDN7gRCdDu06J4vuRaVJiPaMN8qc0nVDDDIxn5qQ1CW8yNct99X
 GJ6+HwvB7RyJWw20t3t0nS60tiMKki4UwG6Iod+1Z2TDuCJgEHjULLDSNVyPYMqlYEE9
 rQFXlbqs9BO+0GWpA551G8ATJsA7m73DQMiJdeu4Osy9jRPSsmK/tEcC8Met/r0ll1re
 Oa0kMD6J3EpL+7+c3wexTZ3XS33rOuIUGemm8Sko5NbCwgc/ciSLp6+c/ogaIlTU7dAF
 /85g==
X-Gm-Message-State: AOAM531Hkz8z9CFSRMny9EY4enOGfYjcFkXn/PbScOrFe2iU5oHu/0SS
 KHGjxIti7sj93uNEIi+Er3C2TGLlR1qjVdY6ZjeWnXYqD04H/xVeZjLOJj5H+ZuSMCgdxjVs+5Y
 C2Gz0ZGzog3/S2Ag=
X-Received: by 2002:a05:6402:297:: with SMTP id
 l23mr13822786edv.145.1597648630102; 
 Mon, 17 Aug 2020 00:17:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8qHgHmB7/f1Ex5V9dMmRmmlEd+whUYxK6P+TTdqrVwal0RpNwqskczk6IF709fAlUvluwJQ==
X-Received: by 2002:a05:6402:297:: with SMTP id
 l23mr13822769edv.145.1597648629796; 
 Mon, 17 Aug 2020 00:17:09 -0700 (PDT)
Received: from fiorina (ip-94-112-73-67.net.upcbroadband.cz. [94.112.73.67])
 by smtp.gmail.com with ESMTPSA id d2sm13710134ejm.19.2020.08.17.00.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 00:17:09 -0700 (PDT)
Date: Mon, 17 Aug 2020 09:17:06 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] qga: add command guest-get-disks
Message-ID: <20200817091706.7d483838@fiorina>
In-Reply-To: <159726777861.7191.12429466315820157245@sif>
References: <cover.1596704579.git.tgolembi@redhat.com>
 <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
 <159726777861.7191.12429466315820157245@sif>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 16:29:38 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2020-08-06 04:03:06)
> > The command guest-get-fsinfo can be used to list information about disk=
s and
> > partitions but it is limited only to mounted disks with filesystem. Thi=
s new
> > command allows listing information about attached root disks of the VM.=
 This is
> > usefull for management applications for mapping virtualized devices or
> > pass-through devices to device names in the guest OS.
> >=20
> > Output is similar to the list of partitions of guest-get-fsinfo, except=
 that
> > the disks are mapped instead of partitions.
> >=20
> > Example output:
> >=20
> > {
> >   "return": [
> >     {
> >       "serial": "SAMSUNG_123456789",
> >       "bus-type": "sata",
> >       "bus": 0,
> >       "unit": 0,
> >       "pci-controller": {
> >         "bus": 0,
> >         "slot": 31,
> >         "domain": 0,
> >         "function": 2
> >       },
> >       "dev": "/dev/sda",
> >       "target": 0
> >     },
> >     ...
> >   ]
> > }
> >=20
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
> >  qga/commands-win32.c | 83 ++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json | 13 +++++++
> >  3 files changed, 186 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 744c2b5a5d..4cebec96a6 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -62,6 +62,8 @@ extern char **environ;
> >  #endif
> >  #endif
> >=20
> > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo, qapi_free_GuestFile=
systemInfo)
> > +
> >  static void ga_wait_child(pid_t pid, int *status, Error **errp)
> >  {
> >      pid_t rpid;
> > @@ -1177,6 +1179,92 @@ static void build_guest_fsinfo_for_device(char c=
onst *devpath,
> >      free(syspath);
> >  }
> >=20
> > +GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
> > +{
> > +    GuestDiskAddressList *item, *ret =3D NULL;
> > +    DIR *dp =3D NULL;
> > +    struct dirent *de =3D NULL;
> > +
> > +    g_debug("listing /sys/block directory");
> > +    dp =3D opendir("/sys/block");
> > +    if (dp =3D=3D NULL) {
> > +        error_setg_errno(errp, errno, "Can't open directory \"/sys/blo=
ck\"");
> > +        return NULL;
> > +    }
> > +    while ((de =3D readdir(dp)) !=3D NULL) {
> > +        g_autofree char *disk_dir =3D NULL, *line =3D NULL,
> > +            *size_path =3D NULL, *slaves_dir =3D NULL;
> > +        g_autoptr(GuestFilesystemInfo) fs =3D NULL;
> > +        uint64_t slaves =3D 0;
> > +        struct dirent *de_slaves;
> > +        DIR *dp_slaves =3D NULL;
> > +        FILE *fp =3D NULL;
> > +        size_t n;
> > +        Error *local_err =3D NULL;
> > +        if (de->d_type !=3D DT_LNK) {
> > +            g_debug("  skipping entry: %s", de->d_name);
> > +            continue;
> > +        }
> > +
> > +        slaves_dir =3D g_strdup_printf("/sys/block/%s/slaves", de->d_n=
ame);
> > +        if (slaves_dir =3D=3D NULL) {
> > +            g_debug("  failed to open directory %s", slaves_dir);
> > +            continue;
> > +        }
> > +        g_debug("  counting entries in: %s", slaves_dir);
> > +        dp_slaves =3D opendir(slaves_dir);
> > +        while ((de_slaves =3D readdir(dp_slaves)) !=3D NULL) {
> > +            if ((strcmp(".", de_slaves->d_name) =3D=3D 0) ||
> > +                (strcmp("..", de_slaves->d_name) =3D=3D 0)) {
> > +                continue;
> > +            }
> > +            slaves++;
> > +        }
> > +        closedir(dp_slaves);
> > +        g_debug("    counted %lu items", slaves);
> > +        if (slaves !=3D 0) {
> > +            continue;
> > +        }
>=20
> For guest-get-fsinfo we skip returning any data about virtual devices
> (dm/md/etc.) and just return the physical disks underlying whatever
> hierarchy the filesystem is built on, which sort of makes sense as far
> as making sure we know what devices are currently in use.
>=20
> But for guest-get-disks we seem to care about usage beyond just mounted
> filesystems, which to me would suggest things like whether a disk is
> part of an LVM/RAID/multipath volume. But by skipping virtual devices
> with "/sys/block/*/slaves" entries we lose that information...
>=20
> So I guess I'm not sure I understand the use-cases you have in mind here.
> Can you provide some examples? And do you anticipate we would need to add
> an interface to report this hierarchy at some point?

The intent is to provide information about devices that were specified
when starting the VM and not about complete disk hierarchy. The
reasoning behind it is for management applications to be able to show
what names in guest OS correspond to the disks in the VM definition. But
if you suggest that reporting the hierarchy similar to what lsblk
provides would be useful I can do that for Linux. The issue is with
Windows where I don't know how to do that.=20

>=20
> > +
> > +        g_debug("  checking disk size");
> > +        size_path =3D g_strdup_printf("/sys/block/%s/size", de->d_name=
);
> > +        fp =3D fopen(size_path, "r");
> > +        if (!fp) {
> > +            g_debug("  failed to read disk size");
> > +            continue;
> > +        }
> > +        if (getline(&line, &n, fp) =3D=3D -1) {
>=20
> We need to set n=3D0, otherwise an uninitialized value might be interpret=
ed as
> the size of line's pre-allocated buffer
>=20
> > +            g_debug("  failed to read disk size");
> > +            fclose(fp);
> > +            continue;
> > +        }
> > +        fclose(fp);
> > +        if (strcmp(line, "0\n") =3D=3D 0) {
> > +            g_debug("  skipping zero-sized disk");
> > +            continue;
> > +        }
> > +
> > +        fs =3D g_malloc0(sizeof(*fs));
> > +        g_debug("  adding %s", de->d_name);
> > +        disk_dir =3D g_strdup_printf("/sys/block/%s", de->d_name);
> > +        build_guest_fsinfo_for_device(disk_dir, fs, &local_err);
> > +        if (local_err !=3D NULL) {
> > +            g_debug("  failed to get device info, ignoring error: %s",
> > +                error_get_pretty(local_err));
> > +            error_free(local_err);
> > +            continue;
> > +        } else if (fs->disk =3D=3D NULL) {
> > +            g_debug("  skipping unknown disk");
> > +            continue;
> > +        }
> > +        item =3D g_steal_pointer(&fs->disk);
>=20
> Does this ensure that fs itself doesn't still get auto-free'd?

Yes, it does.


> In any
> case, it seems awkward to allocate a GuestFilesystemInfo just so we can
> re-use build_guest_fsinfo_for_device(). Can code be refactored into a
> separate build_guest_disk_info_for_device() or something that just takes
> a GuestDiskAddressList* directly?
>=20

It is little bit cumbersome, I agree. Unfortunately refactoring it is
little bit tricky and would make the build_guestfs_info_*() functions
less readable. But moving the code into separate function to hide this
is certainly an option.

    Tomas

> > +        g_assert(item->next =3D=3D NULL); /* expecting just a single d=
isk */
> > +        item->next =3D ret;
> > +        ret =3D item;
> > +    }
> > +    return ret;
> > +}
> > +
> >  /* Return a list of the disk device(s)' info which @mount lies on */
> >  static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
> >                                                 Error **errp)
> > @@ -2809,7 +2897,8 @@ GList *ga_command_blacklist_init(GList *blacklist=
)
> >          const char *list[] =3D {
> >              "guest-get-fsinfo", "guest-fsfreeze-status",
> >              "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> > -            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
> > +            "guest-fsfreeze-thaw", "guest-get-fsinfo",
> > +            "guest-get-disks", NULL};
> >          char **p =3D (char **)list;
> >=20
> >          while (*p) {
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index aaa71f147b..0bafa2dc4c 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -945,6 +945,83 @@ out:
> >      return list;
> >  }
> >=20
> > +GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
> > +{
> > +    GuestDiskAddressList *new =3D NULL, *ret =3D NULL;
> > +    HDEVINFO dev_info;
> > +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> > +    int i;
> > +
> > +    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> > +        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
> > +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> > +        error_setg_win32(errp, GetLastError(), "failed to get device t=
ree");
> > +        return NULL;
> > +    }
> > +
> > +    g_debug("enumerating devices");
> > +    dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);
> > +    for (i =3D 0;
> > +        SetupDiEnumDeviceInterfaces(dev_info, NULL, &GUID_DEVINTERFACE=
_DISK,
> > +            i, &dev_iface_data);
> > +        i++) {
> > +        GuestDiskAddress *disk =3D NULL;
> > +        Error *local_err =3D NULL;
> > +        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
> > +            pdev_iface_detail_data =3D NULL;
> > +        STORAGE_DEVICE_NUMBER sdn;
> > +        HANDLE dev_file;
> > +        DWORD size =3D 0;
> > +
> > +        g_debug("  getting device path");
> > +        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_d=
ata,
> > +                pdev_iface_detail_data,
> > +                size, &size,
> > +                NULL)) {
> > +            if (GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) {
> > +                pdev_iface_detail_data =3D g_malloc(size);
> > +                pdev_iface_detail_data->cbSize =3D
> > +                    sizeof(*pdev_iface_detail_data);
> > +            } else {
> > +                g_debug("failed to get device interface details");
> > +                continue;
> > +            }
> > +        }
> > +
> > +        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
> > +        dev_file =3D CreateFile(pdev_iface_detail_data->DevicePath, 0,
> > +            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> > +        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER=
,
> > +                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
> > +            CloseHandle(dev_file);
> > +            debug_error("failed to get storage device number");
> > +            continue;
> > +        }
> > +        CloseHandle(dev_file);
> > +
> > +        g_debug("  number: %lu", sdn.DeviceNumber);
> > +        disk =3D g_malloc0(sizeof(GuestDiskAddress));
> > +        disk->has_dev =3D true;
> > +        disk->dev =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> > +            sdn.DeviceNumber);
> > +        get_single_disk_info(sdn.DeviceNumber, disk, &local_err);
> > +        if (local_err) {
> > +            g_debug("failed to get disk info: %s",
> > +                error_get_pretty(local_err));
> > +            error_free(local_err);
> > +            g_free(disk);
> > +            continue;
> > +        }
> > +        new =3D g_malloc0(sizeof(GuestDiskAddressList));
> > +        new->value =3D disk;
> > +        new->next =3D ret;
> > +        ret =3D new;
> > +    }
> > +
> > +    SetupDiDestroyDeviceInfoList(dev_info);
> > +    return ret;
> > +}
> > +
> >  #else
> >=20
> >  static GuestDiskAddressList *build_guest_disk_info(char *guid, Error *=
*errp)
> > @@ -952,6 +1029,12 @@ static GuestDiskAddressList *build_guest_disk_inf=
o(char *guid, Error **errp)
> >      return NULL;
> >  }
> >=20
> > +GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
> > +{
> > +    error_setg(errp, QERR_UNSUPPORTED);
> > +    return NULL;
> > +}
> > +
> >  #endif /* CONFIG_QGA_NTDDSCSI */
> >=20
> >  static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **err=
p)
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 408a662ea5..5d8fa1c283 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -862,6 +862,19 @@
> >             'bus': 'int', 'target': 'int', 'unit': 'int',
> >             '*serial': 'str', '*dev': 'str'} }
> >=20
> > +##
> > +# @guest-get-disks:
> > +#
> > +# Returns: The list of disks in the guest. For Windows these are only =
the
> > +#          physical disks. On Linux these are all root block devices o=
f
> > +#          non-zero size including e.g. removable devices, loop device=
s,
> > +#          NBD, etc.
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'guest-get-disks',
> > +  'returns': ['GuestDiskAddress'] }
> > +
> >  ##
> >  # @GuestFilesystemInfo:
> >  #
> > --=20
> > 2.25.0
> >=20
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


