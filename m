Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FDC20728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiFzwPrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FDC20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTkj-0005RG-AW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZTjc-0004Vm-BF
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:22:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZTjb-0007cP-51
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589523733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VjpB2W0CF+eu2sDtRkI3/KmwapnaPOv8w2oJvaNzREY=;
 b=PiFzwPrDXxr8F5wkBXM8eKreOm+H2FyQSYSrULAOWqPcLPn9BF471yquxIo+RyRhWxbFIX
 4KebNd+b0XCxMz2RMQb1xfjS1XMg9WWfQ9sFlFv93ix/swZ3DzVckvj5bRZF8gwybIposq
 ElO9lUtFCC0b5daLLoy5FiVx924Qi1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-akQCEyfUNHefGSmOrW2cLQ-1; Fri, 15 May 2020 02:22:11 -0400
X-MC-Unique: akQCEyfUNHefGSmOrW2cLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D78AF18FE863;
 Fri, 15 May 2020 06:22:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-247.ams2.redhat.com
 [10.36.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E172B4DC;
 Fri, 15 May 2020 06:22:06 +0000 (UTC)
Subject: Re: [PATCH v6 04/14] block/amend: separate amend and create options
 for qemu-img
To: Eric Blake <eblake@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-5-mlevitsk@redhat.com>
 <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
 <52231bba-4ef1-2e96-1e82-9e350a68b106@redhat.com>
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
Message-ID: <c93d9e92-94dc-9965-e291-2aef8724385a@redhat.com>
Date: Fri, 15 May 2020 08:22:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <52231bba-4ef1-2e96-1e82-9e350a68b106@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VsvC4RzEpK1hS193SWazQ26hKCw7WgzlW"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VsvC4RzEpK1hS193SWazQ26hKCw7WgzlW
Content-Type: multipart/mixed; boundary="Yd291Lm8q9bH6hsgAFayHnwFcIzLDbUXh"

--Yd291Lm8q9bH6hsgAFayHnwFcIzLDbUXh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.05.20 18:10, Eric Blake wrote:
> On 5/14/20 7:28 AM, Max Reitz wrote:
>> On 10.05.20 15:40, Maxim Levitsky wrote:
>>> Some options are only useful for creation
>>> (or hard to be amended, like cluster size for qcow2), while some other
>>> options are only useful for amend, like upcoming keyslot management
>>> options for luks
>>>
>=20
>>> =C2=A0 +#define QCOW_COMMON_OPTIONS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "Width of a refer=
ence count entry in bits",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .def_value_str =3D "16"=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
>>> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
>>
>> I think the last line should have a comma in it (otherwise the final
>> backslash doesn=E2=80=99t make much sense, because whenever we=E2=80=99d=
 add a new
>> option, we would need to modify the line anyway to insert a comma).
>=20
> Except that...
>=20
>>
>> Speaking of adding option, this requires a rebase due to the
>> compression_type option added (not trivial in the strict sense, but
>> still straightforward to handle).
>>
>>> +
>>> =C2=A0 static QemuOptsList qcow2_create_opts =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "qcow2-create-opts",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_=
create_opts.head),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc =3D {
>>>
>>
>> [...]
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW_COMMON_OPTIONS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of list */ }
>=20
> ...the intended usage is to use the macro name followed by a comma, so
> including a trailing comma in the macro itself would lead to a syntax
> error.

But why is that the indended usage?  Is there something in our coding
style that forbids macros that don=E2=80=99t allow a separator to be placed
after them?

Max


--Yd291Lm8q9bH6hsgAFayHnwFcIzLDbUXh--

--VsvC4RzEpK1hS193SWazQ26hKCw7WgzlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6+NQwACgkQ9AfbAGHV
z0BlpAf9H3NBGTr/aLqN2TmaX4ycLOsJEN+TRQhyc5pkCVFQIRr9L8ouqBBBGs05
nATktb5PVPi0/fOFOdG5ot16K+PR1ZXTWm50L1V0rKGloPBM2pccw7TTB+0q1hto
JMcMoJlQ173qOiqrG0JSpuaJDmRIADgXMMybfIHSrvmI7GHfldr9fy5LCo+NvRR7
JpUDrhSzvNWI6NnIVwFHkd7uX/H7jwayf6+Q3L5djpPjQWQuJ7qyXkKkzKDN7esI
3WWIRDXdclMl3+PPKp41dlhugzdzVGKzr1IhhsZZklUYYTtf56HF6TP62VYE7ZgY
WYt+SbWjyKelhNnhtQqF38HdFKqelg==
=Tds+
-----END PGP SIGNATURE-----

--VsvC4RzEpK1hS193SWazQ26hKCw7WgzlW--


