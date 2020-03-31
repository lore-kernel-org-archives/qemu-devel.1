Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98222C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FCF20714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CA1OYwac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FCF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFrD-0004pD-IT
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJFoM-0001rf-5T
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJFoL-0005QC-4o
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:16:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJFoL-0005Pg-0y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585656964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsDt1u/fOm7dEybCkmrKecK6CJsSohkllFOz0Ms3j8A=;
 b=CA1OYwac32NPZz3uLSxdv00F+Q5/QQLrzOgsL083qS3JjwiCJMWg+/Q1p+WYkbvqazMDVh
 xC+t29OVikOJoJnTHk/GLyRHTJRUJYKMH7Blsufif1cUjcEaRFgfoP3EecQRqvL5lDzbIx
 zKzOYrLux5FWvRREH9OZHrqFJTbsYXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-0Y4575_2MbOhO4SbT861kw-1; Tue, 31 Mar 2020 08:16:01 -0400
X-MC-Unique: 0Y4575_2MbOhO4SbT861kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48A2E18A6EC1;
 Tue, 31 Mar 2020 12:15:59 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64BD85C1C5;
 Tue, 31 Mar 2020 12:15:54 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:15:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] vl/s390: fixup ram sizes for compat machines
Message-ID: <20200331141551.59c3dc0e.cohuck@redhat.com>
In-Reply-To: <20200331120238.15786-1-borntraeger@de.ibm.com>
References: <20200331120238.15786-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?B?THVr?= =?UTF-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 08:02:38 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> compat machines did fixup the ram size to match what can be reported via
> sclp. We need to mimic those for machines 4.2 and older to not fail on
> inbound migration.
>=20
> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 12 ++++++++++++
>  hw/s390x/sclp.c            | 10 ----------
>  include/hw/boards.h        |  1 +
>  softmmu/vl.c               |  3 +++
>  4 files changed, 16 insertions(+), 10 deletions(-)

(...)

> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 236d239c19..e3574f4b5f 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -218,6 +218,7 @@ struct MachineClass {
>                                                           unsigned cpu_in=
dex);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine)=
;
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
> +    ram_addr_t (*machine_align_ram)(ram_addr_t size);

Maybe add a comment:

/* For compat machine usage only. Don't use this in new machines. */

?

>  };
> =20
>  /**

(...)

(Didn't really read the patch yet.)


