Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E82078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xoo6tU0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10E82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACNC-0001sG-0p
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kACMY-000137-6b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:18:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kACMV-0001PF-JB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598275090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8KWWzJ2IRrnan7oHt6UvGUe4mSmBcXYmvo8tala+JTI=;
 b=Xoo6tU0z7qpisQeyTChq6kwo/Gyqpiub7UZyC+L22Er7T232llPrYc+b8+TOyQsbVKL8n7
 bGH8R6gK1S/H0ME4aJZhrTJVcqSQFofI5mI7w+OMfGNLD2BYdiOt8dLISveAErSXr4M6PV
 Nyu6up/ROH9JwS0F2hLuo+bw+e1KTxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Cy6mvKjuNkCrVUBNUD4nWg-1; Mon, 24 Aug 2020 09:18:07 -0400
X-MC-Unique: Cy6mvKjuNkCrVUBNUD4nWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 372381007467;
 Mon, 24 Aug 2020 13:18:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-171.ams2.redhat.com
 [10.36.112.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A5625C1BB;
 Mon, 24 Aug 2020 13:18:04 +0000 (UTC)
Subject: Re: [PATCH v7 39/47] blockdev: Fix active commit choice
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-40-mreitz@redhat.com>
 <20200821155011.GA26691@linux.fritz.box>
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
Message-ID: <74e6ed51-d610-0982-d265-c8168b5f958c@redhat.com>
Date: Mon, 24 Aug 2020 15:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821155011.GA26691@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6bPttTW4CRmcunA8XXWzx4vFSntxXZaPi"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6bPttTW4CRmcunA8XXWzx4vFSntxXZaPi
Content-Type: multipart/mixed; boundary="cNm6mZyCkAqry7jIodTMJbYbomAV4Jg9K"

--cNm6mZyCkAqry7jIodTMJbYbomAV4Jg9K
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.20 17:50, Kevin Wolf wrote:
> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
>> We have to perform an active commit whenever the top node has a parent
>> that has taken the WRITE permission on it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  blockdev.c | 24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 402f1d1df1..237fffbe53 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2589,6 +2589,7 @@ void qmp_block_commit(bool has_job_id, const char =
*job_id, const char *device,
>>      AioContext *aio_context;
>>      Error *local_err =3D NULL;
>>      int job_flags =3D JOB_DEFAULT;
>> +    uint64_t top_perm, top_shared;
>> =20
>>      if (!has_speed) {
>>          speed =3D 0;
>> @@ -2704,14 +2705,31 @@ void qmp_block_commit(bool has_job_id, const cha=
r *job_id, const char *device,
>>          goto out;
>>      }
>> =20
>> -    if (top_bs =3D=3D bs) {
>> +    /*
>> +     * Active commit is required if and only if someone has taken a
>> +     * WRITE permission on the top node.
>=20
> ...or if someone wants to take a WRITE permission while the job is
> running.
>=20
> Future intentions of the user is something that we can't know, so maybe
> this should become an option in the future (not in this series, of
> course).
>=20
>>                                            Historically, we have always
>> +     * used active commit for top nodes, so continue that practice.
>> +     * (Active commit is never really wrong.)
>> +     */
>=20
> Changing the practice would break compatibility with clients that start
> an active commit job and then attach it to a read-write device, so we
> must continue the practice. I think the comment should be clearer about
> this, it sounds more like "no reason, but why not".

I think that=E2=80=99s what I meant by =E2=80=9Chistorically=E2=80=9D.  Is =
=E2=80=9Clegacily=E2=80=9D a word?

But sure, I can make it more explicit.

> This is even more problematic because the commit job doesn't unshare
> BLK_PERM_WRITE yet, so it would lead to silent corruption rather than an
> error.
>=20
>> +    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
>> +    if (top_perm & BLK_PERM_WRITE ||
>> +        bdrv_skip_filters(top_bs) =3D=3D bdrv_skip_filters(bs))
>> +    {
>>          if (has_backing_file) {
>>              error_setg(errp, "'backing-file' specified,"
>>                               " but 'top' is the active layer");
>=20
> Hm, this error message isn't accurate any more.
>=20
> In fact, the implementation isn't consistent with the QAPI documentation
> any more, because backing-file is only an error for the top level.

Hm.  I wanted to agree, and then I wanted to come up with a QAPI
documentation that fits the new behavior (because I think it makes more
sense to change the QAPI documentation along with the behavior change,
rather than to force us to allow backing-file for anything that isn=E2=80=
=99t on
the top layer).

But in the process of coming up with a better description, I noticed
that this doesn=E2=80=99t say =E2=80=9Cis a root node=E2=80=9D, it says =E2=
=80=9Cis the active layer=E2=80=9D.
I would say a node in the active layer is a node that has some parent
that has taken a WRITE permission on it.  So actually I think that the
documentation is right, and this code only now fits.

Though I do think this wants for some clarification.  Perhaps =E2=80=9CIf '=
top'
is the active layer (i.e., is a node that may be written to), specifying
a backing [...]=E2=80=9D?

There=E2=80=99s more wrong with the specification, namely the whole part un=
der
@backing-file past the =E2=80=9C(Since 2.1)=E2=80=9D, starting with =E2=80=
=9CIf top =3D=3D base=E2=80=9D.  I
think all of that should go to the top level.  (And =E2=80=9CIf top =3D=3D =
active=E2=80=9D
should be changed to =E2=80=9CIf top is active (i.e., may be written to)=E2=
=80=9D.)

Max


--cNm6mZyCkAqry7jIodTMJbYbomAV4Jg9K--

--6bPttTW4CRmcunA8XXWzx4vFSntxXZaPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9DvgoACgkQ9AfbAGHV
z0CGAQf/Z0rnSpFprpGfDXSqD3cx5tTDX4ZvP/Stqz3lA8ATICq/OH+jYBM5xmbJ
/tgiYp8oCPd+ttvRFdF2YbINOAXucRXlnHmxN0CF5GgTWLBbeyqBqrKpiooiSCEB
8S2WgSMq00Cm/lYUqCbG3pBd4v9x3iSNRnpqs2Zqlhw/Lm26omuKXehCImEkevQu
XltJW033yL3aHBEXnVr7uDOfHVRKMq1eml2AHXq4eFzfKbDoy3X2VCxRxOsYG3jE
w8zux8k7Aa8Cax/CfiHhua0vqyodXcLm1WdzAg+RTk5YZBqcHg9C7ChQE+zRNZKK
yvnMdQMVg3UzjPNtryBIjl5a0kaStA==
=3mH4
-----END PGP SIGNATURE-----

--6bPttTW4CRmcunA8XXWzx4vFSntxXZaPi--


