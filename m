Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77945C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405C82072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWSRrnLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405C82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7f7J-0006W5-Ex
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7f6Q-0005yQ-9T
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:23:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7f6N-0005N1-9a
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597670582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=utYWB80ervxTZN+mXKuwEwDPhr1LGj/Q2DbNHSRn+R4=;
 b=PWSRrnLtVf00L8Acblm8XbTwS221eyjcGFX1pCs+1DX0YynLeoj2jtPJddySD1F9X5LJMf
 taHfzFBDqJ0jjh4kP4i2Lbsef1p4SrJpYXQ8KiCN1qk7lDknG5NqndRMjrChhwsunqR/YK
 huyOpNv4zeQ6XF4/01efV3/W7w2K2V0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-IAnF1V_eOWCNg8OuNl_2fQ-1; Mon, 17 Aug 2020 09:22:19 -0400
X-MC-Unique: IAnF1V_eOWCNg8OuNl_2fQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3FB0801ABB;
 Mon, 17 Aug 2020 13:22:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 950E3756AB;
 Mon, 17 Aug 2020 13:22:17 +0000 (UTC)
Subject: Re: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
To: Kevin Wolf <kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-8-kwolf@redhat.com>
 <2a6528d8-1792-ec1e-287b-a9b9e2f20eef@redhat.com>
 <20200817124951.GJ11402@linux.fritz.box>
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
Message-ID: <64b289c5-f65c-3227-6856-d0a2e57db606@redhat.com>
Date: Mon, 17 Aug 2020 15:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817124951.GJ11402@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ib8T8FpnTMXp3ysVbUvfG7Z4GtisW5MMV"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ib8T8FpnTMXp3ysVbUvfG7Z4GtisW5MMV
Content-Type: multipart/mixed; boundary="h9Osb9tMO9jfkEirPcBeGnqNXEzI4zyHT"

--h9Osb9tMO9jfkEirPcBeGnqNXEzI4zyHT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.20 14:49, Kevin Wolf wrote:
> Am 17.08.2020 um 13:41 hat Max Reitz geschrieben:
>> On 13.08.20 18:29, Kevin Wolf wrote:
>>> nbd-server-add tries to be convenient and adds two questionable
>>> features that we don't want to share in block-export-add, even for NBD
>>> exports:
>>>
>>> 1. When requesting a writable export of a read-only device, the export
>>>    is silently downgraded to read-only. This should be an error in the
>>>    context of block-export-add.
>>>
>>> 2. When using a BlockBackend name, unplugging the device from the guest
>>>    will automatically stop the NBD server, too. This may sometimes be
>>>    what you want, but it could also be very surprising. Let's keep
>>>    things explicit with block-export-add. If the user wants to stop the
>>>    export, they should tell us so.
>>>
>>> Move these things into the nbd-server-add QMP command handler so that
>>> they apply only there.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/block/nbd.h   |  3 ++-
>>>  block/export/export.c | 44 ++++++++++++++++++++++++++++++++++++++-----
>>>  blockdev-nbd.c        | 10 ++++------
>>>  nbd/server.c          | 19 ++++++++++++-------
>>>  qemu-nbd.c            |  3 +--
>>>  5 files changed, 58 insertions(+), 21 deletions(-)

[...]

>>> +    }
>>> +
>>> +    export =3D blk_exp_add(&export_opts, errp);
>>> +    if (!export) {
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * nbd-server-add removes the export when the named BlockBackend u=
sed for
>>> +     * @device goes away.
>>> +     */
>>> +    on_eject_blk =3D blk_by_name(arg->device);
>>> +    if (on_eject_blk) {
>>> +        nbd_export_set_on_eject_blk(export, on_eject_blk);
>>> +    }
>>>  }
>>
>> The longer it gets, the more I think maybe it should be in some NBD file
>> like blockdev-nbd.c after all.
>=20
> Fair enough. Though I think blockdev-nbd.c in the root directory is
> something that shouldn't even exist.

Absolutely.  But unless you (or someone=E2=84=A2 else) doesn=E2=80=99t do a=
nything about
it, we may as well continue to (ab)use it. O:)

Max


--h9Osb9tMO9jfkEirPcBeGnqNXEzI4zyHT--

--ib8T8FpnTMXp3ysVbUvfG7Z4GtisW5MMV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86hIgACgkQ9AfbAGHV
z0AXsgf/fdkdQHgdK3Qqz/LWgxboMxdYk1kvv+GyDfiz9tik+kNlZ2NUNaP1Ug2i
0rvkEjo8IflNxgGgfpV76XgqgqJyplQ0Nhok4aI/N9006bRGFhT+DCJ4WDsxcSOK
MiY4LyGnj235DR7WolM2vpTfijLksP1G7ZmD1DZMtFQ5OkXgUfFXQi9+D3FO85KC
tG3e321HVIKP4qRyd8i969FnvyYE0QAlZcdn5lLYYsipcKd+YvtMeWu773IvaZUE
4jd27a/98JNq1h/uZuO4Y3Xf4NaP7stpum74QplLUK4JryUOkKxtKurIPxKzEYaD
2l5zlDqNsMnWcGbUgUNeL0LW61zGWw==
=zTII
-----END PGP SIGNATURE-----

--ib8T8FpnTMXp3ysVbUvfG7Z4GtisW5MMV--


