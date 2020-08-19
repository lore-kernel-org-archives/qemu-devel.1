Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB88C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8887520772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cMFqLmiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8887520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MIx-00027y-Ow
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8MIH-0001EV-0A
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:30:13 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8MIE-0000vv-AY
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=1H5bgK3NOwPtBjTT+Sy97RbKQWEtRilMg5b0ct1KIHA=; b=cMFqLmiGkX4IomFaXi09cP8GlU
 NiYzXHrrbABmcG8XUu1dMaDKFUKg2XhxlfMWKUZyQIgNWveROi1AsHMgUdEDRL++KNu7H5tEq0OWf
 be3z7dQ91v5Yp4F4kvBc3Fzs2inm9AA31TJsNcQHz8A42wgLcyXnChKPfVVcUIZYZMXRj8rSGcFkT
 k7VRdkp5UIckl2GwxnG7qTqbtTos+pHawrd2HW9IGAiZZdl/A2Xsexhm9Vt06cjGXQu467BxEv57t
 nPKP3IB6rTgVQaXGKcWya1i9G8HkPu6Vq6dcI0UYkOO5CFrRVDtDrnqhYKRQ3huyfEMfiyG/2jfNp
 38Q8iXFg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, kraxel@redhat.com
Subject: Re: [PATCH] audio/jack: fix use after free segfault
Date: Wed, 19 Aug 2020 13:30:06 +0200
Message-ID: <2255329.JDkKyqenvo@silver>
In-Reply-To: <fdfc3c5e5ef6c19c82bfaf5503011659@hostfission.com>
References: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
 <11253274.hK5Fc7SEp3@silver>
 <fdfc3c5e5ef6c19c82bfaf5503011659@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 07:30:08
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

On Mittwoch, 19. August 2020 00:20:07 CEST Geoffrey McRae wrote:
> > Could you please describe in more detail how you ran into this
> > situation with
> > your 2nd audio device?
> 
> Sure. Run a Windows guest with two audio devices, let it boot up, then
> restart
> the jack service to trigger the recovery routine, then attempt to use
> the 2nd
> (non-primary) audio device. Ie, go to windows audio settings to test the
> microphone of the second audio device.
> 
> When windows try to use the 2nd audio device it goes through the
> recovery
> routine triggering this fault.

I still don't quite get how this correlates. So you are forcing a restart of 
jackd on host side in between, for what purpose? To simulate the Windows 
client being kicked by jackd?

What latencies do you achieve BTW with Windows guests?

> I am aware and since these libraries are interchangeable I had assumed
> that
> JACK1 will have the same fault. If not I suppose we need to detect which
> is in
> use and change this code appropriately.

I haven't checked this in the JACK1 code base yet, but I assume JACK1 does not 
behave like JACK2 here, because the JACK API is very clear that it is the 
client's responsibility to free itself.

So it looks like a JACK2-only-bug to me.

Very weird that there is no jack_client_version() in the shared weak API (i.e. 
missing on JACK1 side).

Best regards,
Christian Schoenebeck



