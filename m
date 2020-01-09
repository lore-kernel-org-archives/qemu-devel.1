Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA8C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6F22072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlkMIjBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6F22072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWJG-0001M0-1V
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipWIU-0000qd-Gu
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipWIT-0002Oj-9d
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:48:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipWIT-0002LT-0w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578570496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CZG033CiNm29mLuqaANPgCBcf+27zL3lTgIi0zYkmu0=;
 b=KlkMIjBBGH+eNJESF52O9ZEINo9YChuh8fbAoo6PyETTchL/7NRROITbC5uof/rIUT8wLw
 ZviM58GU7CzP/FhVGRjQ97j2orSDlP4cDhPDHh2E1WIyfnc/wWZZregAFe1WSftjkxb5AV
 byQWbq2NpKk5KwQ8BfzCang3MwZttQw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-G61cMoPYOeSZ0oTLQSuW6g-1; Thu, 09 Jan 2020 06:48:15 -0500
Received: by mail-qk1-f197.google.com with SMTP id 65so3954931qkl.23
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E+mr7+jEfIzCY+q7jLitaPGKmfvyzjHRF4cd2A6EIxM=;
 b=aFN1n7h/SRA1b43u6Pzd3DaboBZfv9CBbJmX94GEnDd/U/9/KQcbzjsIfJYT0Ys2OU
 6pTgV70e1msvvybSQ9y2u701bErouf4ajiAKhjrl/OKzmav2SuqP32jitjNVqHOOzimE
 AyvITQfsDuZLgb4DD7galQZp0P/rmC7SImo0/3Sohq+IK5o2toFp9FnuK0SB8L994iuk
 MkNAfCcmyjBNI8P4D99X4Z+vRwOzV/7NwEwXcH6m9YDsHXoKet0Xq72MHw0ADZ2QHTxc
 YXRmPIRDqgHasYJ9wePHClFy52KBNWCnXBmz3sldgBxo2rGZQlx85gyo20vQzRKSuA9r
 cqIg==
X-Gm-Message-State: APjAAAXBtS9+mMMQtZi8Vm8kzh1MLWf7OV6fXMBkmcrnPEGg4wR6YNEW
 OxcyOU2OiByyLfQcMGj5ENEcibus7FFPwtvhPK62jHPqINyEhG1k43znXtYH4mPEgtMUObuIrcO
 89aAzNk5KMYXwrSg=
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr8643953qvp.176.1578570494662; 
 Thu, 09 Jan 2020 03:48:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCrZ5Ts9B42NWevHrTDsDqnuAh6RH8f26W3IqhlTosd8mdmZtQR+xAj+ZJeyT0G0hNq0XTdw==
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr8643930qvp.176.1578570494401; 
 Thu, 09 Jan 2020 03:48:14 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id a185sm2920076qkg.68.2020.01.09.03.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:48:13 -0800 (PST)
Date: Thu, 9 Jan 2020 06:48:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109064527-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200108135353.75471-3-dgilbert@redhat.com>
X-MC-Unique: G61cMoPYOeSZ0oTLQSuW6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Mark the synic pages as ram_device so that they won't be visible
> to vhost.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


I think I disagree with this one.
 * A RAM device represents a mapping to a physical device, such as to a PCI
 * MMIO BAR of an vfio-pci assigned device.  The memory region may be mappe=
d
 * into the VM address space and access to the region will modify memory
 * directly.  However, the memory region should not be included in a memory
 * dump (device may not be enabled/mapped at the time of the dump), and
 * operations incompatible with manipulating MMIO should be avoided.  Repla=
ces
 * skip_dump flag.

Looks like an abuse of notation.



> ---
>  hw/hyperv/hyperv.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index da8ce82725..4de3ec411d 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, Error **e=
rrp)
>      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_index);
>      eventp_name =3D g_strdup_printf("synic-%u-event-page", vp_index);
> =20
> -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
> -                           sizeof(*synic->msg_page), &error_abort);
> -    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
> -                           sizeof(*synic->event_page), &error_abort);
> -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_page_mr);
> -    synic->event_page =3D memory_region_get_ram_ptr(&synic->event_page_m=
r);
> +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_size,
> +                                    sizeof(*synic->msg_page));
> +    synic->event_page =3D qemu_memalign(qemu_real_host_page_size,
> +                                      sizeof(*synic->event_page));
> +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, msgp_nam=
e,
> +                           sizeof(*synic->msg_page), synic->msg_page);
> +    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj, eventp=
_name,
> +                           sizeof(*synic->event_page), synic->event_page=
);
> =20
>      g_free(msgp_name);
>      g_free(eventp_name);
> --=20
> 2.24.1


