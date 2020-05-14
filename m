Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28AEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FADF2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wyLyBAMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FADF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGnI-0001lK-Nu
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jZGmZ-000147-1L
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:32:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jZGmX-0001dD-FX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:32:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EGRAmb122353;
 Thu, 14 May 2020 16:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2020-01-29;
 bh=tszdBA3a1g6i4m1erVIfrMDTLiCEJZZbW23kBbY115A=;
 b=wyLyBAMmWKgrUhQLFVx9YAQpvwNH6AikwAbvgC7BgFu2GA39ZRQBQragHfOBl0xf88MB
 F1f9g0Dcq7PrhK39SE7isAGzOR+ze6xx606/QxFAXLkFT1iF2lyMt1SRjgiW9BnnC+Zv
 KkWfNlDVb+8iOIAESA2yIL5IxFvJu+8EFxescHXjG16IUDNexQ+G1kTybT/v/bvZtLHT
 ZxfRZNWMAvDQNTArL1Pi9fhvqeVLppXIr8jYvjaKPjs5zLy+Hp4AGmvZNSGemnTLzlyT
 Tl3ZQbCIRyaamvfKqr6BHMhxfWon+s+uvtt3M2YD+gsRxiNgUDmjs8o+F/TU3C+Uvj7E gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 3100xwummm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 16:32:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EGO6Hb105224;
 Thu, 14 May 2020 16:32:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3100yd05yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 16:32:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EGWHgc020420;
 Thu, 14 May 2020 16:32:18 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 May 2020 09:32:17 -0700
From: John G Johnson <john.g.johnson@oracle.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Date: Thu, 14 May 2020 09:32:15 -0700
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
In-Reply-To: <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
Message-Id: <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=926 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140145
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=john.g.johnson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


	Thanos and I have made some changes to the doc in response to =
the
feedback we=E2=80=99ve received.  The biggest difference is that it is =
less reliant
on the reader being familiar with the current VFIO implementation.  =
We=E2=80=99d
appreciate any additional feedback you could give on the changes.  =
Thanks
in advance.

							Thanos and JJ


The link remains the same:

=
https://docs.google.com/document/d/1FspkL0hVEnZqHbdoqGLUpyC38rSk_7HhY471Ts=
VwyK8/edit?usp=3Dsharing



> On Apr 20, 2020, at 4:05 AM, Thanos Makatos =
<thanos.makatos@nutanix.com> wrote:
>=20
> Hi,
>=20
> I've just shared with you the Google doc we've working on with John =
where we've
> been drafting the protocol specification, we think it's time for some =
first
> comments. Please feel free to comment/edit and suggest more people to =
be on the
> reviewers list.
>=20
> You can also find the Google doc here:
>=20
> =
https://docs.google.com/document/d/1FspkL0hVEnZqHbdoqGLUpyC38rSk_7HhY471Ts=
VwyK8/edit?usp=3Dsharing
>=20
> If a Google doc doesn't work for you we're open to suggestions.
>=20
> Thanks
>=20


