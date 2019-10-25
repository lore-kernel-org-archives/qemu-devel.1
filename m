Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 05:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD2A21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 05:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+E+TxY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD2A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNsH9-00031y-KK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 01:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNsGJ-0002dG-W4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNsGI-00074p-8D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:35:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNsGI-00074Q-0R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 01:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571981745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VmgRMEyUxTv6BoFauNXR5uTRcQAJ/CVfJiKHZeEt7w=;
 b=S+E+TxY9uKFubnRpdv7vS6ucFTdPjEAgoJwikgdCbGpmo0p1tiEdIpBgqy1hy75qplLCSZ
 DnSQRXhQwBod19ftRyaIQjLL+7s4uYTiIkGkNcyxnb/AihNINSmtqRARTzPVVtdB4zKuHO
 ibrbEtNEHpGIf3DpXP0j4PU+LuWxcUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-vNdbFB73Ml2ERA5EtSBUMQ-1; Fri, 25 Oct 2019 01:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C25800D41;
 Fri, 25 Oct 2019 05:35:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 251AD60600;
 Fri, 25 Oct 2019 05:35:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 992961138619; Fri, 25 Oct 2019 07:35:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 06/11] qapi: add failover negotiated event
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-7-jfreimann@redhat.com>
Date: Fri, 25 Oct 2019 07:35:28 +0200
In-Reply-To: <20191023082711.16694-7-jfreimann@redhat.com> (Jens Freimann's
 message of "Wed, 23 Oct 2019 10:27:06 +0200")
Message-ID: <878sp9mlpb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vNdbFB73Ml2ERA5EtSBUMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We ask patch submitters to cc: subject matter experts for review.  You
did.  When such patches touch the QAPI schema, it's best to cc the qapi
schema maintainers (Eric Blake and me) as well, because we can't require
all subject matter experts to be fluent in the QAPI schema language and
conventions.  I found this one more or less by chance.

Jens Freimann <jfreimann@redhat.com> writes:

> This event is sent to let libvirt know that VIRTIO_NET_F_STANDBY
> feature was not negotiated during virtio feature negotiation. If this
> event is received it means any primary devices hotplugged before
> this were were never really added to QEMU devices.

Too many negations for my poor old brain to process.

>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  qapi/net.json | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
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

The commit message at least tries to explain intended use.  The doc
string does not.  Should it?


