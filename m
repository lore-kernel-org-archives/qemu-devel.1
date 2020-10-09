Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFAFC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905572225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IskbalZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905572225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv9c-0001oz-Lr
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQuyl-00065b-Sg; Fri, 09 Oct 2020 12:10:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kQuye-0002NT-As; Fri, 09 Oct 2020 12:10:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 099G82r3071747; Fri, 9 Oct 2020 12:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0QLi4paJGb0S3fVTsgrrDVvPHBvJDMXZXzi4Ge+c8jc=;
 b=IskbalZtc7S6ogIi1EErJiIKLsUiP9lVq/mknxmVkXCb/iq4Oyklm2qaCUv1IAt80AkF
 cHe9thuGZW6DDUQ9RUsjQbLXWCVSHQrJZHGo421xEYv83qjHvuNY2UiQLEPKw0wmrEwr
 qRmnTyzwL3P//ZExrb6bpjnyEAWfQWfvmsLuwQ/gOQkOQX3BtKudTLQzQFZSytW+gof5
 83uiEmpX3RkqBV0UThEWltIEQI9m0VY9cKuhxTDG0RH69uWpWyRGWGM2gB8KstziW3qK
 /2h5h1nSZk0f0bPmIqhp497NdtO/4eRC1ffLO1GIoSVSlIU7V/54gUgVo0Qx2tr34wfw nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 342tr9rruc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2020 12:10:37 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099G8BL8072739;
 Fri, 9 Oct 2020 12:10:36 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 342tr9rru1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2020 12:10:36 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099G7gFw024692;
 Fri, 9 Oct 2020 16:10:36 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02dal.us.ibm.com with ESMTP id 3429hrg5bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2020 16:10:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 099GAZtH54329756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2020 16:10:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C687AE063;
 Fri,  9 Oct 2020 16:10:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0151AE060;
 Fri,  9 Oct 2020 16:10:32 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.80.216.179])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2020 16:10:32 +0000 (GMT)
Subject: Re: [PATCH v3 10/10] s390x/pci: get zPCI function info from host
To: Cornelia Huck <cohuck@redhat.com>
References: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
 <1602097455-15658-11-git-send-email-mjrosato@linux.ibm.com>
 <20201009174807.6d800999.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <6b5f9372-325c-9136-e5c5-4ff885ea8e15@linux.ibm.com>
Date: Fri, 9 Oct 2020 12:10:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201009174807.6d800999.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-09_06:2020-10-09,
 2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090116
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 12:10:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
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

On 10/9/20 11:48 AM, Cornelia Huck wrote:
> On Wed,  7 Oct 2020 15:04:15 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> We use the capability chains of the VFIO_DEVICE_GET_INFO ioctl to retrieve
>> the CLP information that the kernel exports.
>>
>> To be compatible with previous kernel versions we fall back on previous
>> predefined values, same as the emulation values, when the ioctl is found
>> to not support capability chains. If individual CLP capabilities are not
>> found, we fall back on default values for only those capabilities missing
>> from the chain.
>>
>> This patch is based on work previously done by Pierre Morel.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/meson.build             |   1 +
>>   hw/s390x/s390-pci-bus.c          |  10 +-
>>   hw/s390x/s390-pci-vfio.c         | 197 +++++++++++++++++++++++++++++++++++++++
>>   include/hw/s390x/s390-pci-bus.h  |   1 +
>>   include/hw/s390x/s390-pci-clp.h  |  12 ++-
>>   include/hw/s390x/s390-pci-vfio.h |  19 ++++
>>   6 files changed, 233 insertions(+), 7 deletions(-)
>>   create mode 100644 hw/s390x/s390-pci-vfio.c
>>   create mode 100644 include/hw/s390x/s390-pci-vfio.h
> 
> (...)
> 
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> new file mode 100644
>> index 0000000..43684c6
>> --- /dev/null
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -0,0 +1,197 @@
>> +/*
>> + * s390 vfio-pci interfaces
>> + *
>> + * Copyright 2020 IBM Corp.
>> + * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include <sys/ioctl.h>
>> +#include <linux/vfio.h>
>> +#include <linux/vfio_zdev.h>
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/s390x/s390-pci-bus.h"
>> +#include "hw/s390x/s390-pci-clp.h"
>> +#include "hw/s390x/s390-pci-vfio.h"
>> +#include "hw/vfio/pci.h"
>> +
>> +#ifndef DEBUG_S390PCI_VFIO
>> +#define DEBUG_S390PCI_VFIO  0
>> +#endif
>> +
>> +#define DPRINTF(fmt, ...)                                          \
>> +    do {                                                           \
>> +        if (DEBUG_S390PCI_VFIO) {                                  \
>> +            fprintf(stderr, "S390pci-vfio: " fmt, ## __VA_ARGS__); \
>> +        }                                                          \
>> +    } while (0)
> 
> Not really a fan of DPRINTF. Can you maybe use trace events instead?
> 

Sure, I was just continuing what -inst.c and -bus.c do today.  I'll 
remove DPRINTF here and look at what trace-events make sense, with a 
note to convert the rest of s390-pci* to use trace events at some later 
time.

> Other than that, looks good to me.
> 

Thanks!  Assuming nobody has further comments, I'll plan to send both 
this set (with the change above) and the 's390x/pci: Accomodate vfio DMA 
limiting' set merged together with a single linux header sync once 
5.10-rc1 is available, sound OK?

