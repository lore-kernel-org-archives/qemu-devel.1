Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2085C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3E420716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yv+WjWvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3E420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmgu-0007Z5-Pn
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDmfj-0005iv-JD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:40:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34788
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDmfg-0002EX-Cm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599129647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AVjKIbH5Tx3TFpZlmExPpUPrwyjnzOuR4DT+6UtJodo=;
 b=Yv+WjWvdFDAUX6Arq96wqy1RHPhIJexFGZ9Z3Ohaypk4xWy4AC++kznQAbbj/vTrdC8VHr
 p2LkwHGhiqZgnEmWPYbCLe7p8Lbr1FAA2bakMoLNAAJyaH6DeM1QKXR/rHTeP2CdCMhSNs
 Af2c/1Ob522Bn3/OvPzVBLVM7G+OpzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-MVPmGNlINQC-UQ7zam9whQ-1; Thu, 03 Sep 2020 06:40:45 -0400
X-MC-Unique: MVPmGNlINQC-UQ7zam9whQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E8018B9EC9;
 Thu,  3 Sep 2020 10:40:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-164.ams2.redhat.com
 [10.36.112.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 504AE5C1C2;
 Thu,  3 Sep 2020 10:40:42 +0000 (UTC)
Subject: Re: [PATCH] ide:do nothing for identify cmd if no any device attached
To: John Snow <jsnow@redhat.com>, zhaoxinRockCuioc <RockCui-oc@zhaoxin.com>,
 qemu-devel@nongnu.org
References: <20200817033803.14014-1-RockCui-oc@zhaoxin.com>
 <8dbcc856-879a-af83-1a76-a2a875da3699@redhat.com>
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
Message-ID: <0347935f-5235-3c61-07cc-fb4435ec45d1@redhat.com>
Date: Thu, 3 Sep 2020 12:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8dbcc856-879a-af83-1a76-a2a875da3699@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uUPrLNEehz82986JMsMNQqYLqiTWEDOF6"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, CobeChen@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUPrLNEehz82986JMsMNQqYLqiTWEDOF6
Content-Type: multipart/mixed; boundary="nTVMSTYdp7SrYTXMzLlE0gQIgjYEOl8fR"

--nTVMSTYdp7SrYTXMzLlE0gQIgjYEOl8fR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.09.20 20:02, John Snow wrote:
> (CC Max for block backend model confusion, see below)
>=20
> On 8/16/20 11:38 PM, zhaoxin\RockCuioc wrote:
>> This patch is for avoiding win7 IDE driver polling 0x1f7 when
>> no any device attached. During Win7 VM boot procedure, if use virtio for
>> disk and there is no any device be attached on hda & hdb, the win7 IDE
>> driver
>> would poll 0x1f7 for a while. This action may be stop windows LOGO
>> atomic for
>> a while too on a poor performance CPU.
>>
>=20
> A few questions:
>=20
> (1) How slow is the probing?
>=20
> (2) If there are no devices attached, why don't you remove the IDE
> controller so that Windows doesn't have to probe it?
>=20
>> Signed-off-by: zhaoxin\RockCuioc <RockCui-oc@zhaoxin.com>
>> ---
>> =C2=A0 hw/ide/core.c | 5 +++--
>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index d997a78e47..26d86f4b40 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -2073,8 +2073,9 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D idebus_active_if(bus);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_ide_exec_cmd(bus, s, val);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* ignore commands to non existent slave */
>> -=C2=A0=C2=A0=C2=A0 if (s !=3D bus->ifs && !s->blk) {

(Was the first one basically meant to be =E2=80=9Cs !=3D &bus->ifs[0]=E2=80=
=9D, i.e. to
check that this doesn=E2=80=99t go to the ma^W primary?  Not too obvious.)

>> +=C2=A0=C2=A0=C2=A0 /* ignore commands if no any device exist or non exi=
stent slave */
>> +=C2=A0=C2=A0=C2=A0 if ((!bus->ifs[0].blk && !bus->ifs[1].blk) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s !=3D bus->ifs && !s->blk)=
) {

(Maybe this could be improved here)

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=20
>=20
> I think it's the case that Empty CD-ROM drives will have an anonymous
> block backend representing the empty drive,

(As far as I remember,) yes.

(ide_dev_initfn() ensures all CD drives have one, even if it=E2=80=99s empt=
y.)

> so I suppose this is maybe
> fine?
>=20
> I suppose the idea is that with no drives on the bus that it's fine to
> ignore the register writes, as there are no devices to record those write=
s.
>=20
> (But then, why did we ever only check device1? ...)
>=20
> Maybe before the block-backend split we used to have to check to see if
> we had attached media or not, but I think nowadays we should always have
> a blk pointer if we have a device model intended to be operating at this
> address.

The check in ide_dev_initfn() looks that way to me.

> So I guess it can be simplified ...?
>=20
> if (!s->blk) {
> =C2=A0=C2=A0=C2=A0 return;
> }

Probably.  Although there=E2=80=99s a difference, of course, namely if you =
have
only a secondary device and try to access the primary, this simplified
version will be a no-op, whereas the more complicated version in this
patch would still go on.  I don=E2=80=99t know how real hardware would hand=
le
that case.  Is it even possible to have just a secondary with no primary?

Max


--nTVMSTYdp7SrYTXMzLlE0gQIgjYEOl8fR--

--uUPrLNEehz82986JMsMNQqYLqiTWEDOF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9QyCgACgkQ9AfbAGHV
z0C3XggAtgyq6zDwuoikoW7/n2TAkAahSdhWWCUxi3Z3oh4jREuK4LDImb05HnTf
/0JYYqb+IAL1O+BKbaXCzb15J0MNThl3TgeCHjoxrKrFAlWDe0aukx12zXS9H2+0
NgBFo2OpQW5msjnyjTT8oD9Lur2QgSPPBfF5OnCCsgVJChzg8ANWrECImXPFmAY7
OD8M6+MKLIa4941Vse+Zk2CbzIHiGdUxpKmFf15V2q+rgbrLclvCZfdq9F3BKMRI
073gmsbRpiaRbIwWk7XO8ZAO/TNDMYswhXtBIOYGsaQK4fWBzdbHnCaTrZoXSD0u
kR8ML+Pj58DU6xzwW3UFIdq0IxLcAQ==
=dRiq
-----END PGP SIGNATURE-----

--uUPrLNEehz82986JMsMNQqYLqiTWEDOF6--


