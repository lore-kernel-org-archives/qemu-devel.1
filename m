Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D68C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9450E2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sMzyoZZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9450E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP424-0004Y8-Q5
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:49:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hP412-0004E6-6T
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hP411-0003YA-7Z
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:48:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hP410-0003Wz-UR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:48:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4ABiKZm196079; Fri, 10 May 2019 11:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=zUMPKnY54+IgOat56fY6McWPnlrNyrFK25KVmwlrYNY=;
	b=sMzyoZZSox/g4IgvNRnXY120HqgzLAPhoN7HkKG3jf+tmsE/XcmwcpleIcn0PkFHkfw8
	8xXAmhQnWct0G9057mrb8AVIuymbFpY4R2Aec9/hhS8FS9I6KAKnnzQRosg/POtIJ+co
	jZrQ/3Vkg3lLXSRwGkr7BYUM8r9dA7qElKJQh/Aa0oNOoTYHLdlShGxoIjO4weLz9NkA
	0xvY+y0JR68bgEB2sfVQF0ypqqYvqpvOhnzij0QTlWdlkNJTpJtEiGUGmEbffbdEdmd3
	GzLexmNmKxx1mPtq6MNPbj97XYcAwOuJYMIJ7d1tTwoFdmCRMuFfm2ZpvITR3mQdKB63
	8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2s94b18g0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2019 11:48:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4ABm3ux086103; Fri, 10 May 2019 11:48:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2sagyvstf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2019 11:48:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4ABmV4V013638;
	Fri, 10 May 2019 11:48:31 GMT
Received: from [192.168.14.112] (/79.181.223.222)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 10 May 2019 04:48:31 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190425135319-mutt-send-email-mst@kernel.org>
Date: Fri, 10 May 2019 14:48:23 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <41141B94-B9FC-4198-A3A2-236B4C09D33D@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
	<17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
	<20190425083819.GE30231@stefanha-x1.localdomain>
	<20190425135319-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=692
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905100084
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=729
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905100084
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
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
Cc: ehabkost@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>,
	mtosatti@redhat.com, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com, pbonzini@redhat.com,
	nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 25 Apr 2019, at 20:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Apr 25, 2019 at 09:38:19AM +0100, Stefan Hajnoczi wrote:
>> On Wed, Apr 24, 2019 at 07:38:57PM +0300, Liran Alon wrote:
>>>=20
>>>=20
>>>> On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>>>=20
>>>> On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
>>>>> Hi,
>>>>>=20
>>>>> This patch series aims to add supprot to migrate a VM with a =
vhost-scsi device.
>>>>>=20
>>>>> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi =
backend when a
>>>>> VM is stopped (As happens on migratino pre-copy completion).
>>>>>=20
>>>>> The 2nd patch adds ability to save/load vhost-scsi device state in =
VMState.
>>>>>=20
>>>>> The 3rd and final paqtch adds a flag to vhost-scsi which allows =
admin to specify
>>>>> it's setup supports vhost-scsi migratino. For more detailed =
information on why
>>>>> this is valid, see commit message of specific patch.
>>>>>=20
>>>>> Regards,
>>>>> -Liran
>>>>=20
>>>> Looks fine for vhost_scsi.ko.  I have not checked how this =
interacts
>>>> with vhost-user-scsi.
>>>>=20
>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>=20
>>> Gentle Ping.
>>=20
>> This should go either through Michael's virtio/vhost tree or Paolo's
>> SCSI tree.
>>=20
>> Stefan
>=20
> OK I'll queue it.

Thanks.
When is this expected to be merged to QEMU=E2=80=99s master?

-Liran



