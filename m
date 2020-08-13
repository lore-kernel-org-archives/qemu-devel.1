Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06CEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 02:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CE0205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 02:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmCgRMXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CE0205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63DY-0007XO-QO
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 22:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k63Cp-00071H-5u; Wed, 12 Aug 2020 22:43:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63134
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k63Cm-0000GX-VV; Wed, 12 Aug 2020 22:43:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07D2Wg1Q015273; Wed, 12 Aug 2020 22:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=08NWHf6EhTCj8/47xn7qtigF9qlT4yfmhbDKHZxtLB0=;
 b=NmCgRMXkmsZm02kkqGAKj8muw1RDcKUskEVanDlvCHV62AV96qJbz3+V9xhcshqzYb3w
 6a9XjTu2LI0oTUHv3jGD1QjWM3ep61mYswNwzb5GlT4lKgodC8RAO6kTb98HzOQtweed
 IyQVKX3CnPyWXaAMMyujUCQooM65dTYqqv8l9aUrZFhgpSVtJGods/02cVrD0tE5IdL8
 zqN+ht/A6s6mvZFANZkIxHGAky6G531absoCg7YQUN3A8G5IwEDQtXZHeyT0faL9XHb6
 qZVNcajzA0db1MbN0qHWrMIS3BFcP+WbCyDhI8D+ZGLuGCEajOBSWvnOY4BbodDimwbT Cw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32v7r546ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 22:42:39 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07D2eN8S025408;
 Thu, 13 Aug 2020 02:42:39 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04wdc.us.ibm.com with ESMTP id 32skp9eft4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 02:42:39 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07D2gYXe46006558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2020 02:42:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75CF578060;
 Thu, 13 Aug 2020 02:42:38 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F53C7805F;
 Thu, 13 Aug 2020 02:42:36 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.85.204.240])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2020 02:42:36 +0000 (GMT)
Subject: Re: [PATCH v2] target/ppc: Integrate icount to purr, vtb, and tbu40
To: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200811153235.4527-1-gromero@linux.ibm.com>
 <5944440c-73ac-8c21-9f02-fee91a3a2dfd@linaro.org>
 <20200813000321.GA17532@yekko.fritz.box>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Message-ID: <5d05adf7-a6d0-7f15-5a69-9226a8b9646c@linux.vnet.ibm.com>
Date: Wed, 12 Aug 2020 23:42:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200813000321.GA17532@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-12_19:2020-08-11,
 2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130012
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=gromero@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 22:42:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Gustavo Romero <gromero@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 9:03 PM, David Gibson wrote:
> On Wed, Aug 12, 2020 at 02:33:33PM -0700, Richard Henderson wrote:
>> On 8/11/20 8:32 AM, Gustavo Romero wrote:
>>> Currently if option '-icount auto' is passed to the QEMU TCG to enable
>>> counting instructions the VM crashes with the following error report when
>>> Linux runs on it:
>>>
>>> qemu-system-ppc64: Bad icount read
>>>
>>> This happens because read/write access to the SPRs PURR, VTB, and TBU40
>>> is not integrated to the icount framework.
>>>
>>> This commit fixes that issue by making the read/write access of these
>>> SPRs aware of icount framework, adding the proper gen_io_start() calls
>>> before calling the helpers to load/store these SPRs in TCG and ensuring
>>> that the associated TBs end immediately after, accordingly to what's in
>>> docs/devel/tcg-icount.rst.
>>>
>>> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
>>> ---
>>>   target/ppc/translate_init.inc.c | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Applied to ppc-for-5.2, thanks.

Thanks Peter, Richard and David.


Best regards,
Gustavo

