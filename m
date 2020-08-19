Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E7DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AAB206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="jQaMD3wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AAB206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Gfy-000547-1F
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8GfL-0004em-Au
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:29:39 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:60428)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8GfJ-0004pK-Lx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:29:39 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 49F5F42539;
 Wed, 19 Aug 2020 15:29:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597814976;
 bh=cdXJ2hiizMyhjSFBPBzTnhEKkSO3kIKQnswtu3+14bE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jQaMD3wqB2K7THg+yPbzPMFLW14DT56/Ac9WBILVemiMPYQj9jecSIVzR8RuieAuj
 hDLSajfVsDDebFzDHT9rNyZIVN8aRdRSmGuh6m0uik7VSU0QmKcfi2vuZhthJxjcV5
 bNrOq6Ll6jevKsszzAtw5l39M7Dpzz3hsVlz7aso=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 3DB9F9D947;
 Wed, 19 Aug 2020 15:29:36 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Aug 2020 15:29:36 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] audio/jack: fix use after free segfault
In-Reply-To: <9a87a1208b126b2fe882c34a41ebbb18@hostfission.com>
References: <20200819010741.91DAE3A0788@moya.office.hostfission.com>
 <20200819050445.qlhafh2kwh5rt2jh@sirius.home.kraxel.org>
 <9a87a1208b126b2fe882c34a41ebbb18@hostfission.com>
Message-ID: <5f01ceace88ae5ba515debf57f99e87a@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:36:32
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

On 2020-08-19 15:28, Geoffrey McRae wrote:
> On 2020-08-19 15:04, Gerd Hoffmann wrote:
>> Hi,
>> 
>>> As JACK1 and JACK2 are interchangeable and JACK2 has "cleanup" 
>>> routine
>>> that JACK1 does not have, we need to determine which version is in 
>>> use
>>> at runtime. Unfortunatly there is no way to determine which is in use
>>> other then to look for symbols that are missing in JACK1, which in 
>>> this
>>> case is `jack_get_version`.
>> 
>> No.  That'll quickly becomes a maintainance nightmare.
>> 
>> How about moving the qjack_client_fini() call to qjack_shutdown()?  
>> Or,
>> if that isn't an option due to qjack_shutdown being called from a 
>> signal
>> handler, schedule a bottom half calling qjack_client_fini()?
> 
> You are correct, you can not perform such actions in the callback.
> 
>> schedule a bottom half calling qjack_client_fini()
> 
> Does QEMU have such a mechanism for doing this?

There could also be a possible race here if `jack_client_connect` is 
called before the scheduled shutdown takes place.

> 
>> 
>> take care,
>>   Gerd

