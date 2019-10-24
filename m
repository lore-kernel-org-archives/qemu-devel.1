Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2368CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886E4205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFcBUQ2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886E4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhTC-0001XQ-4m
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNgyz-0005JU-8v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNgyx-00080w-6G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:33:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNgyx-00080d-1D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571938386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROTVFsZAaQbT3/ih8j3XLeTnP0uCsrRCtGiUIw+D3mA=;
 b=TFcBUQ2MOKTb09qNixBBTYxkVxXyGJFEnJDF/nF/b3R3bco98atZ7qeMsiGhYoe/4DJLJ/
 HA4TK7XSNiffX1PdeeZFJuwzeYrYF1wL//288j3Q/pcgIFw52DoyeXndSZMFoaxRdxqgRl
 NyRY5dOjJ8le60HS7rBBzCnuXELWR1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-qATnKHOxNger00x8lAEIEw-1; Thu, 24 Oct 2019 13:33:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CC25801E5F;
 Thu, 24 Oct 2019 17:33:02 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7395D9D5;
 Thu, 24 Oct 2019 17:32:47 +0000 (UTC)
Date: Thu, 24 Oct 2019 18:32:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 06/11] qapi: add failover negotiated event
Message-ID: <20191024173245.GP2877@work-vm>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-7-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191023082711.16694-7-jfreimann@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qATnKHOxNger00x8lAEIEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jens Freimann (jfreimann@redhat.com) wrote:
> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY
> feature was not negotiated during virtio feature negotiation. If this
> event is received it means any primary devices hotplugged before
> this were were never really added to QEMU devices.
>=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>

Can I just understand a bit more about what the meaning of this is.

Say my VM boots:
   a) BIOS
   b) Boot loader
   c) Linux
   d) Reboots
      (possibly a',b', different c')

When would I get that event?
When can libvirt know it can use it?

Dave

> ---
>  qapi/net.json | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/qapi/net.json b/qapi/net.json
> index 728990f4fb..8c5f3f1fb2 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -737,3 +737,19 @@
>  ##
>  { 'command': 'announce-self', 'boxed': true,
>    'data' : 'AnnounceParameters'}
> +
> +##
> +# @FAILOVER_NEGOTIATED:
> +#
> +# Emitted when VIRTIO_NET_F_STANDBY was negotiated during feature negoti=
ation
> +#
> +# Since: 4.2
> +#
> +# Example:
> +#
> +# <- { "event": "FAILOVER_NEGOTIATED",
> +#      "data": {} }
> +#
> +##
> +{ 'event': 'FAILOVER_NEGOTIATED',
> +  'data': {} }
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


