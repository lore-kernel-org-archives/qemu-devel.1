Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD24E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Chi9BmGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD24E2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNDY-0004eM-35
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jjNCT-0003PM-5f; Thu, 11 Jun 2020 09:24:57 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jjNCR-0000Mz-Ho; Thu, 11 Jun 2020 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=TbGuVxNClVfyTAUvLHlpJV0TvM5BxgfRDVj0lAWDjZo=; 
 b=Chi9BmGi0idvpgfzsClghcy+VfTB2acQz1wt+33nt+GGAexQBKs4PKzciLZy/VOXvk8AOyeqXl3kWZwKlLBYQECLKl1/ebbDIrRWqxP4WWIzQR3h2LuiWW20/hyuub+goKQ7yD9Us6ESV66TAjX+Yz1OC33g1l4ZLcOflDhXk1lrZISvNdRpoLrlAq4Ip3NpF58ZGLg4881jbhesN0RCS3Necj4LRysbD0vdC643ctEosDk0vQJBHACYScADVOYYQObLBaq1RdgV/vTgOqI9Pf8T/eGLHmx+zcdOG3ztdrYOo1pm+aKQPjjL3A/EWAMiCuNqbM7JbMzZJP+pIKS1Bg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jjNC2-00061n-Ru; Thu, 11 Jun 2020 15:24:30 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jjNC2-0006sE-Hj; Thu, 11 Jun 2020 15:24:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 33/34] qcow2: Assert that expand_zero_clusters_in_l1()
 does not support subclusters
In-Reply-To: <abcbfa4c-c70f-3c2e-ec8f-4087b348af26@redhat.com>
References: <cover.1591801197.git.berto@igalia.com>
 <19afb93b267b9698edf5e0253458c5db69ef91a2.1591801197.git.berto@igalia.com>
 <abcbfa4c-c70f-3c2e-ec8f-4087b348af26@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 11 Jun 2020 15:24:30 +0200
Message-ID: <w51y2othh0x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 09:24:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 10 Jun 2020 09:43:53 PM CEST, Eric Blake wrote:
> On 6/10/20 10:03 AM, Alberto Garcia wrote:
>> This function is only used by qcow2_expand_zero_clusters() to
>> downgrade a qcow2 image to a previous version. It is however not
>> possible to downgrade an image with extended L2 entries because older
>> versions of qcow2 do not have this feature.
>
> Well, it _is_ possible, but it would involve rewriting the entire
> L1/L2 tables (including all internal snapshots)

Right :-) Let's try this way:

    This function is only used by qcow2_expand_zero_clusters() to
    downgrade a qcow2 image to a previous version. This would require
    transforming all extended L2 entries into normal L2 entries but
    this is not a simple task and there are no plans to implement this
    at the moment.

Berto

