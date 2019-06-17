Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44633C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B83B21873
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 04:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83B21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcj6D-0006G7-6e
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 00:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49701)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wangjie88@huawei.com>) id 1hcj4t-0005bo-76
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wangjie88@huawei.com>) id 1hciys-00020b-4f
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 00:10:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43466 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wangjie88@huawei.com>)
 id 1hciyq-0001rw-M0; Mon, 17 Jun 2019 00:10:53 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 94C577F64F3DA17FFB14;
 Mon, 17 Jun 2019 12:10:40 +0800 (CST)
Received: from [10.133.211.192] (10.133.211.192) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun
 2019 12:10:33 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
From: "wangjie (P)" <wangjie88@huawei.com>
Message-ID: <7462792e-687f-b4b9-5242-5abccd318deb@huawei.com>
Date: Mon, 17 Jun 2019 12:10:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.133.211.192]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] =?utf-8?q?question=EF=BC=9Aabout_pr-helper_unlink_so?=
 =?utf-8?q?ck_file_fail?=
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
Cc: zhangjixiang2@huawei.com, qemu-block@nongnu.org,
 "Fangyi \(C\)" <eric.fangyi@huawei.com>, oscar.zhangbo@huawei.com,
 qemu-devel@nongnu.org, wangjie88@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I found there is a bug in pr-helper:

We run pr-helper process in root, and drop all capabilities =C2=A0expect=20
CAP_SYS_RAWIO.

 =C2=A0=C2=A0=C2=A0 But the sock file which connect from qemu is owned by=
 qemu group,=20
when pr-helper exit,

 =C2=A0=C2=A0=C2=A0 it will call =C2=A0=E2=80=9Cclose_server_socket ->=20
object_unref(OBJECT(server_ioc)) -> qio_channel_socket_finalize ->=20
socket_listen_cleanup=E2=80=9D ,

 =C2=A0=C2=A0=C2=A0 unlink sock file =C2=A0will fail and output =E2=80=9C=
Failed to unlink socket=20
xxx, Permission denied=E2=80=9D.

 =C2=A0=C2=A0=C2=A0 I tried to add capability CAP_DAC_OVERRIDE in pr-help=
er, it will=20
unlink sock success, but I think capability CAP_DAC_OVERRIDE is too=20
dangerous.
