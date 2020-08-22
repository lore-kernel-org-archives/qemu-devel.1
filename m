Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE75C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9616A20724
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KdCnuy+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9616A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9NUo-0007O7-OU
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 02:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k9NUF-0006xV-OV
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 02:58:47 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:45657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k9NUD-0008Cg-LI
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 02:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=djxahE3gQNKtWiL3TmRWxHr4lUmJq9tH0itK9xnDkfg=; b=KdCnuy+q3i+HQ9q8jhHeY47YWC
 OuizEK4iZvS7jfhK3/OOQ1HiUwTU7h61n3yMJmaCcGDlOd1y6Rk2rMvSDEl7BxAm5Fwo97Z6FVLpe
 A0iKVGzUA9NstD0BnZ6YpUiDB/jhKxvjQMBvkg5xukIvxKCAwXl8RQjG48B/EthhCBcSwLdANbpY6
 zzAAEKJcqVYiVJd/mdSt/aJQ1n6fWMhgr0k9yF82m4RLxSFbgSgEbhEe3ThMv+cHz2PZHNon1u24b
 dGXzKAMQTtoyytmcjx6eBZtE/2rR2YvUxKRTDLcUpQZ/cpaQHWmeuLrkp2vYJIKps8d3TBqeopAp+
 S+LTFjsw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kraxel@redhat.com
Subject: Re: [PATCH v8 1/1] audio/jack: fix use after free segfault
Date: Sat, 22 Aug 2020 08:58:41 +0200
Message-ID: <4344040.8rWxCWeqvY@silver>
In-Reply-To: <1f240cabf78098364f7c0a7d399e2773@hostfission.com>
References: <20200821134554.101397-1-geoff@hostfission.com>
 <0f297508-2b27-9303-002b-2eaa9983cabc@redhat.com>
 <1f240cabf78098364f7c0a7d399e2773@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 02:58:43
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

On Samstag, 22. August 2020 02:16:23 CEST Geoffrey McRae wrote:
> On 2020-08-22 03:47, Paolo Bonzini wrote:
> > On 21/08/20 19:34, Christian Schoenebeck wrote:
> >>>  static void qjack_fini_out(HWVoiceOut *hw)
> >>>  {
> >>>  
> >>>      QJackOut *jo = (QJackOut *)hw;
> >>>      qjack_client_fini(&jo->c);
> >>> 
> >>> +
> >>> +    qemu_bh_delete(jo->c.shutdown_bh);
> >> 
> >> Paolo wrapped that qemu_bh_delete() call inside the lock as well. So I
> >> guess
> >> it makes a difference for the BH API?
> > 
> > It is not a problem as long as qjack_client_fini is idempotent.
> 
> `qjack_client_fini` is indeed idempotent

Right.

> >>> +    qemu_mutex_destroy(&jo->c.shutdown_lock);
> >>> 
> >>>  }
> >> 
> >> Hmmm, is this qemu_mutex_destroy() safe at this point?
> > 
> > Perhaps make the mutex global and not destroy it at all.
> 
> It's safe at this point as `qjack_fini_out` is only called at device
> destruction, and `qjack_client_fini` ensures that JACK is shut down
> which prevents jack from trying to call the shutdown event handler.

You mean because jack_client_close() is synchronized. That prevents JACK from 
firing the callback after jack_client_close() returns, that's correct.

But as qemu_bh_delete() is async, you do not have a guarantee that a 
previously scheduled BH shutdown handler is no longer running. So it might 
still hold the lock when you attempt to destroy the mutex.

On doubt I would do like Paolo suggested by making the mutex global and not 
destroying it at all.

Best regards,
Christian Schoenebeck



