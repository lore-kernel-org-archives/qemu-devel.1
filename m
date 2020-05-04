Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C419C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267342063A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+JsoJTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267342063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdIK-00013h-6y
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jVdH8-0007km-3v
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:44:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jVdH6-0008Lv-KK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588607094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ks4ptpeKfPoz4LZEmpjuCiZs5YXStm1Qc7IxbkJ0+Hw=;
 b=H+JsoJTOmDvGbD1X3RxvV4hrFe6WN5k1LKb8FzA3wMZOtVuugUeT9J6LNT5ilPY2/RztU2
 5+jqEZjs3wdk81lJj8s+mM4gyGK1PrC+xAaXJIt5iMkGHj6IaeFWwjGLRCmG8Lz6VVTnqR
 jEgH8ERF7OYxRuodzAZEpDhew8uGrJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-hN6nJ15vOo-hacErbv-NzQ-1; Mon, 04 May 2020 11:44:53 -0400
X-MC-Unique: hN6nJ15vOo-hacErbv-NzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2CD7835B51;
 Mon,  4 May 2020 15:44:51 +0000 (UTC)
Received: from localhost (ovpn-115-57.phx2.redhat.com [10.3.115.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4525C1B2;
 Mon,  4 May 2020 15:44:51 +0000 (UTC)
Date: Mon, 4 May 2020 11:44:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
Message-ID: <20200504154450.GM5244@habkost.net>
References: <20200430154606.6421-1-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430154606.6421-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, mhohmann@physnet.uni-hamburg.de, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 11:46:06AM -0400, Igor Mammedov wrote:
> Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
> The backend however calls mbind() which is typically NOP
> in case of default policy/absent host-nodes bitmap.
> However when runing in container with black-listed mbind()
> syscall, QEMU fails to start with error
>  "cannot bind memory to host NUMA nodes: Operation not permitted"
> even when user hasn't provided host-nodes to pin to explictly
> (which is the case with -m option)
>=20
> To fix issue, call mbind() only in case when user has provided
> host-nodes explicitly (i.e. host_nodes bitmap is not empty).
> That should allow to run QEMU in containers with black-listed
> mbind() without memory pinning. If QEMU provided memory-pinning
> is required user still has to white-list mbind() in container
> configuration.
>=20
> Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Queued on machine-next, thanks!

--=20
Eduardo


