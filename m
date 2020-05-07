Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FC0C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1270D2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCtklF/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1270D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcJL-0004Mr-8r
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcDg-0002zn-9w
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:49:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcDf-0007Ny-6d
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588841366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TEBDyPZg+tWEo8hM9o2TLwMBbs4f3EjolsavhpT8kMI=;
 b=jCtklF/0s4kKJl/Lp74ria+VeoczemD0+dIpkZ8/qokAtVBxeMyzvfCV1XFfJD0zQv25TC
 Li1phhCkTX3eAKQM2LoAguvg5Osbuy8eoBgYo8jFPc2DLZggZ1RKHiYmUMSe1R5449ozu2
 HDR6iAUi8g0HO36SU9evcFJiabNA11k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-7k8xdBYiM_edQs4p2x4iJQ-1; Thu, 07 May 2020 04:49:22 -0400
X-MC-Unique: 7k8xdBYiM_edQs4p2x4iJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E01464;
 Thu,  7 May 2020 08:49:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF5462952;
 Thu,  7 May 2020 08:49:19 +0000 (UTC)
Subject: Re: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-10-mreitz@redhat.com>
 <20200506103722.GB6333@linux.fritz.box>
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
Message-ID: <7d226c94-2f14-eddb-b795-f8a961023947@redhat.com>
Date: Thu, 7 May 2020 10:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506103722.GB6333@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XJL9UXjnNVfCqg5hRGcUPHHgUkIN9dfsM"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XJL9UXjnNVfCqg5hRGcUPHHgUkIN9dfsM
Content-Type: multipart/mixed; boundary="fRBdyO9iKXoZZYyzxABrzEY8HlCWT20IL"

--fRBdyO9iKXoZZYyzxABrzEY8HlCWT20IL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.20 12:37, Kevin Wolf wrote:
> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
>> After the series this patch belongs to, we want to have a common
>> BdrvChildClass that encompasses all of child_file, child_format, and
>> child_backing.  Such a single class needs a single .inherit_options()
>> implementation, and this patch introduces it.
>>
>> The next patch will show how the existing implementations can fall back
>> to it just by passing appropriate BdrvChildRole and parent_is_format
>> values.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index c33f0e9b42..9179b9b604 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -998,6 +998,90 @@ static void bdrv_temp_snapshot_options(int *child_f=
lags, QDict *child_options,
>>      *child_flags &=3D ~BDRV_O_NATIVE_AIO;
>>  }
>> =20
>> +/*
>> + * Returns the options and flags that a generic child of a BDS should
>> + * get, based on the given options and flags for the parent BDS.
>> + */
>> +static void __attribute__((unused))
>> +    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
>> +                           int *child_flags, QDict *child_options,
>> +                           int parent_flags, QDict *parent_options)
>> +{
>> +    int flags =3D parent_flags;
>> +
>> +    /*
>> +     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
>> +     * Generally, the question to answer is: Should this child be
>> +     * format-probed by default?
>> +     */
>> +
>> +    /*
>> +     * Pure and non-filtered data children of non-format nodes should
>> +     * be probed by default (even when the node itself has BDRV_O_PROTO=
COL
>> +     * set).  This only affects a very limited set of drivers (namely
>> +     * quorum and blkverify when this comment was written).
>> +     * Force-clear BDRV_O_PROTOCOL then.
>> +     */
>> +    if (!parent_is_format &&
>> +        (role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
>> +                 BDRV_CHILD_FILTERED)) =3D=3D
>> +            BDRV_CHILD_DATA)
>=20
> You could avoid the odd indentation (I can't decide whether or not it
> should be one space more to align correctly) and probably also make the
> expression more readable if you split it into:
>=20
>     (role & BDRV_CHILD_DATA) &&
>     !(role & (BDRV_CHILD_METADATA | BDRV_CHILD_FILTERED))

Yes, looks good.

