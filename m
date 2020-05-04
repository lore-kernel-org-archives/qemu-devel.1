Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA064C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EB5206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="njgRBvjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EB5206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVfEJ-0006Rl-ON
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jVfDf-000621-3k
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:49:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jVfDd-0003UW-8S
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:49:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044HnA2v146063;
 Mon, 4 May 2020 17:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=gsUCcs37ExyJJzhZ7q8U2l8E/0Y32Xhk2lw5kjNSDWU=;
 b=njgRBvjxuuzxW2ZzGhTU5K8SKDxA6b3lqotzzPw8BL+maNcrmjrFXxX8JfsdPDXB7T9n
 S8izoGIp8EUHxG6pdH2OlILumqsMS00UbrOFMpKW0b45RFzmXfuuPkAcv9Udl/BYaJ2T
 yiftfGQbvn7JJXiI1zbOYuLb2UdenixUOHjeSEvL/i6EwshcY4JYeXcCy9GpQg6WB2ua
 eOZ1LuGGB/kksl8RewBEl670UULqkgU49W3cg1M7SrBtc/xw+karMp9t7mNaSQNBr9w8
 oCf19fPRvED+z/8dFXHPoHQYFoDuVvpOy5SYCYZTvPL5OpzbNBNKlRT794hzIVGEpPzT YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 30s0tm8de4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2020 17:49:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044HcUXH099375;
 Mon, 4 May 2020 17:49:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30sjjwcypq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2020 17:49:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044HnEiS014269;
 Mon, 4 May 2020 17:49:14 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 04 May 2020 10:49:14 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200504094521.GA354891@stefanha-x1.localdomain>
Date: Mon, 4 May 2020 10:49:11 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A84D74A-333F-46BB-B743-E103348B83E2@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200430114041.GN2084570@redhat.com>
 <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <F64E2C4A-ED0D-43AE-8A34-C6693DDFF93A@nutanix.com>
 <20200501152825.GA3356@redhat.com>
 <20200504094521.GA354891@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040140
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=john.g.johnson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:52:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 4, 2020, at 2:45 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Fri, May 01, 2020 at 04:28:25PM +0100, Daniel P. Berrang=C3=A9 =
wrote:
>> On Fri, May 01, 2020 at 03:01:01PM +0000, Felipe Franciosi wrote:
>>> Hi,
>>>=20
>>>> On Apr 30, 2020, at 4:20 PM, Thanos Makatos =
<thanos.makatos@nutanix.com> wrote:
>>>>=20
>>>>>>> More importantly, considering:
>>>>>>> a) Marc-Andr=C3=A9's comments about data alignment etc., and
>>>>>>> b) the possibility to run the server on another guest or host,
>>>>>>> we won't be able to use native VFIO types. If we do want to =
support that
>>>>>>> then
>>>>>>> we'll have to redefine all data formats, similar to
>>>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>>>>>>> 3A__github.com_qemu_qemu_blob_master_docs_interop_vhost-
>>>>>>>=20
>>>>> 2Duser.rst&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw=
6
>>>>>>>=20
>>>>> ogtti46atk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJ=

