Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D0FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8261320716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBaF9EqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOjL-00031l-P4
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnOgQ-0000ah-LY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:48:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnOgM-0005CW-PD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d57/k2JCwPxn1stBr0kvmNsgwhh1ecHpLdF357Nu6o4=;
 b=QBaF9EqN9i6tepbGfCH4RI5Y3nkZMKRw0t+4oQICtxymn4O7n07JLzHWNy+CcGj6ppbrhZ
 GWwXVXwqcqNhJnCRNxPDCXVRn1PpyQ7CBVlQINvPthzvpsYUlfA1BE5QjkKhfj5F3PPGb7
 GIxiJrKJ9gwrTNDldTpp0ZTFOAkcKxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-RPud_qyQO0OQz9zV0HtmaQ-1; Mon, 22 Jun 2020 11:48:19 -0400
X-MC-Unique: RPud_qyQO0OQz9zV0HtmaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD028005AD;
 Mon, 22 Jun 2020 15:48:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-85.ams2.redhat.com
 [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDECA6FDD1;
 Mon, 22 Jun 2020 15:48:15 +0000 (UTC)
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
To: Nir Soffer <nsoffer@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
 <w51eeqb9f43.fsf@maestria.local.igalia.com>
 <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
 <w51r1u788gg.fsf@maestria.local.igalia.com>
 <2d35fdff-6230-18b9-cf99-ca72be53267f@redhat.com>
 <CAMRbyytkKjdAqH0hFiiAUEv7NeA9beC5CXx9LmBBSJd0r=5qQA@mail.gmail.com>
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
Message-ID: <3b4353d4-cbf1-df89-7f5f-1a1454cfe174@redhat.com>
Date: Mon, 22 Jun 2020 17:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytkKjdAqH0hFiiAUEv7NeA9beC5CXx9LmBBSJd0r=5qQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h80jyoe7vcqva2Bashz0CytxRRbcXEp03"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h80jyoe7vcqva2Bashz0CytxRRbcXEp03
Content-Type: multipart/mixed; boundary="ySLDnbZaK4JkW03nut6kObhS5qIYc3NkH"

--ySLDnbZaK4JkW03nut6kObhS5qIYc3NkH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.06.20 17:15, Nir Soffer wrote:
> On Mon, Jun 22, 2020 at 6:07 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 22.06.20 16:46, Alberto Garcia wrote:
>>> On Mon 22 Jun 2020 11:35:59 AM CEST, Max Reitz wrote:
>>>>>> +    if (qcow2_opts->data_file_raw &&
>>>>>> +        qcow2_opts->preallocation =3D=3D PREALLOC_MODE_OFF)
>>>>>> +    {
>>>>>> +        /*
>>>>>> +         * data-file-raw means that "the external data file can be
>>>>>> +         * read as a consistent standalone raw image without lookin=
g
>>>>>> +         * at the qcow2 metadata."  It does not say that the metada=
ta
>>>>>> +         * must be ignored, though (and the qcow2 driver in fact do=
es
>>>>>> +         * not ignore it), so the L1/L2 tables must be present and
>>>>>> +         * give a 1:1 mapping, so you get the same result regardles=
s
>>>>>> +         * of whether you look at the metadata or whether you ignor=
e
>>>>>> +         * it.
>>>>>> +         */
>>>>>> +        qcow2_opts->preallocation =3D PREALLOC_MODE_METADATA;
>>>>>
>>>>> I'm not convinced by this,
>>>>
>>>> Why not?
>>>>
>>>> This is how I read the spec.  Furthermore, I see two problems that we
>>>> have right now that are fixed by this patch (namely (1) using a device
>>>> file as the external data file, which may have non-zero data at
>>>> creation; and (2) assigning a backing file at runtime must not show
>>>> the data).
>>>
>>> What happens if you first create the image (which would be preallocated
>>> with this patch), then you resize it and finally you assign the backing
>>> file? Would the resized part be preallocated?
>>
>> Good point, when resizing an image with data-file-raw we also need to
>> preallocate the L2 tables.
>>
>>>>> but your comment made me think of another possible alternative: in
>>>>> qcow2_get_cluster_offset(), if the cluster is unallocated and we are
>>>>> using a raw data file then we return _ZERO_PLAIN:
>>>>>
>>>>> --- a/block/qcow2-cluster.c
>>>>> +++ b/block/qcow2-cluster.c
>>>>> @@ -654,6 +654,10 @@ out:
>>>>>      assert(bytes_available - offset_in_cluster <=3D UINT_MAX);
>>>>>      *bytes =3D bytes_available - offset_in_cluster;
>>>>>
>>>>> +    if (type =3D=3D QCOW2_CLUSTER_UNALLOCATED && data_file_is_raw(bs=
)) {
>>>>> +        type =3D QCOW2_CLUSTER_ZERO_PLAIN;
>>>>> +    }
>>>>> +
>>>>>      return type;
>>>>>
>>>>> You could even add a '&& bs->backing' to the condition and emit a
>>>>> warning to make it more explicit.
>>>>
>>>> No, this is wrong.  This still wouldn=E2=80=99t fix the problem of hav=
ing a
>>>> device file as the external data file, when it already has non-zero
>>>> data during creation.  (Reading the qcow2 file would return zeroes,
>>>> but reading the device would not.)
>>>
>>> But you wouldn't fix that preallocating the metadata either, you would
>>> need to fill the device with zeroes.
>>
>> What it fixes is that reading the qcow2 image and the raw device returns
>> the same data.
>>
>> Initially, I also thought that we should initialize raw data files to be
>> zero during creation, but Eric changed my mind:
>>
>> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00223.html
>>
>>>> I interpret the spec in that the metadata can be ignored, but it does
>>>> not need to be ignored.  So the L1/L2 tables must be 1:1 mapping of
>>>> QCOW2_CLUSTER_NORMAL entries.
>>>>
>>>> We could also choose to interpret it as =E2=80=9CWith data-file-raw, t=
he L1/L2
>>>> tables must be ignored=E2=80=9D.  In that case, our qcow2 driver would=
 need to
>>>> be modified to indeed fully ignore the L1/L2 tables with
>>>> data-file-raw.  (I certainly don=E2=80=99t interpret the spec this way=
, but I
>>>> suppose we could call it a bug fix and amend it.)
>>>
>>> The way I interpret it is that regardless of whether you read the data
>>> through the qcow2 file or directly from the data file you should get th=
e
>>> same results, but how that should be reflected in the L1/L2 metadata is
>>> not specified.
>>
>> That=E2=80=99s an absolute given, but the question is what does =E2=80=
=9Creading through
>> the qcow2 file=E2=80=9D mean.  Respecting the metadata?  Ignoring it?  S=
omething
>> in between?
>>
>> As I noted in my reply to myself, data-file-raw is an autoclear flag.
>> That means, an old version of qemu that doesn=E2=80=99t recognize the fl=
ag must
>> read the same data as a new version.  It follows that the the L2 tables
>> must be a 1:1 mapping.  (Or the flag can=E2=80=99t be an autoclear flag.=
)
>=20
> Being able to read sounds like a nice to have feature, but what about wri=
ting?
>=20
> I hope that the image is not writable by older versions that do not under=
stand
> data_file. Otherwise older qemu versions can corrupt the image silently.

It=E2=80=99s an autoclear flag.  That means such versions of qemu will
automatically clear the flag.

(To elaborate, there are three kinds of flags for qcow2 images:
Incompatible flags, compatible flags, and autoclear flags.

When qemu encounters an image with an unknown incompatible flag, it
refuses to open the image.

When it encounters an unknown compatible flag, it just ignores that flag
(but keeps it set).

When it encounters an unknown autoclear flag, it will clear that flag
and then continue as if it hadn=E2=80=99t been present.

So autoclear flags are useful for features that are optional, but that
may be broken when the image is written to by versions of qemu that
don=E2=80=99t understand them.)

Max


--ySLDnbZaK4JkW03nut6kObhS5qIYc3NkH--

--h80jyoe7vcqva2Bashz0CytxRRbcXEp03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7w0r4ACgkQ9AfbAGHV
z0C57Af/U1ZMQ2EDE0VMI1yhgSUU3msYdX7tHcFovYZq4CFVRcN3qopxQlpOsWMV
ikohmSAh1ZQ8UzsC++DTgJyUlhZR2b4QSF5mDDadpbc6Ns7JOXpzRRJBz0Tgx4NF
qf6K9lKzhisdWvy1rXCLfTV45avqZ+GhtiaSrG8g7TuWoS5NYZMkY9cKomrAjN/Y
WOoyIqOlacKY6R+V+A5E259t7BizjaRBoHyAwAUkAaOSEoFQhamPgOghsfUEV56F
OsOoHj256fVWjnFTvfHEKGCp2uRt+i0O4chiV/ttmk9KfZo0ulGIBh+4oh8qLRg7
aPyOwx5/ftKX4L7tTP+lGt57seQhOA==
=Nudi
-----END PGP SIGNATURE-----

--h80jyoe7vcqva2Bashz0CytxRRbcXEp03--


