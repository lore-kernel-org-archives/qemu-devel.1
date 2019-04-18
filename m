Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050CC282DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 03:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3532083D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 03:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxBbj06j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3532083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGxpY-0003z8-9o
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 23:35:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGxof-0003hm-PW
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGxoe-0008OW-Cn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:34:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hGxod-0008NR-RH
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:34:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3I3YInA156654; Thu, 18 Apr 2019 03:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=LKO9bEvjkUMegENsxuCc7+V1NkReLGbdnZLOKF7X/EM=;
	b=NxBbj06j6oZt/KjCI2ttUhpbu/j7iaRLEagq++51vsUXIWEltKPpYME9J1rCewUclbEU
	6nn4Gza14WLIBZ+WAFs/wJYgUxO1QSHhmGLekM12GwPvMof99bS+gSdO3gkAJUEQDrnD
	5Cezy6HNoHjdPJrKWh3i22ktAT8GhBo8xx8O+Ca+j1nRqdCGH9XPY3H/I0HgneE30ioW
	ZFHsoupAt+1PGma6EbGpL1xcG3Dym5Xj7Hd1Wk7eLvd3/eTXleYJdjC/ux71IKZTOt6q
	0mdILk3vbzkN36unhLnr3qm+hg9WobNWOjj1qvfSZMcW4GT4ABdimugzuopxd+jvF2Zz
	sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2ru59deey8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2019 03:34:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3I3WZFn143482; Thu, 18 Apr 2019 03:34:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2rubq79rd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2019 03:34:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3I3YFZT005935;
	Thu, 18 Apr 2019 03:34:15 GMT
Received: from [10.74.110.187] (/10.74.110.187)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 17 Apr 2019 20:34:15 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Wed, 17 Apr 2019 20:34:13 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <8558D6DA-A44A-48E2-A733-163270CF063D@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
	<0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
	<85DF2701-24E2-4159-94F5-CB9C60D333BE@oracle.com>
	<5d5049df-655a-8ff1-d8fb-d363d684459b@redhat.com>
In-Reply-To: <5d5049df-655a-8ff1-d8fb-d363d684459b@redhat.com>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=880
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904180021
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=903
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904180021
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
Cc: Sergio Lopez Pascual <slp@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418033413.B8AfBaeKfNrt9AM1fDfYKRP7ALwDvq8p9usM23qedZw@z>

Sounds good, let's keep in touch. __

Thanks,
Wei

=EF=BB=BFOn 4/17/19, 5:17 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 17/04/19 03:38, Wei Li wrote:
    > Thanks Paolo for your response and clarification.
    >=20
    > Btw, is there any rough schedule about when are you planning to start
    > working on the multi queue feature?  Once you start working on the
    > feature, I would like to hear more details about the design and
    > better understand how this feature will benefit the performance of
    > virtio-scsi.
   =20
    I wish I knew... :)  However, hopefully I will share the details soon
    with Sergio and start flushing that queue in 4.1.
   =20
    Paolo
   =20



