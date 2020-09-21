Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F3EC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07B921789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyjLfs9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07B921789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLYR-0000dw-Lh
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kKLXE-0008VF-Lb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kKLXD-0007LF-3M
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600693630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llsU2FQ3j6EzkrsurBg+jEiSMGoecRncjGgL5uSHvSs=;
 b=TyjLfs9IwztKwb0TjafiXdEZ2HEulbnH6gSBq8o0lt8w/ncyQMT9nvLM2ZVQX4xMheiujk
 aVJllxzE6OHpibaa13goLS/g3qiNW/98yvXKqIMtWHLVfRyqnoNuAyIroRvZJQOSGGQTt5
 +3ANY1TQH/bWxE43J3Z2WeokGwNDFsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-DAqmdOnpP0KExjVYCcHebQ-1; Mon, 21 Sep 2020 09:07:06 -0400
X-MC-Unique: DAqmdOnpP0KExjVYCcHebQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CFFA801F95;
 Mon, 21 Sep 2020 13:07:05 +0000 (UTC)
Received: from gondolin (unknown [10.40.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 962957366D;
 Mon, 21 Sep 2020 13:06:59 +0000 (UTC)
Date: Mon, 21 Sep 2020 15:06:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] s390x/tcg: Implement MONITOR CALL
Message-ID: <20200921150656.0f2fcb81.cohuck@redhat.com>
In-Reply-To: <20200918085122.26132-1-david@redhat.com>
References: <20200918085122.26132-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 10:51:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> Recent upstream Linux uses the MONITOR CALL instruction for things like
> BUG_ON() and WARN_ON(). We currently inject an operation exception when
> we hit a MONITOR CALL instruction - which is wrong, as the instruction
> is not glued to specific CPU features.
> 
> Doing a simple WARN_ON_ONCE() currently results in a panic:
>   [   18.162801] illegal operation: 0001 ilc:2 [#1] SMP
>   [   18.162889] Modules linked in:
>   [...]
>   [   18.165476] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> With a proper implementation, we now get:
>   [   18.242754] ------------[ cut here ]------------
>   [   18.242855] WARNING: CPU: 7 PID: 1 at init/main.c:1534 [...]
>   [   18.242919] Modules linked in:
>   [...]
>   [   18.246262] ---[ end trace a420477d71dc97b4 ]---
>   [   18.259014] Freeing unused kernel memory: 4220K
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> -  Simplify by not using the tb flags, always calling the helper.
> 
> I looked into monitor-event counting, which looks easy at first glance
> - but proper DAT/access exception handling is tricky. Leaving that for
> a cold winter evening :)

Fortunately, this is covered by a facility bit, so no need to do this
now :)

> 
> ---
>  target/s390x/excp_helper.c | 23 +++++++++++++++++++++++
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  3 +++
>  target/s390x/translate.c   | 21 +++++++++++++++++++++
>  4 files changed, 48 insertions(+)

Thanks, applied.


