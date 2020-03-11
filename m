Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4229AC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E98720848
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZYsTeri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E98720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBy76-0005KV-8b
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jBy6J-0004GW-AQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jBy6I-0002J7-E0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:56:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jBy6I-0002IG-Aw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583920589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0+asA5DTHEAtkwKXEAUoVcm7EKaHU50stltHUcW1qg=;
 b=IZYsTeriVzEdR+Z/DkawqLpU+1ODIK7ORkrkPDGOk0cqjOXEUOl8VmgAYVpIn5HIfvIgOE
 hGePS/nfw7T/HwZE3Scy6Oo6d8vvSt9DoNeS71AycxA+W8Yd0mUUwsps9nY5uHuzXMOIzP
 REOCNnk6jZEvudHUG0l8iaKNnBJQtyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-TciYKUi3O_i_001jj0KRHw-1; Wed, 11 Mar 2020 05:56:27 -0400
X-MC-Unique: TciYKUi3O_i_001jj0KRHw-1
Received: by mail-wm1-f70.google.com with SMTP id 20so461868wmk.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 02:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LF9pqJIb06girj2Cmul2tQCYIuIsqdoetjtfYvVouOo=;
 b=VVXxGqHi8BhEiZ/cRCzQATX8tNTxYnF3YmKIxxj/udW+CkDYvkPi0P2cuZxNrbc6Zq
 +edct17jq673U9mUauGf0vk6qS07uRVibXivYCiPbmMFL3h0OiqAHDEjOKxlNkVNOcWg
 UjpkfKR+DjYkA5ABiowPybAPi+fZWyjJYlBlZhGjtP/zWKCtRvLFng3Fj7HRptNZg1df
 5FMW/TI8hICbJ9aQY6dzL0bN8yxkH8Z//VS0TbWWvG4330iJ8xpym9GcNb8dcla1xXJh
 5C8gOvqJEQDpW6C/qsMCwsBC2ELfh8XGiqocbt2ihRmDLbjCS0CiBJold6P6t3O6omn1
 THxw==
X-Gm-Message-State: ANhLgQ2rnI2FLIpl6mKeGmRTsshaDByhAChpFX1BYu4dsSkde8ZoP9xA
 RJ8/PVe2xB7rno8JJSVEJTFyU/g/ftDKpRxlHWijkKSz24/t2ZtLh1iVZG84WQhC9Tot5ylYWKK
 FDtpzSboYrnl+FOQ=
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr3725700wrp.247.1583920586619; 
 Wed, 11 Mar 2020 02:56:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvLS6jfCl4dGnrZiuYjKWkc4Wsp65Ie/UyhGADVO+FmcMmjKMv96LHbBcKKFShfoP1tvVCk0g==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr3725682wrp.247.1583920586418; 
 Wed, 11 Mar 2020 02:56:26 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id k12sm10340633wrv.88.2020.03.11.02.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 02:56:25 -0700 (PDT)
Date: Wed, 11 Mar 2020 10:56:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 0/2] hw/mem/pc-dimm: Trivial code changes
Message-ID: <20200311095623.g32nabv45ws23uah@steredhat>
References: <20200310180510.19489-1-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310180510.19489-1-wainersm@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-trivial@nongnu.org, imammedo@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 03:05:08PM -0300, Wainer dos Santos Moschetta wrote=
:
> Improve one error message and fix one code style warning.
>=20
> Wainer dos Santos Moschetta (2):
>   hw/mem/pc-dimm: Print slot number on error at pc_dimm_pre_plug()
>   hw/mem/pc-dimm: Fix line over 80 characters warning
>=20
>  hw/mem/pc-dimm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


