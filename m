Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B789C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 06:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402D420897
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 06:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402D420897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jloO5-0005I8-7E
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 02:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jloN9-0004UY-UC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 02:50:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2525 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jloN6-0000a8-Ur
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 02:50:03 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 85DD3967B501EFCB0662;
 Thu, 18 Jun 2020 14:49:52 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 18 Jun 2020 14:49:51 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 18 Jun 2020 14:49:51 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Thu, 18 Jun 2020 14:49:51 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: RE: Memory leak in transfer_memory_block()?
Thread-Topic: Memory leak in transfer_memory_block()?
Thread-Index: AQHWRTJtqk4GroVog0qllPUMIQmMXKjd7Xrw
Date: Thu, 18 Jun 2020 06:49:51 +0000
Message-ID: <8562bcb768514568b14788e801aee681@huawei.com>
References: <87h7v9szpe.fsf@dusky.pond.sub.org>
In-Reply-To: <87h7v9szpe.fsf@dusky.pond.sub.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 02:49:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Thursday, June 18, 2020 1:36 PM
> To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Cc: qemu-devel@nongnu.org; Michael Roth <mdroth@linux.vnet.ibm.com>
> Subject: Memory leak in transfer_memory_block()?
>=20
> We appear to leak an Error object when ga_read_sysfs_file() fails with
> errno !=3D ENOENT unless caller passes true @sys2memblk:
>=20
>     static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool
> sys2memblk,
>                                       GuestMemoryBlockResponse
> *result,
>                                       Error **errp)
>     {
>         [...]
>         if (local_err) {
>=20
> We have an Error object.
>=20
>             /* treat with sysfs file that not exist in old kernel */
>             if (errno =3D=3D ENOENT) {
>=20
> Case 1: ENOENT; we free it.  Good.
>=20
>                 error_free(local_err);
>                 if (sys2memblk) {
>                     mem_blk->online =3D true;
>                     mem_blk->can_offline =3D false;
>                 } else if (!mem_blk->online) {
>                     result->response =3D
>=20
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
>                 }
>             } else {
>=20
> Case 2: other than ENOENT
>=20
>                 if (sys2memblk) {
>=20
> Case 2a: sys2memblk; we pass it to the caller.  Good.
>=20
>                     error_propagate(errp, local_err);
>                 } else {
>=20
> Case 2b: !sys2memblk; ???
>=20

Good catch!  I think we should pass the error info back to the caller,
Let's record this error for debug when it happens.

>                     result->response =3D
>=20
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>                 }
>             }
>             goto out2;
>         }
>         [...]
>     out2:
>         g_free(status);
>         close(dirfd);
>     out1:
>         if (!sys2memblk) {
>             result->has_error_code =3D true;
>             result->error_code =3D errno;
>         }
>     }
>=20
> What is supposed to be done with @local_err in case 2b?


