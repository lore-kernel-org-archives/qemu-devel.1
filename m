Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771DAC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 23:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22E62078D
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 23:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GfTUvv6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22E62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRON4-0001kc-Ue
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 19:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maciej.szmigiero@oracle.com>)
 id 1kROMB-0001Jl-0e
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 19:32:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maciej.szmigiero@oracle.com>)
 id 1kROM6-0007So-Ql
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 19:32:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09ANURE3182400;
 Sat, 10 Oct 2020 23:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=In1NNIOjZvdpapBsGbbGUhF7+n29cxmcKkCT0j+NjLM=;
 b=GfTUvv6jad/Nhwx5BSFbJ5f5ScaEnLCX3l38kx9mLsNE3k5lDWQpQhCbIjBtOprjl9Yu
 L5Inp65NXujSjw1ZZhr4WC3ktA7025jJ6/DOKW+iFh5wJvaLgff4JgonAXZ8MeKI67T2
 isd4W0aBiLIO8SrEndTkTxJWL1ccBMlYa9VkhxPbYd5gbKw8/OE9oUDwoiHJ7xOF3Hu8
 PfuG2Meet9CHtW7mdE7xXtU+d8eyoTcaTpNxENfG9EsxsRHzjFJ4v0iP5pyK5yHHCJqV
 LpLme5+seIOB0+Jn2OosUgS5PPHNbCDwRw+fCZMzxKHV5MV5+X7jMYUi33delhkqAioy sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 3434wk9brr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 10 Oct 2020 23:32:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09ANULni054211;
 Sat, 10 Oct 2020 23:30:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 34322r8fjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 10 Oct 2020 23:30:45 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09ANUfED028675;
 Sat, 10 Oct 2020 23:30:41 GMT
Received: from [192.168.1.3] (/89.66.140.113)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 10 Oct 2020 16:30:41 -0700
Subject: Re: [PATCH] vmbus: Don't make QOM property registration conditional
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201009200701.1830060-1-ehabkost@redhat.com>
 <4caca0ac-f3a0-bf45-c3d8-7b8c3ec18857@oracle.com>
 <20201009213336.GJ7303@habkost.net>
From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Message-ID: <4de9310f-7627-7440-7fcb-23dc2a0f7441@oracle.com>
Date: Sun, 11 Oct 2020 01:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201009213336.GJ7303@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9770
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010100222
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9770
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010100222
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=maciej.szmigiero@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 19:32:47
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.207, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jon Doron <arilou@gmail.com>,
 qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.10.2020 23:33, Eduardo Habkost wrote:
> On Fri, Oct 09, 2020 at 11:05:47PM +0200, Maciej S. Szmigiero wrote:
>> On 09.10.2020 22:07, Eduardo Habkost wrote:
>>> Having properties registered conditionally makes QOM type
>>> introspection difficult.  Instead of skipping registration of the
>>> "instanceid" property, always register the property but validate
>>> its value against the instance id required by the class.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>> Note: due to the lack of concrete vmbus-dev subclasses in the
>>> QEMU tree, this patch couldn't be tested.
>>
>> Will test it tomorrow since I have a VMBus device implementation.
> 
> Thanks!
> 

Tested the patch with a hv-balloon device and is seems to work okay, so:
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Maciej

