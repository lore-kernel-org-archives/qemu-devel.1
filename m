Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76657FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45577207FA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM1JZeS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45577207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52067 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1eH-00085k-Fs
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT1dV-0007Ne-WB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT1dU-00024l-QM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:37:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT1dU-00024f-Ld
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573209420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NUCF0gOFzYcIYEuEh8wognvumSisDImhYpj1UabNkYg=;
 b=UM1JZeS4jkU67tg2xms3lHe9cicrd0dfVMSx+VcOhkBWU+hmCTwoD3JqhuJgmsqk9No09H
 fqv9SiEpoR30EEKg67T9UWyw2Gtz/CUeRzJSifYXZNisCvnIj90jErq2BzCULAbVItEXQH
 xl67rMZigxWmMaIDlaA69jF9HQLbYOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-siSG2jQaNMqu5yGqv03opw-1; Fri, 08 Nov 2019 05:36:58 -0500
X-MC-Unique: siSG2jQaNMqu5yGqv03opw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3812F1005500;
 Fri,  8 Nov 2019 10:36:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 040D71001B39;
 Fri,  8 Nov 2019 10:36:52 +0000 (UTC)
Subject: Re: [PATCH v2 07/11] block: add x-blockdev-amend qmp command
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-8-mlevitsk@redhat.com>
 <931af700-bb9a-ae84-bd01-215560f66494@redhat.com>
 <268fd0b724a685b69e2d41067e34e403b68e244e.camel@redhat.com>
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
Message-ID: <4bcbb15d-4566-77a4-de0a-c9c3833543cc@redhat.com>
Date: Fri, 8 Nov 2019 11:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <268fd0b724a685b69e2d41067e34e403b68e244e.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XLDLhAErZrnyFdbOZaqxT4Pc6KdmRZ7yK"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XLDLhAErZrnyFdbOZaqxT4Pc6KdmRZ7yK
Content-Type: multipart/mixed; boundary="KvFK4vU0zgRG38OzNSlfJ9eIJRymfkB9S"

--KvFK4vU0zgRG38OzNSlfJ9eIJRymfkB9S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.19 10:26, Maxim Levitsky wrote:
> On Fri, 2019-10-04 at 20:53 +0200, Max Reitz wrote:
>> On 13.09.19 00:30, Maxim Levitsky wrote:
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>  block/Makefile.objs       |   2 +-
>>>  block/amend.c             | 116 ++++++++++++++++++++++++++++++++++++++
>>>  include/block/block_int.h |  23 ++++++--
>>>  qapi/block-core.json      |  26 +++++++++
>>>  qapi/job.json             |   4 +-
>>>  5 files changed, 163 insertions(+), 8 deletions(-)
>>>  create mode 100644 block/amend.c

[...]

>>> +static int coroutine_fn blockdev_amend_run(Job *job, Error **errp)
>>> +{
>>> +    BlockdevAmendJob *s =3D container_of(job, BlockdevAmendJob, common=
);
>>> +    int ret;
>>> +
>>> +    job_progress_set_remaining(&s->common, 1);
>>> +    ret =3D s->bs->drv->bdrv_co_amend(s->bs, s->opts, s->force, errp);
>>> +    job_progress_update(&s->common, 1);
>>
>> It would be nice if the amend job could make use of the progress
>> reporting that we have in place for amend.
>=20
> I also thought about it, but is it worth it?
>=20
> I looked through the status reporting of the qcow2 amend
> code (which doesn't really allowed to be run through
> qmp blockdev-amend, due to complexity of changing=20
> the qcow2 format on the fly).

True, and we could always add it later.

I suppose I was mostly wondering because bdrv_amend_options already has
all of that infrastructure and I was assuming that qcow2's bdrv_co_amend
implementation would make some use of the existing function.  Well, it
doesn=E2=80=99t, so *shrug*

[...]

>>> +    /*
>>> +     * Create the block job
>>> +     * TODO Running in the main context. Block drivers need to error o=
ut or add
>>> +     * locking when they use a BDS in a different AioContext.
>>
>> Why shouldn=E2=80=99t the job just run in the node=E2=80=99s context?
>=20
> This is shameless copy&pasta from the blockdev-create code
> (which I did note in the copyright of the file)
Well, you noted that it=E2=80=99s heavily based on it, not that it=E2=80=99=
s just C&P.

So I suppose the comment is just wrong here?

Max


--KvFK4vU0zgRG38OzNSlfJ9eIJRymfkB9S--

--XLDLhAErZrnyFdbOZaqxT4Pc6KdmRZ7yK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3FRUMACgkQ9AfbAGHV
z0DKoQf/TNnC5xpWzfG+afjkGbglCEV0FFg41Yqqe3gEzdicVlDBLxKa3O7nepEx
J29xpcFbXT26eioEMgXzFvpjJGEdielJnY5LEtnA46jLGV9D7ElzGrY8bCN0QJ+1
aNV4OKx7G84bfffDDV8FOQT1f/XEXh/UpgWSLFUMBlojy2uTwThk+htecWUTF3WX
RoTTIju8SdlcIjPPTIB0qX3NAjHNnYQ6YDbepICZWvzBLugAmsZL+u3IK5sB/j1D
YmpUtX2Ex8RiZXwyf64cT14HCeGmwtHgMnfrsrwP3Ja2fQ+Akamv1GY81Pb+NeAv
eQ/tF8rLKFVWzG7O4F4pQmY84Nw18Q==
=Ctdm
-----END PGP SIGNATURE-----

--XLDLhAErZrnyFdbOZaqxT4Pc6KdmRZ7yK--


