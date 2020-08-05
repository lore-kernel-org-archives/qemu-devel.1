Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5AAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEABE2313E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BaKux+AO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEABE2313E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3KU2-0000fa-9O
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 10:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k3KTS-00008P-DB; Wed, 05 Aug 2020 10:32:58 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k3KTP-0001Sh-Nz; Wed, 05 Aug 2020 10:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=77yhbi9Ltacs0E4JL67DeT7XK33vgNRaY44CmbwB9o4=; 
 b=BaKux+AOXiiwuIqf3mIPPY0Y7N4Gnw+Efot2WQOXdowk57n9Ybx26/Xgu/CPNIk8HlCSqHZlh7icMQU5FJOh+weTABD1x4YVKjQEA4uDzeNpCZb+mwuAkemZAeZ7Ru+LY3lQ2YwNt3l2W0HpK3YmA6WsdQ3FrDfILQSLJiyFwcF3nBqpOi+30H6T/bIpKO4H5tN8lE7hJ5pT0KZgX0PGgCLruLS8/OWSAhXyp90s1K7FHCYcuRNn/5Tkz3z6LF2EG2jA9LJvfw64DtMdYWvBZh4VD7mK4MjoLBC3RLjgEN18tfwSTUlDeZZoe9SErNgDErYmQxyn5x/PGV6XQrVCNg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k3KTI-0005FF-Ny; Wed, 05 Aug 2020 16:32:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k3KTI-0006wU-Eg; Wed, 05 Aug 2020 16:32:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
In-Reply-To: <20200805141657.GA37318@linux.fritz.box>
References: <81ba90fe0c014f269621c283269b42ad@h3c.com>
 <w51imdxb42f.fsf@maestria.local.igalia.com>
 <20200805141657.GA37318@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 05 Aug 2020 16:32:48 +0200
Message-ID: <w51d045b1tb.fsf@maestria.local.igalia.com>
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
Cc: Chengchiwen <chengchiwen@h3c.com>, Tuguoyi <tu.guoyi@h3c.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Gaoliang <liang_gao@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 05 Aug 2020 04:16:57 PM CEST, Kevin Wolf wrote:
>> nb_clusters is an int and there are more cases of
>> 
>>     nb_clusters << s->cluster_bits
>> 
>> I can see at least these: handle_alloc(), qcow2_free_any_clusters(),
>> qcow2_alloc_cluster_abort().
>
> Actuallyx, handle_alloc() and everything that comes from it should be
> fine. It has a uint64_t nb_clusters locally and limits it:
>
>     nb_clusters = MIN(nb_clusters, INT_MAX >> s->cluster_bits);

INT_MAX replaced with BDRV_REQUEST_MAX_BYTES in my subcluster allocation
series, so it should still be fine.

> The problematic request that causes the crash comes actually from
> qcow2_co_truncate(). It limits it only to s->l2_slice_size, which can
> be larger than that, but will be at most 256k (= 2 MB /
> sizeof(uint64_t)).
>
> cow_end.offset will get a wraparound then, too. This is harmless
> because cow_end.nb_bytes = 0, so the offset will be ignored anyway.

In that one nb_clusters is actually int64_t so there's no wraparound.

> I think the proper fix to be made in the 5.2 release cycle would revert
> this one and instead fix the limit in qcow2_co_truncate().
>
> But this one is good enough as a band-aid for 5.1.

The other one is just as simple, no? This line in the while() loop in
qcow2_co_truncate():

   nb_clusters = MIN(nb_clusters, BDRV_REQUEST_MAX_BYTES >> s->cluster_bits);

Berto

