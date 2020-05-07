Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6252CC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA3F2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K75L/4Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA3F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcgQ-000515-61
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcfh-0004Vl-RW
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:18:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcff-0003JV-NA
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588843102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fwvIKQX7Hk3iKvKb/PmJD2U/E6d33PwChmGtacoy5kE=;
 b=K75L/4RpNg1aZpFau/pDJcSf5ubaCrML7uMoLS7yyi9whEaf8KI1iah1ixeT8GMXAmQbQg
 flKxzATfDrdMtQ5E2QtU0111UMu0+rxlsy581Tu/3XGQ6FzBfUQ/rvW0ZBI6p80JiTvu4i
 61+xcqBMlwDMObp/rQJUCF7u5iHI1lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-v4FzPjQeMpSJwIWi1M182g-1; Thu, 07 May 2020 05:18:20 -0400
X-MC-Unique: v4FzPjQeMpSJwIWi1M182g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B60F464;
 Thu,  7 May 2020 09:18:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C06563F61;
 Thu,  7 May 2020 09:18:17 +0000 (UTC)
Subject: Re: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-10-mreitz@redhat.com>
 <20200506103722.GB6333@linux.fritz.box>
 <20200506131135.GE6333@linux.fritz.box>
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
Message-ID: <7b7084ea-fb31-c994-cae0-f9a2c8438ae1@redhat.com>
Date: Thu, 7 May 2020 11:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506131135.GE6333@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C8K6OzaxsYUYFvqwL9X8KlzQo5MHDUzGA"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
--C8K6OzaxsYUYFvqwL9X8KlzQo5MHDUzGA
Content-Type: multipart/mixed; boundary="pkdazhM8xI4hMTMMG6UY1KDFbBPajJRP3"

--pkdazhM8xI4hMTMMG6UY1KDFbBPajJRP3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.20 15:11, Kevin Wolf wrote:
> Am 06.05.2020 um 12:37 hat Kevin Wolf geschrieben:
>> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
>>> After the series this patch belongs to, we want to have a common
>>> BdrvChildClass that encompasses all of child_file, child_format, and
>>> child_backing.  Such a single class needs a single .inherit_options()
>>> implementation, and this patch introduces it.
>>>
>>> The next patch will show how the existing implementations can fall back
>>> to it just by passing appropriate BdrvChildRole and parent_is_format
>>> values.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 84 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index c33f0e9b42..9179b9b604 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -998,6 +998,90 @@ static void bdrv_temp_snapshot_options(int *child_=
flags, QDict *child_options,
>>>      *child_flags &=3D ~BDRV_O_NATIVE_AIO;
>>>  }
>>> =20
>>> +/*
>>> + * Returns the options and flags that a generic child of a BDS should
>>> + * get, based on the given options and flags for the parent BDS.
>>> + */
>>> +static void __attribute__((unused))
>>> +    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
>>> +                           int *child_flags, QDict *child_options,
>>> +                           int parent_flags, QDict *parent_options)
>>> +{
>>> +    int flags =3D parent_flags;
>>> +
>>> +    /*
>>> +     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
>>> +     * Generally, the question to answer is: Should this child be
>>> +     * format-probed by default?
>>> +     */
>=20
> Just for clarity: Do you know a good reason to ever leave it (i.e.
> inherit it from the parent), except that that's what we have always been
> doing for backing files? Though of course, only formats have backing
> files, so the flag would never be set in practice in this case.

It seems correct for filters.

[...]

>>> +    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
>>> +        /*
>>> +         * Our format drivers take care to send flushes and respect
>>> +         * unmap policy, so we can default to enable both on lower
>>> +         * layers regardless of the corresponding parent options.
>>> +         */
>>> +        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap"=
);
>>> +    }
>>
>> Why the restriction to format here? Don't we break "unmap" propagation
>> through filters with this?
>>
>> It would probably also be a good question why we don't propagate it to
>> the backing file, but this is preexisting.
>=20
> Some patches later, I think the fix is an else branch that copies the
> flag from parent_options.

I thought about the same thing, but is that really necessary if
bdrv_co_pdiscard() will already suppress discards on the parent if unmap
is false?

Max


--pkdazhM8xI4hMTMMG6UY1KDFbBPajJRP3--

--C8K6OzaxsYUYFvqwL9X8KlzQo5MHDUzGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6z0lgACgkQ9AfbAGHV
z0A4oQf/Q8XeI41Qx7VzT77NFo0MyeALYc3vA1yB7tki4sxl0Knnog9A+iApSM24
f5dN0nEtF9oCh85MQ/NXTS6lZZdEIJkqY+IZi0ij5VwW2iZkXZ1zBdsLvPyQAWi1
qKSARkVEhCegvTadfIx2UNNaqvgmepYCz3FetNGE3X+xEpLKkAUT6tbzS4CCdgA8
hA2KyUaYV/nWRZ/+D/584ZP7n6HRybhI9wsS8ifXuXSlMSSyNmwkhayX65vreFpn
ms8xRpylh+5WBcqghHzCL5mpIGBCR9KponyeonaHFf2sgdb34jaIlWWghpa813uY
5nfjIW5Mq9l0tL3738QRKvgFi+slrw==
=pUap
-----END PGP SIGNATURE-----

--C8K6OzaxsYUYFvqwL9X8KlzQo5MHDUzGA--


