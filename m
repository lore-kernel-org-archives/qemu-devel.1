Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EAC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0934F21569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXxM4/22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0934F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu8s-00062e-Hd
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itsn7-0000sR-3o
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itsn6-0006ht-2c
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:37:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itsn5-0006hf-TE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579610275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxzw5sZWQGhF70CUXEEOHthBDZLz3s1l3w3v7t+H1AY=;
 b=BXxM4/22KP/89qoqbPTE5q0uHaTzXEV8eUr7zu43v1DrHxdY7dAC1kS6DbTZfFwPVd0n92
 wGH8MSQV+XFdpeHUwzNzJcLTNuun58NaMWgh5yjfri/yfA+bNm2u9WEeitod0bMP9t/5+a
 1+pyDfnwcvsjiCs6F6Iv334Frm9RQw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-IdQr7lz-NPGJRJhiVdUH-w-1; Tue, 21 Jan 2020 07:37:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2848014E3;
 Tue, 21 Jan 2020 12:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C87610013A7;
 Tue, 21 Jan 2020 12:37:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1104E1138600; Tue, 21 Jan 2020 13:37:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390x/event-facility: fix error propagation
References: <20200121095506.8537-1-cohuck@redhat.com>
Date: Tue, 21 Jan 2020 13:37:47 +0100
In-Reply-To: <20200121095506.8537-1-cohuck@redhat.com> (Cornelia Huck's
 message of "Tue, 21 Jan 2020 10:55:06 +0100")
Message-ID: <87o8uxdlyc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: IdQr7lz-NPGJRJhiVdUH-w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cornelia Huck <cohuck@redhat.com> writes:

> We currently check (by error) if the passed-in Error pointer errp
> is non-null and return after realizing the first child of the
> event facility in that case. Symptom is that 'virsh shutdown'
> does not work, as the sclpquiesce device is not realized.
>
> Fix this by (correctly) checking the local Error err.
>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 3d508334dd2c ("s390x/event-facility: Fix realize() error API viola=
tions")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/event-facility.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 8a93b8a1da97..9d6972afa8b3 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -338,7 +338,7 @@ static void sclp_events_bus_realize(BusState *bus, Er=
ror **errp)
>          DeviceState *dev =3D kid->child;
> =20
>          object_property_set_bool(OBJECT(dev), true, "realized", &err);
> -        if (errp) {
> +        if (err) {
>              error_propagate(errp, err);
>              return;
>          }

Thanks for cleaning the mess I made!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


