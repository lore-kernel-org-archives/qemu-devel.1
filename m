Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB46C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBB9205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8vZbJBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipxHo-0005uj-V7
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipxGU-0004mE-FA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipxGS-0005TL-8q
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:36:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipxGS-0005PP-3T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578674159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phcUKnnbbOXqmPJPyYHt02WHdFR+v7sbuaHFfwlpPqc=;
 b=L8vZbJBg+QtglkLOH5PuSwuHkoWzcBbhTgiPX4TgSKcAkmuLW7x3kyItxKOTraU0d7qq11
 X9MkM4sNr4jPf56uq39kF1FFIdu7rVUZ5lmylmGvu6ik4HFk8ymuDQjiWU1zX5gnFYxC/5
 K9T67D/H9phRUMwS5uiTugbSMJMxcg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ROvzg3vNN2WKfLXzo7dLCg-1; Fri, 10 Jan 2020 11:35:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8DEE593A0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:35:54 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F7FE5C1D4;
 Fri, 10 Jan 2020 16:35:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 4/4] migration: Check in savevm_state_handler_insert
 for dups
In-Reply-To: <20191016022933.7276-5-peterx@redhat.com> (Peter Xu's message of
 "Wed, 16 Oct 2019 10:29:33 +0800")
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016022933.7276-5-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 10 Jan 2020 17:35:50 +0100
Message-ID: <87muavxo9l.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ROvzg3vNN2WKfLXzo7dLCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> wrote:
> Before finally register one SaveStateEntry, we detect for duplicated
> entries.  This could be helpful to notify us asap instead of get
> silent migration failures which could be hard to diagnose.
>
> For example, this patch will generate a message like this (if without
> previous fixes on x2apic) as long as we wants to boot a VM instance
> with "-smp 200,maxcpus=3D288,sockets=3D2,cores=3D72,threads=3D2" and QEMU=
 will
> bail out even before VM starts:
>
> savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=3Dapic=
, instance_id=3D0x0
>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Hi peter

I have to drop this one.  There is something on current tree (I think
that it is the VMSTATE_IF) that make isa-ide choke for migration on
"make check".  Will take a look to it later.

Later, Juan.


