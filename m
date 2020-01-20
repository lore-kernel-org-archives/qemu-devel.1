Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4552FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093AB22525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNDPo1+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093AB22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itdAi-0005x7-6a
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itdA5-0005SI-8Z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itdA1-000811-Lj
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:56:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itdA1-00080t-Ih
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579550193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPYN5nM2EKawa0WjfOxwtl33RSQGhzSu6qJozBzrb0Y=;
 b=gNDPo1+sNmD1DAte9Dh+pjSk3ueeNG0UgQB4HK+fqN7TKrQtwlA6ON27M4XslPWKmcg9S5
 BabSIE0dEYH1TZTh1qEvu5xln9ujh9dy+NVpRks90dbvA/yb2VJ57LjWSL+CE9iJrrDwTv
 9Ye9SbO3L4mkjAdCr5rqeBAygI1VQ2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-YgZbjn9ENeaCDeNhhoOteg-1; Mon, 20 Jan 2020 14:56:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF3EA18B5FA7;
 Mon, 20 Jan 2020 19:56:26 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 105C060BF7;
 Mon, 20 Jan 2020 19:56:24 +0000 (UTC)
Subject: Re: [PATCH v3 05/10] block/dirty-bitmap: switch _next_dirty_area and
 _next_zero to int64_t
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-6-vsementsov@virtuozzo.com>
 <ee73d55c-7f4f-fda1-b651-ced940027b62@redhat.com>
 <c2f78255-c001-01a3-487a-f7cf224f86f8@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a9d1c3a2-5121-75dd-3682-3c02a510b494@redhat.com>
Date: Mon, 20 Jan 2020 13:56:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c2f78255-c001-01a3-487a-f7cf224f86f8@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YgZbjn9ENeaCDeNhhoOteg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 6:28 AM, Vladimir Sementsov-Ogievskiy wrote:

>> As far as I can see, NBD just passes NBDRequest.from (which is a
>> uint64_t) to this function (on NBD_CMD_BLOCK_STATUS).  Would this allow
>> a malicious client to send a value > INT64_MAX, thus provoking an
>> overflow and killing the server with this new assertion?
>=20
>=20
> in nbd_co_receive_request() we have
>=20
>=20
>       if (request->from > client->exp->size ||
>           request->len > client->exp->size - request->from) {
>=20
>=20
> So, we check that from is <=3D exp->size. and exp->size cant be greater t=
han INT64_MAX,
> as it derived from bdrv_getlength, which returns int64_t.
>=20
>=20
>=20
> Interesting, should we be more strict in server:?

I think we're okay based on the existing bounds checks.

>=20
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2178,7 +2178,7 @@ static int nbd_co_receive_request(NBDRequestData *r=
eq, NBDRequest *request,
>            error_setg(errp, "Export is read-only");
>            return -EROFS;
>        }
> -    if (request->from > client->exp->size ||
> +    if (request->from >=3D client->exp->size ||
>            request->len > client->exp->size - request->from) {
>            error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: =
%" PRIu32
>                       ", Size: %" PRIu64, request->from, request->len,
>=20
> Or is it intentional? Looking through NBD spec I found only
>=20
>      client MUST NOT use a length ... or which, when added to offset, wou=
ld exceed the export size.
>=20
> So, formally pair offset=3D<export size>, len=3D0 is valid...

Except that the spec also says that len=3D0 is generally unspecified=20
behavior (whether it is a no-op, or means special handling, or whatever=20
else, is up to the server, but clients shouldn't be sending it - thus a=20
server that rejects it instead of handling it as a no-op is no worse for=20
the wear).

>=20
>>
>> On second thought, we have this problem already everywhere in
>> nbd_handle_request().  I don=92t see it or its caller ever checking
>> whether the received values are in bounds, it just passes them to all
>> kind of block layer functions that sometimes even just accept plain
>> ints.  Well, I suppose all other functions just error out, so it
>> probably isn=92t an actual problem in practice so far...
>>
>> Max
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


