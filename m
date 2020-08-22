Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2078EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 00:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C6A214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 00:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="yp5xbPmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C6A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9HDS-0002WQ-5d
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 20:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k9HCu-000258-Dn
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 20:16:28 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:53980)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k9HCs-0006LC-M3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 20:16:28 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id BE63B42803;
 Sat, 22 Aug 2020 10:16:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1598055383;
 bh=/CSuEdTDcmo16GB/hN2a39qSL9NNvZtCYC7Sfuta4wM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=yp5xbPmY6POpKnAlbOPo+OTW0+FYPO6KL3BvN/n7oz2HQhU0GtMrNtx3tslaFNLRR
 1tVTMR8luy++JH7z5e+7R+S8/8WeyR+LCwq2W1wyxFgjp0aIUavn2/6yO+pjLlhL20
 h6SMP1r48dIg/7Wryhvyjzhjae7eTaKu+UrPrM04=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id A925789DE4;
 Sat, 22 Aug 2020 10:16:23 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Aug 2020 10:16:23 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com
Subject: Re: [PATCH v8 1/1] audio/jack: fix use after free segfault
In-Reply-To: <0f297508-2b27-9303-002b-2eaa9983cabc@redhat.com>
References: <20200821134554.101397-1-geoff@hostfission.com>
 <20200821134554.101397-2-geoff@hostfission.com> <3291053.UyeazdVyI9@silver>
 <0f297508-2b27-9303-002b-2eaa9983cabc@redhat.com>
Message-ID: <1f240cabf78098364f7c0a7d399e2773@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 20:16:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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



On 2020-08-22 03:47, Paolo Bonzini wrote:
> On 21/08/20 19:34, Christian Schoenebeck wrote:
>>> 
>>>  static void qjack_fini_out(HWVoiceOut *hw)
>>>  {
>>>      QJackOut *jo = (QJackOut *)hw;
>>>      qjack_client_fini(&jo->c);
>>> +
>>> +    qemu_bh_delete(jo->c.shutdown_bh);
>> Paolo wrapped that qemu_bh_delete() call inside the lock as well. So I 
>> guess
>> it makes a difference for the BH API?
> 
> It is not a problem as long as qjack_client_fini is idempotent.

`qjack_client_fini` is indeed idempotent

> 
>>> +    qemu_mutex_destroy(&jo->c.shutdown_lock);
>>>  }
>> 
>> Hmmm, is this qemu_mutex_destroy() safe at this point?
> 
> Perhaps make the mutex global and not destroy it at all.

It's safe at this point as `qjack_fini_out` is only called at device 
destruction, and `qjack_client_fini` ensures that JACK is shut down 
which prevents jack from trying to call the shutdown event handler.

> 
> Paolo

