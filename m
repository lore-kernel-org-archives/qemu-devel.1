Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0537BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40CC207C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Tm/ATlzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40CC207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98vW-00048U-0g
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k98ut-0003eo-Bu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:25:19 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:45625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k98ur-0005XS-8L
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=b29J67g2O50FLJaQk/oiWMurhwaKf8lGUDwNmLZR+3A=; b=Tm/ATlzTZ1XbkGbQmmDDO9hs/3
 96lJyLuSgV/yaD0KwR6D2MvA5P0zF/gMy7sSoSrgl+H2rF7amyEqS7z8X4n6LSgzSQs8DERvBGWuC
 hCu7q0conFmA9j3USNTQqX1EMlnxc0N0drNetVWLOlaDX2P4trVJEkyDO1mn1V2OKYNWpCN1QKmMK
 ML45z5ms2whma2A0Jb7R44FV0GLiQFgh3tfj/etwnibymhKXWxQoya/k61TldCSrAPpDVaI7Wstpz
 Fb7qFAXexQOecCgfLh37xblrWq0H4B7qa9W5k8tF2eiRS/ft/OSq7RmF77Iu/hUUWnGD2ygc8gDeX
 dl2dOsrg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: recursive locks (in general)
Date: Fri, 21 Aug 2020 17:25:12 +0200
Message-ID: <3505776.nlAjVYSdU6@silver>
In-Reply-To: <87c93055-c4ef-cba7-43b4-da2e7f65f2e4@redhat.com>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <4046931.6zmTeCK0lb@silver> <87c93055-c4ef-cba7-43b4-da2e7f65f2e4@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 11:25:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Freitag, 21. August 2020 15:08:09 CEST Paolo Bonzini wrote:
> On 21/08/20 13:12, Christian Schoenebeck wrote:
> > There is a golden rule with recursive locks: You always have to preserve a
> > clear hierarchy. Say you have the following recursive mutexes:
> > 
> > RecursiveMutex mutex0;
> > RecursiveMutex mutex1;
> > RecursiveMutex mutex2;
> > ...
> > RecursiveMutex mutexN;
> > 
> > where the suffix shall identify the hierarchy, i.e. h(mutex0) = 0,
> > h(mutex1) = 1, ... h(mutexN) = N. Then the golden rule is that in any call
> > stack the nested locks must always preserve the same transitive hierarchy,
> 
> > e.g.:
> That's also what you do with regular locks.

You can't do that with non-recursive mutexes if you have cyclic dependencies.

> But the difference is that with regular locks you can always do
> 
> void bar(std::unique_lock<std::mutex> &mutex3_guard)
> {
> 	...
> 	mutex3_guard.unlock();
> 	synchronized(mutex2) {
> 	}
> 	mutex3_guard.lock();
> 	...
> }

Right, if you are able to clearly judge that this unlock is really safe for 
all layers involved.

Okay never mind, I see that we'll keep split on this recursive lock issue 
anyway. Sorry for the noise Paolo! :)

Best regards,
Christian Schoenebeck



