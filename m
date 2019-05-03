Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12100C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C841220651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x7DlMWDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C841220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMb2v-00015E-4q
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:28:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hMaxt-0005Tt-I5
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hMaxr-0007LN-Pv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hMaxq-0007IS-CB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x43GEMRq100948; Fri, 3 May 2019 16:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=yPadwx0o9vyNe/qAD61VPMlwyZ7/kW/FyTzTchMBG/g=;
	b=x7DlMWDVu1ExkpId8swOIhaBFMAk1aBtjybgI50yF/9zK9/I2DY/hK3bFInDY4K+pYY3
	8+mq2Yvfy+OXTpZWyAL+mbmPUUTIs/SFKf3ENbdA+O1zQc6DBB/it1nVyoR7UFXYRT+/
	BRA5xRhOqczeELBNmJUA63VoywwLWdROv0yQzlr0CzljW6RrRoZn7USkBitJcsw3ZSQd
	NPr7D3cMwZmBSgmhL2vc8O9I9+Jl4nuVYA1TGVYUXXUQKPEHIh13igVyJGI2rxdhOLDm
	gfl0JeDqSqI7TxltFBMIF6Y1jzrsmV6TBGBmicVPgBSaD93uS3cCD/GZMJGyQ1BFud0U
	jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2s6xhyquwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2019 16:23:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x43GKnjr070552; Fri, 3 May 2019 16:21:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2s7rtccga7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2019 16:21:05 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x43GL4uU016211;
	Fri, 3 May 2019 16:21:04 GMT
Received: from [10.144.107.60] (/10.144.107.60)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 May 2019 09:21:04 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Fri, 03 May 2019 09:21:15 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <1823F9C3-8092-4B75-87AA-A05325032F48@oracle.com>
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
In-Reply-To: <20190501163650.GF21155@stefanha-x1.localdomain>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=839
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905030104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=863
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905030104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503162115.6fhvPHjRYZzE0ftjMR-7GgjmCL0pSML_Mixv1t1ndZg@z>

Got it, thanks Stefan for your clarification!

Wei

=EF=BB=BFOn 5/1/19, 9:36 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:

    On Mon, Apr 29, 2019 at 10:56:31AM -0700, Wei Li wrote:
    >Does this mean the performance could be improved via adding Batch I/O =
submission support in Guest driver side which will be able to reduce the num=
ber of virtqueue kicks?
   =20
    Yes, I think so.  It's not obvious to me how a Linux SCSI driver is
    supposed to implement batching though.  The .queuecommand API doesn't
    seem to include information relevant to batching.
   =20
    Stefan
   =20
   =20



