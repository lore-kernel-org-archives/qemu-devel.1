Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EB6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15E920663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJYPwal+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15E920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0MR-0008Jv-TX
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iO0CO-000772-Ng
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iO0CK-00082m-OF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:04:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54355
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iO0CK-00082T-KR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572012251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1jJqNbmywj+hnhLmj0ipV9e5HhnCpBuPlNK9EYEFLU=;
 b=PJYPwal+/udjMGKhNl1GD3NCzE2mXIYxSr/9c1nC4EWbyaq6M7FBSBLshmSavzNVB0U95Y
 tfK/6BKP+iDwXj7sf6vEZA5iD0hE2rg1UeoGd1P3yJ2FrrlLQJ4Cej4TG0RvnqJYXL/UcZ
 EOYWgeQZqwMjQxfAt07qGhlWnnPyMMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-UMOKY2y6Nd25mrxCDpzyiw-1; Fri, 25 Oct 2019 10:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5076A1005500;
 Fri, 25 Oct 2019 14:04:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABCC15D721;
 Fri, 25 Oct 2019 14:03:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BAE21138619; Fri, 25 Oct 2019 16:03:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v6 06/11] qapi: add failover negotiated event
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-7-jfreimann@redhat.com>
Date: Fri, 25 Oct 2019 16:03:54 +0200
In-Reply-To: <20191025121930.6855-7-jfreimann@redhat.com> (Jens Freimann's
 message of "Fri, 25 Oct 2019 14:19:25 +0200")
Message-ID: <87wocsrkfp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UMOKY2y6Nd25mrxCDpzyiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, armbru@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bear with me, I know next to nothing about failover.

Jens Freimann <jfreimann@redhat.com> writes:

> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY feature
> was enabled. The primary device this virtio-net device is associated
> with, will now be hotplugged via qdev_device_add().

Passive voice deftly avoids telling the reader who will do the
hot-plugging.  Intentional?

> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  qapi/net.json | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/qapi/net.json b/qapi/net.json
> index 728990f4fb..ea6eeee4f7 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -737,3 +737,22 @@
>  ##
>  { 'command': 'announce-self', 'boxed': true,
>    'data' : 'AnnounceParameters'}
> +
> +##
> +# @FAILOVER_NEGOTIATED:
> +#
> +# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature negotiati=
on.
> +# Failover primary devices which were hidden (not hotplugged when reques=
ted)
> +# before will now be hotplugged by the virtio-net standby device.
> +#
> +# device-id: QEMU device id of the unplugged device

@device-id is new since v5.

A quick skim of
https://www.kernel.org/doc/html/latest/networking/net_failover.html
tells me there are three devices involved: master, primary slave,
standby slave.  Which one is @device-id?  Or am I confused?

> +# Since: 4.2
> +#
> +# Example:
> +#
> +# <- { "event": "FAILOVER_NEGOTIATED",
> +#      "data": "net1" }
> +#
> +##
> +{ 'event': 'FAILOVER_NEGOTIATED',
> +  'data': {'device-id': 'str'} }


