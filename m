Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B1DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D237020759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S92TJ04F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D237020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaP3m-0002CV-Rt
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 15:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaP2Q-0000sg-LL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaP2M-0004I0-EJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604520340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BAG1T5veMpG6Sxkcod0xsPvvGLkfNZcq2MFqzRyx5s=;
 b=S92TJ04FxI50t7EQaI0yqgEzAiS7CWwRp7DzhMbhwZxBBUtKFkiQCHlwX2q9m0ahfqO7vw
 1H/u/s3zSN24Mi7kw50/N16ToJ4NVJ95bmgYIFicuBG/Y93VesPwrxR6huFIv3XfbMzvTo
 SY07aPgh123IwgCsPIwcWx4IQl97u7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-ehUCJazOOemkou0yJNIhRg-1; Wed, 04 Nov 2020 15:05:36 -0500
X-MC-Unique: ehUCJazOOemkou0yJNIhRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E95B18C88E2;
 Wed,  4 Nov 2020 20:05:34 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-163.ams2.redhat.com
 [10.36.112.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB39D19C4F;
 Wed,  4 Nov 2020 20:05:25 +0000 (UTC)
Subject: Re: [PATCH v9 2/8] fw_cfg: Write the extra roots into the fw_cfg
From: Laszlo Ersek <lersek@redhat.com>
To: Jiahui Cen <cenjiahui@huawei.com>, qemu-devel@nongnu.org
References: <20201103120157.2286-1-cenjiahui@huawei.com>
 <20201103120157.2286-3-cenjiahui@huawei.com>
 <dadc89f2-bff2-358a-b15d-1302018286a5@redhat.com>
Message-ID: <25c7d6a0-98e4-6287-2da3-bbdf9836fb95@redhat.com>
Date: Wed, 4 Nov 2020 21:05:24 +0100
MIME-Version: 1.0
In-Reply-To: <dadc89f2-bff2-358a-b15d-1302018286a5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, Gerd Hoffmann <kraxel@redhat.com>, imammedo@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Phil, +Gerd

On 11/04/20 20:54, Laszlo Ersek wrote:
> +Marcel
> 
> On 11/03/20 13:01, Jiahui Cen wrote:
>> From: Yubo Miao <miaoyubo@huawei.com>
>>
>> Write the extra roots into the fw_cfg, therefore the uefi could
>> get the extra roots. Only if the uefi knows there are extra roots,
>> the config space of devices behind the root could be obtained.
>>
>> Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
>> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
>> ---
>>  hw/arm/virt.c              |  8 ++++++++
>>  hw/i386/pc.c               | 18 ++----------------
>>  hw/nvram/fw_cfg.c          | 20 ++++++++++++++++++++
>>  include/hw/nvram/fw_cfg.h  |  2 ++
>>  include/hw/pci/pcie_host.h |  4 ++++
>>  5 files changed, 36 insertions(+), 16 deletions(-)

I realize I never reacted to this patch before (and we're at v9), so you
might not welcome my feedback at this point.

The explanation why I've only reacted now is the following: there's an
agreement between Phil and myself that Phil handles fw_cfg reviews
primarily, and I review only (or almost only) Phil's patches for fw_cfg.
Furthermore, all versions of this particular patch, as far as I can see,
CC'd me but not Phil. So Phil never knew to look, and I never checked
(this being an fw_cfg patch, per subject line) beyond the author being
Phil or not.

The solution is of course to use the get_maintainer.pl script for
determining reviewers, and adding them with "Cc:" tags to the commit
message. (You also missed Marcel at the least; see my previous
response.) git-send-email is supposed to adhere to those "Cc:" tags.

The reason I've looked now is... I guess I was too tired to remember our
agreement with Phil.

Thanks
Laszlo


