Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE0C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90920223BF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p7EwxAe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90920223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWyT-0001d3-95
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWxs-0001CI-UZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:32:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWxq-0005OP-Vt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:32:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9SjOo103032;
 Thu, 22 Oct 2020 09:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=PpHkrQWGQ52EFuf2dejkCEHGVDWX23AjfS+zSHupCMc=;
 b=p7EwxAe52G+1DBWtOSBashvnhkXhXzzKjpycIaHsb+zwSVDrUr1qrXr+MkQ9gIjVjmEe
 Anr7glFdYQIKUzekYzHyIfFhJaF4M3WseQyV9OHjv44/X+sOWNTfZD1jcmiMuoyZUDar
 YLe+UaGYjj0ohma/jGuuTrYKtCzYPSGYCOixpe0z1ySatNAxqvPOoY85gK2BilSlQWzu
 Tm7PcZDCvPt+prZCubJL9Vxad1P0JwBpIy6lLbBFzf++sN+vyDYW/AMA4tkpot7Nx3+5
 kVsoel/mVbALLWQI1oSRbhQT934a1rJc0xragbLhExh339C7/MylgXrf50gOchFSPcqu 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 349jrpw34n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 09:32:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9V2wX153539;
 Thu, 22 Oct 2020 09:32:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 348ahyjqyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 09:32:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M9WnFY032335;
 Thu, 22 Oct 2020 09:32:49 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 02:32:49 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 88E861D6E206; Thu, 22 Oct 2020 10:32:43 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 16/16] scripts/oss-fuzz: remove the generic-fuzz target
In-Reply-To: <20201021210922.572955-17-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
 <20201021210922.572955-17-alxndr@bu.edu>
Date: Thu, 22 Oct 2020 10:32:43 +0100
Message-ID: <m2o8ku7ghw.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=2 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220063
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:25:28
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
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Wednesday, 2020-10-21 at 17:09:22 -04, Alexander Bulekov wrote:
> generic-fuzz is not a standalone fuzzer - it requires some env variables
> to be set. On oss-fuzz, we set these with some predefined
> generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
> Remove generic-fuzz from the oss-fuzz build, so oss-fuzz does not treat
> it as a standalone fuzzer.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 0c3ca9e06f..37cd7f9e25 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -97,5 +97,11 @@ do

I'm presuming that the target that you're removing is being created by
this line, maybe we should just specifically skip it here instead?

The comment below on the removal probably would still apply though.

>      cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"

Also, did you look into using hard-links, or even sym-links - they would
require less duplication of the binaries, which may be important, or may
not, and quicker creation too, e.g.

      ln qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"

It's something that has been done for years, for example if you do:

      ls -il /sbin/{e2fsck,fsck.ext*}

you will see they share the same inode. Similarly for vi and ex, they
use symlinks (hardlinks on some OSes, but seems not Linux):

      ls -il /bin/{vi,ex}

The main point is that argv[0] will be the name of link itself, not the
thing pointed to.

Thanks,

Darren.

>  done
>  
> +# Remove the generic-fuzz target, as it requires some environment variables to
> +# be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets that
> +# are thin wrappers around this target that set the required environment
> +# variables according to predefined configs.
> +rm "$DEST_DIR/qemu-fuzz-i386-target-generic-fuzz"
> +
>  echo "Done. The fuzzers are located in $DEST_DIR"
>  exit 0
> -- 
> 2.28.0

