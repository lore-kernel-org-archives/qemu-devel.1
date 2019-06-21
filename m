Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1164EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C971F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvWcegHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C971F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heNZi-0007mq-Lr
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60446)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1heNYj-0007BU-Kr
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1heNYi-0005vg-Jw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:42:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1heNYf-0005nH-M1; Fri, 21 Jun 2019 13:42:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LHcjVo191239;
 Fri, 21 Jun 2019 17:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2018-07-02;
 bh=/VnxSNvJy4nP+dFtS48YFNI5Azr35fn9ScKh66OYdeo=;
 b=KvWcegHK3e+jCBljT88tpRK38N4OchWSWPjKqhySZgQSIuOAkMlmHZrPMphnAoeQgp32
 HS9AlOBb8AmshKAwMVWeEjfA51TbOVvcKuQMRSD+21h26T2vUCK/UB0TY17LXbvLTUld
 /24tVTq8zjHU0cBDsZ/cqCFfCjU/vV+H0/JtDebviJeg1Uk4ju9du6Yr5h9dQ6OOUlXd
 JJEmHw2kT7Fv5LjRbaGNONc5ueXEbYpXXZDwe5KWE32RHZEL20Zy2IeSDNDb9F+d7kBX
 ycE4YN1GzFefokjQK68ArSnitfAKwmouOjsNou2BLjKmx7Lnh2QJ+HIjcI9yzuBmmeJh Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t7809qs9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 17:42:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LHgW6R083239;
 Fri, 21 Jun 2019 17:42:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t77yparkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 17:42:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LHgXdA021010;
 Fri, 21 Jun 2019 17:42:33 GMT
Received: from [10.0.0.38] (/79.180.42.160)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 10:42:33 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Fri, 21 Jun 2019 20:42:28 +0300
In-Reply-To: <20190620143749.GC17015@morn.lan>
To: "Kevin O'Connor" <kevin@koconnor.net>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
 <20190620143749.GC17015@morn.lan>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH v3 3/4] geometry: Add
 boot_lchs_find_*() utility functions
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 liran.alon@oracle.com, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sounds reasonable, how do purpose to deal with:

config BIOS_GEOMETRY
config BOOTORDER

precompiler optouts?

If we don=E2=80=99t need any of them we also don=E2=80=99t need to call =
=E2=80=9Cget_scsi_devpath", =E2=80=9Cget_ata_devpath=E2=80=9D, =
=E2=80=9Cget_pci_dev_path=E2=80=9D.

I=E2=80=99ll see what can be done.=20

> On 20 Jun 2019, at 17:37, Kevin O'Connor <kevin@koconnor.net> wrote:
>=20
> On Wed, Jun 19, 2019 at 12:23:51PM +0300, Sam Eiderman wrote:
>> Adding the following utility functions:
>>=20
>>    * boot_lchs_find_pci_device
>>    * boot_lchs_find_scsi_device
>>    * boot_lchs_find_ata_device
>=20
> FWIW, this leads to a bit of code duplication.  I think it would be
> preferable to refactor the bootprio_find_XYZ() calls.  Instead of
> returning an 'int prio' they could return a znprintf'd 'char *devpath'
> instead.  Then the boot_add_XYZ() calls could directly call
> find_prio(devpath). The boot_add_hd() could then directly populate
> drive->lchs or call setup_translation().
>=20
> -Kevin

