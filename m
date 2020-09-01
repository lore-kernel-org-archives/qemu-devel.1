Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB81C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1038F206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sy3Gd1Qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1038F206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5yX-0006Li-79
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kD5qt-0001qM-7I; Tue, 01 Sep 2020 08:57:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kD5qn-0002qb-Hj; Tue, 01 Sep 2020 08:57:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 081CWJ4M056208; Tue, 1 Sep 2020 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3sIT4I7xpM1QOjgLyJA0Hdw/0/6z28dFQyKQrefeWTg=;
 b=sy3Gd1QpckekCfPrnYsmmmFXsq36B6zMV2pMey6YCsX5E/CHepqb/It8MLzwhRtX8Tj/
 vljBtwDfiJmMtEenuuy5+qv/ZQ5YPqhgvjpyy5M2IDrmewJGdNheorrzpAULM3ZrRsf/
 NRjN0uZFUIbyJCXvemnp3FcEZC1ckdEsANCyzW7qvPFwKqnQh+Ti6yVvralc123w0kpc
 ia+VQEB99BvEouABiHrAVWMgghHunQkzZmB6fwKtbDbijKBZVtGs3XeTpXkDIVeFrytl
 YLS0HSWUHnCq4NOJ+B89EqQlnZAc5iFHizWwITuX758EA8p0GHeMzasGeJpd6uxKVh/R vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339msjkaee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 08:57:21 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 081CWfR2056994;
 Tue, 1 Sep 2020 08:57:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339msjkadk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 08:57:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 081Cq6Qx009181;
 Tue, 1 Sep 2020 12:57:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 337en83dx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 12:57:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 081CvGlo28246430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2020 12:57:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2026EA4055;
 Tue,  1 Sep 2020 12:57:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6A95A4040;
 Tue,  1 Sep 2020 12:57:15 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.34.193])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2020 12:57:15 +0000 (GMT)
Date: Tue, 1 Sep 2020 14:57:06 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio: add Virtio*BusClass sizes
Message-ID: <20200901145706.34def7db.pasic@linux.ibm.com>
In-Reply-To: <20200824122051.99432-1-cohuck@redhat.com>
References: <20200824122051.99432-1-cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-01_08:2020-09-01,
 2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:57:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 14:20:51 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Both VirtioPCIBusClass and VirtioCcwBusClass are typedefs of
> VirtioBusClass, but set .class_size in the TypeInfo anyway
> to be safe if that changes in the future.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  hw/s390x/virtio-ccw.c  | 1 +
>  hw/virtio/virtio-pci.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 0e602702971b..8feb3451a098 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1237,6 +1237,7 @@ static const TypeInfo virtio_ccw_bus_info = {
>      .name = TYPE_VIRTIO_CCW_BUS,
>      .parent = TYPE_VIRTIO_BUS,
>      .instance_size = sizeof(VirtioCcwBusState),
> +    .class_size = sizeof(VirtioCcwBusClass),
>      .class_init = virtio_ccw_bus_class_init,
>  };
>  
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index ccdf54e81c78..45e7b65a8d24 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2101,6 +2101,7 @@ static const TypeInfo virtio_pci_bus_info = {
>      .name          = TYPE_VIRTIO_PCI_BUS,
>      .parent        = TYPE_VIRTIO_BUS,
>      .instance_size = sizeof(VirtioPCIBusState),
> +    .class_size    = sizeof(VirtioPCIBusClass),
>      .class_init    = virtio_pci_bus_class_init,
>  };
>  


