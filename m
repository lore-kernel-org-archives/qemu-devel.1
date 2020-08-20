Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD1322B4D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nEgiIRkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD1322B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8jGG-00007o-91
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8jFC-0007c3-DN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:00:34 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8jF8-0006MU-E9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=383Tp2MVBqkTQ+llMQf/Ghf9/3LA8IoE7p5zXcTpDtI=; b=nEgiIRkYsuEX5JkHDSNvdQvCrc
 h5klta8fmBD5ihu75vun1c6cvL9YYX1PBWED7AlgGFmsd+u0Vlb9u77MRZfHY023UFT5zy9zNXGiu
 swwJ/CeMFgmPXlxujhQg8ZrM+5GlPZFgFk6w/93Y0QeQy1RQP+gS+fbmegvizCKArkMK8hNkuh4cJ
 XCbZMLFML8fzq3oBPaOkufqwagprEhy5S/rUmwbcJ9MifR3f8aiqMQV1jk0nBfn9kZIlvYpkI9mMj
 C7Br9ns7HlrpXMvXSWVeVJKafqcbDfFiXc/B2yByRTXGmMy6adj4rNOxi37oNDJkmhiKBq5U+4e5F
 0WAE3NyQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Geoffrey McRae <geoff@hostfission.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
Date: Thu, 20 Aug 2020 14:00:27 +0200
Message-ID: <2337495.aVM56tU1U7@silver>
In-Reply-To: <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
References: <20200819062940.52774-1-geoff@hostfission.com>
 <3140676.b1PlGooJ8z@silver> <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:06:40
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

On Donnerstag, 20. August 2020 12:54:49 CEST Paolo Bonzini wrote:
> More on the practical side, recursive mutex are an easy way to get a
> deadlock.  It's a common idiom to do
> 
>     /* Need to take foo->lock outside bar->lock.  */
>     mutex_unlock(&bar->lock);
>     mutex_lock(&foo->lock);
>     mutex_lock(&bar->lock);

The general theoretical implications about recursive locks was clear to me. 
AFAICS your point is that a recursive lock could mislead poeple taking things 
easy and running into a deadlock scenario like outlined by you.

My point was if it happens for whatever reason that a main IO mutex lock was 
accidentally introduced, i.e. without knowing it was already locked on a 
higher level, wouldn't it make sense to deal with this in some kind of 
defensive way?

One way would be a recursive type and logging a warning, which you obviously 
don't like; another option would be an assertion fault instead to make 
developers immediately aware about the double lock on early testing. Because 
on a large scale project like this, it is almost impossible for all developers 
to be aware about all implied locks. Don't you think so?

At least IMO the worst case would be a double unlock on a non-recursive main 
thread mutex and running silently into undefined behaviour.

> My suggestion is to work towards protecting the audio code with its own
> mutex(es) and ignore the existence of the BQL for subsystems that can do
> so (audio is a prime candidate).  Also please add comments to
> audio_int.h about which functions are called from other threads than the
> QEMU main thread.

That main thread lock came up here because I noticed this API comment on 
qemu_bh_cancel():

  "While cancellation itself is also wait-free and thread-safe, it can of         
   course race with the loop that executes bottom halves unless you are 
   holding the iothread mutex.  This makes it mostly useless if you are not 
   holding the mutex."

So this lock was not about driver internal data protection, but rather about 
dealing with the BH API correctly.

Best regards,
Christian Schoenebeck



