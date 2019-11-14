Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35AAC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E013D206E4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZLMerSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E013D206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5Rn-0005x5-QX
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 22:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV5Qr-0005Px-Pv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV5Qq-0005EZ-1S
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:04:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV5Qp-0005CP-TH
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573700666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVbZEjBXiI35NResQYIcVaetA1ldq6PwC2DikxCyriM=;
 b=DZLMerSnvkz/fm1QPaK8g9r1WiLMR6uhEhs+2i95vEcTzrooNqQB1TQnAS9OOhG3l/gSEZ
 i59TXI56fjLnhgejy7AVwZkxg5iEv6PNFSH8r7pa4jj+C1lM0kzjWSNOhIjI3v2OuSOz3a
 2I84EquHuQw/K91Qxx3RIuVgJ45qEzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-VRNsGvwUOAKsEsiq_e_fnQ-1; Wed, 13 Nov 2019 22:04:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2788DDB2D;
 Thu, 14 Nov 2019 03:04:23 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C74498175D;
 Thu, 14 Nov 2019 03:04:22 +0000 (UTC)
Subject: Re: [PATCH v3 for-4.2 0/4] Better NBD string length handling
To: qemu-devel@nongnu.org
References: <157370043192.25875.12348439356190898901@37313f22b938>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bd14b1ba-07a8-6194-fa7a-4f61b77675e9@redhat.com>
Date: Wed, 13 Nov 2019 21:04:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157370043192.25875.12348439356190898901@37313f22b938>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VRNsGvwUOAKsEsiq_e_fnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 9:00 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191114024635.11363-1-eblake@redha=
t.com/
>=20

>=20
>                   from /tmp/qemu-test/src/include/qemu/osdep.h:140,
>                   from /tmp/qemu-test/src/nbd/server.c:20:
> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_negotiate_handle_export=
_name':
> /usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0/glib/glib-autocle=
anups.h:28:3: error: 'name' may be used uninitialized in this function [-We=
rror=3Dmaybe-uninitialized]
>     g_free (*pp);
>     ^~~~~~~~~~~~
> /tmp/qemu-test/src/nbd/server.c:435:22: note: 'name' was declared here
>       g_autofree char *name;
>                        ^~~~

Ha - I posted the fix to that one minute before patchew flagged it.=20
Still, I'm not sure why my gcc didn't flag this locally, while the mingw=20
builder did.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


