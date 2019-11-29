Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FCC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABF1217BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABF1217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagk8-0006PZ-LW
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1iaggZ-0003pV-Ar
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1iaggW-0007KX-3Q
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:51:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1iaggV-0007A8-RS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:51:48 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATDo1Sn151054
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 08:51:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjah7q0xp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 08:51:43 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Fri, 29 Nov 2019 13:51:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 13:51:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xATDpbrS54788202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 13:51:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A42ABA404D;
 Fri, 29 Nov 2019 13:51:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65BA3A4040;
 Fri, 29 Nov 2019 13:51:37 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.151])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 13:51:37 +0000 (GMT)
Date: Fri, 29 Nov 2019 14:51:36 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-pci: disable vring processing when
 bus-mastering is disabled
In-Reply-To: <20191128120223-mutt-send-email-mst@kernel.org>
References: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
 <20191128174800.2d4a2cc2.pasic@linux.ibm.com>
 <20191128120223-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19112913-0020-0000-0000-00000390A9FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112913-0021-0000-0000-000021E7BC9F
Message-Id: <20191129145136.6edeb41c.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=800 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290121
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xATDo1Sn151054
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Janosch Frank <frankja@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 12:03:01 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

[..]

> >=20
> > But it keeps nagging me, is it really OK for the device to access the
> > virtio ring during reset? My intuition tells me that the device shoul=
d
> > not look for new requests after it has been told to reset.
>=20
>=20
> Well it's after it was told to reset but it's not after
> it completed reset. So I think it's fine ...

Thanks Michael! I agree and we are covered by the specification. Namely
3.3.1 Driver Requirements: Device Cleanup says "Thus a driver MUST
ensure a virtqueue isn=E2=80=99t live (by device reset) before removing e=
xposed
buffers.". Draining the available buffers from the queue is not wrong --=20
although possibly unnecessary.

So I guess for externally initiated resets (ones not initiated by the
driver) we just have to make sure that the virtio structures are intact
until the virtio device is reset.

Regards,
Halil=20

[..]


