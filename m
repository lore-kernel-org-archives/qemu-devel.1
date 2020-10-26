Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B07C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8428322242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4yVeNbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8428322242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2wx-0007Ei-Ci
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kX2u8-0005KY-AC; Mon, 26 Oct 2020 09:51:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kX2u5-0001hu-Bz; Mon, 26 Oct 2020 09:51:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QDnIFd068914;
 Mon, 26 Oct 2020 13:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=auub1rovbp8q0GUEyFyhFiazXj7YK8IRFXOXS11Xue4=;
 b=h4yVeNbVLs6kThH5LQ+nrp7UFQWfguDLUaWY6Ki3WyYImBOCEsRv3typc15osgEzRJcp
 BEi3WuzuZSXtzE9RZBTOOMf46CNmSiR/VMZM6A96PeNfDjH5wi+XwuoNjrAjEMagJmSF
 rroDkbC074ByPPF1UqZ6ML5Ye7wBHvVEfxNoQ35zGZkJmKU7/UX8RHeXUVaCRTL7jVre
 c0FjAI7HCSj82aYd+tEzoYPCvgTtBXvIdypSRgEUPG2vKHa436HLKf2E/arIk/jTrlSa
 PTvMl7M1TKKlBMlbiUtu3/opIwlp/QPTFehCv2eBqWh3xnkejJ34EsMgbUk6kvUJCSl6 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 34cc7kmpmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Oct 2020 13:51:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QDoOXk152672;
 Mon, 26 Oct 2020 13:51:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 34cwuk87h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 13:51:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QDp7TE004625;
 Mon, 26 Oct 2020 13:51:08 GMT
Received: from [192.168.248.100] (/86.120.250.68)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 26 Oct 2020 06:51:02 -0700
Subject: Re: [PATCH 0/8] Add support for pvpanic mmio device
To: Peter Maydell <peter.maydell@linaro.org>
References: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
 <CAFEAcA9n3T5MrBp2RbOQGWBptV5ObCssF00ygK8TDieP+V1Srg@mail.gmail.com>
From: Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <a6065386-a844-9d06-21ca-57baa98c8caf@oracle.com>
Date: Mon, 26 Oct 2020 15:50:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9n3T5MrBp2RbOQGWBptV5ObCssF00ygK8TDieP+V1Srg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9785
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260100
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=mihai.carabas@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 09:51:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/2020 1:17 PM, Peter Maydell wrote:
> On Thu, 22 Oct 2020 at 09:25, Mihai Carabas <mihai.carabas@oracle.com> wrote:
>> The patchset was assembled from chuncks from some old patches from 2018 [1]
>> which were left unmerged and some additions from me. Surprisingly their Linux
>> kernel counterpart were merged (so the pvpanic driver from the kernel supports
>> mmio).
>>
>> I have seen the discussions about moving the pvpanic to PCI [1]. Those patches
>> were sent but nothing happened. Also they are not trivial and require major
>> modifications at the driver level also. Given the fact that we already have
>> mmio driver support for pvpanic in the Linux kernel, I have sent these patches
>> to ask again the maintainers if this can be merged.
> 
> I'm afraid the answer is still the same. You need to provide
> a convincing argument for why this needs to be an MMIO
> device rather than a PCI device. I really don't want to
> add MMIO devices to the virt board if I can avoid it,
> because they're all extra code and potential extra
> security boundary attack surface. PCI devices are guest
> probeable and user-pluggable so they're almost always
> nicer to use than MMIO.
> 

Thank you for your input.

The reason why pvpanic should be MMIO is that is a special device which 
is not used commonly by the user (aka VM), it is not need to be 
hot-plugable and it does not have a hardware correspondent to be a PCI 
device. Another reason is that MMIO support was accepted in the kernel 
driver and it is pretty useless there without a device.

I know it seems that I want to get this on the short-path, but at this 
point having a kernel driver in the upstream and no device to test it 
against it is pretty weird.

Thank you,
Mihai

