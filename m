Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD2EC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D6720797
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bAx09n1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D6720797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0O9-0000YI-3g
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVzXO-0001sr-2l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:03:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVzXM-0006CM-5d
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:03:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NFjEfO153935;
 Fri, 23 Oct 2020 16:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=kwa9GtcgnfBcZANafLfHfkXWdQkeqqSZmPiz1NFyYD8=;
 b=bAx09n1A9xOo7id8oqJOv/eHTBDByq5Y/8ZyHW3ro9vdUPh7AgHr15QStpytN6wSdWCV
 ZiqTkrDjJLOvZ6XHUfanhLh3OBfI4Bc2CkQ34RiEIGIlCdANPFWi/OSbZ3/ZP3dVk7l3
 RFn4xxzXZIy9LLs3pv3MfnT6J1d2rl2TokmdJgvBYUhACGk9o9EcLISrAmegCzZ6/MVI
 BS6CpO9XHmrMID0MiKvdXjq6KE+T7QY/iiLWCuV6GWrsX85/NhGL1pc3hhMj4v8qT6ll
 zh9J22a173ja2WTBqkXV59K8OS7hKYofuiBLLNmWZOeiiBXUFc+1LRLsyoV/ObmKjwdg 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 347p4bc0vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Oct 2020 16:03:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NFkQBo040209;
 Fri, 23 Oct 2020 16:03:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 348a6rvvvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 16:03:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09NG3MD3027787;
 Fri, 23 Oct 2020 16:03:22 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 23 Oct 2020 09:03:21 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 38F571DC1B28; Fri, 23 Oct 2020 17:03:15 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 17/17] scripts/oss-fuzz: ignore the generic-fuzz target
In-Reply-To: <20201023150746.107063-18-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
 <20201023150746.107063-18-alxndr@bu.edu>
Date: Fri, 23 Oct 2020 17:03:15 +0100
Message-ID: <m2pn59lykc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=2 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230106
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 12:03:26
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
Cc: thuth@redhat.com, f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday, 2020-10-23 at 11:07:46 -04, Alexander Bulekov wrote:
> generic-fuzz is not a standalone fuzzer - it requires some env variables
> to be set. On oss-fuzz, we set these with some predefined
> generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
> Do not make a link for the generic-fuzz from the oss-fuzz build, so
> oss-fuzz does not treat it as a standalone fuzzer.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  scripts/oss-fuzz/build.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 0ce2867732..40e15985cf 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -99,8 +99,14 @@ cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
>  # executable name)
>  for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
>  do
> -    ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
> -        "$DEST_DIR/qemu-fuzz-i386-target-$target"
> +    # Ignore the generic-fuzz target, as it requires some environment variables to
> +    # be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets that
> +    # are thin wrappers around this target that set the required environment
> +    # variables according to predefined configs.
> +    if [ "$target" != "generic-fuzz" ]; then
> +        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
> +            "$DEST_DIR/qemu-fuzz-i386-target-$target"
> +    fi
>  done
>  
>  echo "Done. The fuzzers are located in $DEST_DIR"
> -- 
> 2.28.0

