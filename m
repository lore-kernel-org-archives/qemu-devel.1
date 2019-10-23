Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00823CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF40A2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyYYIIwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF40A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFMb-0000sl-QQ
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNEsd-0007vK-SQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNEsa-0003cy-7C
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:32:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNEsY-0003Mo-LH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571830340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/59X2Omb6FYUcGXfhxnI/lxrSBG+w9/vrP99TGSedlM=;
 b=DyYYIIwKEO3s/6iOFSkNA1fRhW+Jz5R612xFV3/o/KWVYQDgDzvnz9x9rwTnmNS8Hu0R8w
 XX/xpF80YPRTdgYYL3HlLVQxx/6sKDFpKEvpqRDB9oIYjMEKJ/ylDur8NSb5DGjLKMBW8A
 EzIVzNOE0M9R9UTK4y5udMsEZ3ksIDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-OtMda3kmM_qrbgjZKcI9pQ-1; Wed, 23 Oct 2019 07:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD04801E66;
 Wed, 23 Oct 2019 11:32:16 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2D45C1B2;
 Wed, 23 Oct 2019 11:32:01 +0000 (UTC)
Subject: Re: [PATCH v5 05/11] qapi: add unplug primary event
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-6-jfreimann@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1064f550-353d-0a5d-38ae-76a934fac3cc@redhat.com>
Date: Wed, 23 Oct 2019 06:32:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023082711.16694-6-jfreimann@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OtMda3kmM_qrbgjZKcI9pQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 3:27 AM, Jens Freimann wrote:
> This event is emitted when we sent a request to unplug a
> failover primary device from the Guest OS and it includes the
> device id of the primary device.
>=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>   qapi/migration.json | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>=20
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 82feb5bd39..52e69e2868 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1448,3 +1448,22 @@
>   # Since: 3.0
>   ##
>   { 'command': 'migrate-pause', 'allow-oob': true }
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
> +# @device_id: QEMU device id of the unplugged device
> +#
> +# Since: 4.2
> +#
> +# Example:
> +#   {"event": "UNPLUG_PRIMARY", "data": {"device_id": "hostdev0"} }

Should be device-id


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


