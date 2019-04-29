Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642AEC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7CC20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6q4kxPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7CC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAQk-0004Qg-8h
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:51:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hLAPN-0003h6-3X
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hLAPM-0002J4-9V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:49:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hLAPM-0002IH-0P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:49:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3THcuNn111240; Mon, 29 Apr 2019 17:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=p4YwyUI+aCRK1s3fYxNR/1/nvu2p3mfUoKcVGbVcTHI=;
	b=M6q4kxPItBESjdSpyRqhgcmLlzMJSjYZlik5qMYxpXWxn0HPPwSNv5c8pPWCj+Sf33Ho
	Q2micd2uHCkRKbAUdxDxeJYcY0nweHOjh/u8Gcdm02Scn8OBh5/QfP87EdPb3j7PDJ98
	Aqwu7SUrklRTLTeLm4bhUwGSIIMNwhK+RnNSwqFIDZ4xDaNs6Eh/BW9gC165GdJo7u8p
	JJSwmaGkaFrN2lie51Drk38VZE5mYNN+5Qdk4IYRYXEEgxhBqIOKXBQea62jQ/9SYwLM
	2DW6eFWOHVjwujaNn7fXRrJ+89U2DwM8QIflQH8dTEH9vYzg0Ay522G7oBmFQsHu2fu0
	8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2s4fqpyw0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2019 17:49:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3THnZVk194770; Mon, 29 Apr 2019 17:49:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 2s4yy93kcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2019 17:49:34 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3THnXHn023129;
	Mon, 29 Apr 2019 17:49:33 GMT
Received: from [10.74.107.66] (/10.74.107.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 29 Apr 2019 10:49:33 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Mon, 29 Apr 2019 10:49:31 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <F5614236-1B07-421B-8FE6-90129297014F@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<7044D39A-8D7B-41F7-B8C3-DC2214E6826A@oracle.com>
	<825292440.15675844.1556339085478.JavaMail.zimbra@redhat.com>
In-Reply-To: <825292440.15675844.1556339085478.JavaMail.zimbra@redhat.com>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=897
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904290121
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=919
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904290121
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429174931.nV-hji_DBLvmac50AVl7Wb8AKKxdVlB2kSc5bhXTUQk@z>

Thanks Paolo for your clarification!

Just wanted to double confirm, does this mean batch I/O submission won't ap=
ply to aio=3Dthreads (which is the default mode)?

Thanks,
Wei


=EF=BB=BFOn 4/26/19, 9:25 PM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

   =20
    > Thanks Stefan and Paolo for your response and advice!
    >=20
    > Hi Paolo,
    >=20
    > As to the virtio-scsi batch I/O submission feature in QEMU which you
    > mentioned, is this feature turned on by default in QEMU 2.9 or there =
is a
    > tunable parameters to turn on/off the feature?
   =20
    Yes, it is available by default since 2.2.0.  It cannot be turned off, =
however
    it is only possible to batch I/O with aio=3Dnative (and, since 2.12.0, wi=
th the NVMe
    backend).
   =20
    Paolo
   =20



