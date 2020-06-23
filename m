Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F4EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296E120738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296E120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnePS-0007d8-EK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jneOk-00076t-SR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:35:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:59394 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jneOi-0007WB-Cf
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:35:18 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 3AF0FAE7B7283219A5A8;
 Tue, 23 Jun 2020 16:35:09 +0800 (CST)
Received: from dggeme705-chm.china.huawei.com (10.1.199.101) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 23 Jun 2020 16:35:08 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme705-chm.china.huawei.com (10.1.199.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 23 Jun 2020 16:35:08 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Tue, 23 Jun 2020 16:35:08 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 08/22] qga: Plug unlikely memory leak in
 guest-set-memory-blocks
Thread-Topic: [PATCH 08/22] qga: Plug unlikely memory leak in
 guest-set-memory-blocks
Thread-Index: AQHWSIHrB3gGpXSVlUOJbfX1RNyitajl4RDQ
Date: Tue, 23 Jun 2020 08:35:08 +0000
Message-ID: <08e8776a63244eca924238e29791fced@huawei.com>
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-9-armbru@redhat.com>
In-Reply-To: <20200622104250.1404835-9-armbru@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 04:35:09
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Monday, June 22, 2020 6:43 PM
> To: qemu-devel@nongnu.org
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>
> Subject: [PATCH 08/22] qga: Plug unlikely memory leak in
> guest-set-memory-blocks
>=20
> transfer_memory_block() leaks an Error object when reading file
> /sys/devices/system/memory/memory<INDEX>/state fails with errno other
> than ENOENT, and @sys2memblk is false, i.e. when the state file exists bu=
t
> cannot be read (seems quite unlikely), and this is guest-set-memory-block=
s,
> not guest-get-memory-blocks.
>=20
> Plug the leak.
>=20
> Fixes: bd240fca42d5f072fb758a71720d9de9990ac553
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/commands-posix.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c index
> ae1348dc8f..cdbeb59dcc 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2421,6 +2421,7 @@ static void
> transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
>              if (sys2memblk) {
>                  error_propagate(errp, local_err);
>              } else {
> +                error_free(local_err);
>                  result->response =3D
>=20
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>              }
> --
> 2.26.2


