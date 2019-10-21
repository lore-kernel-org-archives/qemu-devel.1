Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D8ECA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FF52070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX0O5lMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FF52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMS3X-0006B2-EQ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 03:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iMS2o-0005hJ-EN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iMS2m-0007Zx-Ff
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:23:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iMS2m-0007Xn-4N
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 03:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571642633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClLiGPEMMWTzeh+osYqsUOxLMmAduo0dPPbJrPbFFps=;
 b=ZX0O5lMdIS/FhMPvy2VvVByuxOiU+Eq9We3N7KzQ9TIlTHsqUca9CV9wyOmMjExzg4YnD0
 2gpKnCOeop6whp9MIhUAAfX7ydqqTVwTYwQlMh+KiFnEOG4LProhwkQeea2EgFJsPNEq8F
 DjLHD/lA9A9ooflxPyzAIFyVtym7vFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Z9hwyN9tOfmeIrKToTtfyg-1; Mon, 21 Oct 2019 03:23:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5511800E00;
 Mon, 21 Oct 2019 07:23:51 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A353260126;
 Mon, 21 Oct 2019 07:23:43 +0000 (UTC)
Date: Mon, 21 Oct 2019 09:23:42 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 05/11] qapi: add unplug primary event
Message-ID: <20191021072342.omxkgwma73cl4e37@jenstp.localdomain>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-6-jfreimann@redhat.com>
 <186357a6-3b91-51eb-1daf-2ea9ef6071f5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <186357a6-3b91-51eb-1daf-2ea9ef6071f5@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Z9hwyN9tOfmeIrKToTtfyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 03:28:36PM -0500, Eric Blake wrote:
>On 10/18/19 3:20 PM, Jens Freimann wrote:
>>This event is emitted when we sent a request to unplug a
>>failover primary device from the Guest OS and it includes the
>>device id of the primary device.
>>
>>Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>---
>>  qapi/migration.json | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>>diff --git a/qapi/migration.json b/qapi/migration.json
>>index 82feb5bd39..52e69e2868 100644
>>--- a/qapi/migration.json
>>+++ b/qapi/migration.json
>>@@ -1448,3 +1448,22 @@
>>  # Since: 3.0
>>  ##
>>  { 'command': 'migrate-pause', 'allow-oob': true }
>>+
>>+##
>>+# @UNPLUG_PRIMARY:
>>+#
>>+# Emitted from source side of a migration when migration state is
>>+# WAIT_UNPLUG. Device was unplugged by guest operating system.
>>+# Device resources in QEMU are kept on standby to be able to re-plug it =
in case
>>+# of migration failure.
>>+#
>>+# @device_id: QEMU device id of the unplugged device
>>+#
>>+# Since: 4.2
>>+#
>>+# Example:
>>+#   {"event": "UNPLUG_PRIMARY", "data": {"device_id": "hostdev0"} }
>
>Unless there is a strong reason in favor of 'device_id' (such as=20
>consistency with a similar event), our naming convention prefers this=20
>to be 'device-id'.

No reason, I'll change it.

Thanks Eric!

regards,
Jens=20


