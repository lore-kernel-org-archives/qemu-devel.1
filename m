Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6272C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8787920651
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XRbRGaSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8787920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCW6l-0000kT-NX
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 17:10:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hCW62-0000MH-1w
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hCW5t-0005v5-4y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:09:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hCW5l-0005LS-0Q
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:09:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x35L97I6088205; Fri, 5 Apr 2019 21:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=dsMK5oq7lohD0csr6mLSTMRSg6BXReJwJ8IUunZQa7Q=;
	b=XRbRGaSOgC0n16apKKrEmqaQkLiBLZLpC4fUH08OV4CNyEO+Wpb/9uPLMSU+J4+fc0vf
	+TOowomMUkRXTbLhF7WAsqjjxYHefGiXMa6bvokhFFcR2B4mAHoFtbfqQnNRiOSXHEbP
	dnVnXSd9e3QmCtyFxaaUmhZO9sW/p6EsH1nrK7GAvrHdVTafYdLWtaEnUCGNted0uEKu
	n+sxe5YphbTVTTQGX3A0GBIXqI1O84In6EwwuRvMUFwjcTqSLkelKll3yNgrEMh8MtP/
	TOxCDuC2lYXcBy7TgSxW/bxWDz0MJPkvxZfBHJpONDrlvVwi45jsdU7dlIOGhMboeO0A
	kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 2rhwydq6eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2019 21:09:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x35L7nml030574; Fri, 5 Apr 2019 21:09:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2rp35s318n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2019 21:09:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x35L96xM016481;
	Fri, 5 Apr 2019 21:09:06 GMT
Received: from [10.74.109.160] (/10.74.109.160)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 05 Apr 2019 14:09:05 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Fri, 05 Apr 2019 14:09:04 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
In-Reply-To: <20190401090724.GA643@stefanha-x1.localdomain>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904050140
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904050140
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405210904.xBSkzJJrQBmqvJAxQmNJg2ZfG-KqcJFRJAXsamOCjNs@z>

Thanks Stefan for your quick response!

Hi Paolo,
Could you please send us a link related to the multiqueue feature which you=
 are working on so that we could start getting some details about the featur=
e.

Thanks again,
Wei=20

=EF=BB=BFOn 4/1/19, 3:54 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:

    On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
    > Thanks Stefan for your reply and guidance!
    >=20
    > We spent some time on exploring the multiple I/O Threads approach per=
 your feedback. Based on the perf measurement data, we did see some IOPS imp=
rovement for multiple volumes, which is great. :)
    >=20
    > In addition, IOPS for single Volume will still be a bottleneck, it se=
ems like multiqueue block layer feature which Paolo is working on may be abl=
e to help improving the IOPS for single volume.
    >=20
    > @Paolo, @Stefan,=20
    > Would you mind sharing the multiqueue feature code branch with us? So=
 that we could get some rough idea about this feature and maybe start doing =
some exploration?=20
   =20
    Paolo last worked on this code, so he may be able to send you a link.
   =20
    Stefan
   =20



