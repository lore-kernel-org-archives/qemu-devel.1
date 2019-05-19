Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 08:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE8220833
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 08:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DYg1cF1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE8220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSHJn-0008BU-LL
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 04:37:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hSHJ0-0007oG-TC
	for qemu-devel@nongnu.org; Sun, 19 May 2019 04:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hSHJ0-0008IH-2G
	for qemu-devel@nongnu.org; Sun, 19 May 2019 04:36:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hSHIx-0008Ew-P8; Sun, 19 May 2019 04:36:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4J8Y9B0088104; Sun, 19 May 2019 08:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=V4kHGwqXaHR6nyxyNG+rOZIvHBi+GKvBADq0NXudq6c=;
	b=DYg1cF1bgB714wfb3XrMHwso9fdYL/3WKp6CsjE/71X1XH5Rs8k+wA25YrEgGuldeqtQ
	epueVoqkRrRWe0wdSicl0r+B6tjbpLUtCpABHzqm/xKhsofj2Mlgu9pX4wkdeHA8vF04
	9Rqq8Mjk4H3uYInusTBaeqIDHeKTOzijUsg/KyBds/n+7BR3YpFtdxwL8whw8q6pgA5G
	mn2SDWhxDtdt/crs/NEcLF4oBk78m01t6EWtouNrauZAsK16zrvgBQd6OUSR6NLFtycH
	W7td0EL012as6bRqg2BmlenptEi46kFw9vKCfHYkhYFEZOuXxshDSq+oZT+BaBJ9p4ce
	1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2sj9ft2qd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 May 2019 08:36:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4J8YN55103912; Sun, 19 May 2019 08:34:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 2sjucqvuab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 May 2019 08:34:23 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4J8YKu7021594;
	Sun, 19 May 2019 08:34:20 GMT
Received: from [10.74.126.157] (/10.74.126.157)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 19 May 2019 08:34:20 +0000
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
Date: Sun, 19 May 2019 11:34:14 +0300
Content-Transfer-Encoding: 7bit
Message-Id: <5EA23F3B-EC65-4302-BE8F-3D9228A6499D@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
To: Eric Blake <eblake@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9261
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=379
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905190063
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9261
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=412
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905190064
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qemu-img: rebase: Improve/optimize
 rebase operation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, eyal.moscovici@oracle.com, qemu-block@nongnu.org,
	arbel.moshe@oracle.com, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, liran.alon@oracle.com,
	sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping.
Do you want me to resend this patch as a new top-level thread?

Thanks,
Sam

> On 2 May 2019, at 17:21, Eric Blake <eblake@redhat.com> wrote:
> 
> On 5/2/19 8:58 AM, Sam Eiderman wrote:
>> This patch series aims to improve the speed of qemu-img rebase.
>> 
>> 1. Mainly by removing unnecessary reads when rebasing on the same
>>   chain.
>> 2. But also by minimizing the number of bdrv_open calls rebase
>>   requires.
>> 
> 
> When sending a v2 series, it's best to do so as a new top-level thread
> rather than in-reply-to the v1 series, as our CI tools are more likely
> to spot it that way.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 


