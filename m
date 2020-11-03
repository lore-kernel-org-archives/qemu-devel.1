Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461AC55179
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B8E22264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rf1vAMnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B8E22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZx14-00076Y-6J
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kZwwt-0002U1-7M; Tue, 03 Nov 2020 09:06:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60134
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kZwwr-0004W2-9B; Tue, 03 Nov 2020 09:06:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A3E20eF092964; Tue, 3 Nov 2020 09:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uJOH03+cKdpAlHmCX98HlPNen/kU1cvTXm6BqLi1tTI=;
 b=Rf1vAMnIPCGSz/wh/e6MTAGXki7f69zqkbQhJp2OoobDyhc9qeLW9mJSL4e+hUeLi0oO
 pxEMfpsLe+2pSHP/bBrVjl5SBM5HIL5KfJHMDMTCcEtWunfnPQ9O8KdNnIKnsWQscRJ7
 wkRIO6sPM1mV+mxwSTz0Wqxvs54WMqirPc+RlnKGdwiD6mfRSbDjxDc+zkTrTwEQVSzt
 S10WehjA6mSSWNTM/O95uFWYPRnA6ENKGSOnpyCnyqSKh5DxQIZax9c8YUiIqd1lexBv
 qbl4FGovaeYXj9yzV7YzbXiTiDPHO2PkMa8p0ihQdz5N28Ry0AlsSVmYzyS9f/HMelNu 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34ju7cdcd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 09:06:05 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3E2d9Y098582;
 Tue, 3 Nov 2020 09:06:04 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34ju7cdcc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 09:06:04 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3E2ajK026740;
 Tue, 3 Nov 2020 14:06:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma05wdc.us.ibm.com with ESMTP id 34h09mx68c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 14:06:03 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A3E62g257606442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2020 14:06:02 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB916BE053;
 Tue,  3 Nov 2020 14:06:02 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F333BE04F;
 Tue,  3 Nov 2020 14:06:02 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.156.34])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  3 Nov 2020 14:06:01 +0000 (GMT)
Subject: Re: [PATCH for-5.2] s390x: fix build for --without-default-devices
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20201103123237.718242-1-cohuck@redhat.com>
 <deff16f8-028e-32dc-89d1-29a5881f07be@linux.ibm.com>
Message-ID: <7653f62a-61fa-139b-4702-85045fac72ad@linux.ibm.com>
Date: Tue, 3 Nov 2020 09:06:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <deff16f8-028e-32dc-89d1-29a5881f07be@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-03_08:2020-11-03,
 2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030093
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 06:23:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 8:21 AM, Matthew Rosato wrote:
> On 11/3/20 7:32 AM, Cornelia Huck wrote:
>> s390-pci-vfio.c calls into the vfio code, so we need it to be
>> built conditionally on vfio (which implies CONFIG_LINUX).
>>
>> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma 
>> available count")
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> 
> Good catch.  Did a test compile and this clearly works, but I'm 
> wondering if it should be checking against CONFIG_VFIO_PCI?
> 

I guess looking at it again, there's nothing in s390-vfio-pci today that 
strictly needs it, just the VIOPCIDevice struct defined in hw/vfio/pci.h 
and that should still be available even if CONFIG_VFIO_PCI=n (not like 
you'll be able to create these devices without CONFIG_VFIO or 
CONFIG_VFIO_PCI anyway).

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>> ---
>>   hw/s390x/meson.build             | 2 +-
>>   include/hw/s390x/s390-pci-vfio.h | 3 ++-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>> index f4663a835514..2a7818d94b94 100644
>> --- a/hw/s390x/meson.build
>> +++ b/hw/s390x/meson.build
>> @@ -27,7 +27,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>>   ))
>>   s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: 
>> files('s390-virtio-ccw.c'))
>>   s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>> -s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
>> +s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
>>   virtio_ss = ss.source_set()
>>   virtio_ss.add(files('virtio-ccw.c'))
>> diff --git a/include/hw/s390x/s390-pci-vfio.h 
>> b/include/hw/s390x/s390-pci-vfio.h
>> index c7984905b3b7..ff708aef500f 100644
>> --- a/include/hw/s390x/s390-pci-vfio.h
>> +++ b/include/hw/s390x/s390-pci-vfio.h
>> @@ -13,8 +13,9 @@
>>   #define HW_S390_PCI_VFIO_H
>>   #include "hw/s390x/s390-pci-bus.h"
>> +#include CONFIG_DEVICES
>> -#ifdef CONFIG_LINUX
>> +#ifdef CONFIG_VFIO
>>   bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
>>   S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>>                                             S390PCIBusDevice *pbdev);
>>
> 


