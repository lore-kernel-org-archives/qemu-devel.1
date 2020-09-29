Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D30C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5CE20936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Khuecxtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5CE20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNIS5-0000Mq-FH
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 12:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1kNIQG-0007ot-8Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:24:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1kNIQC-0002nR-N3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:24:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TGMSvr089820;
 Tue, 29 Sep 2020 16:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=yxrDG7Oxb/0SpXNz6yUBkm1+bRwy73AkdlZu+B5LVac=;
 b=KhuecxturokocW8YzR39hOqlo5evEkuIxYB6miVOII+bMQACydGCupjIQhToAJAS+q1B
 WZ2QwC/yva3JgQwe5Uhf3Th9FwyPdbXuC429MeeKiS5rwIsLBZEdSktul3ogdxMTEUS9
 ReIi0edFCTx7Ew/tz3BgAb6421oRUfUglMcPfoo0ixXDCXk4uS0dRbcE7lpE3EL5z5pr
 x5K029DnXaVDi4YuLKCVKsYipRbMVP+j+GPpfqqTJLh2lH5eZvlRddG71xaYgSXkYrmj
 dFP1mO7/gCkwyMBtBmOghWIJpbec7AlBPfXBBhac6zLCAzuGZOcPU2f7NP6RBn7l+RBL bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 33swkkuwxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Sep 2020 16:24:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TGKrSF014060;
 Tue, 29 Sep 2020 16:22:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33uv2e4nkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2020 16:22:00 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08TGLvlw016552;
 Tue, 29 Sep 2020 16:21:57 GMT
Received: from [192.168.10.110] (/98.207.176.72)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 29 Sep 2020 09:21:57 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200929103743.GB181609@stefanha-x1.localdomain>
Date: Tue, 29 Sep 2020 09:21:54 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290139
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=john.g.johnson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 10:51:00
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
>>> It should be accompanied by a test in tests/. PCI-level testing APIS =
for
>>> BARs, configuration space, interrupts, etc are available in
>>> tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
>>> device backend interact with QEMU's vfio-user-pci implementation.
>>=20
>> We plan to use a libmuser-based backend for testing. This, I suppose, =
will
>> make libmuser a dependency of QEMU (either as a submodule or as a =
library),
>> which for now can be disabled in the default configuration. Is this =
acceptable?
>=20
> If there are no other dependencies and libmuser supports all host
> operating systems that QEMU's -device vfio-user supports, then I think
> it's a good idea to use libmuser for at least one in-tree test in =
QEMU.
>=20
>>> Also please let us know who is working on what so additional people =
can
>>> get involved in areas that need work!
>>=20
>> Swapnil and I will be working on libmuser and the test in QEMU, John =
and
>> the mp-qemu folks will be working on the patches for implementing
>> --device vfio-user-pci.
>=20
> Great!
>=20
> John: Will mpqemu use libmuser to implement the remote PCI host
> controller?
>=20


	The vfio-user-pci plan is to use libmuser on the server side.

								JJ



