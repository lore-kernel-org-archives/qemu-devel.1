Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE50C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9A220575
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4vxGSWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9A220575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCHNX-000530-Hh
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCHMJ-0004Q7-3K
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCHMI-0003f3-1v
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:30:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCHMH-0003ey-Ty
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583994617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVZ68vC7H+1+b+ZjBfXE1pGYLkLu709bi42oq000tu8=;
 b=F4vxGSWkpTgBKg4ci/4H3UfFe6lTZpfKJgaAM8o/++cIbBE8OCVgr++mohWZZFV2K3Hvgo
 qMnanSlI5tbKSPpQ0hw/0ldZoyGZ7c+0s6VPcSxHfa0XlgRzGV7j4pCWgWSJEftnnc7u7V
 5uIze/4DDhEvMYIpk4tDzPnQl6arBCg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-ezv2cvj-PQuQZ6jSvfoZmg-1; Thu, 12 Mar 2020 02:30:15 -0400
X-MC-Unique: ezv2cvj-PQuQZ6jSvfoZmg-1
Received: by mail-qt1-f200.google.com with SMTP id y11so2852396qtn.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 23:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1LSsH4jO1nFy2uU4UGjPoAbJVGLVx6JH1X20LXM6TzY=;
 b=OdxuoQ8oOV1a1x1aWTZw2pClsaOBIV58o60mMABKxgTG+3mKAFWV/ZOY/LPs9AukUB
 1rwekRuLuhXNnLThbD0B1LMA9e/OQhHLSuH2U8CBaDSdKyFiL91bVqjW7scOvhdA+sRj
 nHKWYJ34BWUxwiswj/cOtAU+0RG+KLeQ4Sk7aM13A+KEKpbRAqWcDxhQSUYEwKzqsLwC
 Kyvmw8go9+BZ/xepgV5rPWr+DKqPKdu5r8Fh+KLqqje+uspBX4Ur+xtGoNIlQ9WAOQvA
 EQvDxnEOUg+szAyv8mKK5l/QLtF/eA363WW0x2p+SDou+ZezoWOg/wqW+XTNsekcp49d
 C06A==
X-Gm-Message-State: ANhLgQ12BoPWlGUMUysGTfPitf6oelployUlNGc7nsW4+D0XclzG3e2f
 mnxiv15gNI7NXWZpni6ctT4gIVs8dvNWkdVDHsE4o7qcXcbTMVRkuAs2fPlRnRHEoaE7M9QZ9sq
 X968I+wkz5dz2RXo=
X-Received: by 2002:ac8:508:: with SMTP id u8mr5925248qtg.157.1583994615016;
 Wed, 11 Mar 2020 23:30:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vszVaOLuyovm2w5JdRB4UTrg0eteS/rIFKWLi8YXwMXAtd7Pt363v2Op795SqBcX1utCUPSdA==
X-Received: by 2002:ac8:508:: with SMTP id u8mr5925237qtg.157.1583994614753;
 Wed, 11 Mar 2020 23:30:14 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x3sm2644491qkn.37.2020.03.11.23.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 23:30:13 -0700 (PDT)
Date: Thu, 12 Mar 2020 02:30:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200312022937-mutt-send-email-mst@kernel.org>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311232342.1614944-3-ehabkost@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, jtomko@redhat.com, jingqi.liu@intel.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 07:23:42PM -0400, Eduardo Habkost wrote:
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
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Cc: qemu-stable@nongnu.org


> ---
> Changes v1 -> v2:
> * (none)
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


