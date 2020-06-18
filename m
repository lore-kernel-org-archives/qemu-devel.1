Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE990C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 21:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B30208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IMmxbMV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B30208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm2Fl-0002CI-Jw
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 17:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jm2Ej-0001lR-4Y
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 17:38:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jm2Eh-0007nZ-2Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 17:38:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05ILc8sT153733;
 Thu, 18 Jun 2020 21:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RUDeNoe5KcshrU4TnoC6pZzYH4FMi6/MrTs/5fF4V9M=;
 b=IMmxbMV4oFJLGCfiMFYEyTVttTGvBwyAPltJfPdDAFS1GeUcqGREwxUJOxgBHHa2QmQK
 ulUlv5nqYTMvokvKwr937/EfffS4dJfj93gZ8JUkhF5G57UhPUe05PlTE2icEpH1kMEZ
 TPFOTopsYbyViaCMIcfEwzgaCY7Vb99tBSlFWIhZAk5cKpNzl+TZE09dip4r5rQquP22
 YiYwEpfjqlHiAiaXL5OXe1BeXoiJ9aKU3DYw6vCcP6gKdyepYQnd4qGWNmq1JI6Xc5jJ
 1TSSxYT28Z7UWF8csx+ll4xoNrb9jJ4OXxHGvi2j1ST3PrvhVjz3u5QuZJ2Yx8uSsJ7u wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 31q6603kkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Jun 2020 21:38:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05ILbmIv127336;
 Thu, 18 Jun 2020 21:38:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 31q661g4xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 21:38:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05ILc68k004669;
 Thu, 18 Jun 2020 21:38:06 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 18 Jun 2020 14:38:06 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200615104929.GD1491454@stefanha-x1.localdomain>
Date: Thu, 18 Jun 2020 14:38:04 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <DE330A27-2343-459F-9EA0-D3C5F20EE87D@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
 <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
 <20200615104929.GD1491454@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180164
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=john.g.johnson@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 15:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 15, 2020, at 3:49 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> 
> 
> It's challenging to implement a fast and secure IOMMU. The simplest
> approach is secure but not fast: add protocol messages for
> DMA_READ(iova, length) and DMA_WRITE(iova, buffer, length).
> 

	We do have protocol messages for the case where no FD is
associated with the DMA region:  VFIO_USER_DMA_READ/WRITE.


> An issue with file descriptor passing is that it's hard to revoke access
> once the file descriptor has been passed. memfd supports sealing with
> fnctl(F_ADD_SEALS) it doesn't revoke mmap(MAP_WRITE) on other processes.
> 
> Memory Protection Keys don't seem to be useful here either and their
> availability is limited (see pkeys(7)).
> 
> One crazy idea is to use KVM as a sandbox for running the device and let
> the vIOMMU control the page tables instead of the device (guest). That
> way the hardware MMU provides memory translation, but I think this is
> impractical because the guest environment is too different from the
> Linux userspace environment.
> 
> As a starting point adding DMA_READ/DMA_WRITE messages would provide the
> functionality and security. Unfortunately it makes DMA expensive and
> performance will suffer.
> 

	Are you advocating for only using VFIO_USER_DMA_READ/WRITE and
not passing FDs at all?  The performance penalty would be large for the
cases where the client and server are equally trusted.  Or are you
advocating for an option where the slower methods are used for cases
where the server is less trusted?

								JJ



