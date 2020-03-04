Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B15C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB4A20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7fCgJ+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB4A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Ppq-0002Y4-IV
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9Pon-0001zG-2F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9Pok-0000gF-K8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:55:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9Pok-0000cs-80
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583312149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hiDKf+1FRP7Qsn6NU2jsLDyFS+cOtFP+Bpiumr4sdU=;
 b=F7fCgJ+f5/+Dz8wnafbOs5wDiUFksZ9HCVj1jWEUNSjjBnuocD+pJtDC9Tga4pDUG8n5QD
 ugyLiNtrY84F+EUpyGrfXruZ7K8w8PCDqqsOuhWIU7g99wpK6zUPaVD2lnG+X91LEoYGrp
 2dXbY6KAIW7kIEQ3LiUaaS1xJvQPV+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-lnlDn6QmM7Gfu4vNsl9HNg-1; Wed, 04 Mar 2020 03:55:45 -0500
X-MC-Unique: lnlDn6QmM7Gfu4vNsl9HNg-1
Received: by mail-wm1-f70.google.com with SMTP id y7so574719wmd.4
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 00:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=esVLzDgs8QjiaS788crFRrla9njdU+b+E9+Nys4J2VQ=;
 b=s9SaWAJDSnAU4DHX2tStmqzXI0wCG7bcl3O5HIPrpAW+1x8e6ocyIRMwdwLQRDLiWO
 J6C5tVzhjhORydkpmbQ+nnEYXjyIqvMoJxV9FHF4GiXNRjREQKLVkJfxNiQykffJSFEH
 dtZ9Zz1fCUfZiTPtZzNXSb3FDTgYE2nU0iO7DrzCkW4hcJ/nnX/4qFuLPEyQTmWszeh4
 1brt2avEpdcvDvuSd6EPCl7j/jB/FmQ3nVJ/eXtDMxuE9K5nKwGJirKZ0BYwTNS4WORf
 V35HKXsYmlnEkB06IOTqAPtsOUsgtv3fh6ZcqQA7uomn2KFPzqpZlQZ6NcSo1De6xvL1
 yffA==
X-Gm-Message-State: ANhLgQ14jZu4xbPH0UdtQR7N6rs0K5BA7s+LzJZ5xrA1L55Mt2+2Qytg
 HSkOjy1gMM75Ke0Z29F0vg57zfX5bb2tkFq9vnaGXVxzEKabq8p8qVYvEf5N86uLWlmWSL1iSNL
 fjslFbKXtyEKc298=
X-Received: by 2002:a5d:6b8d:: with SMTP id n13mr3197049wrx.292.1583312144622; 
 Wed, 04 Mar 2020 00:55:44 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtlFpqQK3JvcZAcFaxLj8iGluCqNJWsGAtE4XN4jCRtHeYTRt5AMCtk0Avb1gMUPfqQ/8skjw==
X-Received: by 2002:a5d:6b8d:: with SMTP id n13mr3197020wrx.292.1583312144295; 
 Wed, 04 Mar 2020 00:55:44 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id z14sm35043325wrg.76.2020.03.04.00.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 00:55:43 -0800 (PST)
Date: Wed, 4 Mar 2020 09:55:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Joe Richey <joerichey94@gmail.com>
Subject: Re: [PATCH] optionrom/pvh: scan entire RSDP Area
Message-ID: <20200304085541.cyirmrx5dozhf63a@steredhat>
References: <20200303105246.66390-1-joerichey94@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200303105246.66390-1-joerichey94@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-trivial@nongnu.org, Joe Richey <joerichey@google.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing Paolo

On Tue, Mar 03, 2020 at 02:52:47AM -0800, Joe Richey wrote:
> From: Joe Richey <joerichey@google.com>
>=20
> Right now the PVH option rom scans for the RSDP from 0xE0000 to
> 0xE1FFF. This is probobly a typo, it should scan from 0xE0000 to
> 0xFFFFF.
>=20
> This is actually an issue on some QEMU versions/machines. For example,
> when I run QEMU the RSDP is placed at 0xf5ad0 which will not be picked
> up by the current implementation.
>=20
> This bug still allows a Linux guest to boot (in most configurations) as
> the kernel will just scan for the RSDP if one isn't provided.
>=20
> Signed-off-by: Joe Richey <joerichey@google.com>
> ---
>  pc-bios/optionrom/pvh_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
> index a015e1bf22..28e79d7fc4 100644
> --- a/pc-bios/optionrom/pvh_main.c
> +++ b/pc-bios/optionrom/pvh_main.c
> @@ -29,7 +29,7 @@ asm (".code32"); /* this code will be executed in prote=
cted mode */
> =20
>  #define RSDP_SIGNATURE          0x2052545020445352LL /* "RSD PTR " */
>  #define RSDP_AREA_ADDR          0x000E0000
> -#define RSDP_AREA_SIZE          2048
> +#define RSDP_AREA_SIZE          0x00020000
>  #define EBDA_BASE_ADDR          0x0000040E
>  #define EBDA_SIZE               1024
> =20

The patch LGTM!

When I wrote this code I followed [1], where it is written that it can
be found in the "memory region from 0x000E0000 to 0x000FFFFF", so it
should be a typo.

Thanks for fixing it!


Fixes: 2785dc7b17 ("optionrom: add new PVH option rom")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


[1] https://wiki.osdev.org/RSDP#Detecting_the_RSDP


