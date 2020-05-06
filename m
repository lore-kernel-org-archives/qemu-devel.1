Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F8C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34972068E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBFuWxMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34972068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWMSU-0001lt-Qh
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWMRq-0001Kn-DD
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:59:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWMRp-0000yw-LI
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588780739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=merf9dA+BjiqyLT8q0lZ2ckbH3ecdknfBqHs5LLcLME=;
 b=OBFuWxMKVNpOBJlxw6eHL+kdDsz3QkyTAq2RTDyjYwGuO0FcU+sHoeR6J5lhCE1if5FQ/4
 kwRsOI6dalaTZdeUISi2bBsRUVbr/TrxUxtky0m0mUpTEFlUmWu1i91Zchmm0+qqXh6Ddl
 R/KRHV/62iDSSoCwZ2NeYNNVAMwGEWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-1QhliYrBP9uQMfy-E8fdgg-1; Wed, 06 May 2020 11:58:58 -0400
X-MC-Unique: 1QhliYrBP9uQMfy-E8fdgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C753835B5A;
 Wed,  6 May 2020 15:58:57 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2A7E60619;
 Wed,  6 May 2020 15:58:55 +0000 (UTC)
Date: Wed, 6 May 2020 17:58:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v4 5/6] s390x/css: Refactor the css_queue_crw() routine
Message-ID: <20200506175853.04dc508a.cohuck@redhat.com>
In-Reply-To: <20200505125757.98209-6-farman@linux.ibm.com>
References: <20200505125757.98209-1-farman@linux.ibm.com>
 <20200505125757.98209-6-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 14:57:56 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> We have a use case (vfio-ccw) where a CRW is already built and
> ready to use.  Rather than teasing out the components just to
> reassemble it later, let's rework this code so we can queue a
> fully-qualified CRW directly.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v3->v4:
>      - s/css_queue_crw_cont/css_crw_add_to_queue/ [CH]
> 
>  hw/s390x/css.c         | 44 ++++++++++++++++++++++++++++--------------
>  include/hw/s390x/css.h |  1 +
>  2 files changed, 30 insertions(+), 15 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


