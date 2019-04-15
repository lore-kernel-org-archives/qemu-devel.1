Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E28C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 23:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1AC20656
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 23:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sxe6SgN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1AC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGAu5-00041n-37
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 19:20:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1hGAtI-0003gc-C7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1hGAtG-0002aU-R2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:19:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1hGAtG-0002YW-DW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:19:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FNIvFK017118; Mon, 15 Apr 2019 23:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=/M8KLNQAVCgWYmkqa+ogljYYZ/gyVKrHdmOfTZXFrIc=;
	b=Sxe6SgN4kFn5+OEiCIVt6FWthOEArimqokBcBAZ0yPKEFevBDkx6SVbHjnh2JmFAIoBv
	VsK0DeNVQzmRB2Q9A8ZPPBVOaOtoWKlAFP0ccE0rcYUSZqJOzaWrD/aP/RXfzZzJ9mnX
	JoCQNpjCDMnj7bQdCqAU9I7wBHJPzA9l42TJPsSsGlXE7m+TbMfd6wdbQN1P7FH4Wfmv
	GAjNvfFa9DZKlmKjJYSWWrvkXV9YLxRy2z4K4423qgWxhCG8Leesgki2Zpnu1M+cD75T
	THV3u2RpMlq/UbYLLyvFQ82jV39f8oXmfKkFyxYYO+Tcjy+1ku8aUdRP2g2Qs4MGyylr
	Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2rusneqg0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 23:19:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FNI7FH064876; Mon, 15 Apr 2019 23:19:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2rvv13f7xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 23:19:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FNJk2u023262;
	Mon, 15 Apr 2019 23:19:46 GMT
Received: from [10.182.69.106] (/10.182.69.106)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 15 Apr 2019 16:19:46 -0700
To: Wei Li <wei.d.li@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
Date: Tue, 16 Apr 2019 07:23:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150155
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150155
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
	x3FNIvFK017118
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
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415232338.OHiQn-I114ptYl_lSiiKGopaR94a8EaTUr72l82OBXo@z>



On 4/16/19 1:34 AM, Wei Li wrote:
> Hi @Paolo Bonzini & @Stefan Hajnoczi,
>=20
> Would you please help confirm whether @Paolo Bonzini's multiqueue featu=
re change will benefit virtio-scsi or not? Thanks!
>=20
> @Stefan Hajnoczi,
> I also spent some time on exploring the virtio-scsi multi-queue feature=
s via num_queues parameter as below, here are what we found:
>=20
> 1. Increase number of Queues from one to the same number as CPU will ge=
t better IOPS increase.
> 2. Increase number of Queues to the number (e.g. 8) larger than the num=
ber of vCPU (e.g. 2) can get even better IOPS increase.

As mentioned in below link, when the number of hw queues is larger than
nr_cpu_ids, the blk-mq layer would limit and only use at most nr_cpu_ids =
queues
(e.g., /sys/block/sda/mq/).

That is, when the num_queus=3D4 while vcpus is 2, there should be only 2 =
queues
available /sys/block/sda/mq/

https://lore.kernel.org/lkml/1553682995-5682-1-git-send-email-dongli.zhan=
g@oracle.com/

I am just curious how increasing the num_queues from 2 to 4 would double =
the
iops, while there are only 2 vcpus available...

Dongli Zhang

>=20
> In addition, It seems Qemu can get better IOPS while the attachment use=
s more queues than the number of vCPU, how could it possible? Could you p=
lease help us better understand the behavior? Thanks a lot!
>=20
>=20
> Host CPU Configuration:
> CPU(s):                2
> Thread(s) per core:    2
> Core(s) per socket:    1
> Socket(s):             1
>=20
> Commands for multi queue Setup:
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D1 id=3Dtest1
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D2 id=3Dtest2
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D4 id=3Dtest4
> (QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D8 id=3Dtest8
>=20
>=20
> Result:
> 	|  8 Queues   |  4 Queues     |      2 Queues    |      Single Queue
> IOPS 	|   +29%         |      27%           |        11%           |   =
   Baseline
>=20
> Thanks,
> Wei
>=20
> =EF=BB=BFOn 4/5/19, 2:09 PM, "Wei Li" <wei.d.li@oracle.com> wrote:
>=20
>     Thanks Stefan for your quick response!
>    =20
>     Hi Paolo,
>     Could you please send us a link related to the multiqueue feature w=
hich you are working on so that we could start getting some details about=
 the feature.
>    =20
>     Thanks again,
>     Wei=20
>    =20
>     =EF=BB=BFOn 4/1/19, 3:54 AM, "Stefan Hajnoczi" <stefanha@gmail.com>=
 wrote:
>    =20
>         On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
>         > Thanks Stefan for your reply and guidance!
>         >=20
>         > We spent some time on exploring the multiple I/O Threads appr=
oach per your feedback. Based on the perf measurement data, we did see so=
me IOPS improvement for multiple volumes, which is great. :)
>         >=20
>         > In addition, IOPS for single Volume will still be a bottlenec=
k, it seems like multiqueue block layer feature which Paolo is working on=
 may be able to help improving the IOPS for single volume.
>         >=20
>         > @Paolo, @Stefan,=20
>         > Would you mind sharing the multiqueue feature code branch wit=
h us? So that we could get some rough idea about this feature and maybe s=
tart doing some exploration?=20
>        =20
>         Paolo last worked on this code, so he may be able to send you a=
 link.
>        =20
>         Stefan
>        =20
>    =20
>=20
>=20
>=20

