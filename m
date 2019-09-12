Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCB9C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 07:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8870F2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 07:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EEr1wXIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8870F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8JUi-0005Ot-36
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 03:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1i8JTg-0004Sa-0B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 03:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1i8JTf-0005jC-2B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 03:25:15 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:57535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1i8JTe-0005iZ-EA; Thu, 12 Sep 2019 03:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=u2NEVgbKrHqJ7Z9pJt2JzXOCx5CjC2J8vyK3xhIZPAo=; 
 b=EEr1wXIfJoOCVRnca/TH/cEJ9QVPB8BrdxOYKZxlF2pjs6+2z6ZmzESpmp4n1KObxZLGhHumuZCsG0a/tGJ8Ue6aHWiDLTH5OOrx1qfu/BKb/gxo90TbCjNG7wXKIfsP83vNWaow+G9ZoVK8Rc+FsX19Tuc7BdyqlPiktPUIjoxWNjhtNPEht3aCj2/Twqbpcy15SijLbxm84EWCJsEZHqVMKA4rpIPLMuHeuyiwh8FWXDHIlUGyViCC0fYVZ2STQT69w5DIwti/gwPqcaVL1bvevh7lnTpWgXFkKQPJok27+O09DQe7UlFbKphjegTK2ToBRZVoJfA8dNAUKDQPEg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1i8JTb-00030o-N6; Thu, 12 Sep 2019 09:25:11 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1i8JTb-0007kS-KO; Thu, 12 Sep 2019 09:25:11 +0200
From: Alberto Garcia <berto@igalia.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <b3bd3fa6-e700-b5d1-0339-8670cd79026e@redhat.com>
References: <20190911151626.6823-1-berto@igalia.com>
 <b3bd3fa6-e700-b5d1-0339-8670cd79026e@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 12 Sep 2019 09:25:11 +0200
Message-ID: <w51mufa9dt4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: Stop overwriting
 compressed clusters one by one
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 12 Sep 2019 01:33:05 AM CEST, John Snow <jsnow@redhat.com> wrote:
>> This restriction comes from commit 095a9c58ce12afeeb90c2 from 2018.
>
> You accidentally typed a reasonably modern date. It's from *2008*!

Oh my, and I reviewed the message 3 times ... if this one gets committed
please correct the date.

Berto

