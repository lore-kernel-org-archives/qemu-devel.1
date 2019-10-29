Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B9CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F31C21479
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABeJ0TRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F31C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQxc-000311-PO
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPQup-00015G-2n
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPQun-00005z-0z
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:48:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPQul-0008WV-EC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572353278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1Znqf6DFTaN2JfW1XPRQonMbqK/ehutKO9Vt3ebCes=;
 b=ABeJ0TRK+T2SHDeR+/nPF0MeijljjXqy9KAdRxJBXsA55OIyQrkNnQBsPz6ilO6RPyjc7q
 5iDzUuG0RexTw8OBlxamFZiy6oy7XJwdUFs8RHjY/1vifB7yexkza9jquRznV1QDr/gGhP
 Dq35YXLL4JyBHtgB7fAqQTW0RtEtJ4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-VBB4B1R6MQKF967jnZ98zw-1; Tue, 29 Oct 2019 08:47:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6A41804971;
 Tue, 29 Oct 2019 12:47:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C78FE5D9C3;
 Tue, 29 Oct 2019 12:47:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DA0111385C9; Tue, 29 Oct 2019 13:47:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v7 06/11] qapi: add failover negotiated event
References: <20191029114905.6856-1-jfreimann@redhat.com>
 <20191029114905.6856-7-jfreimann@redhat.com>
Date: Tue, 29 Oct 2019 13:47:36 +0100
In-Reply-To: <20191029114905.6856-7-jfreimann@redhat.com> (Jens Freimann's
 message of "Tue, 29 Oct 2019 12:49:00 +0100")
Message-ID: <87r22vpvkn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VBB4B1R6MQKF967jnZ98zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, armbru@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jens Freimann <jfreimann@redhat.com> writes:

> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY feature
> is enabled. The primary device this virtio-net (standby) device is
> associated with, is now hotplugged by the virtio-net device.
>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
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

Acked-by: Markus Armbruster <armbru@redhat.com>


