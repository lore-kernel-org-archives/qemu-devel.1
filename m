Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C492C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1602075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwaJW0PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1602075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMcg2-0002Pr-Ue
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:12:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hMcf7-000272-Nz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hMcf6-0001sv-R2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:11:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hMcf6-0001rP-HS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:11:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x43I4ati019433; Fri, 3 May 2019 18:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=xy4o8Aq1BzET6i+2EMKFebHATKxd4oHPHvY/PXKUrRI=;
	b=QwaJW0PD9Nv+1Fwj3ib4i80v5Ifu/5Bn138j4qzkrMCia6mcpsoCVGYQ5G4KJW6FfGQm
	lNu9bJJI86GYNxVLz7vdUS+cD+Zxe/OcE2KZaAT9XI/y8uXQ3UqmFrgU2mDJl1t1hjmH
	nhSInBVZUEaNLDs1U61w5DYjqBPnchiIaxKipkpiKxt0G20SXkOcRFQabMOBVbnujdjA
	Qoza39H45xxhYqVy3tmkZpGxo4tNZk7JFfICaRK8AT5L+xdo4oZxIz/JykERU8UvblbQ
	Hh+HEOV0S8r/hnjzMHhKNRiQzYL64zzGSqyQ6zk39axpDb12bJBk6/8JAJpWxZSvAPOD
	4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2s6xj00ef3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2019 18:11:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x43IBixc144402; Fri, 3 May 2019 18:11:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2s7p8afk1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2019 18:11:53 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x43IBqcE004053;
	Fri, 3 May 2019 18:11:52 GMT
Received: from [10.74.111.122] (/10.74.111.122)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 May 2019 11:11:52 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Fri, 03 May 2019 11:11:50 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <C4E4C87E-7CFC-4262-BA3F-251090C57AEF@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<20190429134048.GH7587@stefanha-x1.localdomain>
	<1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
	<20190501163650.GF21155@stefanha-x1.localdomain>
	<1823F9C3-8092-4B75-87AA-A05325032F48@oracle.com>
	<428e3ee5-28b0-7895-8a17-9178354c9406@redhat.com>
In-Reply-To: <428e3ee5-28b0-7895-8a17-9178354c9406@redhat.com>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=956
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905030118
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=991
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905030118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
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
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503181150.oz8XSQwHdq9riAvTf8zsWbEKbVGIgTSF0r6LrtI4iks@z>

Hi Paolo,

That will be great, I would like to hear more details about the design and =
implementation once you get those ready.=20

Thanks a lot,
Wei

=EF=BB=BFOn 5/3/19, 11:05 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 03/05/19 10:21, Wei Li wrote:
    > Got it, thanks Stefan for your clarification!
   =20
    Hi Wei,
   =20
    Stefan and I should be posting a patch to add Linux SCSI driver
    batching, and an implementation for virtio-scsi.
   =20
    Paolo
   =20
    > Wei
    >=20
    > =EF=BB=BFOn 5/1/19, 9:36 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
    >=20
    >     On Mon, Apr 29, 2019 at 10:56:31AM -0700, Wei Li wrote:
    >     >Does this mean the performance could be improved via adding Batc=
h I/O submission support in Guest driver side which will be able to reduce t=
he number of virtqueue kicks?
    >    =20
    >     Yes, I think so.  It's not obvious to me how a Linux SCSI driver =
is
    >     supposed to implement batching though.  The .queuecommand API doe=
sn't
    >     seem to include information relevant to batching.
    >    =20
    >     Stefan
    >    =20
    >    =20
    >=20
    >=20
   =20
   =20



