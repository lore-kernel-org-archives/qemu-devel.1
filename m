Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8243CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C16C206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J5enENPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYMR-0005vr-Q0
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYYCA-0003Wr-Ob
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:55:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYYC8-0002mA-T8
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:55:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CGrAW5094372;
 Tue, 12 May 2020 16:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VyTSberEN8IaUfl/h0047FcmgfWA9aS0fYVk7q9jHrM=;
 b=J5enENPfeIKwuZUb5NNjQ2CSQ/SWyEHwvlrBmvRSkW4vKHnoE+DURglmUVUtRCmwYBdm
 Uu+V2Yg5tC/5We6sM+8cVUKGrlSImVSYxBjabSRfJltM2K5G6h6nEMRHlfaSWEIRFizX
 jIvh8J5Lzju1oApL5saGIknN8IDvJcx1C0n/1V/5uQm04ZhzTjz9NT+xOifoFBUBnUsY
 GTr8TfofNPHKJb9Z9tXTVmABIoV4j3PlDmk7/TYtxpGImNnqF3qB2b5qasICKivvZfR9
 T6Y6vLasjh89SkFL9qGmuGRzm/+fLr/hipLTdt+5OJ9HM/cXWk6oXCrvEbaLiBZsxvcU Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 30x3mbv6m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 16:55:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CGqbLD192798;
 Tue, 12 May 2020 16:55:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 30xbgka5q2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 16:55:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CGtcbn028099;
 Tue, 12 May 2020 16:55:38 GMT
Received: from dhcp-10-39-202-98.vpn.oracle.com (/10.39.202.98)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 09:55:38 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200512161319.GA299814@stefanha-x1.localdomain>
Date: Tue, 12 May 2020 12:55:35 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <B729C859-0C37-41E7-9D79-67A15C2386AC@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200511144005.GC182627@stefanha-x1.localdomain>
 <2D3D00E3-EFE0-4D60-8B68-9CF41F6154CA@oracle.com>
 <20200512161319.GA299814@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=3 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120129
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:46:50
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 12, 2020, at 12:13 PM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Mon, May 11, 2020 at 03:30:50PM -0400, Jag Raman wrote:
>>> On May 11, 2020, at 10:40 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>>=20
>>> Hi,
>>> Have you decided whether to drop the remote device program in favor =
of
>>> using a softmmu make target?
>>>=20
>>> Is there anything in this series you'd like me to review before you =
send
>>> the next revision?
>>=20
>> Hi Stefan,
>>=20
>> We are planning to drop the separate remote device program in the =
next
>> revision. We are planning to use QEMU=E2=80=99s existing event loop =
instead of
>> a separate event loop for the remote process, as well as the command
>> line invocation you suggested in your feedback.
>>=20
>> We hope the following core patches look good to you, by and large:
>> [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
>> [PATCH RESEND v6 11/36] multi-process: define mpqemu-link object
>> [PATCH RESEND v6 12/36] multi-process: add functions to synchronize =
proxy and remote endpoints
>> [PATCH RESEND v6 13/36] multi-process: setup PCI host bridge for =
remote device
>> [PATCH RESEND v6 14/36] multi-process: setup a machine object for =
remote device process
>> [PATCH RESEND v6 15/36] multi-process: setup memory manager for =
remote device
>> [PATCH RESEND v6 17/36] multi-process: introduce proxy object
>> [PATCH RESEND v6 18/36] multi-process: Initialize Proxy Object's =
communication channel
>> [PATCH RESEND v6 19/36] multi-process: Connect Proxy Object with =
device in the remote process
>> [PATCH RESEND v6 20/36] multi-process: Forward PCI config space =
acceses to the remote process
>> [PATCH RESEND v6 21/36] multi-process: PCI BAR read/write handling =
for proxy & remote endpoints
>> [PATCH RESEND v6 22/36] multi-process: Synchronize remote memory
>> [PATCH RESEND v6 23/36] multi-process: create IOHUB object to handle =
irq
>> [PATCH RESEND v6 24/36] multi-process: Retrieve PCI info from remote =
process
>=20
> I've completed the review of these patches. Looking forward to
> discussing more.

Thank you very much, Stefan!

We will incorporate the feedback we received from your review.

Thanks!
--
Jag

>=20
> Stefan


