Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C1C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F542080C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lpBM/jWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F542080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7QF-0003h4-74
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kI7PR-0002wX-8l; Tue, 15 Sep 2020 05:37:57 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:33022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kI7PN-0004P9-Ox; Tue, 15 Sep 2020 05:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=WNvAvNiA7lvOkZVgoSz4pHsPDji9sG5EGU7FW38XRdc=; 
 b=lpBM/jWsyCG3n2Ni8QNPxwwNCqN7B9lo22ZofE8MDy6ZSlWmm4JR6Gk6tKK6H1gpPoyhwoNvO5/U1uwf8MMMpvSwGwJg6ta5shl6jESFGEi3DIbiqm9HB9UF7QZqULFpTdsUfR1iqrwnDJjQTYG/rub+tf78es39aa/hvKPfR+deU2sRpQ4+pXsR2EVfAQK+pNdusYzTeuMOxY7vg6kZm4iv8WNfJL4ei9tcIdWd1WLK3mpMTJf6Qr6vAQp9V+gQzZdmkwFBEfDU6AtmOvTPEKzUHFWyCg4KKXE3nzkXClIVmVbuq3nkvxI/FzC95fVGnkN0wT12r9tpufEW+uFVgw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kI7PJ-0000rz-01; Tue, 15 Sep 2020 11:37:49 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kI7PI-00015w-M1; Tue, 15 Sep 2020 11:37:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] qcow2: Make preallocate_co() resize the image to the
 correct size
In-Reply-To: <a5a760d1-5b8f-dfd7-93ef-b62e63b3c320@redhat.com>
References: <cover.1599833007.git.berto@igalia.com>
 <adeb8b059917b141d5f5b3bd2a016262d3052c79.1599833007.git.berto@igalia.com>
 <a5a760d1-5b8f-dfd7-93ef-b62e63b3c320@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 15 Sep 2020 11:37:48 +0200
Message-ID: <w511rj34byr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:37:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 15 Sep 2020 11:29:22 AM CEST, Max Reitz wrote:
> On 11.09.20 16:09, Alberto Garcia wrote:
>> This function preallocates metadata structures and then extends the
>> image to its new size, but that new size calculation is wrong because
>> it doesn't take into account that the host_offset variable is always
>> cluster-aligned.
>> 
>> This problem can be reproduced with preallocation=metadata when the
>> original size is not cluster-aligned but the new size is. In this case
>> the final image size will be shorter than expected.
>> 
>>    qemu-img create -f qcow2 img.qcow2 31k
>>    qemu-img resize --preallocation=metadata img.qcow2 128k
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2.c              |  1 +
>>  tests/qemu-iotests/125     | 40 +++++++++++++++++++++-----------------
>>  tests/qemu-iotests/125.out | 28 ++++++++++++++++++++++++--
>>  3 files changed, 49 insertions(+), 20 deletions(-)
>
> The test additions make this test fail with compat=0.10.  Are you OK
> with disabling compat=0.10 by squashing this in?

Yes, thanks

Berto

