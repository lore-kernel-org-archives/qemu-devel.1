Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E6C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDD02074A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaXqcanO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD02074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCARu-0004nV-Hp
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCAR7-0004HG-0U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCAR5-00025i-U1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:06:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCAR5-000248-QJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583968007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54D4voWNqW7MGsLKJ+6hdaXWDoKbjRkhhticRK1DX9w=;
 b=KaXqcanOfFNJlFyA63AXEsqGQSBq4Hen7MXe8S2TrRoRadKmOQv7G0Sv+4e2BmfLXvb/TG
 mVX+ZgpjvH0NX8uv6ROu65M9c4Jq0W1Junt4JCsHQaE3nQIic3rIBPmhqigoY/AkYNHjiU
 +lrPFaOFD7bKnVpRfCgZ4YpYKnhYMs8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-HLPZZ3TsNgqTwtgdcaLQfg-1; Wed, 11 Mar 2020 19:06:45 -0400
X-MC-Unique: HLPZZ3TsNgqTwtgdcaLQfg-1
Received: by mail-qk1-f198.google.com with SMTP id w2so2600671qka.4
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 16:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QcUt/U6jtY+Z64sCtbawbBgCt2qAC1LVNKUbYSSuUzQ=;
 b=YOz7/ukiQVXqNrPQOyCTM1VpQviZAgoLQarOo+tPI+10guUeSfpsP+n9GTkaAyxGIk
 DNZWuP1gvWLdUmt6t/N3CKzD1d25t3CY1ovEBDdqE3x3VW7SqlnlgJYsIAXcPC5X6aq7
 IRaeYF4UR74DHDsROWXIm8afA1nTUnB4cn62Y1+ufx+DdhPMO9nhBzQFiFuaS4Ce4P5K
 g/qUpLOLr30RUV8sFWCQogwaIPjkltVZ8gnx26UA85nB/UgGD7pRLk/D1cHioma6AJi1
 U+as/7vCLa7va3YCG8u5EMeGBvmdndoyXY+VuVSLDIDCEdNEMeDgnEi1/+eQcdNHkpWn
 uvCg==
X-Gm-Message-State: ANhLgQ0dmwweNtYCNsTcVwHWwu2Imi9SUHMMydxkvDOuL3QfbaGDhGUB
 ZS+Y/FwJB4XTsGc8vankmK6SMhPVH3/pIAhsYgbpbvnLkmaaji3cpEXj7+0yyH2B8JA0EGoZX4g
 MJSZhWnbFoFm5k/E=
X-Received: by 2002:ad4:41cf:: with SMTP id a15mr4983968qvq.125.1583968004825; 
 Wed, 11 Mar 2020 16:06:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuHrG95mZHc8G6ZErwPX6piO0Ljr9GK0I4L30B2zRNI8clvCGM5RsRk9b6nUXjHNgw1tlSivw==
X-Received: by 2002:ad4:41cf:: with SMTP id a15mr4983948qvq.125.1583968004628; 
 Wed, 11 Mar 2020 16:06:44 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g15sm22647862qtq.71.2020.03.11.16.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 16:06:43 -0700 (PDT)
Date: Wed, 11 Mar 2020 19:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200311190618-mutt-send-email-mst@kernel.org>
References: <20200311225130.1599619-1-ehabkost@redhat.com>
 <20200311225130.1599619-3-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311225130.1599619-3-ehabkost@redhat.com>
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 jtomko@redhat.com, qemu-devel@nongnu.org, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 06:51:30PM -0400, Eduardo Habkost wrote:
> The CONFIG_LINUX check at the top of mmap-alloc.c never worked
> because it was done before including osdep.h.
>=20
> This means MAP_SYNC and MAP_SHARED_VALIDATE would always be set
> to 0 at the beginning of the file.  Luckily, this didn't break
> when using recent glibc versions (2.28+), because those macros
> were redefined by glibc headers.
>=20
> Move the CONFIG_LINUX check after the main include lines, so the
> CONFIG_LINUX check works and we actually include <linux/mman.h>.
> This will make MAP_SYNC and MAP_SHARED_VALIDATE available even if
> the host has an older glibc version.
>=20
> Reported-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Makes sense, and I guess we should CC stable on this?

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  util/mmap-alloc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..7c2ce98eb0 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -9,6 +9,9 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or
>   * later.  See the COPYING file in the top-level directory.
>   */
> +#include "qemu/osdep.h"
> +#include "qemu/mmap-alloc.h"
> +#include "qemu/host-utils.h"
> =20
>  #ifdef CONFIG_LINUX
>  #include <linux/mman.h>
> @@ -17,10 +20,6 @@
>  #define MAP_SHARED_VALIDATE   0x0
>  #endif /* CONFIG_LINUX */
> =20
> -#include "qemu/osdep.h"
> -#include "qemu/mmap-alloc.h"
> -#include "qemu/host-utils.h"
> -
>  #define HUGETLBFS_MAGIC       0x958458f6
> =20
>  #ifdef CONFIG_LINUX
> --=20
> 2.24.1


