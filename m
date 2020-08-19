Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E16DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB622063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRYjn6RG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB622063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QMc-0000aV-9B
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8QLu-00088h-1O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8QLs-0003fw-9d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597852211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nUmsalAnzI1XML5eaj+HO2B2SZzJl1fAMqi9DFj4cbA=;
 b=MRYjn6RGaGKZ4q/ifaDTjYDuL7l7L7DF291pTsPH/eb5pl9tZDctg5eGYUsYBFHl1vqX9i
 iooSSXRZRBhApVuMDDLGHd/wmOeTV/HK2DTk7PGvjCj9DBt3WswQ9e63tGgPnsyO1Wb9SA
 g+jikP+G7RcLJ3DKZofc9+7lqc6gh88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-TOJTdGLxOOuOoq6_KuNKHQ-1; Wed, 19 Aug 2020 11:50:08 -0400
X-MC-Unique: TOJTdGLxOOuOoq6_KuNKHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B608186A568;
 Wed, 19 Aug 2020 15:50:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-120.ams2.redhat.com
 [10.36.113.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E9F5C1A3;
 Wed, 19 Aug 2020 15:50:05 +0000 (UTC)
Subject: Re: [PATCH v7 27/47] blkverify: Use bdrv_sum_allocated_file_size()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-28-mreitz@redhat.com>
 <20200819104644.GA10272@linux.fritz.box>
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
Message-ID: <66b31c9c-1357-9761-bac9-2a13dbed4377@redhat.com>
Date: Wed, 19 Aug 2020 17:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819104644.GA10272@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rr3Myat0Ze4vvWePEhtby00bJ81s9Ci7A"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:57:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
--rr3Myat0Ze4vvWePEhtby00bJ81s9Ci7A
Content-Type: multipart/mixed; boundary="8TjxcsRbzHbIeHa2ZGebzZgXUOK2eXYsO"

--8TjxcsRbzHbIeHa2ZGebzZgXUOK2eXYsO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 12:46, Kevin Wolf wrote:
> Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
>> blkverify is a filter, so bdrv_get_allocated_file_size()'s default
>> implementation will return only the size of its filtered child.
>> However, because both of its children are disk images, it makes more
>> sense to sum both of their allocated sizes.
>=20
> Hm, but so are the children of, say, backup-top. I don't think you're
> suggesting that backup-top should add the sizes of both images,

Can be argued either way.

I lean on the side of that it should not, because: The backup is
external.  The job is copying data off.  So it isn=E2=80=99t really directl=
y
data that serves qemu, which can be seen from the fact that it=E2=80=99s ne=
ver read.

Which is not the case for quorum and blkverify.  Though one can argue
that blkverify is different from quorum here in that it doesn=E2=80=99t rea=
d
data from the non-filtered child to serve a guest device, but just to
verify it node-internally.

> even
> though the backup job is actively increasing the allocated size of the
> non-primary node, much like blkverify.
>=20
> So I believe returning only the allocated size of the primary child in
> blkverify would be more consistent with what we do elsewhere.

For me, blkverify is basically an archaic mode of quorum, and for quorum
it=E2=80=99s clear that we should sum the sizes.  Which is why I thought su=
mming
the sizes would be more consistent.

But honestly, I just don=E2=80=99t care about blkverify whatsoever.  I don=
=E2=80=99t
believe anyone actually cares about whether what blkverify returns for
.bdrv_get_allocated_file_size() is consistent.  I believe we could
return 42 and nobody would bat an eyelash.

(But that=E2=80=99s the curse of this series.  I have to touch stuff that n=
obody
cares about, and then we have discussions on stuff nobody cares about.)

So from that POV I=E2=80=99m happy to drop this patch if it means there=E2=
=80=99s just
one less opportunity to have a discussion on blkverify.

Max


--8TjxcsRbzHbIeHa2ZGebzZgXUOK2eXYsO--

--rr3Myat0Ze4vvWePEhtby00bJ81s9Ci7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl89SiwACgkQ9AfbAGHV
z0BbJgf8D3msur3CC3Zb6j789B6scmh876F/KcexY/nclflfhPe7lSecjG/ybr4J
UsPM02jT9KkItlWLUoaBC4/L3l7f8hDfMBynrgqWKrTjZaM92lx05LjJqUIL+tAb
PMkQvhDsghCsdUwKp7N2fWG8Ya4wn1vScalNZ7Ae62mtZA+Uj71XKsef5ADHNo+n
0XTUFUnabtwmCvAUSqWR3oRkQdQUZhnm8hMVGAQu4cozy6GrNNukGx+ZVRjgwpW7
8YapmrzKnXH7FwN+cDjNBo45iMi2A3GM6XfT6n8KflVVLBD/Hnuxr2lPek6Aq4WR
LH//GfWcurgTaAWaL7bVwJONZen4fQ==
=Hf2T
-----END PGP SIGNATURE-----

--rr3Myat0Ze4vvWePEhtby00bJ81s9Ci7A--


