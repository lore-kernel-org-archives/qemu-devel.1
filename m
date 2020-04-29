Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A11C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAC42085B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qXakW3sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAC42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlvA-0005tF-Fw
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jTlt1-0003Z7-LU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jTlt1-0006LM-8o
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:32:23 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jTlsJ-0005RL-Ak; Wed, 29 Apr 2020 08:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=CbxEA2bP1xCRixx8tmZIHBIL3c1bwrbEsE5ER1QspXc=; 
 b=qXakW3sOIdXUVPPmayUvNyFluR6tgHZ2RK19ExZdJciF2syrjc/Cy5pPk09Db938W+ruP0umQZ3dLIEHe09NGQG2ISOJhHsiXZREK4yA7+SP6ScqioOPMh3dAJun1Eb9XWjUSTSvhmycFwK3vhETwfVS3nzWR/Izf4K4erj/LLLotgM+iVuln9mtczAvmxZmZolIEFr0oVQmD5nwWWHbdFJSI/uAgQYjQK5wptvXVyzu/saO6KLcw2zdiwDTxaUF+N16NqFoUW3JDyBlWurgpqDKrllILQBsRxCJ+jFRqil14uBa+WOUEtAcqdAJrnGJWI4Az5Hkgya1eLWDdZvfHg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jTlsG-0001r7-B9; Wed, 29 Apr 2020 14:31:36 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jTlsG-0007r7-0f; Wed, 29 Apr 2020 14:31:36 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/3] backup: Improve error for bdrv_getlength() failure
In-Reply-To: <20200429111539.42103-2-kwolf@redhat.com>
References: <20200429111539.42103-1-kwolf@redhat.com>
 <20200429111539.42103-2-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 29 Apr 2020 14:31:36 +0200
Message-ID: <w51o8rascbb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 08:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 29 Apr 2020 01:15:37 PM CEST, Kevin Wolf wrote:
> bdrv_get_device_name() will be an empty string with modern management
> tools that don't use -drive. Use bdrv_get_device_or_node_name() instead
> so that the node name is used if the BlockBackend is anonymous.
>
> While at it, start with upper case to make the message consistent with
> the rest of the function.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

