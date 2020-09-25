Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8EEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D84208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/MHHfUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D84208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoS9-0002Vd-Sk
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kLoQd-0001C0-Fp; Fri, 25 Sep 2020 10:10:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kLoQZ-0003Pc-8e; Fri, 25 Sep 2020 10:10:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08PE1pKH065304; Fri, 25 Sep 2020 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IShSNVfYfjJus+mZ22FD6Xy3V6hlTL4uvy8GRN67aWE=;
 b=q/MHHfUdZwPeQsyc1xOjhpBExqF9NcCDPe5jQ4uYcdTuyJjxQQkmuK2+aThdAtZGMRT8
 WMUhb5jkKAp6vLKzeD4mQ8Py6DIlRFOfKtotP5Wj2HI4VnFSEYM+fJ+ppxBGPDy6/56n
 3JMe4EQ+SB4Y9SiRlsL79ANMzwEx8B5NuGtvu4cRC/+SXGGzODmas61OjmPuigUfofOl
 3OeAiOOlU0aTxD7XW/XnPlHSssjkVB9OoW4RaG2qCHc6CHSpDo3zzcJnqb8sMWfWpSuS
 F8Bt6NLGuQROPhrQkAY03Vgein8Ccxn3kW7WKreofPjV5h/3Dtuhuum5RIHEPlog2qgG Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sfavdmn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 10:10:19 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08PE1tf8065789;
 Fri, 25 Sep 2020 10:10:18 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sfavdmjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 10:10:18 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08PE797B025928;
 Fri, 25 Sep 2020 14:10:16 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 33n9ma60yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 14:10:16 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08PEAFOY42336592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 14:10:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6243B124062;
 Fri, 25 Sep 2020 14:10:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3147F12405A;
 Fri, 25 Sep 2020 14:10:13 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.16.144])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2020 14:10:12 +0000 (GMT)
Subject: Re: [PATCH 3/7] s390x/pci: create a header dedicated to PCI CLP
To: Cornelia Huck <cohuck@redhat.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
 <1600529672-10243-4-git-send-email-mjrosato@linux.ibm.com>
 <20200925111746.2e3bf28f.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <9303d8c1-dd93-6e63-d90e-0303bd42677b@linux.ibm.com>
Date: Fri, 25 Sep 2020 10:10:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925111746.2e3bf28f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-25_11:2020-09-24,
 2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=907 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250095
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 10:10:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 5:17 AM, Cornelia Huck wrote:
> On Sat, 19 Sep 2020 11:34:28 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> To have a clean separation between s390-pci-bus.h and s390-pci-inst.h
>> headers we export the PCI CLP instructions in a dedicated header.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.h  |   1 +
>>   hw/s390x/s390-pci-clp.h  | 211 +++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/s390x/s390-pci-inst.h | 196 -------------------------------------------
>>   3 files changed, 212 insertions(+), 196 deletions(-)
>>   create mode 100644 hw/s390x/s390-pci-clp.h
> 
> Looks sane; but I wonder whether we should move the stuff under
> include/hw/s390x/.
> 

Probably.  I'd be fine with creating this file under include, but if 
we're going to do that we should plan to move the other s390-pci* ones 
too.  For this patchset, I can change this patch to put the new header 
in include/hw/s390x, easy enough.

I'll plan to do a separate cleanup patchset to move s390-pci-bus.h and 
s390-pci-inst.h.

How would you like me to handle s390-pci-vfio.h (this is a new file 
added by both this patch set and 's390x/pci: Accomodate vfio DMA 
limiting') --  It seems likely that the latter patch set will merge 
first, so my thought would be to avoid a cleanup on this one and just 
re-send 's390x/pci: Accomodate vfio DMA limiting' once the kernel part 
hits mainline (it's currently in linux-next via Alex) with 
s390-pci-vfio.h also created in include/hw/s390x (and I guess the 
MAINTAINERS hit for it too). Sound OK?

