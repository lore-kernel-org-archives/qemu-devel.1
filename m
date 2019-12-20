Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21082C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDA32467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQNtpXt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDA32467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFNX-0006pR-Vx
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiFMe-0005jU-Jf
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiFMb-00029v-Ju
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:18:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiFMb-00025i-5h
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576837108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oB3BLqZKMlmo8U3BBud/EX37eY1Kla7jsKmo+DdMM5w=;
 b=hQNtpXt3w0U+fu+PNy0Uw/qfJ9ywjTfkBkp5ZtClCh3rulx/veyMZF2xWudZwZVmpI52Dx
 oltBlJt8B7rwlGZFOQHKJb4bkvgjGnMJmPgEfd0mFrw7ECSiTqEIqdKa+GB9cyVc2nqLb3
 2ltEPXudcudkr025zoh3SEPKvTkkHlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-w6ymrO1-PPSZ6BXZchLwAw-1; Fri, 20 Dec 2019 05:18:26 -0500
X-MC-Unique: w6ymrO1-PPSZ6BXZchLwAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E44F107ACC4;
 Fri, 20 Dec 2019 10:18:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59C045C1B0;
 Fri, 20 Dec 2019 10:18:24 +0000 (UTC)
Subject: Re: [PATCH v2] iotests.py: Let wait_migration wait even more
To: Kevin Wolf <kwolf@redhat.com>
References: <20191219183617.213637-1-mreitz@redhat.com>
 <20191220093258.GB4019@dhcp-200-226.str.redhat.com>
 <ae410084-8100-de49-4576-d13da3f6adee@redhat.com>
 <20191220100722.GC4019@dhcp-200-226.str.redhat.com>
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
Message-ID: <6f204683-ee90-77b1-7db0-05d882b02142@redhat.com>
Date: Fri, 20 Dec 2019 11:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220100722.GC4019@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V532azYSyvkEDYBJSPwxWDoexQ5vjoB21"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
--V532azYSyvkEDYBJSPwxWDoexQ5vjoB21
Content-Type: multipart/mixed; boundary="8gAbaokQLFoT3KhTuyvmnEyFi4zSU1zxc"

--8gAbaokQLFoT3KhTuyvmnEyFi4zSU1zxc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.12.19 11:07, Kevin Wolf wrote:
> Am 20.12.2019 um 10:52 hat Max Reitz geschrieben:
>> On 20.12.19 10:32, Kevin Wolf wrote:
>>> Am 19.12.2019 um 19:36 hat Max Reitz geschrieben:
>>>> The "migration completed" event may be sent (on the source, to be
>>>> specific) before the migration is actually completed, so the VM runsta=
te
>>>> will still be "finish-migrate" instead of "postmigrate".  So ask the
>>>> users of VM.wait_migration() to specify the final runstate they desire
>>>> and then poll the VM until it has reached that state.  (This should be
>>>> over very quickly, so busy polling is fine.)
>>>>
>>>> Without this patch, I see intermittent failures in the new iotest 280
>>>> under high system load.  I have not yet seen such failures with other
>>>> iotests that use VM.wait_migration() and query-status afterwards, but
>>>> maybe they just occur even more rarely, or it is because they also wai=
t
>>>> on the destination VM to be running.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>
>>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>>>> index 13fd8b5cd2..0b62c42851 100644
>>>> --- a/tests/qemu-iotests/iotests.py
>>>> +++ b/tests/qemu-iotests/iotests.py
>>>> @@ -668,12 +668,16 @@ class VM(qtest.QEMUQtestMachine):
>>>>              }
>>>>          ]))
>>>> =20
>>>> -    def wait_migration(self):
>>>> +    def wait_migration(self, expect_runstate):
>>>>          while True:
>>>>              event =3D self.event_wait('MIGRATION')
>>>>              log(event, filters=3D[filter_qmp_event])
>>>>              if event['data']['status'] =3D=3D 'completed':
>>>>                  break
>>>> +        # The event may occur in finish-migrate, so wait for the expe=
cted
>>>> +        # post-migration runstate
>>>
>>> That's a bit too specific now that you have expect_runstate.
>>
>> Can you be more specific? :-)
>>
>> If you mean the fact of mentioning =E2=80=9Cpost-migration runstate=E2=
=80=9D, I simply
>> meant that as =E2=80=9Cthe runstate after the migration=E2=80=9D.  The s=
pecific runstate
>> on the source VM is called =E2=80=9Cpostmigrate=E2=80=9D.
>=20
> Oh, yes, "postmigrate" is what I had in mind.
>=20
>> I wouldn=E2=80=99t mind changing it to =E2=80=9Cafter-migration runstate=
=E2=80=9D or something
>> similar, if that=E2=80=99s what you mean.
>=20
> "runstate after migration"?

Sure.

(Now you got me to wonder what permutations are permissible.  =E2=80=9Cmigr=
ation
after runstate=E2=80=9D isn=E2=80=99t.  =E2=80=9Crunstate migration after=
=E2=80=9D is just garbage.  So
probebly on RAM and AMR.)

Max


--8gAbaokQLFoT3KhTuyvmnEyFi4zSU1zxc--

--V532azYSyvkEDYBJSPwxWDoexQ5vjoB21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl38n+4ACgkQ9AfbAGHV
z0CE3Af8D8KIOW6I3vf9ST6O0/BL/o0Oh/vbgJIRgIvZD4r0fm1QQEIQExSTGM1K
bozI6tC6Z7J6NtMyQhocqeaV1XNKo3BL5IoryKVFS03vS9cbIV6Ooixbwt67q1fE
SZNK2suZwrSwZVrJUZjIhK9Stu6odyeHFeWgwrlEUkRzriQt/VCPKCVfLRXXIPft
ZID3x7aoxgjUOoeSt9AWBPlFEXONDCx57OLGT/ssYcEsKNDXy18Q2V0m1RQvK1Xf
zxXvI6RKjpoW26XS0sblFg/94RbzTjQS3i6fyAlmm5bjIk30MufJsuiQ2P4k0u3O
m8kf9kFA05yXJz1hFwuuihAc1AG/XQ==
=P5+E
-----END PGP SIGNATURE-----

--V532azYSyvkEDYBJSPwxWDoexQ5vjoB21--


