Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE50C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2487C2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGhOjt0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlOc-0001Wx-42
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlNe-0000cN-Hf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:18:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlNc-0007ds-8w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:18:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839E1UL156662;
 Thu, 3 Sep 2020 09:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=EEyWNmVRxKHLN/akI8eJJwk/qcPrmXyS0XfcwJvm/Rw=;
 b=WGhOjt0EB5jezTZQBBRkfkX+j5E9fvhudM/arlirB7ZKkkQhMVMK/bDbr7DxLXqepnUJ
 H+idN8sw+rYrOuvUq943+debrz5jFGYs/IpXav3kMCjyJ48a5QqYhr9sgjKGuNI6sP0L
 FYR63AXL5waEUGbBw/wZ3YWdqrrLvt34lB/gSox5vodRoQdkbpZygGK933PTtNEB44VO
 8zTwd5QjX0tU2hjcr1q9ZQsvWvDYUveFTK9fTKqAYpVcIrhpSjHQDLz2XIjx6aL9KS2Y
 X/TTDDASAq0Y2MnZuwGi8STR3zNt222fbY/SAXb9VMrNbEjgdoioiwtAjWDiNoDpoOT1 Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 339dmn62e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:18:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839AgS4153316;
 Thu, 3 Sep 2020 09:17:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 3380x9cnvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:17:59 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0839HwtH031550;
 Thu, 3 Sep 2020 09:17:58 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:17:58 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 8E8A6134FE25; Thu,  3 Sep 2020 10:17:55 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 13/15] scripts/oss-fuzz: build the general-fuzzer
 configs
In-Reply-To: <20200819061110.1320568-14-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-14-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:17:55 +0100
Message-ID: <m24kofrzgc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=2
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030085
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:43:20
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, f4bug@amsat.org,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:08 -04, Alexander Bulekov wrote:
> Build general-fuzzer wrappers for each configuration defined in
> general_fuzzer_configs.yml and move the actual general-fuzzer to a
> subdirectory, so oss-fuzz doesn't treat it as a standalone fuzzer.

You didn't mention the removeal of *uhci* from the config below, should
probably be at least referenced.

>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

With that,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

> ---
>  scripts/oss-fuzz/build.sh                   | 8 +++++++-
>  scripts/oss-fuzz/general_fuzzer_configs.yml | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index a07b3022e8..2071e77ac2 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -38,7 +38,7 @@ OSS_FUZZ_BUILD_DIR="./build-oss-fuzz/"
>  # remove it, resulting in an unresolved reference to qemu_build_not_reached
>  # Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose whether
>  # to " #define qemu_build_not_reached()  g_assert_not_reached() "
> -EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
> +EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__ -DCONFIG_FUZZ=y"
>  
>  if ! { [ -e "./COPYING" ] &&
>     [ -e "./MAINTAINERS" ] &&
> @@ -101,5 +101,11 @@ do
>      cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
>  done
>  
> +mkdir -p "$DEST_DIR/deps"
> +mv "$DEST_DIR/qemu-fuzz-i386-target-general-fuzz" "$DEST_DIR/deps/"
> +
> +./scripts/oss-fuzz/build_general_fuzzers.py \
> +    "./scripts/oss-fuzz/general_fuzzer_configs.yml" "$DEST_DIR/general-fuzz-"
> +
>  echo "Done. The fuzzers are located in $DEST_DIR"
>  exit 0
> diff --git a/scripts/oss-fuzz/general_fuzzer_configs.yml b/scripts/oss-fuzz/general_fuzzer_configs.yml
> index 010e92a2a5..f70bacb243 100644
> --- a/scripts/oss-fuzz/general_fuzzer_configs.yml
> +++ b/scripts/oss-fuzz/general_fuzzer_configs.yml
> @@ -92,7 +92,7 @@ configs:
>          -device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid
>          -device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1
>          -device usb-tablet -device usb-wacom-tablet -device usb-audio
> -      objects: "*usb* *uhci* *xhci*"
> +      objects: "*usb* *xhci*"
>  
>      - name: pc-i440fx
>        args: -machine pc
> -- 
> 2.27.0

