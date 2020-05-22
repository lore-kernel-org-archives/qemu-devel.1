Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E07C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB442072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB442072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxeJ-0004Ds-OF
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <piaojun@huawei.com>)
 id 1jbxak-0004zj-QZ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:39:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34126 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <piaojun@huawei.com>)
 id 1jbxaj-0005gj-EY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:39:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 26671B143AB602F738B8;
 Fri, 22 May 2020 10:39:11 +0800 (CST)
Received: from [10.174.149.79] (10.174.149.79) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 22 May
 2020 10:39:02 +0800
To: <kraxel@redhat.com>
From: Jun Piao <piaojun@huawei.com>
Subject: [QUESTION] How to improve virtio-gpu performance
Message-ID: <65461f86-c44b-6009-51f3-333b79fb612a@huawei.com>
Date: Fri, 22 May 2020 10:39:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.149.79]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=piaojun@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 22:39:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, jianjay.zhou@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

I'm using glmark2 to test virtio-gpu on AMDGPU, but the result is
unsatisfactory.

GPU: AMD Radeon Pro WX 5100
Host OS: CentOS Linux release 7.7.1908 (AltArch)
  --QEMU: 4.0.0
  --linux kernel 4.18
  --mesa 18.3
  --virglrenderer
  --spice server 0.14.2
  --spice-gtk3-0.35
  --libepoxy 1.5.2
Guest OS: CentOS Linux release 7.7.1908 (AltArch)
  --linux kernel 4.18
  --mesa 18.3
  --xorg server 1.20
TestSuit: glmark2

Host result:
glmark2 Score: 10043

Single Guest result:
glmark2 Score: 2209

Multi Guest result:
Guest1: glmark2 Score: 1136
Guest2: glmark2 Score: 1231
Guest3: glmark2 Score: 1282
Guest4: glmark2 Score: 1175
Guest5: glmark2 Score: 1398

It seems the whole performance of multi-guests is better than single
guest, but each one has lower performance. I change 'ctrl_vq' from 256
to 1024, but has little effect. I wonder the result is normal or
abnormal? And which is the bottleneck? I'm appreciated for you help.

thanks,
Jun

