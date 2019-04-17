Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF9C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 01:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68142073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 01:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nbp/jDRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68142073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45195 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGZYH-0005wh-Sn
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 21:39:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGZXR-0005dy-Px
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGZXQ-0005dU-Su
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:39:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hGZXQ-0005cY-Fc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:39:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3H1crx1080072; Wed, 17 Apr 2019 01:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=B4JwpL0zXi6ljqlUJJG8ODjvwk8gtqu4rt6toF/RlWU=;
	b=Nbp/jDRKKaOVylo4md8itcD/qgtZQ1i6wBKIYljCmULtKyqsI7S0IEguXZ6UuwqhGqxU
	WOOY6SIM0bLYgTGcgTeuDMkfnbxs9gPXy0Dd04RYoHvFRsYtvQAscBgEfO9hP83H1ylp
	ui0PDtiAv0zFDkQUd92bKiXegGsKknoAjZnoGtnDB5IU4a07aH4CVFimmqRRArMnmQR4
	WDOrSTxKrJlahvQZvAMrmhTqdT5MOaBz39h5nVFZnjArMEG9lc36eb0ya3MXBdUVAH7S
	MiAIexQNY6N2THxq4GCyDi3/QWypSVKmwhC9kYhqMqLtflQlISrxikfzYCY8RT2t7L4X
	DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rvwk3r25t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2019 01:38:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3H1c616015549; Wed, 17 Apr 2019 01:38:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2rwe7a4100-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2019 01:38:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3H1cpxe000789;
	Wed, 17 Apr 2019 01:38:51 GMT
Received: from [10.74.109.118] (/10.74.109.118)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 16 Apr 2019 18:38:51 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Tue, 16 Apr 2019 18:38:49 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <85DF2701-24E2-4159-94F5-CB9C60D333BE@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
	<0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
In-Reply-To: <0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9229
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904170007
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9229
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=960
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904170007
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417013849.68iyvkRqdv7_ZPNeay-PW0JAh_P5FiLkyWkuXH_Z4uM@z>

Thanks Paolo for your response and clarification.=20

Btw, is there any rough schedule about when are you planning to start worki=
ng on the multi queue feature?  Once you start working on the feature, I wou=
ld like to hear more details about the design and better understand how this=
 feature will benefit the performance of virtio-scsi.

Thanks again,
Wei

=EF=BB=BFOn 4/16/19, 7:01 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 05/04/19 23:09, Wei Li wrote:
    > Thanks Stefan for your quick response!
    >=20
    > Hi Paolo, Could you please send us a link related to the multiqueue
    > feature which you are working on so that we could start getting some
    > details about the feature.
   =20
    I have never gotten to the point of multiqueue, a prerequisite for that
    was to make the block layer thread safe.
   =20
    The latest state of the work is at github.com/bonzini/qemu, branch
    dataplane7.
   =20
    Paolo
   =20



