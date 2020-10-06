Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6ACC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5678420789
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcXULr/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5678420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiOs-0002WW-7H
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kPiO9-00024w-Gl
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kPiO3-0001g5-Ac
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601973106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9yazghXf4tzvfnScHl6C6jpNzp6L6B3bm5IlmfyBhk=;
 b=hcXULr/SnB6ecsuOGoE19RVikfr/sT/AQbdZi89dmdSzGnPXF2wMYaLMgY/a0sf1+4rVpl
 O/s9ub4zh7kbHlUjLrqGT927O+5Bf/XJw9qsXiseK/M8mjlCtKWlvsSJPKqwWxpaAvk4BB
 9Ax2jQsLabQSE2PKiX820oN2TZP/43g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-0JCz7AGWOXmAsilSPB7dlA-1; Tue, 06 Oct 2020 04:31:45 -0400
X-MC-Unique: 0JCz7AGWOXmAsilSPB7dlA-1
Received: by mail-wm1-f70.google.com with SMTP id r19so825091wmh.9
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 01:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=a9yazghXf4tzvfnScHl6C6jpNzp6L6B3bm5IlmfyBhk=;
 b=qe4pqeEF27QHza+ww/Mm7HMmrDj9sBMfuu5gZYjfT0H7OTcckKptLAoSUYVEBgTlnv
 vo5190m5JqqztmMS67pyp5OSmxUPPJfYl1KN7rOV/DQR2H8DXGb7Hk6FRPhmxW3sfMuJ
 IleEXJgkelxaeWhcPs7GzR0yQz+mFhWwg7y14uv49A7UgnbQhFzkxJYzBhKL1fKV+iNj
 kASBAfYfv6IzqXP01CSuPoqydeGjS/UZ97h5e2lg58E/yF4UAHYQVYT1rjjEbcdMEE4W
 /+XnPGVxLpbL8uuXkkHYQKFZAemYgI9MKo7XeiPzEijNeE+//t01+0Nc5twe2rlGp0Vv
 d8Cw==
X-Gm-Message-State: AOAM530SXQdkH2bKCvLs+S1r8S9ZbUtZ7kjuropkfF6B1BqI4D3J29iI
 DKmoiXG9IwpuK1aVxNea07tVhheim2329RMkf1ZBEAN9pavPqj3wXlNCMnpWEm9vUtjVzVrWNBv
 nAC82nItum2G5LYQ=
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr3523235wrr.283.1601973103969; 
 Tue, 06 Oct 2020 01:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznMSBiVIVmYSqSBMQ/2LKAJ8U57JLpWlX9xArTB/7ie4nBYjztM+sI7oH87/iNVnsLXFrteg==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr3523203wrr.283.1601973103516; 
 Tue, 06 Oct 2020 01:31:43 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id n2sm3403793wrt.82.2020.10.06.01.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 01:31:42 -0700 (PDT)
Date: Tue, 6 Oct 2020 10:31:41 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2 2/3] qga: add implementation of guest-get-disks for
 Linux
Message-ID: <20201006083141.m4xmo2pzlte72pzp@auriga.localdomain>
References: <cover.1599470071.git.tgolembi@redhat.com>
 <1bf9ede3b9273613319ff8ff99b40c385439cfa8.1599470071.git.tgolembi@redhat.com>
 <CAJ+F1C+FPkg-fznQdfqnioJ9CD3fi7apW34ad=cQMgzRsphqCQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+FPkg-fznQdfqnioJ9CD3fi7apW34ad=cQMgzRsphqCQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 07:22:00PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Sep 7, 2020 at 1:17 PM Tomáš Golembiovský <tgolembi@redhat.com>
