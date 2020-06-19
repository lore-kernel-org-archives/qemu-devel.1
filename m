Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6A0207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiHJ631B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6A0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmBup-0000TR-Rc
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jmBu6-0007ur-F7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:57:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jmBu4-00077k-Mx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592553455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iUpKXL7nxt5mBmSOzmRLIkfYsjG182Bi7oPrRr98QJo=;
 b=EiHJ631B+367aFYf+d1EiuY/3G/CdmcVdabVjck0p6MgjfKRQRduw1OQ3pJHfZS7KYkMHP
 W/hUCHOIGJr3v8+BVmoul7jEEO0h7PBJwXqhZxfn3pbep1RAm/SbpRN277VTYzIyN2TZw9
 fDM1PX8WNCdeD7QkTMOZJlhEs6CMlOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-2MxpW4IDNkKGP31bepLijg-1; Fri, 19 Jun 2020 03:57:33 -0400
X-MC-Unique: 2MxpW4IDNkKGP31bepLijg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67DBF1005512;
 Fri, 19 Jun 2020 07:57:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-28.ams2.redhat.com
 [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ACAD10013C4;
 Fri, 19 Jun 2020 07:57:30 +0000 (UTC)
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200415190207.21118-1-berto@igalia.com>
 <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
 <w51r1uctwc2.fsf@maestria.local.igalia.com>
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
Message-ID: <80d5af9c-0b8b-472a-fba2-cace33be6053@redhat.com>
Date: Fri, 19 Jun 2020 09:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <w51r1uctwc2.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5jxoDAsnco8fPQZCHiW0NglSH6p27nGzu"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5jxoDAsnco8fPQZCHiW0NglSH6p27nGzu
Content-Type: multipart/mixed; boundary="33qzK0gy6wKKoJSDpZRMCRnASyY6hPqmu"

--33qzK0gy6wKKoJSDpZRMCRnASyY6hPqmu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.06.20 14:03, Alberto Garcia wrote:
> On Wed 03 Jun 2020 03:53:03 PM CEST, Max Reitz wrote:
>> Sorry for the long delay. :/
>=20
> And sorry for my long delay as well.
>=20
>> The patch itself looks good, but I=E2=80=99m not sure whether it is exte=
nsive
>> enough.  Let me just jump straight to the problem:
>>
>> $ ./qemu-img create -f qcow2 \
>>     -o data_file=3Dfoo.qcow2.raw,data_file_raw=3Don \
>>     foo.qcow2 64M
>> (Create some file empty foo.qcow2 with external data file that=E2=80=99s=
 raw)
>>
>> $ ./qemu-img create -f qcow2 backing.qcow2 64M
>> $ ./qemu-io -c 'write -P 42 0 64M' backing.qcow2
>> (Create some file filled with 42s)
>>
>> $ ./qemu-img compare foo.qcow2 foo.qcow2.raw
>> Images are identical.
>> (As expected, foo.qcow2 is identical to its raw data file)
>>
>> $ ./qemu-img compare --image-opts \
>>     file.filename=3Dfoo.qcow2,backing.file.filename=3Dbacking.qcow2 \
>>     file.filename=3Dfoo.qcow2.raw
>> Content mismatch at offset 0!
>> (Oops.)
>=20
> If two images have the same contents but then you compare them changing
> the backing file of one of them you can also get a content mismatch. How
> is this different?

It=E2=80=99s different in that files with data-file-raw can=E2=80=99t have =
backing files
at all.  So maybe users shouldn=E2=80=99t be allowed to give them backing f=
iles
at runtime either.

Or at least, if we have data-file-raw, *all* data visible on such an
image should be taken from the raw data file, never from any backing file.

> Regardless of how we should ideally handle bs->backing and data-file-raw
> (and yes I agree that it would be nice that QEMU would say "you cannot
> have a backing file and an external raw file" in all cases) I think that
> if the problem is that the user can override the backing file name and
> get different contents, then that's not a problem that we should be
> worried about.

Well, not really be worried about, but I do think it=E2=80=99s indicative o=
f
some problem, though I=E2=80=99m not sure whether the problem is error
reporting.  I think it=E2=80=99s rather the fact that data-file-raw should =
imply
metadata preallocation.

With preallocation, we=E2=80=99d ensure that we always take all data from t=
he
raw data file.  So we=E2=80=99d always ignore any potential backing file.

(It makes sense to guard users against giving images with data-file-raw
a backing file, and to consider such images corrupt, as done by this
patch.  But if users can force a backing file at runtime, I think
showing its contents is another bug.)

Max


--33qzK0gy6wKKoJSDpZRMCRnASyY6hPqmu--

--5jxoDAsnco8fPQZCHiW0NglSH6p27nGzu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7sb+gACgkQ9AfbAGHV
z0CSVwf9E6CIbYc7bH4zwTpIawNA8OlrWcTw0Lx8XIrpjVYqLFkxhPuHpW5fLcWB
vOpUOqV74142+Otp3UiNDUusKTksWHEEiqsG8QXx/N7NPGx72dQiQqbOdPCwOCPz
I9yD8xkQHINiaFv+r2tLtbCIdL9/3KwJ9i5P6al4CNxcAWuHI8C1hFwSx29vKgLK
1l1/T+/U2S2DV1Emv7B8EkmcLza6krSlB9mGSc7Qf6qYc8X2zuauGCrMYddtsl+C
M4CwU4CJFsdj/LMJ639DFGP9AJgZzjg3hTxuCU/qu4lRj6T6wTISrSM6iYjNEUPu
EbXw4tgaJcFrnh6amSJx8zfnAeN/nw==
=I/1F
-----END PGP SIGNATURE-----

--5jxoDAsnco8fPQZCHiW0NglSH6p27nGzu--


