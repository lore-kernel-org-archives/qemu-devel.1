Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC03C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EDD22251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iARtjVFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EDD22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0Bl-0008Nj-SG
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maciej.szmigiero@oracle.com>)
 id 1kQzae-0004Hf-JV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:06:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maciej.szmigiero@oracle.com>)
 id 1kQzab-0006DU-A7
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:06:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099L4f4c009787;
 Fri, 9 Oct 2020 21:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tlsp35VwhyJH3elrLcPRXiS5e1/6wp3uV5ZIcr/qL7E=;
 b=iARtjVFSBihFIXwrk1AI7+XtgzmoserCuvQpDAvYF8telMcA9bglzYlgRe9o7ctX1dfh
 wI4Ep0ZQsJa+RN+WUHTycaJsiPStZaejj2131NcNvmGY12e+gDb+NaBewUj355dbS4gR
 snqD4DKewLusRoSB9ttaP5BkaLQWAMoPzG//n/PPJBgPqUYrjzI+4cRlq9ugzK/ki7zQ
 ijRlaoF0rkH8XFuPhrLdvA+0wybzig2xJIHGnjCsT5gLeDHllcJozsqdIDR8zOPkjP1u
 stB6I0rrc5mQ/qLMFinyitGERBeKsQhZ66pkMtQLsBGnQFIFqW/PPJk7SH9TiXPj1UoV rA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 342kvyujfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 09 Oct 2020 21:06:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099L0L6C143466;
 Fri, 9 Oct 2020 21:06:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 3429k1jp3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Oct 2020 21:06:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 099L60Uj025008;
 Fri, 9 Oct 2020 21:06:00 GMT
Received: from [192.168.1.3] (/89.66.140.113)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 09 Oct 2020 14:06:00 -0700
Subject: Re: [PATCH] vmbus: Don't make QOM property registration conditional
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201009200701.1830060-1-ehabkost@redhat.com>
From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Message-ID: <4caca0ac-f3a0-bf45-c3d8-7b8c3ec18857@oracle.com>
Date: Fri, 9 Oct 2020 23:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201009200701.1830060-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1011
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010090154
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=maciej.szmigiero@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 17:06:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Oct 2020 17:43:24 -0400
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

On 09.10.2020 22:07, Eduardo Habkost wrote:
> Having properties registered conditionally makes QOM type
> introspection difficult.  Instead of skipping registration of the
> "instanceid" property, always register the property but validate
> its value against the instance id required by the class.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Note: due to the lack of concrete vmbus-dev subclasses in the
> QEMU tree, this patch couldn't be tested.

Will test it tomorrow since I have a VMBus device implementation.

Maciej

