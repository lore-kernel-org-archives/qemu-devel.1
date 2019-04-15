Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DAFC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 17:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F3B2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 17:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oVvouFb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F3B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG5Wt-0003ji-LL
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 13:36:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hG5Vn-0003FO-5l
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hG5Vl-0006Tf-8G
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:35:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hG5Ve-0006Nh-UW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:35:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FHTBR6127998; Mon, 15 Apr 2019 17:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=0TNi/KsN301QmPRwfpdHjDdPP+FR5yzGMLmPNr0v020=;
	b=oVvouFb1pqVtfFYwhahzwUuidOqiPXc4dr8RCsE7V5udBV2/gv0O6w4JRtFQE99JrPBX
	nzPQD+JLBOjXpklNhza5+LVRqDpRRnJwmLLmHD+IrkSVeFjrvplhp/zBN+gu9aJniSdk
	H4dEoor111DCYxhHc2L5p7w8cHQiJkedBuLHhcVy1X0uFuSdx9c2QmQb/xIxDxL05hNu
	08E8eibqrhEO4ucdVCZFtDnbs3iMWMJrxSS9IRihaCAg/hMyiBCSQbgsAXuAJ8eOrctW
	sdTg9Hw5Y9YEKNaT/ep8eCZ1KOCvnmR3MysH4BgRbGB9WoCX0REvjpflvLPmixN2hdW9
	Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 2ru59d07q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 17:35:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FHY34e106307; Mon, 15 Apr 2019 17:35:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2rvv13awht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 17:35:01 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FHYwo2013015;
	Mon, 15 Apr 2019 17:34:58 GMT
Received: from [10.74.110.61] (/10.74.110.61)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 15 Apr 2019 10:34:58 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Mon, 15 Apr 2019 10:34:56 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
In-Reply-To: <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150121
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150121
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415173456.zVaXPHB57XurdacL_m_MmUYCYgvgNVugsrGQRTtKZqc@z>

Hi @Paolo Bonzini & @Stefan Hajnoczi,

Would you please help confirm whether @Paolo Bonzini's multiqueue feature c=
hange will benefit virtio-scsi or not? Thanks!

@Stefan Hajnoczi,
I also spent some time on exploring the virtio-scsi multi-queue features vi=
a num_queues parameter as below, here are what we found:

1. Increase number of Queues from one to the same number as CPU will get be=
tter IOPS increase.
2. Increase number of Queues to the number (e.g. 8) larger than the number =
of vCPU (e.g. 2) can get even better IOPS increase.

In addition, It seems Qemu can get better IOPS while the attachment uses mo=
re queues than the number of vCPU, how could it possible? Could you please h=
elp us better understand the behavior? Thanks a lot!


Host CPU Configuration:
CPU(s):                2
Thread(s) per core:    2
Core(s) per socket:    1
Socket(s):             1

Commands for multi queue Setup:
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D1 id=3Dtest1
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D2 id=3Dtest2
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D4 id=3Dtest4
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D8 id=3Dtest8


Result:
	|  8 Queues   |  4 Queues     |      2 Queues    |      Single Queue
IOPS 	|   +29%         |      27%           |        11%           |      B=
aseline

Thanks,
Wei

=EF=BB=BFOn 4/5/19, 2:09 PM, "Wei Li" <wei.d.li@oracle.com> wrote:

    Thanks Stefan for your quick response!
   =20
    Hi Paolo,
    Could you please send us a link related to the multiqueue feature which=
 you are working on so that we could start getting some details about the fe=
ature.
   =20
    Thanks again,
    Wei=20
   =20
    =EF=BB=BFOn 4/1/19, 3:54 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
   =20
        On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
        > Thanks Stefan for your reply and guidance!
        >=20
        > We spent some time on exploring the multiple I/O Threads approach=
 per your feedback. Based on the perf measurement data, we did see some IOPS=
 improvement for multiple volumes, which is great. :)
        >=20
        > In addition, IOPS for single Volume will still be a bottleneck, i=
t seems like multiqueue block layer feature which Paolo is working on may be=
 able to help improving the IOPS for single volume.
        >=20
        > @Paolo, @Stefan,=20
        > Would you mind sharing the multiqueue feature code branch with us=
? So that we could get some rough idea about this feature and maybe start do=
ing some exploration?=20
       =20
        Paolo last worked on this code, so he may be able to send you a lin=
k.
       =20
        Stefan
       =20
   =20



