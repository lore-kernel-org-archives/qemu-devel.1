Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3CDC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB562084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB562084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48201 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIs70-0006bB-O6
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iIs62-00069u-0U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iIs61-0001Bw-5N
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:24:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iIs60-0001Bm-W9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E802218CB8E0;
 Fri, 11 Oct 2019 10:24:27 +0000 (UTC)
Received: from redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82F925F7C0;
 Fri, 11 Oct 2019 10:24:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 4/4] migration/multifd: pages->used would be cleared when
 attach to multifd_send_state
In-Reply-To: <20191011085050.17622-5-richardw.yang@linux.intel.com> (Wei
 Yang's message of "Fri, 11 Oct 2019 16:50:50 +0800")
References: <20191011085050.17622-1-richardw.yang@linux.intel.com>
 <20191011085050.17622-5-richardw.yang@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 11 Oct 2019 12:24:25 +0200
Message-ID: <878sprwpeu.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 10:24:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> When we found an available channel in multifd_send_pages(), its
> pages->used is cleared and then attached to multifd_send_state.
>
> It is not necessary to do this twice.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

