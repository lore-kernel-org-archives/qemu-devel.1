Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F25C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722D42158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722D42158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZjG-00014j-Kw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 01:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iaZgO-0000C8-Hj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iaZgJ-0002WR-C9
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:23:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45278 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1iaZgI-00026Z-UX
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:23:07 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5AEDCCFE605AFB1342B1;
 Fri, 29 Nov 2019 14:22:58 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 14:22:57 +0800
To: <qemu-devel@nongnu.org>
From: Guoheyi <guoheyi@huawei.com>
Subject: [RFC] smbios: does it make sense to present some host smbios
 information to guest?
Message-ID: <d98de3f9-b893-c21d-9461-342af83594f0@huawei.com>
Date: Fri, 29 Nov 2019 14:22:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi folks,

Right now some smbios fields are hard coded (like CPU nominal 
frequency), and some can be opted in, but there is no feasible way to 
present real backend hardware information to the front. In some 
scenario, the users of virtual machines may not be happy to see an 
unknown CPU model and 2.0GHz CPU speed, while they have been told the 
backend CPUs are the newest model with much high frequency.

The backend information may be changed after migration from one host to 
another, but in a large cluster it may also be kept in high probability. 
Even if it is changed, we can synchronize the information after a system 
reset.

So does it make sense to present some host smbios information 
(especially CPU information) to guest, by default or by some easy 
option? Or do you have any other advice?

Thanks,
HG


