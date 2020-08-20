Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA22C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D994A20658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA9ERQkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D994A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8hoj-0005nL-76
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8hoB-0005II-TY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8ho9-0003Nn-NP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597919310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cM0T8rn9IHg1rp01B/PgURaEezejJhiOPhwqrtbfcm8=;
 b=cA9ERQkzgnDtcGBf66W+ULaI6U9xNN6KE8LMU9d7eT+ecEKjajuTb+jtsyNETUQXkJRD9U
 DLqLwSQvrU5wzKSoitU6UCJHFu4n5ULyVVbojsCTUuKkgW/ytgkR/u/cq2Ke6q1qFZyYQl
 pKciGttJbWHnyNfuj7k9/uadD91WuII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Xe5l8NcfMjecVhqYcMznew-1; Thu, 20 Aug 2020 06:28:28 -0400
X-MC-Unique: Xe5l8NcfMjecVhqYcMznew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FAC81F024;
 Thu, 20 Aug 2020 10:28:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-133.ams2.redhat.com
 [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6EE9600DD;
 Thu, 20 Aug 2020 10:28:25 +0000 (UTC)
Subject: Re: [PATCH v7 33/47] mirror: Deal with filters
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-34-mreitz@redhat.com>
 <20200819165036.GH10272@linux.fritz.box>
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
Message-ID: <7d3e38bb-53ed-031a-9955-a3c23abe119d@redhat.com>
Date: Thu, 20 Aug 2020 12:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819165036.GH10272@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LOLFNF76Xeol2B55D6VqO7Odk8qKkVUpc"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LOLFNF76Xeol2B55D6VqO7Odk8qKkVUpc
Content-Type: multipart/mixed; boundary="4nUboUfEMwZgc28dILjFhKltp0Zy5KEuv"

--4nUboUfEMwZgc28dILjFhKltp0Zy5KEuv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 18:50, Kevin Wolf wrote:
> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
>> This includes some permission limiting (for example, we only need to
>> take the RESIZE permission for active commits where the base is smaller
>> than the top).
>>
>> Use this opportunity to rename qmp_drive_mirror()'s "source" BDS to
>> "target_backing_bs", because that is what it really refers to.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> @@ -1682,6 +1721,7 @@ static BlockJob *mirror_start_job(
>>      s->zero_target =3D zero_target;
>>      s->copy_mode =3D copy_mode;
>>      s->base =3D base;
>> +    s->base_overlay =3D bdrv_find_overlay(bs, base);
>>      s->granularity =3D granularity;
>>      s->buf_size =3D ROUND_UP(buf_size, granularity);
>>      s->unmap =3D unmap;
>=20
> Is this valid without freezing the links between base_overlay and base?

Er...

> Actually, I guess we should freeze everything between bs and base (for
> base !=3D NULL) and it's a preexisting problem that just happens to affec=
t
> this code, too.

Yes, that=E2=80=99s how it looks to me, too.  I don=E2=80=99t think that ha=
s anything to
do with this patch.

> Or maybe freezing everything is too much. We only want to make sure that
> no non-filter is inserted between base and base_overlay and that base
> (and now base_overlay) always stay in the backing chain of bs. But what
> options apart from freezing do we have to achieve this?

I don=E2=80=99t know of any, and I don=E2=80=99t know whether anyone would =
actually care
if we were to just freeze everything.

> Why is using base_overlay even better than using base? Assuming there is
> a good reason, maybe the commit message could spell it out.

The problem is that querying the block status for a filter node falls
through to the underlying data-carrying node.  So if there=E2=80=99s a filt=
er on
top of @base, and we query for is_allocated_above above @base, then
we=E2=80=99ll include @base, which we do not want.

Max


--4nUboUfEMwZgc28dILjFhKltp0Zy5KEuv--

--LOLFNF76Xeol2B55D6VqO7Odk8qKkVUpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8+UEgACgkQ9AfbAGHV
z0AM8gf9EPZYl1O3apy5u4GXs3N12w/rgN/MQkTs/47undbDcDIfbXCUxdWRmVw+
6/ijEbn+zkGAV3qNJOWb2rfPuijcL7e22Wvuq5G+BUkck/Cxro3u5cboqID4MDh7
zLtBqkm62usEe0oML3L5d2cRn84PYQc4Uvj3jA8ld6d7fFIiVgGv14ALKHoFE2Q2
Kol16dxBo+62rehctfxkUYeLLpE6P/oLVJr9ni5Y13al3x5z/YzGwxBsptiN4Qtl
2vyeLNtkXXoc7m49NXqgJ+4crfj6IGU4A++diPMsV0KMOnCfrm+27FZS1vw9jgCn
z04HxMQzxQwhdNR6m9TjQDAv70t2KA==
=Y0HL
-----END PGP SIGNATURE-----

--LOLFNF76Xeol2B55D6VqO7Odk8qKkVUpc--


