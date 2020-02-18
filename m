Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F062C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E721206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E721206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42iZ-0008IJ-DD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j42hZ-0006Ep-54
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j42hX-0006qG-KA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:14:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2498 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
 id 1j42hX-0006mI-3u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:14:11 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 763E98507C88AB9936DF;
 Tue, 18 Feb 2020 21:13:58 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.16]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 21:13:47 +0800
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RFC: Split EPT huge pages in advance of dirty logging
Thread-Topic: RFC: Split EPT huge pages in advance of dirty logging
Thread-Index: AdXmU97BvyK5YKoyS5++my9GnvXVkw==
Date: Tue, 18 Feb 2020 13:13:47 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.228.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.188
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "linfeng \(M\)" <linfeng23@huawei.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "Zhoujian \(jay\)" <jianjay.zhou@huawei.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

We found that the guest will be soft-lockup occasionally when live migratin=
g a 60 vCPU,
512GiB huge page and memory sensitive VM. The reason is clear, almost all o=
f the vCPUs
are waiting for the KVM MMU spin-lock to create 4K SPTEs when the huge page=
s are
write protected. This phenomenon is also described in this patch set:
https://patchwork.kernel.org/cover/11163459/
which aims to handle page faults in parallel more efficiently.

Our idea is to use the migration thread to touch all of the guest memory in=
 the
granularity of 4K before enabling dirty logging. To be more specific, we sp=
lit all the
PDPE_LEVEL SPTEs into DIRECTORY_LEVEL SPTEs as the first step, and then spl=
it all
the DIRECTORY_LEVEL SPTEs into PAGE_TABLE_LEVEL SPTEs as the following step=
.

However, there is a side effect. It takes more time to clear the D-bits of =
the last level
SPTEs when enabling dirty logging, which is held the QEMU BQL and KVM mmu-l=
ock
simultaneously. To solve this issue, the idea of dirty logging gradually in=
 small chunks
is proposed too, here is the link for v1:
https://patchwork.kernel.org/patch/11388227/

Under the Intel(R) Xeon(R) Gold 6161 CPU @ 2.20GHz environment, some tests =
has
been done with a 60U256G VM which enables numa balancing using the demo we
written. We start a process which has 60 threads to randomly touch most of =
the
memory in VM, meanwhile count the function execution time in VM when live
migration. The change_prot_numa() is chosen since it will not release the C=
PU
unless its work has finished. Here is the number:

                    Original                 The demo we written
[1]                  > 9s (most of the time)     ~5ms
Hypervisor cost       > 90%                   ~3%

[1]: execution time of the change_prot_numa() function

If the time in [1] bigger than 20s, it will be result in soft-lockup.

I know it is a little hacking to do so, but my question is: is this worth t=
rying to split
EPT huge pages in advance of dirty logging?

Any advice will be appreciated, thanks.

Regards,
Jay Zhou

