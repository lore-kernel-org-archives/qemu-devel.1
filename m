Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095BACA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DC7208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK9ILlnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DC7208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQz1-0004Dc-Tq
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPQx3-00030v-Iz
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPQx2-0000ux-EA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:50:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPQx2-0000un-Ae
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572353419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIyC3TY6K86X3iOIiMgwdv6a+n2zcFFbSB1jpXjqHn0=;
 b=LK9ILlnPyMwIKtRobljYoxNfvMbBmPAIx7eWibnuF78eetcNWJbZEBifqcjlEanyyHW0kg
 iS0mf0NhBFZm88XNvAojL1POpJt8PHzqne61T+mG1affMS51HgnD7n6Bn9T8KZwXTdoHpe
 Ihxe+kKD3Hf2S3dmJX4dpV7wZZiiWJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-YZdzBMaAO9iJ4gShBvfchg-1; Tue, 29 Oct 2019 08:50:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D40A1804972;
 Tue, 29 Oct 2019 12:50:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B847319C4F;
 Tue, 29 Oct 2019 12:50:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D56411385C9; Tue, 29 Oct 2019 13:50:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v7 05/11] qapi: add unplug primary event
References: <20191029114905.6856-1-jfreimann@redhat.com>
 <20191029114905.6856-6-jfreimann@redhat.com>
Date: Tue, 29 Oct 2019 13:50:02 +0100
In-Reply-To: <20191029114905.6856-6-jfreimann@redhat.com> (Jens Freimann's
 message of "Tue, 29 Oct 2019 12:48:59 +0100")
Message-ID: <87mudjpvgl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YZdzBMaAO9iJ4gShBvfchg-1
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jens Freimann <jfreimann@redhat.com> writes:

> This event is emitted when we sent a request to unplug a

Uh, "we sent a requestion [...] from the Guest OS"...  do you mean "we
received"?

> failover primary device from the Guest OS and it includes the
> device id of the primary device.
>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  qapi/migration.json | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 82feb5bd39..e9e7a97c03 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1448,3 +1448,22 @@
>  # Since: 3.0
>  ##
>  { 'command': 'migrate-pause', 'allow-oob': true }
> +
> +##
> +# @UNPLUG_PRIMARY:
> +#
> +# Emitted from source side of a migration when migration state is
> +# WAIT_UNPLUG. Device was unplugged by guest operating system.
> +# Device resources in QEMU are kept on standby to be able to re-plug it =
in case
> +# of migration failure.
> +#
> +# @device-id: QEMU device id of the unplugged device
> +#
> +# Since: 4.2
> +#
> +# Example:
> +#   {"event": "UNPLUG_PRIMARY", "data": {"device-id": "hostdev0"} }
> +#
> +##
> +{ 'event': 'UNPLUG_PRIMARY',
> +  'data': { 'device-id': 'str' } }

Commit message might need a touch-up.  Regardless:
Acked-by: Markus Armbruster <armbru@redhat.com>


