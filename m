Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA1620838
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA1620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0iEf-0001Fr-6M
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 05:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1k0iE5-0000oa-G6; Wed, 29 Jul 2020 05:18:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18024
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1k0iE3-0008W6-K3; Wed, 29 Jul 2020 05:18:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06T91ixc129657; Wed, 29 Jul 2020 05:18:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32j0a6ssj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2020 05:18:12 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06T91l9Y129953;
 Wed, 29 Jul 2020 05:18:12 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32j0a6sshd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2020 05:18:11 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06T9FLEq018213;
 Wed, 29 Jul 2020 09:18:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 32gcpwaxvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2020 09:18:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06T9I7M831457646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2020 09:18:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9668A4062;
 Wed, 29 Jul 2020 09:18:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64491A4060;
 Wed, 29 Jul 2020 09:18:06 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.10.171])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2020 09:18:06 +0000 (GMT)
Date: Wed, 29 Jul 2020 10:00:42 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 1/6] pc-bios/s390-ccw/Makefile: Compile with
 -std=gnu99, -fwrapv and -fno-common
Message-ID: <20200729100042.089e4098@ibm-vm>
In-Reply-To: <20200728183734.7838-2-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-2-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-29_03:2020-07-28,
 2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=727 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290058
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 05:18:12
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "Jason J .
 Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 20:37:29 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The main QEMU code is compiled with -std=gnu99, -fwrapv and
> -fno-common. We should use the same flags for the s390-ccw bios, too,
> to avoid that we get different behavior with different compiler
> versions that changed their default settings in the course of time
> (it happened at least with -std=... and -fno-common in the past
> already).
> 
> While we're at it, also group the other flags here in a little bit
> nicer fashion: Move the two "-m" flags out of the "-f" area and
> specify them on a separate line.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 50bc880272..9abb0ea4c0 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -13,10 +13,11 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o
> sclp.o menu.o \ virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o
> dasd-ipl.o 
>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
> -QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks
> -msoft-float -QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
> -QEMU_CFLAGS += -fno-asynchronous-unwind-tables
> +QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks
> -fno-common -fPIE +QEMU_CFLAGS += -fwrapv -fno-strict-aliasing
> -fno-asynchronous-unwind-tables QEMU_CFLAGS += $(call cc-option,
> $(QEMU_CFLAGS), -fno-stack-protector) +QEMU_CFLAGS += -msoft-float
> -march=z900 +QEMU_CFLAGS += -std=gnu99
>  LDFLAGS += -Wl,-pie -nostdlib
>  
>  build-all: s390-ccw.img s390-netboot.img

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

