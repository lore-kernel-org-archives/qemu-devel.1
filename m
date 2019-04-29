Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C507C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6098C20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AttrM7nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6098C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33199 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAX2-00085u-IC
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:57:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hLAW9-0007eQ-GC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hLAW8-00057S-IO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:56:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hLAW8-00057C-AT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:56:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3THra5w123126; Mon, 29 Apr 2019 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=xSXQUYOgcKeqrez2deabmhq8qafM0cEGHbMauWY3gX4=;
	b=AttrM7nRNkJwVLGpVRc6CAMfZCZ7uG8KH/lUJ4H56heshOK8lqWbdJtWFWcxPKeVgaPB
	J+wtypMqKK3UdPEoNnU6XcDA+pb9rYYBxZbZW69kww5WO7D1o6EygB3YlgeIDGOFJzLJ
	T/nKgre1OPYyWOuvp+0HWTVv9UyHh800WisqqisukkYgbPfqwhpps4TyjLcUV/sGP6Us
	D4hGallz6RYkhMA2J8jWL/d/4sacSouVsaDVEsi2aE/39IytcHapLauJDcz/XPHufd0o
	pcPsw9yEd6wRdshOrBHBaoZkir4RDECWCMSp60UXKVGfvMXwLFs63qyGKL+ptLU+Wcgd
	Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2s4fqpyx51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2019 17:56:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3THsw2n172533; Mon, 29 Apr 2019 17:56:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2s5u50hq5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2019 17:56:37 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3THuaLI014889;
	Mon, 29 Apr 2019 17:56:37 GMT
Received: from [10.74.107.66] (/10.74.107.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 29 Apr 2019 10:56:36 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Mon, 29 Apr 2019 10:56:31 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<20190429134048.GH7587@stefanha-x1.localdomain>
In-Reply-To: <20190429134048.GH7587@stefanha-x1.localdomain>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904290122
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904290122
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
	Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429175631.mfb_ARpShGU-UeUQLZ7_A0Toeh7nb3dL_tinVqko_Kw@z>

Thanks Stefan!

Does this mean the performance could be improved via adding Batch I/O submi=
ssion support in Guest driver side which will be able to reduce the number o=
f virtqueue kicks?

Thanks,
Wei

=EF=BB=BFOn 4/29/19, 6:40 AM, "Stefan Hajnoczi" <stefanha@redhat.com> wrote:

    On Fri, Apr 26, 2019 at 10:14:16AM +0200, Paolo Bonzini wrote:
    > On 23/04/19 14:04, Stefan Hajnoczi wrote:
    > >> In addition, does Virtio-scsi support Batch I/O Submission feature
    > >> which may be able to increase the IOPS via reducing the number of
    > >> system calls?
    > >
    > > I don't see obvious batching support in drivers/scsi/virtio_scsi.c.
    > > The Linux block layer supports batching but I'm not sure if the SCS=
I
    > > layer does.
    >=20
    > I think he's referring to QEMU, in which case yes, virtio-scsi does
    > batch I/O submission.  See virtio_scsi_handle_cmd_req_prepare and
    > virtio_scsi_handle_cmd_req_submit in hw/scsi/virtio-scsi.c, they do
    > blk_io_plug and blk_io_unplug in order to batch I/O requests from QEM=
U
    > to the host kernel.
   =20
    This isn't fully effective since the guest driver kicks once per
    request.  Therefore QEMU-level batching you mentioned only works if QEM=
U
    is slower at handling virtqueue kicks than the guest is at submitting
    requests.
   =20
    I wonder if this is something that can be improved.
   =20
    Stefan
   =20