> wrote:
> 
> > The command lists all disks (real and virtual) as well as disk
> > partitions. For each disk the list of slave disks is also listed and
> > /dev path is used as a handle so it can be matched with "name" filed of
> >
> 
> field
> 
> other returned disk entries. For disk partitions the "slave" list is
> > populated with the the parent device for easier tracking of hierarchy.
> >
> > Example output:
> > {
> >   "return": [
> >     ...
> >     {
> >       "name": "/dev/dm-0",
> >       "partition": false,
> >       "slaves": [
> >         "/dev/sda2"
> >       ],
> >       "alias": "luks-7062202e-5b9b-433e-81e8-6628c40da9f7"
> >     },
> >     {
> >       "name": "/dev/sda2",
> >       "partition": true,
> >       "slaves": [
> >         "/dev/sda"
> >       ]
> >     },
> >     {
> >       "name": "/dev/sda",
> >       "partition": false,
> >       "address": {
> >         "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
> >         "bus-type": "sata",
> >         ...
> >         "dev": "/dev/sda",
> >         "target": 0
> >       },
> >       "slaves": []
> >     },
> >     ...
> >   ]
> > }
> >
> > Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c | 247 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 240 insertions(+), 7 deletions(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index f99731af51..3babc25c09 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -62,6 +62,9 @@ extern char **environ;
> >  #endif
> >  #endif
> >
> > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo,
> > +    qapi_free_GuestFilesystemInfo)
> > +
> >
> 
> This will now conflict with qapi-gen generated headers.
> 
>  static void ga_wait_child(pid_t pid, int *status, Error **errp)
> >  {
> >      pid_t rpid;
> > @@ -1150,6 +1153,21 @@ static void
> > build_guest_fsinfo_for_virtual_device(char const *syspath,
> >      closedir(dir);
> >  }
> >
> > +static bool is_disk_virtual(const char *devpath, Error **errp)
> > +{
> > +    g_autofree char *syspath = realpath(devpath, NULL);
> > +
> > +    if (!syspath) {
> > +        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> >
> +        return false;
> > +    }
> > +    if (strstr(syspath, "/devices/virtual/block/")) {
> > +        return true;
> > +    } else {
> > +        return false;
> > +    }
> >
> 
>  simply to "return strstr(syspath, "/devices/virtual/block/") != NULL;" ?
> (Or strstr(syspath, "/devices/virtual/block/") ? true : false )
> 
> +}
> > +
> >  /* Dispatch to functions for virtual/real device */
> >  static void build_guest_fsinfo_for_device(char const *devpath,
> >                                            GuestFilesystemInfo *fs,
> > @@ -1168,6 +1186,7 @@ static void build_guest_fsinfo_for_device(char const
> > *devpath,
> >
> >      g_debug("  parse sysfs path '%s'", syspath);
> >
> > +    /* TODO: use is_disk_virtual() */
> >
> 
> just do it, no?

It's great that I put a note there otherwise I might have forgotten to
do it. ;)

> 
>      if (strstr(syspath, "/devices/virtual/block/")) {
> >          build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
> >      } else {
> > @@ -1177,6 +1196,225 @@ static void build_guest_fsinfo_for_device(char
> > const *devpath,
> >      free(syspath);
> >  }
> >
> > +#ifdef CONFIG_LIBUDEV
> > +
> > +/*
> > + * Wrapper around build_guest_fsinfo_for_device() for getting just
> > + * the disk address.
> > + */
> > +static GuestDiskAddress *get_disk_address(const char *syspath, Error
> > **errp)
> > +{
> > +    g_autoptr(GuestFilesystemInfo) fs = NULL;
> > +
> > +    fs = g_new0(GuestFilesystemInfo, 1);
> >
> 
> Heap allocation / auto wasn't really necessary here, but ok.

I used it so that qapi_free_GuestFilesystemInfo() is called on function
exit in all cases. I am not sure if I could do that if `fs` were on the
stack.


> 
> 
> > +    build_guest_fsinfo_for_device(syspath, fs, errp);
> > +    if (fs->disk != NULL) {
> > +        return g_steal_pointer(&fs->disk->value);
> > +    }
> > +    return NULL;
> >
> 
> Could also be a onliner, but perhaps less readable.

Yeah, I prefer it this way.

> 
> +}
> > +
> > +static char *get_alias_for_syspath(const char *syspath)
> > +{
> > +    struct udev *udev = NULL;
> > +    struct udev_device *udevice = NULL;
> > +    char *ret = NULL;
> > +
> > +    udev = udev_new();
> >
> 
> I would have g_return_val_if_fail(udev != NULL, NULL); here as,
> 
> +    udevice = udev_device_new_from_syspath(udev, syspath);
> >
> 
> udev_device_new_from_syspath() might crash otherwise.

That is probably true. This may require fixes at other places too.

> 
> 
> > +    if (udev == NULL || udevice == NULL) {
> > +        g_debug("failed to query udev");
> > +    } else {
> > +        const char *alias = udev_device_get_property_value(
> > +            udevice, "DM_NAME");
> > +        if (alias != NULL && *alias != 0) {
> > +            ret = g_strdup(alias);
> >
> 
> g_strdup() works fine with NULL. Is there "" empty aliases? Why not report
> them too?

NULL means an error and empty alias means there is no alias. I will put
that in a comment there. In QAPI we have alias as optional which seems
preferable rather than always returning empty string.

> 
> +        }
> > +    }
> > +
> > +    udev_unref(udev);
> > +    udev_device_unref(udevice);
> > +    return ret;
> > +}
> > +
> > +static char *get_device_for_syspath(const char *syspath)
> > +{
> > +    struct udev *udev = NULL;
> > +    struct udev_device *udevice = NULL;
> > +    char *ret = NULL;
> > +
> > +    udev = udev_new();
> > +    udevice = udev_device_new_from_syspath(udev, syspath);
> > +    if (udev == NULL || udevice == NULL) {
> >
> 
> Same as above
> 
> +        g_debug("failed to query udev");
> > +    } else {
> > +        ret = g_strdup(udev_device_get_devnode(udevice));
> > +    }
> > +    udev_unref(udev);
> > +    udev_device_unref(udevice);
> > +    return ret;
> > +}
> > +
> >
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> > +{
> > +    GuestDiskInfoList *item, *ret = NULL;
> > +    GuestDiskInfo *disk, *partition;
> > +    DIR *dp = NULL;
> > +    struct dirent *de = NULL;
> > +
> > +    g_debug("listing /sys/block directory");
> > +    dp = opendir("/sys/block");
> > +    if (dp == NULL) {
> > +        error_setg_errno(errp, errno, "Can't open directory
> > \"/sys/block\"");
> > +        return NULL;
> > +    }
> > +    while ((de = readdir(dp)) != NULL) {
> > +        g_autofree char *disk_dir = NULL, *line = NULL,
> > +            *size_dir = NULL, *slaves_dir = NULL;
> > +        struct dirent *de_disk, *de_slaves;
> > +        DIR *dp_disk = NULL, *dp_slaves = NULL;
> > +        FILE *fp = NULL;
> > +        size_t n = 0;
> > +        Error *local_err = NULL;
> > +        if (de->d_type != DT_LNK) {
> > +            g_debug("  skipping entry: %s", de->d_name);
> > +            continue;
> > +        }
> > +
> > +        /* Check size and skip zero-sized disks */
> > +        g_debug("  checking disk size");
> > +        size_dir = g_strdup_printf("/sys/block/%s/size", de->d_name);
> > +        fp = fopen(size_dir, "r");
> > +        if (!fp) {
> > +            g_debug("  failed to read disk size");
> > +            continue;
> > +        }
> > +        if (getline(&line, &n, fp) == -1) {
> > +            g_debug("  failed to read disk size");
> >
> 
> line: getline(3) "This buffer should be freed by the user program even if
> getline() failed."

That is handled by the g_autofree, or am I missing something? `line`
will get out of scope after every interation (even with continue). Or do
you prefer to have it explicit and free as soon as we don't need it?

> 
> +            fclose(fp);
> > +            continue;
> > +        }
> > +        fclose(fp);
> > +        if (strcmp(line, "0\n") == 0) {
> >
> 
> It would be slightly better to  defend against NULL crash here, with
> g_strcmp0()
> 
> +            g_debug("  skipping zero-sized disk");
> > +            continue;
> > +        }
> > +
> >
> 
> line is never freed?
> 
> +        g_debug("  adding %s", de->d_name);
> > +        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
> > +        disk = g_new0(GuestDiskInfo, 1);
> > +        disk->name = get_device_for_syspath(disk_dir);
> > +        disk->partition = false;
> > +        disk->alias = get_alias_for_syspath(disk_dir);
> > +        if (disk->alias != NULL) {
> > +            disk->has_alias = true;
> > +        }
> >
> 
> Could be a single line too
> 
> +        item = g_new0(GuestDiskInfoList, 1);
> > +        item->value = disk;
> > +        item->next = ret;
> > +        ret = item;
> > +
> > +        /* Get address for non-virtual devices */
> > +        bool is_virtual = is_disk_virtual(disk_dir, &local_err);
> > +        if (local_err != NULL) {
> > +            g_debug("  failed to check disk path, ignoring error: %s",
> > +                error_get_pretty(local_err));
> > +            error_free(local_err);
> > +            local_err = NULL;
> >
> +            /* Don't try to get the address */
> > +            is_virtual = true;
> > +        }
> > +        if (!is_virtual) {
> > +            disk->address = get_disk_address(disk_dir, &local_err);
> > +            if (local_err != NULL) {
> > +                g_debug("  failed to get device info, ignoring error: %s",
> > +                    error_get_pretty(local_err));
> > +                error_free(local_err);
> > +                local_err = NULL;
> > +            } else if (disk->address != NULL) {
> > +                disk->has_address = true;
> > +            }
> > +        }
> > +
> > +        /* List slave disks */
> > +        slaves_dir = g_strdup_printf("%s/slaves", disk_dir);
> > +        g_debug("  listing entries in: %s", slaves_dir);
> > +        dp_slaves = opendir(slaves_dir);
> > +        while ((de_slaves = readdir(dp_slaves)) != NULL) {
> > +            g_autofree char *slave_dir = NULL;
> > +            char *slave_dev;
> > +            strList *slave_item = NULL;
> > +
> > +            if ((strcmp(".", de_slaves->d_name) == 0) ||
> > +                (strcmp("..", de_slaves->d_name) == 0)) {
> >
> +                continue;
> > +            }
> > +
> > +            /* Add slave disks */
> > +            slave_dir = g_strdup_printf("%s/%s",
> > +                slaves_dir, de_slaves->d_name);
> > +            slave_dev = get_device_for_syspath(slave_dir);
> > +            if (slave_dev != NULL) {
> > +                g_debug("  adding slave device: %s", slave_dev);
> > +                slave_item = g_new0(strList, 1);
> > +                slave_item->value = slave_dev;
> > +                slave_item->next = disk->slaves;
> > +                disk->slaves = slave_item;
> > +            }
> > +        }
> > +        closedir(dp_slaves);
> > +
> > +        /*
> > +         * Detect partitions subdirectory name is "<parent><number>" or
> > +         * "<parent>p<number>"
> > +         */
> > +        dp_disk = opendir(disk_dir);
> > +        while ((de_disk = readdir(dp_disk)) != NULL) {
> > +            size_t len;
> > +            g_autofree char *partition_dir = NULL;
> > +
> > +            if (!(de_disk->d_type & DT_DIR)) {
> > +                continue;
> > +            }
> > +
> > +            len = strlen(de->d_name);
> > +            if (!(strncmp(de->d_name, de_disk->d_name, len) == 0 &&
> > +                ((*(de_disk->d_name + len) == 'p' &&
> > +                isdigit(*(de_disk->d_name + len + 1))) ||
> > +                    isdigit(*(de_disk->d_name + len))))) {
> > +                continue;
> > +            }
> > +
> > +            partition_dir = g_strdup_printf("%s/%s",
> > +                disk_dir, de_disk->d_name);
> > +            partition = g_new0(GuestDiskInfo, 1);
> > +            partition->name = get_device_for_syspath(partition_dir);
> > +            partition->partition = true;
> > +            /* Add parent disk as slave for easier tracking of hierarchy
> > */
> > +            partition->slaves = g_new0(strList, 1);
> > +            partition->slaves->value = g_strdup(disk->name);
> > +
> > +            item = g_new0(GuestDiskInfoList, 1);
> > +            item->value = partition;
> > +            item->next = ret;
> > +            ret = item;
> > +
> > +        }
> > +        closedir(dp_disk);
> > +    }
> > +    return ret;
> > +}
> > +
> > +#else
> > +
> > +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> > +{
> > +    error_setg(errp, QERR_UNSUPPORTED);
> > +    return NULL;
> > +}
> > +
> > +#endif
> > +
> >  /* Return a list of the disk device(s)' info which @mount lies on */
> >  static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
> >                                                 Error **errp)
> > @@ -2809,7 +3047,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
> >          const char *list[] = {
> >              "guest-get-fsinfo", "guest-fsfreeze-status",
> >              "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> > -            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
> > +            "guest-fsfreeze-thaw", "guest-get-fsinfo",
> > +            "guest-get-disks", NULL};
> >          char **p = (char **)list;
> >
> >          while (*p) {
> > @@ -3042,9 +3281,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> >
> >      return info;
> >  }
> > -
> > -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> > -{
> > -    error_setg(errp, QERR_UNSUPPORTED);
> > -    return NULL;
> > -}
> > --
> > 2.25.0
> >
> >
> >
> 
> -- 
> Marc-André Lureau

-- 
Tomáš Golembiovský <tgolembi@redhat.com>


