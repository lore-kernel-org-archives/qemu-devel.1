Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A1E206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5kwLKnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A1E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXU6-0001QU-Kl
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jtXSl-000060-FZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:23:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jtXSh-0002Zi-Ro
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:23:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069EHmpS157409;
 Thu, 9 Jul 2020 14:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=n0dk50r7nAhIlITk9mhlLzzsSK+7IQtkc0IfoBGHujo=;
 b=E5kwLKnABYGFeQsPG09Mjx1aX3ALNX69+IkgW4JfESnNWKysBtrkrof/g2RPVqjXkUlc
 qGa0Wls8DD5wZIfb7i3dow/M1wlSQS2DP+7yR4k7SLZbbW8W4zWdTTYn3eHBO3X447VB
 ySxv8T8Cp0Qz0yhyNJoOVrHlTHsY0GLhAr6mgXNPM5P1VuDLRnkSkROXRQe2RO6hbNhv
 boZvM/hgkb7qA0qyXC08bZHRI+A9TjvpjQZLzZiGAjznwCHj8tjKi3ZzHUaWJm+NbC5Q
 GoHb4fg+rsw8bQI6XpmYIutxDiHfbDw06sOln13O4Eabs1EXaIIS2UnkaeD3kK9SVBjb ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 325y0ahxg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 09 Jul 2020 14:23:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069ENGL6140794;
 Thu, 9 Jul 2020 14:23:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 325k3h1b4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jul 2020 14:23:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069ENQYp021595;
 Thu, 9 Jul 2020 14:23:27 GMT
Received: from [10.39.237.80] (/10.39.237.80)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 09 Jul 2020 07:23:26 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v7 03/21] multi-process: setup PCI host bridge for remote
 device
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200630151700.GC109906@stefanha-x1.localdomain>
Date: Thu, 9 Jul 2020 10:23:23 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6A58CC0-2A46-45F7-88B3-BFCDA79ECEB6@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <77bf485a3bbaeac83f3db50753fe45156ae7e882.1593273671.git.elena.ufimtseva@oracle.com>
 <20200630151700.GC109906@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090106
Received-SPF: pass client-ip=156.151.31.86; envelope-from=jag.raman@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:23:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 30, 2020, at 11:17 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Sat, Jun 27, 2020 at 10:09:25AM -0700, elena.ufimtseva@oracle.com =
wrote:
>> diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
>> new file mode 100644
>> index 0000000000..5ea9af4154
>> --- /dev/null
>> +++ b/hw/pci-host/remote.c
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Remote PCI host device
>> + *
>> + * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>=20
> A little more detail would be nice:
>=20
>  Unlike PCI host devices that model physical hardware, the purpose of
>  this PCI host is to host multi-process QEMU remote PCI devices.
>=20
>  Multi-process QEMU talks to a remote PCI device that runs in a
>  separate process. In order to reuse QEMU device models in the remote
>  process we need a PCI bus that holds the devices.
>=20
>  This PCI host is purely a container for PCI devices. It's fake in the
>  sense that the guest never sees this PCI host and has no way of
>  accessing it. It's job is just to provide the environment that QEMU
>  PCI device models need when running in a remote process.
>=20
> I think this could be restated more clearly but hopefully it
> communicates the purpose of hw/pci-host/remote.c. :P

OK, we get the theme of the message. :)

>=20
>> +typedef struct RemotePCIHost {
>> +    /*< private >*/
>> +    PCIExpressHost parent_obj;
>> +    /*< public >*/
>> +
>> +    MemoryRegion *mr_pci_mem;
>> +    MemoryRegion *mr_sys_mem;
>=20
> Unused? Please add mr_sys_mem if and when it is used.

Got it. We will add it in the later patches that use these.

--
Jag=

