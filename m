Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BFDC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432B324649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wkIwyugg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432B324649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSaD-0003yZ-Gs
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSZG-0003YE-9s
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSZE-0001QR-Cw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:16:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSZE-0001PM-3Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:16:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A0DZSl086068;
 Tue, 10 Mar 2020 00:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3BM1M+8zcCYyEMUItXIOcAm+65hdZEUJx2bdFzfcl30=;
 b=wkIwyugggHJVGz4pdWQtll1XmbhfsNNxlgLNlnAdzaVHbJZCLxl3bYbQ7Pozq6HTSwpB
 jWqHj0/M4lrRD0gzBM8qbeZMmECv3izqJceYMNhhH4FabJf+Ucjj7QhIXuQ12NOJff9p
 TMjlojpVpBhbb4e+yf71m4WP740o/2t8IXrG1e8KA/XxQCPvK+7gDyfpAjqhY4kRq4I1
 x/CGKm70q0f1nfDyAgPYnmWK+/sxDQDt7h0WggmUJTxVxF4GCK2/TIjXohRBDjvp2HXc
 OMikrztRjmzuPpW33EPEgY3TKItFwbf5zwPzEVtBYCDkVAuzLQH++kVVgFb5u/veGjyD HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2ym48st2y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 00:16:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A0BSNR039837;
 Tue, 10 Mar 2020 00:16:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2ymun83fxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 00:16:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02A0GCOl023604;
 Tue, 10 Mar 2020 00:16:12 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 17:16:12 -0700
Subject: Re: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
To: qemu-devel@nongnu.org
References: <158379920808.20878.11449383700170470292@39012742ff91>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <c103abaf-0ba4-44e5-8551-209422d24955@oracle.com>
Date: Tue, 10 Mar 2020 02:16:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158379920808.20878.11449383700170470292@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090147
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 2:13, no-reply@patchew.org wrote:
> Patchew URL: https://urldefense.com/v3/__https://patchew.org/QEMU/20200309235411.76587-1-liran.alon@oracle.com/__;!!GqivPVa7Brio!IXfneuptZ4caQyQEEgsIN74dLYkkLHJ8XSqL2iGyrzODUx_Jt8Vk-eKN_QQftVU$
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Subject: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
> Message-id: 20200309235411.76587-1-liran.alon@oracle.com
> Type: series
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
>
> Switched to a new branch 'test'
> ec54414 hw/i386/vmport: Assert vmport initialized before registering commands
> 77ea4ed hw/i386/vmport: Add support for CMD_GETHZ
> b1ed920 i386/cpu: Store LAPIC bus frequency in CPU structure
> 62d770f hw/i386/vmport: Allow x2apic without IR
> 5c97d52 hw/i386/vmport: Add support for CMD_GET_VCPU_INFO
> e4a716d hw/i386/vmport: Add support for CMD_GETTIMEFULL
> febcb47 hw/i386/vmport: Add support for CMD_GETTIME
> 25890df hw/i386/vmport: Add support for CMD_GETBIOSUUID
> 9e6211d hw/i386/vmport: Define enum for all commands
> fc5f5ec hw/i386/vmport: Report VMX type in CMD_GETVERSION
> f284754 hw/i386/vmport: Introduce vmx-version property
> 114bf59 hw/i386/vmport: Add device properties
> 8acf5a2 hw/i386/vmport: Set EAX to -1 on failed and unsupported commands
> 97c3de7 hw/i386/vmport: Propagate IOPort read to vCPU EAX register
>
> === OUTPUT BEGIN ===
> 1/14 Checking commit 97c3de7b1b98 (hw/i386/vmport: Propagate IOPort read to vCPU EAX register)
> 2/14 Checking commit 8acf5a2b7630 (hw/i386/vmport: Set EAX to -1 on failed and unsupported commands)
> 3/14 Checking commit 114bf59021b3 (hw/i386/vmport: Add device properties)
> 4/14 Checking commit f284754e01a3 (hw/i386/vmport: Introduce vmx-version property)
> 5/14 Checking commit fc5f5ec6f72f (hw/i386/vmport: Report VMX type in CMD_GETVERSION)
> 6/14 Checking commit 9e6211d4df01 (hw/i386/vmport: Define enum for all commands)
> 7/14 Checking commit 25890df0767b (hw/i386/vmport: Add support for CMD_GETBIOSUUID)
> ERROR: "(foo*)" should be "(foo *)"
> #33: FILE: hw/i386/vmport.c:128:
> +    uint32_t *uuid_parts = (uint32_t*)(qemu_uuid.data);
>
> total: 1 errors, 0 warnings, 39 lines checked
>
> Patch 7/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 8/14 Checking commit febcb4730cb2 (hw/i386/vmport: Add support for CMD_GETTIME)
> 9/14 Checking commit e4a716de3f06 (hw/i386/vmport: Add support for CMD_GETTIMEFULL)
> 10/14 Checking commit 5c97d52c360a (hw/i386/vmport: Add support for CMD_GET_VCPU_INFO)
> ERROR: return is not a function, parentheses are not required
> #41: FILE: hw/i386/vmport.c:185:
> +    return (1 << VCPU_INFO_RESERVED_BIT);
>
> total: 1 errors, 0 warnings, 38 lines checked
>
> Patch 10/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 11/14 Checking commit 62d770f375b6 (hw/i386/vmport: Allow x2apic without IR)
> 12/14 Checking commit b1ed920b0bf3 (i386/cpu: Store LAPIC bus frequency in CPU structure)
> 13/14 Checking commit 77ea4ed42420 (hw/i386/vmport: Add support for CMD_GETHZ)
> 14/14 Checking commit ec54414bea14 (hw/i386/vmport: Assert vmport initialized before registering commands)
> === OUTPUT END ===
>
> Test command exited with code: 1

Arr...
Will fix these minor coding-conventions after the patches are reviewed 
so I will take all into account in v2.

-Liran



