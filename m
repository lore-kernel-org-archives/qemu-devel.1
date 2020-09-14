Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D7C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6ED206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q9jXfrA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6ED206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrb9-0006my-SE
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kHrZW-0005LF-CB; Mon, 14 Sep 2020 12:43:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kHrZS-0000L0-MO; Mon, 14 Sep 2020 12:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Yuum+UDoALM3x9tvHRwzDspTyUb77cgKGEnSU15BW2A=; 
 b=Q9jXfrA54sz86xjdqyfbGS1oppOvoOWBP1IwZ541HPwVNbexf2dZ5HcBhNA8WdVhu9YWr6WLL3FYRoOnZGxxEfC05XdgrvWhXsLAurCXwhvTHFYkZkoekDeyhQkAWKAqhoOPG1ZJ/kQAUk5JysvL85Gl8dIjFWzEh/Zq9wC40ku9oPV0GlapK3A6N8/SgSYWyU8xiX2N4V+WMFXWSteeZZ+KGDPiqFzv0YqHR4leSUXO9ix/OeRdHoYfYGjVn7DpKTMQDE+i6Qk9emv4THH8tyFs3Dcv9XaZ5ePZRp7l35GTJO4IXndeFmg6ENA9otxHR9G/HVw6CYkIAOM1rhPqkA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kHrZ2-0002Lf-TP; Mon, 14 Sep 2020 18:42:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kHrZ2-000601-Ii; Mon, 14 Sep 2020 18:42:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] qcow2: Convert qcow2_alloc_cluster_offset() into
 qcow2_alloc_host_offset()
In-Reply-To: <1c70b5a7-222c-0fbb-e8c8-c8c0000252fb@redhat.com>
References: <cover.1599833007.git.berto@igalia.com>
 <9bfef50ec9200d752413be4fc2aeb22a28378817.1599833007.git.berto@igalia.com>
 <1c70b5a7-222c-0fbb-e8c8-c8c0000252fb@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 14 Sep 2020 18:42:48 +0200
Message-ID: <w51363ks41j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 12:42:49
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

On Mon 14 Sep 2020 02:14:36 PM CEST, Max Reitz wrote:

> However, I wonder what you think about =E2=80=9Ccluster_offset=E2=80=9D in
> qcow2_alloc_host_offset.  It isn=E2=80=99t a cluster offset anymore.
> Can/should we rename it?

That variable was not a cluster offset before this patch either (at
least not during the first iteration of the loop).

The difference is that *host_offset is always the offset of the
beginning of the requested region, and cluster_offset increases with
every iteration of the loop. Maybe current_offset / current_host_offset?
I don't know, but I'm fine with changing it if you have a good name.

Berto

