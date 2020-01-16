Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45951C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6CB208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8ZVUrSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6CB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9sb-0005RJ-UY
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1is9qy-0004Pd-MG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1is9qu-0005R8-Fo
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:26:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1is9qu-0005QG-Bj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579199203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSPx7brIB3VlPtEScmGQABuZFIV9qpk5/FgW5hSetCY=;
 b=K8ZVUrSuypWD3ZeNazk3iR8Ym+MT+1cJfTog65L24Sb+P2pfzwPtXx6iLjM3eQNYWnrgDs
 +lnosc2F01Bch7znMPwF6Y8wI6QU7zr1Uf14xpdposMr82Eyp4NodYqMKyLjyI/NE4dPrn
 hqN0U4vF9EMk75WnMhGjSnur5T0D1sk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-orA6F_9fOlu4EVrRKho6Tg-1; Thu, 16 Jan 2020 13:26:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id i9so9551074wru.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TSPx7brIB3VlPtEScmGQABuZFIV9qpk5/FgW5hSetCY=;
 b=UdNj9dKUCGR7l6Dfa/uZ4IdOWVcsjz3m7repvJbZUPf6wB5zei+APoqvQekApvJfl9
 FA+yAkialNxlBr9Hda6Z156jiEJUjJ1rcQFf0BK5JBBhVy6C7Qd1caGwe+SEOf17rBzT
 3e2vQ9kRsIbCCmQ2gjyZUTw9SYjD7Z4WGhB/2bnbKS+8XjfVv4vVIKBLgL3BXYX44cMS
 6/+BDBtYeTmLDgIsP8pT8quZ7VWDQKBFdWcrJ578yF/67ljyEPCDEF1MBMWhUm4rKBbu
 zrfCo6tdteI2oaKc1wVvi2TdyoFB1sOKsbL/0B3RINKn0lEoRTvKADwkeOUCC0vOLmo1
 hgSw==
X-Gm-Message-State: APjAAAV/nYtap9W0uRuNx8BlHJ5NqxzNNOimdTPUxWueVBSeg2egdZcI
 RYhzLiNgmHBxrJZREe+XtNzxdXhHG23P9bAdGjRCNYSvpUxd2QpxZa3GLZtId7A8ctOMFlM0wpA
 qRMFE/o5tLES2oYc=
X-Received: by 2002:adf:d850:: with SMTP id k16mr4544623wrl.96.1579199201080; 
 Thu, 16 Jan 2020 10:26:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhm3EPHrHSOhWu5NeguxVx/gjYuv2SrNvgpzZHZbLrl8HvFa4K1Xm1kMh/aZCyQ24UGjuIFw==
X-Received: by 2002:adf:d850:: with SMTP id k16mr4544591wrl.96.1579199200761; 
 Thu, 16 Jan 2020 10:26:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id u18sm29930479wrt.26.2020.01.16.10.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:26:40 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
Date: Thu, 16 Jan 2020 19:26:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200116180321.24968-1-olaf@aepfle.de>
Content-Language: en-US
X-MC-Unique: orA6F_9fOlu4EVrRKho6Tg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/20 19:03, Olaf Hering wrote:
> With commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea a new member
> smbus_no_migration_support was added, and enabled in two places.
> With commit 4ab2f2a8aabfea95cc53c64e13b3f67960b27fdf the vmstate_acpi
> got new elements, which are conditionally filled. As a result, an
> incoming migration expected smbus related data unless smbus migration
> was disabled for a given MachineClass.
> 
> Since commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea forgot to handle
> xenfv, live migration to receiving hosts using qemu-4.0 and later is broken.
> 
> Therefore this patch must be applied to stable-4.x as well.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index fa12203079..e19716d0d3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -952,6 +952,7 @@ static void xenfv_machine_options(MachineClass *m)
>      m->desc = "Xen Fully-virtualized PC";
>      m->max_cpus = HVM_MAX_VCPUS;
>      m->default_machine_opts = "accel=xen";
> +    m->smbus_no_migration_support = true;
>  }
>  
>  DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
> 

This patch is wrong; xenfv does not support cross-version migration
compatibility.  Even if the migration stream does not change, the
hardware exposed to the guest will.

My understanding is that Xen is able to use "-M
pc-i440fx-VERSION,accel=xen".  The presence of the version in the
machine type guarantees that the migration stream is compatible and that
the hardware exposed to the guest is the same on the source and destination.

Is this incorrect?

Paolo