>> +    {
>> +        flags &=3D ~BDRV_O_PROTOCOL;
>> +    }
>> +
>> +    /*
>> +     * All children of format nodes (except for COW children) and all
>> +     * metadata children in general should never be format-probed.
>> +     * Force-set BDRV_O_PROTOCOL then.
>> +     */
>> +    if ((parent_is_format && !(role & BDRV_CHILD_COW)) ||
>> +        (role & BDRV_CHILD_METADATA))
>> +    {
>> +        flags |=3D BDRV_O_PROTOCOL;
>> +    }
>> +
>> +    /*
>> +     * If the cache mode isn't explicitly set, inherit direct and no-fl=
ush from
>> +     * the parent.
>> +     */
>> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DI=
RECT);
>> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO=
_FLUSH);
>> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SH=
ARE);
>> +
>> +    if (role & BDRV_CHILD_COW) {
>> +        /* backing files are always opened read-only */
>=20
> Not "always", just by default.

OK.  I just copied the comment from bdrv_backing_options().

>> +        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
>> +        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "=
off");
>> +    } else {
>> +        /* Inherit the read-only option from the parent if it's not set=
 */
>> +        qdict_copy_default(child_options, parent_options, BDRV_OPT_READ=
_ONLY);
>> +        qdict_copy_default(child_options, parent_options,
>> +                           BDRV_OPT_AUTO_READ_ONLY);
>> +    }
>> +
>> +    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
>> +        /*
>> +         * Our format drivers take care to send flushes and respect
>> +         * unmap policy, so we can default to enable both on lower
>> +         * layers regardless of the corresponding parent options.
>> +         */
>> +        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap")=
;
>> +    }
>=20
> Why the restriction to format here? Don't we break "unmap" propagation
> through filters with this?

Right now (before this series), the behavior seems ambiguous, in that
for filters that use bs->file, it is set, but for those that use
bs->backing, it isn=E2=80=99t.

But I suspect the main reason for what I did is the way I interpreted
the comment (which before this series only mentions block drivers in
general, not specifically format drivers): It sounded to me as if the
block driver needed to respect the unmap policy, and I didn=E2=80=99t think
filters did that.  So it was my understanding that filter drivers would
just propagate discards and thus we couldn=E2=80=99t default-enable unmap o=
n
their children.

But I was wrong, the block driver doesn=E2=80=99t need to respect anything,
because bdrv_co_pdiscard() already does.

So I suppose it should indeed be enabled for all children, with the
comment changed to express that it isn=E2=80=99t any block driver that resp=
ects
unmap policy, but bdrv_co_pdiscard(), e.g.:

bdrv_co_pdiscard() respects unmap policy for the parent, so we can
default to enable it on lower layers regardless of the parent option.

> It would probably also be a good question why we don't propagate it to
> the backing file, but this is preexisting.

I suppose we should, although it=E2=80=99s irrelevant, so.  I suppose I=E2=
=80=99ll just
drop the parent_is_format, adjust the comment and that should be fine
for this series.

Max


--fRBdyO9iKXoZZYyzxABrzEY8HlCWT20IL--

--XJL9UXjnNVfCqg5hRGcUPHHgUkIN9dfsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6zy40ACgkQ9AfbAGHV
z0AoMwgAkxyDoRcFWFlAXMzWaTNajiievWxXB+BOMyNoyDdKlKZ0dkgnMZYUMyBF
sGe2zjRE/TagnZdm35kHsZpZ9tqVou8bbX9YzsxNKkz5lkRArdNjxfFctWQZ3o9h
U4PUKPz8s4N8OVy4XwySKAGAwQsZkz2Jw4ag0TnP+MhoEdqJ25MYWGT6C42cIncR
c6LV9YAtUNjjqeGHp45cfKS/UUf3PWzrBTsGz9C1cqQcq7zJqb0GCbAd5pzmOxQ4
xRbpoxkz7Rd4H74vA3f76cK+Y9Oxq01W6B4UQgKUN7X5vPtLPEwDOcNlslkcKx+/
x1Is+2LUXNnoa+lv7eKkPoptf2N/Qg==
=0Sj2
-----END PGP SIGNATURE-----

--XJL9UXjnNVfCqg5hRGcUPHHgUkIN9dfsM--


