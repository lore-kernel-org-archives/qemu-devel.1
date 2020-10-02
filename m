Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C0C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B73206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UANpDecJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B73206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMxR-0002Qa-SG
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kOMvj-0000fK-11; Fri, 02 Oct 2020 11:25:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kOMvc-0001ky-Ct; Fri, 02 Oct 2020 11:25:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092FJCjX009115;
 Fri, 2 Oct 2020 15:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Au3SegbzlEBLORvHP8t+tb1nX/8DEP+yWCdqwmizheA=;
 b=UANpDecJ2zS80w5L+LSFpDHz+kYGFdiUOpuePsnTDvAsd/zk7lkIPWbnr6bj54wPBzah
 iY6ZnWL4DJiIPonoOrK9CBeWQSd+Bisz1jXAHjQ9b9AXiXzoJdcJ5DY7OweX1JgRVmER
 zYaVlW1D60FmCM2RDEGOQNA+iLyLGBaKop1JZMV4NAg4i3c5cfoDbOe7XHmXuCQv9rts
 3qZCTEjE5H/gzAA3Uck7g5WWsyKjzGvx6CKdrhFmprcGDT5gzGxLm4HFEkNuWk9r8N+C
 Fw6/+Ugc18WfCSIfOySPgYFqpNtZrwgL5tY7EiXoPO6/5rsjOTq4p1PQqvmnAUBQeb4Y UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 33sx9nkeqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 02 Oct 2020 15:24:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092FJtWD194156;
 Fri, 2 Oct 2020 15:22:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 33tfk3ng2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Oct 2020 15:22:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 092FMkAm003128;
 Fri, 2 Oct 2020 15:22:47 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 02 Oct 2020 08:22:46 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 5605019208F4; Fri,  2 Oct 2020 16:22:42 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] gitlab-ci.yml: Only run one test-case per fuzzer
In-Reply-To: <20201002143524.56930-1-alxndr@bu.edu>
References: <20201002143524.56930-1-alxndr@bu.edu>
Date: Fri, 02 Oct 2020 16:22:42 +0100
Message-ID: <m27ds87iv1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020120
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:24:51
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday, 2020-10-02 at 10:35:24 -04, Alexander Bulekov wrote:
> With 1000 runs, there is a non-negligible chance that the fuzzer can
> trigger a crash. With this CI job, we care about catching build/runtime
> issues in the core fuzzing code. Actual device fuzzing takes place on
> oss-fuzz. For these purposes, only running one input should be
> sufficient.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a51c89554f..075c15d45c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -303,7 +303,7 @@ build-oss-fuzz:
>                        | grep -v slirp); do
>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || cont=
inue ;
>          echo Testing ${fuzzer} ... ;
> -        "${fuzzer}" -runs=3D1000 -seed=3D1 || exit 1 ;
> +        "${fuzzer}" -runs=3D1 -seed=3D1 || exit 1 ;
>        done
>      # Unrelated to fuzzer: run some tests with -fsanitize=3Daddress
>      - cd build-oss-fuzz && make check-qtest-i386 check-unit
> --=20
> 2.28.0

