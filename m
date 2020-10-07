Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC070C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3142083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arWQdUkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3142083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQH0G-0004cn-D1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 17:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQGzL-00042v-F4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQGzH-0000Bk-OM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602106118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1i2L1gyM5crMMG2Bd7q9MBJL+TdBIfjwepYmbvJbds0=;
 b=arWQdUkqMgsw1m4DuE6NfIWqY9KBX4KfhnLZ26kmW9tBTSrVTRe/+c18tUUDnoKHChxs6j
 TMmJmJL+H4cWbeQF6pLk7a0cuIE3SNDctDWEv/FB/TbdsGHvwNpgUhehrPcqT9WeNCIpNl
 42zgHuGxeveE9cxjurvwXpDx/dQhaWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-GM_sHUkAM-GUnRbUIKs6-Q-1; Wed, 07 Oct 2020 17:28:34 -0400
X-MC-Unique: GM_sHUkAM-GUnRbUIKs6-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F7818A076B;
 Wed,  7 Oct 2020 21:28:33 +0000 (UTC)
Received: from [10.3.113.66] (ovpn-113-66.phx2.redhat.com [10.3.113.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81B875C1BD;
 Wed,  7 Oct 2020 21:28:30 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] nbd: Simplify meta-context parsing
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-4-eblake@redhat.com>
 <9a8a379a-0f43-017c-113a-a355ff9ec5df@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <ca1c9ca4-fb5d-dcff-e0d1-4fa7a3580057@redhat.com>
Date: Wed, 7 Oct 2020 16:28:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9a8a379a-0f43-017c-113a-a355ff9ec5df@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ntLFtJKCSkTpZ8MlOZ5FTFPwmUYS39XR1"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com,
 rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ntLFtJKCSkTpZ8MlOZ5FTFPwmUYS39XR1
Content-Type: multipart/mixed; boundary="U1EGFViWyZznDUUYTWEgWyBH7cmvZmdZw";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <ca1c9ca4-fb5d-dcff-e0d1-4fa7a3580057@redhat.com>
Subject: Re: [PATCH v2 3/5] nbd: Simplify meta-context parsing
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-4-eblake@redhat.com>
 <9a8a379a-0f43-017c-113a-a355ff9ec5df@virtuozzo.com>
In-Reply-To: <9a8a379a-0f43-017c-113a-a355ff9ec5df@virtuozzo.com>

--U1EGFViWyZznDUUYTWEgWyBH7cmvZmdZw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/7/20 6:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.09.2020 15:11, Eric Blake wrote:
>> We had a premature optimization of trying to read as little from the
>> wire as possible while handling NBD_OPT_SET_META_CONTEXT in phases.
>> But in reality, we HAVE to read the entire string from the client
>> before we can get to the next command, and it is easier to just read
>> it all at once than it is to read it in pieces.=C2=A0 And once we do tha=
t,
>> several functions end up no longer performing I/O, so they can drop
>> length and errp parameters, and just return a bool instead of
>> modifying through a pointer.
>>
>> Our iotests still pass; I also checked that libnbd's testsuite (which
>> covers more corner cases of odd meta context requests) still passes.
>>
>=20
> Also, do not advertise bitmaps meta context when bitmap export is not set=
.

That was already there, although seeing the logic change is tricky and
the trace messages change:

> +static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts=
 *meta,
> +                                const char *query)
>  {
> -    bool dirty_bitmap =3D false;
> -    size_t dirty_bitmap_len =3D strlen("dirty-bitmap:");
> -    int ret;
> -
> -    if (!meta->exp->export_bitmap) {
> -        trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
> -        return nbd_opt_skip(client, len, errp);

Old code returned early if there was no bitmap export set

> +    if (!nbd_strshift(&query, "qemu:")) {
> +        return false;
>      }
> +    trace_nbd_negotiate_meta_query_parse("qemu:");
>=20
> -    if (len =3D=3D 0) {
> +    if (!*query) {
>          if (client->opt =3D=3D NBD_OPT_LIST_META_CONTEXT) {
> +            meta->bitmap =3D !!meta->exp->export_bitmap;

while the new code has to handle it specifically.  I'll tweak the commit
message to mention the change in trace messages, even when the end
behavior is the same.


>=20
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--U1EGFViWyZznDUUYTWEgWyBH7cmvZmdZw--

--ntLFtJKCSkTpZ8MlOZ5FTFPwmUYS39XR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl9+Mv0ACgkQp6FrSiUn
Q2qgVAf9GQ42aR2Q89g5AiRcP2+4Tg3JHUhwr3nRYElDXIn85sRM/JQ27eHQysly
Jjj60FeTKvOBEW32lDjwB4fSQDngIHoKiCbmphrPfOVqM5rFzDl3GQIvfn/cV6i7
6TCJelE+GYyXlrqK6oEyu93O+FnGx0qJTIjpw/tYl56YEpfp/oKjzIE0i+7gKn3V
0sHqAPHxutDLeA0VbWEgYM8/Uvr4AfeIrmFU8Gv8rssOQ5kWslwKfnPN9+9LbfXC
8f/USMQ1+fIejLzOgdICQ0v4I24E+c0oBNLKc76pFhRqE8hEq59+y9wOfuozyPbd
k5lGZ+nVZTpSklAT39RZDOeoRIFvbA==
=8AP1
-----END PGP SIGNATURE-----

--ntLFtJKCSkTpZ8MlOZ5FTFPwmUYS39XR1--


