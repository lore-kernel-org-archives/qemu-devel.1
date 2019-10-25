Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93022CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6230A21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeoJ7Jy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6230A21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1hG-0004rV-Ad
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iO1fa-00088X-OO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iO1fY-0007cK-TK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:38:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iO1fY-0007br-Q0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572017907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewLX5luq980Hv4KCClk0slnyRF2lk0ctzX42+i77BvA=;
 b=DeoJ7Jy6GCTcvG7wJQDUnsf5/i8EPaUwfuOIILRtZaI784T1Rm44rY7x7kEAs0icCyCJuU
 UvhhXIh0vO6F/HqDi61CnxnzMOidt2Ms0SSRyCBfwWDGIXoDyPZv9jFbUVL9LoaJl1jisa
 /6B/mXRZQiO9rkDB0O2HHEtUCGJgrkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-gI_cw59bN6Kxc3E9eTTsoA-1; Fri, 25 Oct 2019 11:38:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC335E6;
 Fri, 25 Oct 2019 15:38:22 +0000 (UTC)
Received: from [10.3.116.148] (ovpn-116-148.phx2.redhat.com [10.3.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9AAB60603;
 Fri, 25 Oct 2019 15:38:21 +0000 (UTC)
Subject: Re: [PATCH] qemu-iotests: restrict 264 to qcow2 only
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191025145023.6182-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6284b05a-192b-0a63-6767-145a4a832424@redhat.com>
Date: Fri, 25 Oct 2019 10:38:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025145023.6182-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: gI_cw59bN6Kxc3E9eTTsoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 9:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> 264 is unprepared to run with different formats, for example luks needs
> handling keys, cloop doesn't support image creation, vpc creates image
> larger than requested (which breaks "Backup completed: 5242880" in test
> output).
>=20
> The test is here to check nbd-reconnect feature and we actually don't
> need it for all formats. Let's restrict it to qcow2 only.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/264 | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

I will queue through my NBD tree; it may miss soft freeze (due to my=20
travel schedule for KVM Forum), but is definite 4.2 material, so it will=20
be in by rc1.

>=20
> diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
> index c8cd97ae2b..131366422b 100755
> --- a/tests/qemu-iotests/264
> +++ b/tests/qemu-iotests/264
> @@ -24,6 +24,8 @@ import iotests
>   from iotests import qemu_img_create, qemu_io_silent_check, file_path, \
>           qemu_nbd_popen, log
>  =20
> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> +
>   disk_a, disk_b, nbd_sock =3D file_path('disk_a', 'disk_b', 'nbd-sock')
>   nbd_uri =3D 'nbd+unix:///?socket=3D' + nbd_sock
>   size =3D 5 * 1024 * 1024
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


