Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C930FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9842221744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSAE7Rbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9842221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a4p-0003DI-Ph
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6Z7j-0000oc-QQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6Z7h-00005Y-Hu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:15:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6Z7h-0008WU-Cn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582632936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9zLbsx1t9tJ+pIqteDEZBHygCyCv84fcRk6cFMou4k4=;
 b=HSAE7RbdTuYLquDoZQ9I6vR6SNl46qBs/sLbTe7vrvcvwfy8nTY9+Qn14ohCudwJN3VNQw
 sEMDUUuLX18DE1ev5Si0uvLb0Eo9vdFkpDJJUw50xnUdHvVETIwuq8CAAiimZ0ScQo2E3H
 r4z9o+5bDwxd/i535/V+UYpJ7utD8vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-dyQUTe9UPMS_76_vaIVw_w-1; Tue, 25 Feb 2020 07:15:34 -0500
X-MC-Unique: dyQUTe9UPMS_76_vaIVw_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20FDC1007268;
 Tue, 25 Feb 2020 12:15:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F2D1001B09;
 Tue, 25 Feb 2020 12:15:30 +0000 (UTC)
Subject: Re: QAPI schema for desired state of LUKS keyslots (was: [PATCH
 02/13] qcrypto-luks: implement encryption key management)
To: Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
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
Message-ID: <ad92d470-7388-c419-f3fb-0bfd541b670b@redhat.com>
Date: Tue, 25 Feb 2020 13:15:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LJECeRsyP8Px3soF1mlvavszAPCKeG80c"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LJECeRsyP8Px3soF1mlvavszAPCKeG80c
Content-Type: multipart/mixed; boundary="QbcUzDY5PvrejcTPXyAFOFddpXpHcN5NM"

--QbcUzDY5PvrejcTPXyAFOFddpXpHcN5NM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.02.20 15:51, Markus Armbruster wrote:
> Review of this patch led to a lengthy QAPI schema design discussion.
> Let me try to condense it into a concrete proposal.
>=20
> This is about the QAPI schema, and therefore about QMP.  The
> human-friendly interface is out of scope.  Not because it's not
> important (it clearly is!), only because we need to *focus* to have a
> chance at success.
>=20
> I'm going to include a few design options.  I'll mark them "Option:".
>=20
> The proposed "amend" interface takes a specification of desired state,
> and figures out how to get from here to there by itself.  LUKS keyslots
> are one part of desired state.
>=20
> We commonly have eight LUKS keyslots.  Each keyslot is either active or
> inactive.  An active keyslot holds a secret.
>=20
> Goal: a QAPI type for specifying desired state of LUKS keyslots.
>=20
> Proposal:
>=20
>     { 'enum': 'LUKSKeyslotState',
>       'data': [ 'active', 'inactive' ] }
>=20
>     { 'struct': 'LUKSKeyslotActive',
>       'data': { 'secret': 'str',
>                 '*iter-time': 'int } }
>=20
>     { 'struct': 'LUKSKeyslotInactive',
>       'data': { '*old-secret': 'str' } }
>=20
>     { 'union': 'LUKSKeyslotAmend',
>       'base': { '*keyslot': 'int',
>                 'state': 'LUKSKeyslotState' }
>       'discriminator': 'state',
>       'data': { 'active': 'LUKSKeyslotActive',
>                 'inactive': 'LUKSKeyslotInactive' } }

Looks OK to me.  The only thing is that @old-secret kind of works as an
address, just like @keyslot, so it might also make sense to me to put
@keyslot/@old-secret into a union in the base structure.

(One of the problems that come to mind with that approach is that not
specifying either of @old-secret or @keyslot has different meanings for
activating/inactivating a keyslot: When activating it, it means =E2=80=9CTh=
e
first unused one=E2=80=9D; when deactivating it, it=E2=80=99s just an error=
 because it
doesn=E2=80=99t really mean anything.)

*shrug*

Max


--QbcUzDY5PvrejcTPXyAFOFddpXpHcN5NM--

--LJECeRsyP8Px3soF1mlvavszAPCKeG80c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5VD+EACgkQ9AfbAGHV
z0DvkAf9HDe11TywYs8WMrZ0TSYQLjN9vV6G1dEpM5q7zXdf+O+lLNSYd4vUXZWO
6tcnajZt0LoQvL1naLlqJan8mQDx4afrMJYqz5ThLcBRoNezASAcscVEP+19pmfI
cUg3i06w9Nvs03nntCRIhrhTl+tDKmoQ/JInNK+VCd23ZLZgJCbj6eO1Jaktpkde
V3hh1yMALvRmheJq7CC7BJbK5oeG6l/V2eX+BHndjQePHLPz5pxVtHjcqm+NhZ8u
loiptwPLtTkN2DuXxHeVK0KZWtur6OQoL8akfLOzg6w1lhOcpzhQcqGU3EOCt4Go
y7sxyKVXYaQbDv3256KU09UR1rCrfw==
=1fK3
-----END PGP SIGNATURE-----

--LJECeRsyP8Px3soF1mlvavszAPCKeG80c--


