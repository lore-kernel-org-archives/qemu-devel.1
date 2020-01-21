Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246C0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E4E217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avQ3ZB2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E4E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvPn-0006VY-Ul
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itvOR-00057l-DB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itvOQ-0001Iu-9n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:24:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itvOQ-0001IH-6H
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579620277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ypQmoBs1risnQU7ThFjmYkafd8YaWdj31PnJDVkltg=;
 b=avQ3ZB2wkPNXdYFF3HbCvftWHzO9lTIBFetDczaDwCim7SnjcloMmchQbUa21+lLH3VvM5
 CRbfiWiEbWX7WX/4kV2C7yy7ztM4v8fmQmZpyhr2B0TtFwAAH043GDVeQCM3RgOAUd5UB/
 dcmVZG5ElszD8ojjyC1aJou3DIcX924=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-YWlAD2vHMG2t-TlF8UNRBQ-1; Tue, 21 Jan 2020 10:24:35 -0500
Received: by mail-wm1-f71.google.com with SMTP id g26so481600wmk.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZJlu4yA7MTXN+/hAQn2JyOXLvWp6zfX4ftczNVReyGI=;
 b=lqNFvX6uNSnI9dOuByKV/3R833mZoUl4r/Quae3e89SdTuml63tdQU36/digvwEHqr
 D7wJsPKwayvfmeCjluPkS2PnYKVJD1cZCw5g/riJ68SxP8BiPbCkDCPknzL+nT5qNxWg
 ihH/pVKsrKm5PGHTtgY7PEGBchB4JqmvceYiRRsw3y3uw7cJIsehvl95HnXIRhE5FyPu
 yCrI9exc4idztW22kzB7rkWUnlW6O3whT4oKzIToC6vMTMPkI8WO0n10Lei2MLImhUGc
 wJ/B1rX3roKnuwW2cAT9clSBGjuk/kiRrysMH0xq8cs26guE0R2+FEEHkpgznOMIC2dT
 TTXw==
X-Gm-Message-State: APjAAAXM/R5MU//pWoZhHMO2nL0kXNuKlkKLMpcExtjeZORBewbvIl+Y
 zkoPW7b/3AJA0hHYQP8iRCRftaNBauI8Iryyw778/CVtHeX7lEW86NYBBq72HMJ/TWoFFyFG6uk
 JCB/1OKOCb5I+Hic=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr5757551wrn.245.1579620274320; 
 Tue, 21 Jan 2020 07:24:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7QquMdPL5BJPAOoEDtGEY1iJ/lJROubhff8wt8OOyj2AzKbzAqkFC9a+9OkcIfRj6+qT1Rg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr5757538wrn.245.1579620273986; 
 Tue, 21 Jan 2020 07:24:33 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t25sm4340929wmj.19.2020.01.21.07.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:24:33 -0800 (PST)
Subject: Re: [PATCH v2 011/109] virtiofsd: Fix common header and define for
 QEMU builds
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-12-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8bf51480-fdef-14b5-2d4f-0068fa94e808@redhat.com>
Date: Tue, 21 Jan 2020 16:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-12-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: YWlAD2vHMG2t-TlF8UNRBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:22 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> All of the fuse files include config.h and define GNU_SOURCE
> where we don't have either under our build - remove them.
> Fixup path to the kernel's fuse.h in the QEMUs world.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tools/virtiofsd/buffer.c         | 3 ---
>   tools/virtiofsd/fuse_i.h         | 3 +++
>   tools/virtiofsd/fuse_lowlevel.c  | 5 +----
>   tools/virtiofsd/fuse_opt.c       | 1 -
>   tools/virtiofsd/fuse_signals.c   | 1 -
>   tools/virtiofsd/passthrough_ll.c | 7 +------
>   6 files changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
> index 5df946c82c..db1885ab19 100644
> --- a/tools/virtiofsd/buffer.c
> +++ b/tools/virtiofsd/buffer.c
> @@ -9,9 +9,6 @@
>    * See the file COPYING.LIB
>    */
>  =20
> -#define _GNU_SOURCE
> -
> -#include "config.h"
>   #include "fuse_i.h"
>   #include "fuse_lowlevel.h"
>   #include <assert.h>
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index e63cb58388..bae06992e0 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -6,6 +6,9 @@
>    * See the file COPYING.LIB
>    */
>  =20
> +#define FUSE_USE_VERSION 31
> +
> +
>   #include "fuse.h"
>   #include "fuse_lowlevel.h"
>  =20
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index b3d26cab66..f76f3d3fdc 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -9,11 +9,8 @@
>    * See the file COPYING.LIB
>    */
>  =20
> -#define _GNU_SOURCE
> -
> -#include "config.h"
>   #include "fuse_i.h"
> -#include "fuse_kernel.h"
> +#include "standard-headers/linux/fuse.h"
>   #include "fuse_misc.h"
>   #include "fuse_opt.h"
>  =20
> diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
> index edd36f4a3b..1fee55e266 100644
> --- a/tools/virtiofsd/fuse_opt.c
> +++ b/tools/virtiofsd/fuse_opt.c
> @@ -10,7 +10,6 @@
>    */
>  =20
>   #include "fuse_opt.h"
> -#include "config.h"
>   #include "fuse_i.h"
>   #include "fuse_misc.h"
>  =20
> diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signal=
s.c
> index 19d6791cb9..10a6f88088 100644
> --- a/tools/virtiofsd/fuse_signals.c
> +++ b/tools/virtiofsd/fuse_signals.c
> @@ -8,7 +8,6 @@
>    * See the file COPYING.LIB
>    */
>  =20
> -#include "config.h"
>   #include "fuse_i.h"
>   #include "fuse_lowlevel.h"
>  =20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 9377718d9d..e702f7dec6 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -35,15 +35,10 @@
>    * \include passthrough_ll.c
>    */
>  =20
> -#define _GNU_SOURCE
> -#define FUSE_USE_VERSION 31
> -
> -#include "config.h"
> -
> +#include "fuse_lowlevel.h"
>   #include <assert.h>
>   #include <dirent.h>
>   #include <errno.h>
> -#include <fuse_lowlevel.h>
>   #include <inttypes.h>
>   #include <limits.h>
>   #include <pthread.h>
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


