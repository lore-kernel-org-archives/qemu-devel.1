Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86320C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2A62075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hraV4+e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2A62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDVS-0000Kt-PX
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDUh-0008LV-FS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:31:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDUf-0004KV-JZ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599471080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ix+vDhTh+n1g+0BqERo2XaFIbs4ujyls0wswSRL1RBc=;
 b=hraV4+e/RHsX+44bPhEEIyiuV1+YxnmaWUiBle83s93Pu5x888D+RT9aNIi4GUIz/cQeUQ
 owXCNwNVlWSiIc7sBT360/yO5vG3Utwf7yjGbuf0Sv/+VpdLAQxAWM5qGpF3F1aaH3DzUQ
 38PvHuCzLdUlJfsXvIunCF9grbz28F4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-hSDnDNblORi0KMpQZqSLWQ-1; Mon, 07 Sep 2020 05:31:19 -0400
X-MC-Unique: hSDnDNblORi0KMpQZqSLWQ-1
Received: by mail-wr1-f72.google.com with SMTP id o6so5370634wrp.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ix+vDhTh+n1g+0BqERo2XaFIbs4ujyls0wswSRL1RBc=;
 b=ir/P8JIdAdd+m0fdUjHliRjuN58jkMn7CyPw2SmjkVJ6raMduX2r1ySR2hMDzmXlyl
 1EZlhN/Iu80pG4fTecdlZIEbecXn4BP/KfnvNYhYNANQQt+eRxQZcIZMx9Wxe66bLODt
 RPRq0n/FowcTd7tsxnLdUAsiY2YsQgC0+Rljq8uYbSOW/JmRZ86/lwM8yvodu8nwpeDK
 CuJ98To4Nl6yjSx8o8u5s/pzb0f32cyG/2C4pVK7AwNw8EXVqUdrkwnxsGHzPEwbf47h
 L9CbI8oh/3O2O4HfTJ0mzwl4+vOf0SVFIxDtiJtdH6VgdI7Hj+RcnnHsq0QcYFdgcj3M
 /xyQ==
X-Gm-Message-State: AOAM531CH3nms2Cq2Qlv50YmEqrsdoat93ZqROnjaWUq6AxQoRm7BYwu
 A1O9YVB8VvMehvzFbGCAo0x9yfzNl7wf39JCML3xuebGcE8388CNkyZ/hfWLWlAsN92Kg940nQ8
 rPQrxSd7AefoYbwo=
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr1866762wmt.22.1599471077984; 
 Mon, 07 Sep 2020 02:31:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2Sl8QLyQrrmc/Jmk8n/fMihUW0Ssmy7vjX0co7nWZUP/TjIJCLyBsLDyUxNVfm+JdqpC5nw==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr1866740wmt.22.1599471077765; 
 Mon, 07 Sep 2020 02:31:17 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z7sm19352578wrw.93.2020.09.07.02.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 02:31:17 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] qga: add implementation of guest-get-disks for
 Windows
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <cover.1599470071.git.tgolembi@redhat.com>
 <2cd59ce454e0da02eeb75ab7461ef420b30864f5.1599470071.git.tgolembi@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <bc08b17b-695e-b5d0-a616-c9ae39d337c1@redhat.com>
Date: Mon, 7 Sep 2020 11:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2cd59ce454e0da02eeb75ab7461ef420b30864f5.1599470071.git.tgolembi@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Yonggang Luo for review.

On 9/7/20 11:14 AM, Tomáš Golembiovský wrote:
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
>       "slaves": []
>     }
>   ]
> }
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 97 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 6 deletions(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index e9976a0c46..9ac847a187 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -945,6 +945,91 @@ out:
>      return list;
>  }
>  
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskInfoList *new = NULL, *ret = NULL;
> +    HDEVINFO dev_info;
> +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> +    int i;
> +
> +    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> +        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
> +    if (dev_info == INVALID_HANDLE_VALUE) {
> +        error_setg_win32(errp, GetLastError(), "failed to get device tree");
> +        return NULL;
> +    }
> +
> +    g_debug("enumerating devices");
> +    dev_iface_data.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
> +    for (i = 0;
> +        SetupDiEnumDeviceInterfaces(dev_info, NULL, &GUID_DEVINTERFACE_DISK,
> +            i, &dev_iface_data);
> +        i++) {
> +        GuestDiskAddress *address = NULL;
> +        GuestDiskInfo *disk = NULL;
> +        Error *local_err = NULL;
> +        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
> +            pdev_iface_detail_data = NULL;
> +        STORAGE_DEVICE_NUMBER sdn;
> +        HANDLE dev_file;
> +        DWORD size = 0;
> +
> +        g_debug("  getting device path");
> +        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_data,
> +                pdev_iface_detail_data,
> +                size, &size,
> +                NULL)) {
> +            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
> +                pdev_iface_detail_data = g_malloc(size);
> +                pdev_iface_detail_data->cbSize =
> +                    sizeof(*pdev_iface_detail_data);
> +            } else {
> +                g_debug("failed to get device interface details");
> +                continue;
> +            }
> +        }
> +
> +        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
> +        dev_file = CreateFile(pdev_iface_detail_data->DevicePath, 0,
> +            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> +        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
> +                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
> +            CloseHandle(dev_file);
> +            debug_error("failed to get storage device number");
> +            continue;
> +        }
> +        CloseHandle(dev_file);
> +
> +        disk = g_new0(GuestDiskInfo, 1);
> +        disk->name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> +            sdn.DeviceNumber);
> +
> +        g_debug("  number: %lu", sdn.DeviceNumber);
> +        address = g_malloc0(sizeof(GuestDiskAddress));
> +        address->has_dev = true;
> +        address->dev = g_strdup(disk->name);
> +        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
> +        if (local_err) {
> +            g_debug("failed to get disk info: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            qapi_free_GuestDiskAddress(address);
> +            address = NULL;
> +        } else {
> +            disk->address = address;
> +            disk->has_address = true;
> +        }
> +
> +        new = g_malloc0(sizeof(GuestDiskInfoList));
> +        new->value = disk;
> +        new->next = ret;
> +        ret = new;
> +    }
> +
> +    SetupDiDestroyDeviceInfoList(dev_info);
> +    return ret;
> +}
> +
>  #else
>  
>  static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
> @@ -952,6 +1037,12 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
> @@ -2229,9 +2320,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>  
>      return info;
>  }
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> 


