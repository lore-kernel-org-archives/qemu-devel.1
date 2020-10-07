Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBFC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EB020797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8+EA10k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB020797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBDT-0006mf-9o
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQBAB-00058C-UU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQBA4-0002sT-Ox
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602083717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WIW6Rg+PFRhxOqfzocVmz+dAHr+0L5GrHC2Zgrnyak=;
 b=S8+EA10kJckQb2l9ZI9NeRM11BFJNOYlEffQgyKj8gZm4o1bVMTK4lL3+Xt3jO0TuQB+qD
 0ApNyDkOUm6izFGkReiyfnx1Fn1BhpkHHX8FP+L5UDpeDE+TvG5XveQKcUsw0+Pb65XuZ5
 CHscqKyc+jReq90gUNPliKpwqGKKh0E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-_riLdXdKPbaY-S4RqXu-Kg-1; Wed, 07 Oct 2020 11:15:16 -0400
X-MC-Unique: _riLdXdKPbaY-S4RqXu-Kg-1
Received: by mail-wr1-f70.google.com with SMTP id j7so1272754wro.14
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7WIW6Rg+PFRhxOqfzocVmz+dAHr+0L5GrHC2Zgrnyak=;
 b=VoHdU+4A+L9eR2Om5/BTDKqw5XBArPCyDrr9BteMCuqSS/LHK2SrBlNYm5fvWrL+L4
 /eXqpeQ4cjx3d9fBErzeKgfUm0uK9jwawlTP/hMEeDnGAeYOKRqNT3OhXXNwg/LePCbu
 9ec9LFl8RWNLQWAvdx3BtSFG4wjZHBwoWpjhTt2+3Kwvqx4ayNKmFxigSuvVcSkXpP/9
 P3UVDAIwBG4bnuRERXs67Xokyd5jl4fq+N7EWRuxWeO6MdS4UEE79ll1oUCMHqjJM8lx
 MOtexalcXbThbRvMu8R+37MWnWUpDeu6flCDtHSLBNs1AZHTsTsPDhNDt0YDEyFIshNN
 5KZw==
X-Gm-Message-State: AOAM533Msu7nT13M/uWVx0AK2Q2uRUuFdU+EFQqgE7shW+hUtwC1hPMX
 70ZqwsnG18e0xsmJ6n+SefWCtTK9blAE6GRcimgvRLsGBIe4kD029mApVGW4NfWnTbxm5a7+exj
 dOiin+dhkw1qmMgg=
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3758281wmi.135.1602083715269; 
 Wed, 07 Oct 2020 08:15:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZJFJfgXDD+nrtaYOzaXELWgfzzys8GRSGep8I7JI1D1p6fFczukZggSAaaRiVIxsgREZnfg==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3758154wmi.135.1602083713902; 
 Wed, 07 Oct 2020 08:15:13 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id g14sm3313371wrx.22.2020.10.07.08.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 08:15:13 -0700 (PDT)
Date: Wed, 7 Oct 2020 17:15:11 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v3 3/3] qga: add implementation of guest-get-disks for
 Windows
Message-ID: <20201007151511.oz27p3q7xijqlqge@auriga.localdomain>
References: <cover.1602056784.git.tgolembi@redhat.com>
 <811a746b9a55adc0293ad80989dc9939e2490c1c.1602056784.git.tgolembi@redhat.com>
 <CAJ+F1CLUzkQqc91LcZy5hc4tvvHLJeW0xZeuZJ0kQGTM3Sgxdg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLUzkQqc91LcZy5hc4tvvHLJeW0xZeuZJ0kQGTM3Sgxdg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 12:20:14PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Oct 7, 2020 at 11:46 AM Tomáš Golembiovský <tgolembi@redhat.com>
