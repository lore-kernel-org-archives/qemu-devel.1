Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D3C4742D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABE222491
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUDxLS4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABE222491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUukG-00078l-2j
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUujW-0006iR-7M
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUujU-00070I-Q2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:39:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUujU-0006za-HM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:39:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFZRmd151138;
 Wed, 13 Nov 2019 15:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hes1JWYAyBliYKpv5p9mQtqin2GMY1mc1fxQ6CxDw7o=;
 b=aUDxLS4MHbEEuoXyjOC3usy4M9L2dZeqJe6AE8mOrx3eXUsWBHATyofUYLdy3lgthKkE
 ZeitG+svGt61QDc3VrGNoN3RYAzKeBhxa4Ox+meWSIU3VMYvpMB8WQI1SWwoHwXS/8qS
 XM2XpWlZ6E30ZIjW2T0gYpa7N2hFk92/gZkM7RL4MDZWrzSoPxwf00ZIwy+oMBM0Lb7z
 9l9Eyn2EUvqu+AxlPVnTcK8YWHLIc7fYHuNxipGs/UKjDkGHJFokWScH/wcRKTCf8Mnx
 00zLi14nrrP73j7PpotZ3e24lTnWRPJ2Y4r6dVYbXmyqBgtKiiRV7R9R+9SNO8+hmxaP LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2w5ndqd92m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 15:38:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFceYm085646;
 Wed, 13 Nov 2019 15:38:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2w7vbd2m2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 15:38:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADFc8xP020656;
 Wed, 13 Nov 2019 15:38:08 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 07:38:08 -0800
Subject: Re: [RFC v4 PATCH 02/49] multi-process: util: Add
 qemu_thread_cancel() to cancel running thread
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <e821aa9bccb49bf68c94e3d49b105c420dde9981.1571905346.git.jag.raman@oracle.com>
 <20191113153006.GA563983@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <fd30b4ee-1f92-82a8-42a6-871b0a9e23b1@oracle.com>
Date: Wed, 13 Nov 2019 10:38:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113153006.GA563983@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130143
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 liran.alon@oracle.com, rth@twiddle.net, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mst@redhat.com, kraxel@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 dgilbert@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 10:30 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:08:43AM -0400, Jagannathan Raman wrote:
>> qemu_thread_cancel() added to destroy a given running thread.
>> This will be needed in the following patches.
>>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>>   include/qemu/thread.h    |  1 +
>>   util/qemu-thread-posix.c | 10 ++++++++++
>>   2 files changed, 11 insertions(+)
> 
> Is this still needed?  I thought previous discussion concluded that
> thread cancellation is hard to get right and it's not actually used by
> this series?

Hi Stefan,

This is used in PATCH 41/49.

Thank you very much!
--
Jag

> 
> Stefan
> 

