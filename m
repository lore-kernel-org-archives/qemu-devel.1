Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E65AC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E5321882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="YhdudGTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E5321882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6Ec-0001hM-SL
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT6A8-00067C-ME
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT6A7-0000YT-OJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:27:00 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iT6A5-0000Xc-LN; Fri, 08 Nov 2019 10:26:57 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F14F796EF0;
 Fri,  8 Nov 2019 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573226814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpIN/FeyzyiDDM1leB4oCp2dWBwoukM1bFmAIRHkboo=;
 b=YhdudGTZ7b/C8StE2Vju8edQOZ/ER7xg+3RaUGEulbDofeR3uAkQkpVyRTpyTYzluX8pu7
 MqLpSCZSe6fyrcc5SvKAB1rkmYV4QpcYp9VRvd8K/un6iX5an1itRbuibCYQCcV3GFiHqg
 Z0KjfKZOjmQadjgiORr4SgcykMZvSC4=
Subject: Re: [PATCH v5 00/13] Multi-phase reset mechanism
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <efef625a-8162-5454-128f-489d636563a1@greensocs.com>
Message-ID: <aae84bfb-e735-0aac-124c-9abbdea882ff@greensocs.com>
Date: Fri, 8 Nov 2019 16:26:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <efef625a-8162-5454-128f-489d636563a1@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573226814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpIN/FeyzyiDDM1leB4oCp2dWBwoukM1bFmAIRHkboo=;
 b=MZNeecKpiQBHeGE99mPwRtvLU5kq7e0bueNGwtlDAd9dgv/tOcAg2dTvkaRjH540mMpkmu
 6ZysBugfhxZ1brMCtGSn7ZiCytSGZuR3tpTPg6RT+m9khJ4xg/dml+FzmIxBNJiKitqWtF
 1VcYfeL+kFVCDC03leFQaXy95kyWKLw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573226814; a=rsa-sha256; cv=none;
 b=1R6gXKiwrLzQqyJIEeE1xBaSmW6FsFXNZnc0STfm/f0Nik06rroyxINPsbRfRR02XB/WT7
 pFtGz6HrOMDxKZ5UnNFyUU79D1cUu71397D2FCj6Mrcvx2GP5g1PJu6S4srdOhedfPy2kB
 LBoPIndMw+KxF36uD1ACwRcb7N+IoWs=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/29/19 4:53 PM, Damien Hedde wrote:
> Hi,
> 
> Does anyone has comment about the interface / patch 3 ?
> Should I try to split it ?

ping

> 
> Thanks,
> Damien
> 

Thanks,
Damien

