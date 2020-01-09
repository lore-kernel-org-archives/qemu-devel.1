Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7050C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964E42072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T27P6nlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964E42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipW8t-0001cP-Jt
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipW7f-0000QJ-8e
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipW7d-0000U2-96
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:37:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipW7c-0000ST-ES
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578569823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SDNXG5Yi/btrLMOlEi7BNUjLCnWv8a1bpV6Xjevjjg=;
 b=T27P6nlx+FZXdIuSkpXoIU2eB1P8r6rO+cXi5Qvhdxo6EjJioMKnMpBiQyTYdgEa2Q3YP5
 Defbc0c/XzO6s3X3Gb5kDLkVIB7jv/1RsSbTsFOO5BvA2g4lQlrCEnnGtTWud3oxs1Tlsc
 LzPc3IpMFrFbIAqz6FiWb5G2HWoTAlw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-gb-56Pg9PdeqdV2f87oG-g-1; Thu, 09 Jan 2020 06:37:02 -0500
Received: by mail-qv1-f70.google.com with SMTP id d7so3919426qvq.12
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=V8wsSytS5VzLMRvoBhbSD6l1trukDJP3qnoOhdNNEMI=;
 b=R1iVrE3KTQjdDbE+jJacJ4ID5pvZ8RydCNcxEmxQeQJIGlhKOok7sxduax/VI+GKSh
 iSxqX6P16NMDGC1squ7htGkDYskNQ6+ogydUKzQj2J/u4Hn9uf9vKeUxQ9LzWYv3Cd4t
 pd7JYjMls36aMFmfbRXHNiwU+dUfS/586MCWCEDhdyeHOCm5smfh3+R+ZHtBoov+ufMl
 HfZXatzjn6TiNh1iOwe1BSiRDBOqGe+Nd3octBZlh+qI2orChJDzZ7v8mjkGGedRDVki
 BX03LucloB9WiBsJULmkJL8+ksjHWAhgP4kBEeh77d5qJ/O7dT+q2r0pcdGy2XLdfSlh
 4Qpw==
X-Gm-Message-State: APjAAAUVZ3S26hgOa5+DTlLR9tPtuXAuRcpcLal9WA/8Cl4DVzoE2RG8
 zFI/AClsNW9ly6i0B2wQS8msl+vEQkUdyhFKX9LIW594WVA30dAjCxGWj+YbmLd/kuiwX9qRyaQ
 9vyPXmw+/O+S8/IA=
X-Received: by 2002:a37:490d:: with SMTP id w13mr8467981qka.221.1578569821598; 
 Thu, 09 Jan 2020 03:37:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLBAHZYd2fj7Qvov3ZhRHufVOdT5hWC2YnekJvTWDjsp6Bj166cUj2XW7w10uwZxdfB2Q8oQ==
X-Received: by 2002:a37:490d:: with SMTP id w13mr8467952qka.221.1578569821159; 
 Thu, 09 Jan 2020 03:37:01 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id r37sm3123789qtj.44.2020.01.09.03.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:37:00 -0800 (PST)
Date: Thu, 9 Jan 2020 06:36:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/smbios/smbios: Remove unused include
Message-ID: <20200109063646-mutt-send-email-mst@kernel.org>
References: <20200109112504.32622-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109112504.32622-1-philmd@redhat.com>
X-MC-Unique: gb-56Pg9PdeqdV2f87oG-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 12:25:04PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Nothing from "sysemu/cpus.h" is used by smbios.c, remove the include.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  hw/smbios/smbios.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index ded5f1f4e2..1a0f461541 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -24,7 +24,6 @@
>  #include "qemu/option.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/uuid.h"
> -#include "sysemu/cpus.h"
>  #include "hw/firmware/smbios.h"
>  #include "hw/loader.h"
>  #include "hw/boards.h"
> --=20
> 2.21.1


