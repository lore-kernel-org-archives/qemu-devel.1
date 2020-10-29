Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8882C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7EF20756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmH82Tfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7EF20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY78j-00005f-S3
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kY76Y-0007Sz-Vq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:32:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kY76W-0005fX-Fj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:32:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCOo3A082402
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=I0qGBfFEvxDUJYCvr9KGnnCYyeVZlo79qnomyBIW4ew=;
 b=GmH82Tfbe/x84L9dPAVJHJxnYEYjy720rjULvsSNOI1jKOYBroR0eX65vWZabrE4oGXB
 Ewzp6WKkzvxJJ5gGhSQHopxWotb0biuvGfaDEsmF51zgwOc8Jx6SvyljPxCxE6LhIUJr
 fJKY/90RtjkcV+YGthh6ysdNpOP/JdZu0vEhNPfJNT0A9Kz4Awx0QSIWiy/rDvwcrZWQ
 HiGV+25r2D+v+MiQ1+z1ly82gSgzFg7AZWVZiRpYhCN3WynyDVZHx+fs1K/HagsVLKYV
 Mv7zKzaqIys1x1YA5zze4jr8jf/OGfSeoqbMiofHYtEewKMy3XQYmODB72B60jT/pRX3 RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 34dgm4a5bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:32:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCQdNA117139
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:30:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34cx1t5k8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:30:30 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09TCUTmp003264
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 12:30:29 GMT
Received: from [10.175.50.168] (/10.175.50.168)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 29 Oct 2020 05:30:29 -0700
Subject: Re: [PATCH] Add support for pvpanic pci device
To: qemu-devel@nongnu.org
References: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
From: Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <a141323c-ecae-5c39-cf90-aae794e0099f@oracle.com>
Date: Thu, 29 Oct 2020 14:30:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ro
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290092
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=mihai.carabas@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 08:32:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

La 28.10.2020 15:32, Mihai Carabas a scris:
> This patchset adds support for pvpanic pci device. The patchset was assembled
> from chuncks from some old patches [1] from 2018 which were left unmerged and
> some additions from me.
> 
> How to test this:
> /usr/bin/qemu-system-aarch64 \
>          -machine virt,gic-version=3 -device pvpanic-pci
> 
> After that you need to run a Linux kernel as guest, but you have to also apply
> the patches I will send for adding pci support for the pvpanic driver.

Here are the patches for Linux: https://lkml.org/lkml/2020/10/29/645
> 
> [1] http://patchwork.ozlabs.org/project/qemu-devel/cover/1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn/
> 
> Mihai Carabas (1):
>    pvpanic: break dependency on ISA_BUS adding PCI
> 
> Peng Hao (3):
>    hw/misc/pvpanic: Add the PCI interface
>    hw/arm/virt: Use the pvpanic pci device
>    pvpanic : update pvpanic document
> 
> Philippe Mathieu-Daudé (2):
>    hw/misc/pvpanic: Build the pvpanic device for any machine
>    hw/misc/pvpanic: Cosmetic renaming
> 
>   default-configs/devices/arm-softmmu.mak |  1 +
>   docs/specs/pvpanic.txt                  | 12 ++++-
>   hw/misc/Kconfig                         |  2 +-
>   hw/misc/meson.build                     |  2 +-
>   hw/misc/pvpanic.c                       | 96 +++++++++++++++++++++++++++------
>   include/hw/misc/pvpanic.h               |  3 +-
>   include/hw/pci/pci.h                    |  1 +
>   7 files changed, 97 insertions(+), 20 deletions(-)
> 


