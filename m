Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F338AC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8402075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="okJ9FU9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8402075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDC4-00030p-Io
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:00:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCqj-0007sv-Aq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCqi-0003t6-DA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:38:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hMCqg-0003l9-3f; Thu, 02 May 2019 10:38:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42ETP0k070479; Thu, 2 May 2019 14:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=A9TzjULkZrXCiKdzUO+sJhESDmK/09lhaFH+hgM7GuA=;
	b=okJ9FU9hmBMdK4QtjkpkepJ8rrXR7XJungm8yGsCLUhOfDyxTTZAucZ7pgiNODL/JZyA
	4A7Atnola76BIvwBHERwVilC5BoUMkhZ4f+xQP7jT5IzSIf/XxuH4mNyZPNWneyKdxMC
	kvi7tYg2y4L5cPERE3sRYAU0Bvd+6+d51BxcwKmI3+IetHjTbSOFm25afKyKgq+yCk8C
	ECvdfCu0TFeiD5O91ivbRMQ2qYpeI9I5mv9jKzcprIvKZ2UKtMNfSdUAkvZdzJtUMAG3
	WPtf7n9OHJZ6Dj3VDMBnM0NkyzwkXWLGa6EQG57a9TGMRcdWUfAjDQ1gDtd3i1S6hwNO
	gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2s6xhyh410-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 14:38:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x42Ebq0Y027669; Thu, 2 May 2019 14:38:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2s7p89t5vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2019 14:38:08 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x42Ec77I026043;
	Thu, 2 May 2019 14:38:07 GMT
Received: from [10.0.5.147] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 02 May 2019 07:38:06 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
From: Sam <shmuel.eiderman@oracle.com>
In-Reply-To: <3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
Date: Thu, 2 May 2019 17:38:02 +0300
Content-Transfer-Encoding: 7bit
Message-Id: <B7F58E1E-D1FA-40E2-BF86-BE8BAA1A18D7@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
To: Eric Blake <eblake@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=365
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905020099
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=389
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905020098
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
	arbel.moshe@oracle.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	liran.alon@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502143802.eY8RnxWQdHT9zN-8DbQYlsi_EqsWFPEVFrKjCsgTdHc@z>

I see,

Thanks

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


