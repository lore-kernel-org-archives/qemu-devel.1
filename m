Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF0CC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE242083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kep4bFyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE242083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadVU-000686-1I
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kadUY-0005aV-GP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kadUW-0000y6-MZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604575903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0JbbLRwjl6dJP53iM0EBi7mBvJtQmsAsQB2lAAr/iA=;
 b=Kep4bFyvNHMZWRYHe5q9azHcmO9BP7xQN4wPg4yuiQd/4zWCayNRBexV37xBBIiAIj8wHq
 RRDs+WjLwmVpQGuNIl3MU4rAZEa53lc5I+ETot6VtqNHwH/giZImpip1n8WYbCttiK8tvb
 eXbswSJ2cV7zdlSAi8U+SuuSrPMe9VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-rb_CC8NqN9eU5lLNRUYlOQ-1; Thu, 05 Nov 2020 06:31:42 -0500
X-MC-Unique: rb_CC8NqN9eU5lLNRUYlOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18604107AFA9;
 Thu,  5 Nov 2020 11:31:41 +0000 (UTC)
Received: from gondolin (ovpn-112-138.ams2.redhat.com [10.36.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 843F41002C3C;
 Thu,  5 Nov 2020 11:31:34 +0000 (UTC)
Date: Thu, 5 Nov 2020 12:31:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3] target/s390x: fix execution with icount
Message-ID: <20201105123132.4cd676d4.cohuck@redhat.com>
In-Reply-To: <160455551747.32240.17074484658979970129.stgit@pasha-ThinkPad-X280>
References: <160455551747.32240.17074484658979970129.stgit@pasha-ThinkPad-X280>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 05 Nov 2020 08:51:57 +0300
Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> wrote:

> This patch adds some gen_io_start() calls to allow execution
> of s390x targets in icount mode with -smp 1.
> It enables deterministic timers and record/replay features.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> 
> v2:
>  - added IF_IO flag to reuse icount code in translate_one()
>    (suggested by Richard Henderson)
> v3:
>  - using "unlikely" conditions for icount checks
>    (suggested by David Hildenbrand)
> ---
>  target/s390x/insn-data.def |   70 ++++++++++++++++++++++----------------------
>  target/s390x/translate.c   |   15 +++++++++
>  2 files changed, 50 insertions(+), 35 deletions(-)

Thanks, queued to s390-fixes.


