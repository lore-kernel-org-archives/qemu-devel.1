Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ECC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAC32151B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJ2VALo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAC32151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOqN-0000Pz-NG
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kYOpa-0008Ow-30
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:28:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kYOpY-0003Gx-4M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:28:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U7PbXp081442;
 Fri, 30 Oct 2020 07:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=JZoBBH9P7ELDQhKwLrKDnRbmSQR4xNtAWo5yGWkAVGQ=;
 b=pJ2VALo5jGNZ24ZxepAUU7mWEQNKvhTtCJ9Jl8Zh0AxAEQdTMpvQ/V6zUUed//UCVSSu
 zEyPWgIp+7wuNmteg6pGfisAfCM4sngQ3mPhNQeqYrsSLWJrXE8BqljRLMQ4m68Hq9pl
 72H04mezkPr8w69Jx/93cV6X/DhO2vgnVhQvFZHQhjigfFHc9qqAI1/3+uLdpq7UVbwd
 HKvyBkV1TfF3aSVHBl9zjA9F5IBltip8ue7p5gWGyN1H9XnNt9E29o9qvykqBMLPhGAu
 A+KznTHu59hZwf0trJTSVicRdo2vuhO8/4e3tsQhk81Sl0w9wZp1+uTeq088HZmcOyQh Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 34cc7m8c54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 30 Oct 2020 07:28:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U7QQ8L107348;
 Fri, 30 Oct 2020 07:28:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34cx1u59s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 07:28:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09U7S0FO005460;
 Fri, 30 Oct 2020 07:28:00 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 30 Oct 2020 00:27:59 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 4C79F1F33968; Fri, 30 Oct 2020 07:27:55 +0000 (GMT)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH-for-5.2 0/3] Bug-fixes for the generic-fuzzer
In-Reply-To: <20201029172901.534442-1-alxndr@bu.edu>
References: <20201029172901.534442-1-alxndr@bu.edu>
Date: Fri, 30 Oct 2020 07:27:55 +0000
Message-ID: <m2zh442mx0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300054
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 03:28:07
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
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sigh, I should have caught some of these in the last review, sorry.

For the series,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Thursday, 2020-10-29 at 13:28:57 -04, Alexander Bulekov wrote:
> These patches fix some silly issues I found after the generic-fuzzer
> started running on OSS-Fuzz.
>
> Alexander Bulekov (3):
>   fuzz: fix writing DMA patterns
>   fuzz: check the MR in the DMA callback
>   fuzz: fuzz offsets within pio/mmio regions
>
>  tests/qtest/fuzz/generic_fuzz.c | 44 +++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> -- 
> 2.28.0

