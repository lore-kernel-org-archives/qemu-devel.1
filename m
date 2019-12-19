Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F5DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E612146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNTAWU11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E612146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihqSG-000260-C1
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 02:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihqRQ-000146-Hm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihqRN-00027I-94
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:41:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihqRM-00020h-QT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576741303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xt5LG8xKjhrNhju7YIWIAcPmEbmJqchRvZPPSWm1G/g=;
 b=bNTAWU11tIhk5SRqwywbVNPDZ03r4mqUfZOEH1KgC7YU6fKdjOQyt2GPimLuuXBEIlvEhq
 DRh5oz5snwFhqgDmGaOWZb+4hYx3njP5wz1BlqENkahzA+76Mv9BPCnI0peu1mJO7ciXcz
 lS+RG4kjQvPqoExnVd72wRmL3f/zlyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-xVPf6yhWMAm6MXS93fkIBA-1; Thu, 19 Dec 2019 02:41:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A30800EBF
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 07:41:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60DAB10013A1;
 Thu, 19 Dec 2019 07:41:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA28B11386A7; Thu, 19 Dec 2019 08:41:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 06/10] migration: Add multifd-compress parameter
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-7-quintela@redhat.com>
Date: Thu, 19 Dec 2019 08:41:37 +0100
In-Reply-To: <20191218020119.3776-7-quintela@redhat.com> (Juan Quintela's
 message of "Wed, 18 Dec 2019 03:01:15 +0100")
Message-ID: <87d0cku5hq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xVPf6yhWMAm6MXS93fkIBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
> Rename it to NONE
> Fix typos (dave)
> We don't need to chek values returned by visit_type_MultifdCompress (mark=
us)
> Fix yet more typos (wei)
> ---
>  hw/core/qdev-properties.c    | 13 +++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  migration/migration.c        | 13 +++++++++++++
>  monitor/hmp-cmds.c           | 13 +++++++++++++
>  qapi/migration.json          | 30 +++++++++++++++++++++++++++---
>  tests/migration-test.c       | 13 ++++++++++---
>  6 files changed, 79 insertions(+), 6 deletions(-)

For QAPI:
Acked-by: Markus Armbruster <armbru@redhat.com>


