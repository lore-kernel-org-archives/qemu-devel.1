Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AF9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F7420B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Shad7g51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F7420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjeI-0005lS-Rb
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjcM-0004IR-SU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjcL-0004ZS-2d
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602692828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QVEZRUVG7NG6+EIkLs9ZJmj2Mm4x81Cldcaux2xAny4=;
 b=Shad7g51ANhkxvsIE1WjbKl2Rmu4dJnKCrcarYfXmpkvwYUjZXojkaZlHgYsQqgXflvE7i
 OaXjXIeTtE2kvTdu7D/INpssN/nYVL6LUav4BaSqsD7lG4P5C5eEAarlRi9KYsk0afyGgA
 kGajqY481i7t96FS8BcfGW7n5qIHKCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-U56Mvh9yM52uJ-iD0HQGbA-1; Wed, 14 Oct 2020 12:27:04 -0400
X-MC-Unique: U56Mvh9yM52uJ-iD0HQGbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D3E7104D419;
 Wed, 14 Oct 2020 16:26:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F29F27D4E7;
 Wed, 14 Oct 2020 16:26:19 +0000 (UTC)
Subject: Re: [PATCH v11 02/13] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <39aec06d-6dbd-a0e4-c3b8-d0f243864121@redhat.com>
 <e88ba6fb-17ae-1539-1174-395bfee890de@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <4aea6d8c-de75-9b2e-b527-f146f96ff0b3@redhat.com>
Date: Wed, 14 Oct 2020 18:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e88ba6fb-17ae-1539-1174-395bfee890de@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oHrd4c2CPeoAy8CscxIfPkl0obLt9B3S4"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oHrd4c2CPeoAy8CscxIfPkl0obLt9B3S4
Content-Type: multipart/mixed; boundary="B1mv8uZrQjSqaMO9Kk8ib5jJFedGKvF47"

--B1mv8uZrQjSqaMO9Kk8ib5jJFedGKvF47
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 16:28, Andrey Shinkevich wrote:
> On 14.10.2020 13:44, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> Provide API for the COR-filter insertion/removal.
>>> Also, drop the filter child permissions for an inactive state when the
>>> filter node is being removed.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 block/copy-on-read.c | 88
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 block/copy-on-read.h | 35 +++++++++++++++++++++
>>> =C2=A0 2 files changed, 123 insertions(+)
>>> =C2=A0 create mode 100644 block/copy-on-read.h
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index cb03e0f..bcccf0f 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>
>> [...]
>>
>>> @@ -159,4 +188,63 @@ static void bdrv_copy_on_read_init(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_register(&bdrv_copy_on_read);
>>> =C2=A0 }
>>> =C2=A0 +
>>> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 QDict *node_options,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int flags, Error **errp)
>>
>> I had hoped you could make this a generic block layer function. :(
>>
>> (Because it really is rather generic)
>>
>> *shrug*
>=20
> Actually, I did (and still can do) that for the 'append node' function
> only but not for the 'drop node' one so far...

Ah, yeah.

> diff --git a/block.c b/block.c
> index 11ab55f..f41e876 100644
> --- a/block.c
> +++ b/block.c
> @@ -4669,6 +4669,55 @@ static void bdrv_delete(BlockDriverState *bs)
> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(bs);
> =C2=A0}
>=20
> +BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict
> *node_options,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags, Error =
**errp)
> +{
> +=C2=A0=C2=A0=C2=A0 BlockDriverState *new_node_bs;
> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
> +
> +=C2=A0=C2=A0=C2=A0 new_node_bs =3D=C2=A0 bdrv_open(NULL, NULL, node_opti=
ons, flags, errp);
> +=C2=A0=C2=A0=C2=A0 if (new_node_bs =3D=3D NULL) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(errp, "Could no=
t create node: ");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 bdrv_drained_begin(bs);
> +=C2=A0=C2=A0=C2=A0 bdrv_replace_node(bs, new_node_bs, &local_err);
> +=C2=A0=C2=A0=C2=A0 bdrv_drained_end(bs);
> +
> +=C2=A0=C2=A0=C2=A0 if (local_err) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unref(new_node_bs);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_e=
rr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return new_node_bs;
> +}
> +
> +void bdrv_remove_node(BlockDriverState *bs)
> +{
> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
> +=C2=A0=C2=A0=C2=A0 BlockDriverState *inferior_bs;
> +
> +=C2=A0=C2=A0=C2=A0 child =3D bdrv_filter_or_cow_child(bs);
> +=C2=A0=C2=A0=C2=A0 if (!child) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 inferior_bs =3D child->bs;
> +
> +=C2=A0=C2=A0=C2=A0 /* Retain the BDS until we complete the graph change.=
 */
> +=C2=A0=C2=A0=C2=A0 bdrv_ref(inferior_bs);
> +=C2=A0=C2=A0=C2=A0 /* Hold a guest back from writing while permissions a=
re being
> reset. */
> +=C2=A0=C2=A0=C2=A0 bdrv_drained_begin(inferior_bs);
> +=C2=A0=C2=A0=C2=A0 /* Refresh permissions before the graph change. */
> +=C2=A0=C2=A0=C2=A0 bdrv_child_refresh_perms(bs, child, &error_abort);
> +=C2=A0=C2=A0=C2=A0 bdrv_replace_node(bs, inferior_bs, &error_abort);
> +
> +=C2=A0=C2=A0=C2=A0 bdrv_drained_end(inferior_bs);
> +=C2=A0=C2=A0=C2=A0 bdrv_unref(inferior_bs);
> +=C2=A0=C2=A0=C2=A0 bdrv_unref(bs);
> +}
>=20
> So, it is an intermediate solution in this patch of the series. I am
> going to make both functions generic once Vladimir overhauls the QEMU
> permission update system. Otherwise, the COR-filter node cannot be
> removed from the backing chain gracefully.

True.

> Thank you for your r-b. If the next version comes, I can move the
> 'append node' function only to the generic layer.

Thanks!  Even if you decide against it, I=E2=80=99m happy as long as there =
are
plans to perhaps make it generic at some point.

(I=E2=80=99m just afraid this function might be useful in some other case, =
too,
and we forget that it exists here already, and then end up
reimplementing it.)

Max


--B1mv8uZrQjSqaMO9Kk8ib5jJFedGKvF47--

--oHrd4c2CPeoAy8CscxIfPkl0obLt9B3S4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+HJqoACgkQ9AfbAGHV
z0D2OQf+Jkagw0xOinZ8nU+jS6L/a0hraGHzJIgmEyxzOnI16JfHFAqVs8msYD8d
29v/DeqMKVPlwRSNU9b+UKQWOoVx1JElf1TtnlisoyRRWyqb4D1Tij+vsL7Dna2F
ORiZe1CK11EvHcRzXpwyLmpVP6Z+KiNAAedwRRdentYWfOliru7agnkdCKs4vCs8
lcoouLYXzzZF1cuatPiJSi29sQx2+iaYOYhVr0BO21rE/EpVgD7x38cjqP3YWh2y
HkUdLuRli83npPEyDCqO8LfGTcN2wuSJb00+AQa1z9ner+k/5k1OmjjhBbCtmDFI
uXKo+SWhT3RyeuBE5bpvzBGKUNqSfA==
=nbpz
-----END PGP SIGNATURE-----

--oHrd4c2CPeoAy8CscxIfPkl0obLt9B3S4--


