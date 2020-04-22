Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5452FC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD4A206B9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD4A206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAnw-0006d9-Au
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRAn7-000652-9K
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRAmy-0006g1-VJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:31:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:3013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRAmy-0006Xg-CU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:31:24 -0400
IronPort-SDR: ek9ofdexBRU9vlbIA8+sX1IZUJwaW2y6oD8eS7HwKuDBBsxUwGxVOxCkZscj3qLqiJ0+WBA7D8
 RCTMwqQujsrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 01:31:21 -0700
IronPort-SDR: v4jRfK+fdpYg/rDJ5Q0vtv3FljuVc/P4l1XA46WESTJL/OhoPH5DWBahRdIKtzF3Di+nQDRkpK
 HocBxNnpH1jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,413,1580803200"; d="scan'208";a="365614981"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 01:31:21 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 01:31:21 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Apr 2020 16:31:19 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 22 Apr 2020 16:31:19 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/3] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Thread-Topic: [PATCH 2/3] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Thread-Index: AQHWDdRNnkCIsDBxXE6FbsLyxcPo8qiE5N3A
Date: Wed, 22 Apr 2020 08:31:19 +0000
Message-ID: <0ec3fe8fb159493fa7f08bf7484116a0@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <f231c9abc706f5825e41c0fbaa4fc82de1121435.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <f231c9abc706f5825e41c0fbaa4fc82de1121435.1586370737.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 03:46:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Thursday, April 9, 2020 2:34 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH 2/3] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
>=20
> This will be needed in the next patch.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>


Reviewed-by: Zhang Chen <chen.zhang@intel.com>

> ---
>  chardev/char.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/chardev/char.c b/chardev/char.c index 04075389bf..51ad0dc6b3
> 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -38,6 +38,7 @@
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/id.h"
> +#include "qemu/coroutine.h"
>=20
>  #include "chardev/char-mux.h"
>=20
> @@ -119,7 +120,11 @@ static int qemu_chr_write_buffer(Chardev *s,
>      retry:
>          res =3D cc->chr_write(s, buf + *offset, len - *offset);
>          if (res < 0 && errno =3D=3D EAGAIN && write_all) {
> -            g_usleep(100);
> +            if (qemu_in_coroutine()) {
> +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
> +            } else {
> +                g_usleep(100);
> +            }
>              goto retry;
>          }
>=20
> --
> 2.20.1


