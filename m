Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9789521D95
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WcPWrORA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9789521D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Jko-0002KR-U0
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k3JjG-00016H-Bo; Wed, 05 Aug 2020 09:45:14 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k3JjE-0004QD-Hy; Wed, 05 Aug 2020 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=jgp9nlcbaQZ4ViCEm48FAaQDOQS7oXtsFE24VlVipT0=; 
 b=WcPWrORAlhHt2zp7M9PxvnCmDu3Zo0CIDqvmS3cZ6Lrhx5d91tPfhEhjBnsxeLECMNjbZuXoOF2QwVcwVU1Yter3YczHbUSFhGKNTsANErTWtLdsyTJO2IByzAeTYExo8KXC5SVER1EpPzp8w5ISEe87WF1XTK6wb02vZjfFBAzzWSr3p9wXrwpfEr9C2oxGET12MN1/d5yw/oubDXwLmrfSBB7E4b27XCS7guxrSalsOgEntjBYdu42RYFRCe11vgWOBApSgX41bCJTygsaONwQU5VS+dUCoUIaRETbDZlA1khIBEYQWIcL974ZaKBKukBKvG47hUeQpkXQqklPLQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k3Jj7-0007VH-KB; Wed, 05 Aug 2020 15:45:05 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k3Jj7-00037W-AL; Wed, 05 Aug 2020 15:45:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf\@redhat.com" <kwolf@redhat.com>,
 "mreitz\@redhat.com" <mreitz@redhat.com>,
 "qemu-block\@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
In-Reply-To: <w51imdxb42f.fsf@maestria.local.igalia.com>
References: <81ba90fe0c014f269621c283269b42ad@h3c.com>
 <w51imdxb42f.fsf@maestria.local.igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 05 Aug 2020 15:45:05 +0200
Message-ID: <w51ft91b40u.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 09:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gaoliang <liang_gao@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 05 Aug 2020 03:44:08 PM CEST, Alberto Garcia wrote:
> On Wed 05 Aug 2020 11:22:58 AM CEST, Tuguoyi wrote:
>> This patch fix it by casting @i to uint64_t before doing left shift
>> operation
>
> The patch seems fine and I also think that it's perhaps worth a test
> case (although it only seems to happen with preallocation=falloc or full
> so the test would need to generate very large files).
>
> But I also wonder if there are other cases where this can happen.
>
> nb_clusters is an int and there are more cases of
>
>     nb_clusters << s->cluster_bits
>
> I can see at least these: handle_alloc(), qcow2_free_any_clusters(),
> qcow2_alloc_cluster_abort().

I forgot to add

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

