Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51EC206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="eVn9OB0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51EC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhG5N-0005E1-Qv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jhG4p-0004mS-V5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:24:19 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:59614 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jhG4p-0008Fn-1M
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:24:19 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id EBF9E4C857;
 Fri,  5 Jun 2020 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1591377855;
 x=1593192256; bh=dLdjfuawmfDUZqI5cqD/JQd8/gmxM9XInfsnWfzY/CA=; b=
 eVn9OB0rpKOLKEX/58e8qjSsU2HF9ZMLLbT/EsT9/mK2hi3NmYx+d1H89vpNQmBI
 mYLibYiGlxXwDrz+wgJU9Fimkd2QfFYu/lY9m82Llqx1RP30AkkwtWnL8UNC1j07
 q4BYpVrqtXsr3CaZkwVsI9N5TFeR4Xa2VQDBvNhsTwQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LkcCthhxEPRM; Fri,  5 Jun 2020 20:24:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 49CD64C855;
 Fri,  5 Jun 2020 20:24:15 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 5 Jun
 2020 20:24:15 +0300
Date: Fri, 5 Jun 2020 20:24:14 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/13] i386: hvf: Move mmio_buf into CPUX86State
Message-ID: <20200605172414.GB27616@SPB-NB-133.local>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-13-r.bolshakov@yadro.com>
 <d57e48c6-574e-471c-78be-1245d62bc908@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d57e48c6-574e-471c-78be-1245d62bc908@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:30:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 08:27:37PM +0200, Paolo Bonzini wrote:
> On 28/05/20 21:37, Roman Bolshakov wrote:
> > There's no similar field in CPUX86State, but it's needed for MMIO traps.
> > 
> 
> It should be possible to get rid of the buffer altogether, but it's ok
> to do it separately.
> 

Hi Paolo,

I will look into that.

Thanks,
Roman