> wrote:
> 
> > The command lists all the physical disk drives. Unlike for Linux
> > partitions and virtual volumes are not listed.
> >
> > Example output:
> >
> > {
> >   "return": [
> >     {
> >       "name": "\\\\.\\PhysicalDrive0",
> >       "partition": false,
> >       "address": {
> >         "serial": "QM00001",
> >         "bus-type": "sata",
> >         ...
> >       },
> >       "dependents": []
> >     }
> >   ]
> > }
> >
> > Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> > ---
> >  qga/commands-win32.c | 98 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 92 insertions(+), 6 deletions(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 0dd16315d7..7fe5676785 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -979,6 +979,92 @@ out:
> >      return list;
> >  }
> >
> > +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> > +{
> >
> 
> ERRP_GUARD?

Is it necessary? We're not dereferencing errp anywhere.

> 
> +    GuestDiskInfoList *new = NULL, *ret = NULL;
> > +    HDEVINFO dev_info;
> > +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> > +    int i;
> > +
> > +    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> > +        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
> > +    if (dev_info == INVALID_HANDLE_VALUE) {
> > +        error_setg_win32(errp, GetLastError(), "failed to get device
> > tree");
> > +        return NULL;
> > +    }
> > +
> > +    g_debug("enumerating devices");
> > +    dev_iface_data.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
> > +    for (i = 0;
> > +        SetupDiEnumDeviceInterfaces(dev_info, NULL,
> > &GUID_DEVINTERFACE_DISK,
> > +            i, &dev_iface_data);
> > +        i++) {
> > +        GuestDiskAddress *address = NULL;
> > +        GuestDiskInfo *disk = NULL;
> > +        Error *local_err = NULL;
> > +        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
> > +            pdev_iface_detail_data = NULL;
> > +        STORAGE_DEVICE_NUMBER sdn;
> > +        HANDLE dev_file;
> > +        DWORD size = 0;
> > +
> > +        g_debug("  getting device path");
> > +        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_data,
> > +                pdev_iface_detail_data,
> > +                size, &size,
> > +                NULL)) {
> > +            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
> > +                pdev_iface_detail_data = g_realloc(pdev_iface_detail_data,
> > +                    size);
> > +                pdev_iface_detail_data->cbSize =
> > +                    sizeof(*pdev_iface_detail_data);
> > +            } else {
> > +                g_debug("failed to get device interface details");
> > +                continue;
> >
> 
> Is "continue" appropriate here? Looks like this may loop forever easily.

Duh! It would.

    Tomas

> 
> +            }
> > +        }
> > +
> > +        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
> > +        dev_file = CreateFile(pdev_iface_detail_data->DevicePath, 0,
> > +            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> > +        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
> > +                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
> > +            CloseHandle(dev_file);
> > +            debug_error("failed to get storage device number");
> > +            continue;
> > +        }
> > +        CloseHandle(dev_file);
> > +
> > +        disk = g_new0(GuestDiskInfo, 1);
> > +        disk->name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> > +            sdn.DeviceNumber);
> > +
> > +        g_debug("  number: %lu", sdn.DeviceNumber);
> > +        address = g_malloc0(sizeof(GuestDiskAddress));
> > +        address->has_dev = true;
> > +        address->dev = g_strdup(disk->name);
> > +        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
> > +        if (local_err) {
> > +            g_debug("failed to get disk info: %s",
> > +                error_get_pretty(local_err));
> > +            error_free(local_err);
> > +            qapi_free_GuestDiskAddress(address);
> > +            address = NULL;
> > +        } else {
> > +            disk->address = address;
> > +            disk->has_address = true;
> > +        }
> > +
> > +        new = g_malloc0(sizeof(GuestDiskInfoList));
> > +        new->value = disk;
> > +        new->next = ret;
> > +        ret = new;
> > +    }
> > +
> > +    SetupDiDestroyDeviceInfoList(dev_info);
> > +    return ret;
> > +}
> > +
> >  #else
> >
> >  static GuestDiskAddressList *build_guest_disk_info(char *guid, Error
> > **errp)
> > @@ -986,6 +1072,12 @@ static GuestDiskAddressList
> > *build_guest_disk_info(char *guid, Error **errp)
> >      return NULL;
> >  }
> >
> > +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> > +{
> > +    error_setg(errp, QERR_UNSUPPORTED);
> > +    return NULL;
> > +}
> > +
> >  #endif /* CONFIG_QGA_NTDDSCSI */
> >
> >  static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
> > @@ -2457,9 +2549,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> > **errp)
> >      }
> >      return head;
> >  }
> > -
> > -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> > -{
> > -    error_setg(errp, QERR_UNSUPPORTED);
> > -    return NULL;
> > -}
> > --
> > 2.28.0
> >
> >
> 
> -- 
> Marc-André Lureau

-- 
Tomáš Golembiovský <tgolembi@redhat.com>