>>>>>>> W7NMgRg&s=3D1d_kB7VWQ-
>>>>> 8d4t6Ikga5KSVwws4vwiVMvTyWVaS6PRU&e=3D .
>>>>>>>=20
>>>>>>> So the protocol will be more like an enhanced version of the =
Vhost-user
>>>>>>> protocol
>>>>>>> than VFIO. I'm fine with either direction (VFIO vs. enhanced =
Vhost-user),
>>>>>>> so we need to decide before proceeding as the request format is
>>>>>>> substantially
>>>>>>> different.
>>>>>>=20
>>>>>> Regarding the ability to use the protocol on non-AF_UNIX sockets, =
we can
>>>>>> support this future use case without unnecessarily complicating =
the
>>>>> protocol by
>>>>>> defining the C structs and stating that data alignment and =
endianness for
>>>>> the
>>>>>> non AF_UNIX case must be the one used by GCC on a x86_64 bit =
machine,
>>>>> or can
>>>>>> be overridden as required.
>>>>>=20
>>>>> Defining it to be x86_64 semantics is effectively saying "we're =
not going
>>>>> to do anything and it is up to other arch maintainers to fix the =
inevitable
>>>>> portability problems that arise".
>>>>=20
>>>> Pretty much.
>>>>=20
>>>>> Since this is a new protocol should we take the opportunity to =
model it
>>>>> explicitly in some common standard RPC protocol language. This =
would have
>>>>> the benefit of allowing implementors to use off the shelf APIs for =
their
>>>>> wire protocol marshalling, and eliminate questions about =
endianness and
>>>>> alignment across architectures.
>>>>=20
>>>> The problem is that we haven't defined the scope very well. My =
initial impression=20
>>>> was that we should use the existing VFIO structs and constants, =
however that's=20
>>>> impossible if we're to support non AF_UNIX. We need consensus on =
this, we're=20
>>>> open to ideas how to do this.
>>>=20
>>> Thanos has a point.
>>>=20
>>> =46rom https://wiki.qemu.org/Features/MultiProcessQEMU, which I =
believe
>>> was written by Stefan, I read:
>>>=20
>>>> Inventing a new device emulation protocol from scratch has many
>>>> disadvantages. VFIO could be used as the protocol to avoid =
reinventing
>>>> the wheel ...
>>>=20
>>> At the same time, this appears to be incompatible with the (new?)
>>> requirement of supporting device emulation which may run in non-VFIO
>>> compliant OSs or even across OSs (ie. via TCP or similar).
>>=20
>> To be clear, I don't have any opinion on whether we need to support
>> cross-OS/TCP or not.
>>=20
>> I'm merely saying that if we do decide to support cross-OS/TCP, then
>> I think we need a more explicitly modelled protocol, instead of =
relying
>> on serialization of C structs.
>>=20
>> There could be benefits to an explicitly modelled protocol, even for
>> local only usage, if we want to more easily support non-C languages
>> doing serialization, but again I don't have a strong opinion on =
whether
>> that's neccessary to worry about or not.
>>=20
>> So I guess largely the question boils down to setting the scope of
>> what we want to be able to achieve in terms of RPC endpoints.
>=20
> The protocol relies on both file descriptor and memory mapping. These
> are hard to achieve with networking.
>=20
> I think the closest would be using RDMA to accelerate memory access =
and
> switching to a network notification mechanism instead of eventfd.
>=20
> Sooner or later someone will probably try this. I don't think it makes
> sense to define this transport in detail now if there are no users, =
but
> we should try to make it possible to add it in the future, if =
necessary.
>=20
> Another use case that is interesting and not yet directly addressed =
is:
> how can another VM play the role of the device? This is important in
> compute cloud environments where everything is a VM and running a
> process on the host is not possible.
>=20

	Cross-VM is not a lot different from networking.  You can=E2=80=99=
t
use AF_UNIX; and AF_VSOCK and AF_INET do not support FD passing.
You=E2=80=99d either have to add FD passing to AF_VSOCK, which will have
some security issues, or fall back to message passing that will
degrade performance.  You can skip the byte ordering issues, however,
when it=E2=80=99s the same host.

							JJ



> The virtio-vhost-user prototype showed that it's possible to add this =
on
> top of an existing vhost-user style protocol by terminating the
> connection in the device VMM and then communicating with the device
> using a new VIRTIO device. Maybe that's the way to do it here too and =
we
> don't need to worry about explicitly designing that into the vfio-user
> protocol, but if anyone has other approaches in mind then let's =
discuss
> them now.
>=20
> Finally, I think the goal of integrating this new protocol into the
> existing vfio component of VMMs is a good idea. Sticking closely to =
the
> <linux/vfio.h> interface will help in this regard. The further away we
> get, the harder it will be to fit it into the vfio code in existing =
VMMs
> and the harder it will be for users to configure the VMM along the =
lines
> for how vfio works today.
>=20
> Stefan


