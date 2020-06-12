Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE44C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2249F207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="nXf1Gsk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2249F207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjehs-00078v-9b
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jjehH-0006k2-NZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:05:55 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:36940)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jjehF-0006xj-6e
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:05:55 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 975CA444F9;
 Fri, 12 Jun 2020 18:05:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1591949148;
 bh=ogEjotLmd7lC99Lsi9FxOt0N7IiSlhTu2xqt6og7p40=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nXf1Gsk/cp4GEiRrl4GtenkiAaPYRG4HckR18Ix+mPCgUTZTgJxPMYtDyxKJhEg1R
 pkK237XmUXSp5+vomgcB5CrYirWkS446ukttOPwiTiZ4+pASBGoK2q7NiWTN+9ldRu
 uhbJF5LMIYgS0XjJ2i0XI5rRuA/2I9GovC7wh8y8=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 7EFE91E2EC;
 Fri, 12 Jun 2020 18:05:48 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jun 2020 18:05:48 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] audio/jack: fixes to overall jack behaviour
In-Reply-To: <20200612071137.6sjvpemuxzqzxgsn@sirius.home.kraxel.org>
References: <20200612020400.989D93A0172@moya.office.hostfission.com>
 <20200612071137.6sjvpemuxzqzxgsn@sirius.home.kraxel.org>
Message-ID: <b56d7398cac7d42cccfdf3d6bf50b631@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:05:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks, still learning how best to submit these things :)
Is it worth re-sending this again as per the below?

On 2020-06-12 17:11, Gerd Hoffmann wrote:
> On Fri, Jun 12, 2020 at 10:12:37AM +1000, Geoffrey McRae wrote:
>> Sorry for the spam, resubmitted due to missing subject on this cover
>> letter. Seems patchew.org can't find the associated patches without 
>> it.
> 
> Alot of tools (patchew probably included) depend on
> "git send-email --thread" which sends all patches as reply to the cover
> letter.
> 
> HTH,
>   Gerd

