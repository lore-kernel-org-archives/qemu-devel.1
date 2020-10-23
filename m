Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA535C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574412192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9ocu3gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574412192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzqV-00045N-8X
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVzX0-0001Nq-BI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:03:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVzWy-00069U-4x
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:03:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NFj2vQ094976;
 Fri, 23 Oct 2020 16:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=zBopEL4Etwy5c7KrNeOieWK5K+UD0axO8fGeD1mZRSI=;
 b=O9ocu3gtYiiu4ZCJzzYAyYSuDwFKlFnNkQMRUMDKSXgDCKbsR4FF2A9bAUeFICrBRI9m
 yr2E8SM+nkBGUodZ2stuDSBneo1n6RSjKohiyQIFBZpzAPKZOP4Zphkz29i+40x7h4xD
 NNzlbuRHSKUUMXg9QSRv7ZzKxW4NOyfwtyXRrCUfWcOYPu/FfJFwpwTGHHVfsKPahs5n
 KbY9oYEhVz5hD7vZSRL35tcNOdzGL+FFxf9l/82FindliRjCp2EgbHR+Q+B/5HMsmuzi
 0CMuf5V/FxJ+kukq5OPve5OvRRV1ss7aTlQaQCm/L1EdWuozjocexoWj0ClzyuNA8a7F +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 349jrq4162-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Oct 2020 16:02:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NFkIc3100492;
 Fri, 23 Oct 2020 16:02:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 34ak1b7340-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 16:02:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09NG2uXV022959;
 Fri, 23 Oct 2020 16:02:56 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 23 Oct 2020 09:02:56 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 7B1AF1DC1A44; Fri, 23 Oct 2020 17:02:44 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 16/17] scripts/oss-fuzz: use hardlinks instead of
 copying
In-Reply-To: <20201023150746.107063-17-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
 <20201023150746.107063-17-alxndr@bu.edu>
Date: Fri, 23 Oct 2020 17:02:44 +0100
Message-ID: <m2sga5lyl7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=2 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230106
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 12:03:01
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

On Friday, 2020-10-23 at 11:07:45 -04, Alexander Bulekov wrote:
> Prior to this, fuzzers in the output oss-fuzz directory were exactly
> the same executable, with a different name to do argv[0]-based
> fuzz-target selection. This is a waste of space, especially since these
> binaries can weigh many MB.
>
> Instead of copying, use hard links, to cut down on wasted space. We need
> to place the primary copy of the executable into DEST_DIR, since this is
> a separate file-system on oss-fuzz. We should not place it directly into
> $DEST_DIR, since oss-fuzz will treat it as an independent fuzzer and try
> to run it for fuzzing. Instead, we create a DEST_DIR/bin directory to
> store the primary copy.
>
> Suggested-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  scripts/oss-fuzz/build.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 0c3ca9e06f..0ce2867732 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -62,6 +62,9 @@ fi
>  
>  mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
>  
> +mkdir -p "$DEST_DIR/bin/"  # Copy executables that shouldn't
> +                           # be treated as fuzzers by oss-fuzz here
> +
>  # Build once to get the list of dynamic lib paths, and copy them over
>  ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
>      --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
> @@ -88,13 +91,16 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
>  # Copy over the datadir
>  cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
>  
> +cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
> +
>  # Run the fuzzer with no arguments, to print the help-string and get the list
>  # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
>  # to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
>  # executable name)
>  for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
>  do
> -    cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
> +    ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
> +        "$DEST_DIR/qemu-fuzz-i386-target-$target"
>  done
>  
>  echo "Done. The fuzzers are located in $DEST_DIR"
> -- 
> 2.28.0

