Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69812C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD6620674
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJi3KgMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD6620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVft2-0007Gx-7f
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 13:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVfrv-0006fg-9o
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVfrs-00058W-Q8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:58:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVfrs-00058K-Mi
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573840727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0cChxa3QFKf8B7BOwuxNLytzexujOqnktnr9e0QbeA=;
 b=MJi3KgMRTfeIMBZw9MoG1Rt0TNkAoxoz5XP8lhcO1gMovPw+BNNjUwKqICrJeKQUPttC1Z
 zOi+DROAcEEvtYMpgGmxQ0PUblHe2EmqhSoIQZteZ84A3iAIFt3yBlBEIQp2IuLsP/PfHa
 eB2CayEv3pv1z/ZOCbQVjqWFzZvPvoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-89p0WWSHO6yO7_-8RLM3Aw-1; Fri, 15 Nov 2019 12:58:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D16F1005502;
 Fri, 15 Nov 2019 17:58:43 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB8669183;
 Fri, 15 Nov 2019 17:58:38 +0000 (UTC)
Subject: Re: [RFC 21/24] backup: move to block-copy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
 <20191115141444.24155-22-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <66b4478f-3d51-9888-3a88-78d4ae7dcd48@redhat.com>
Date: Fri, 15 Nov 2019 11:58:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115141444.24155-22-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 89p0WWSHO6yO7_-8RLM3Aw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org,
 crosa@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 8:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> This brings async request handling and block-status driven chunk sizes
> to backup out of the box, which improves backup performance.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/qapi/block-core.json
> @@ -1455,6 +1455,12 @@
>   #                    above node specified by @drive. If this option is =
not given,
>   #                    a node name is autogenerated. (Since: 4.2)
>   #
> +# @x-max-workers: maximum of parallel requests for static data backup. T=
his
> +#                 doesn't influence copy-before-write operations. (Since=
: 4.3)
> +#
> +# @x-max-chunk: maximum chunk length for static data backup. This doesn'=
t
> +#               influence copy-before-write operations. (Since: 4.3)

The next release is 5.0, not 4.3.

Is there a reason to keep these experimental for a while?  For example,=20
are there potential changes to the interface that might affect how it=20
gets used?  Or should we drop the x- prefix and add this outright in 5.0?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


