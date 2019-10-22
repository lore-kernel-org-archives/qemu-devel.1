Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FAFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C121121783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX4siXrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMu5f-0003L2-ON
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMu3G-0001nG-V9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMu3D-0006wv-GV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:18:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35224
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMu3C-0006wH-MS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571750292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c/6/phZoiWS3Hf/+daYYG0NVxsJQmPJrKc1O5GpYW7M=;
 b=iX4siXrvX5pBam+1PGndFSkekrcsaDw/D/0U9zj+Yge46bBEy4b35K5YAnJfVJTrt3wxLt
 cM5bCEjVdoNfjMTeX0nJJB94EczLDyQ5k9zJlrER+BKflPGkM3vuyUxs0/tVqnEiXPvcoG
 OG+JLXJTz0rUICkCqY/0+4F7ZBqQ4BU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Pd-kEeyfMZWPOO-ROAy08g-1; Tue, 22 Oct 2019 09:18:11 -0400
X-MC-Unique: Pd-kEeyfMZWPOO-ROAy08g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E3101005509;
 Tue, 22 Oct 2019 13:18:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 509F51001DC2;
 Tue, 22 Oct 2019 13:18:08 +0000 (UTC)
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
 <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
 <12dab583-cc5e-f790-a77b-b0476f2aa1d1@virtuozzo.com>
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
Message-ID: <f012a789-bd2a-11fc-141c-ba6e9e256687@redhat.com>
Date: Tue, 22 Oct 2019 15:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <12dab583-cc5e-f790-a77b-b0476f2aa1d1@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Yq8NydGKjYp9k4FX9oUmnRc7sOAggRN3o"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yq8NydGKjYp9k4FX9oUmnRc7sOAggRN3o
Content-Type: multipart/mixed; boundary="AUBseFeO4D22R3MbbYlM5B3d2cDuyeB78"

--AUBseFeO4D22R3MbbYlM5B3d2cDuyeB78
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.10.19 14:53, Denis Plotnikov wrote:
>=20
> On 22.10.2019 14:05, Max Reitz wrote:
>> On 21.10.19 08:50, Denis Plotnikov wrote:
>>> On 18.10.2019 18:02, Max Reitz wrote:
>>>> On 18.10.19 14:09, Denis Plotnikov wrote:
>>>>> The modification is useful to workaround exclusive file access restri=
ctions,
>>>>> e.g. to implement VM migration with shared disk stored on a storage w=
ith
>>>>> the exclusive file opening model: a destination VM is started waiting=
 for
>>>>> incomming migration with a fake image drive, and later, on the last m=
igration
>>>>> phase, the fake image file is replaced with the real one.
>>>>>
>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> Isn=E2=80=99t this what we would want to use reopen for?
>>>>
>>>> Max
>>> Could you please explain what is "use reopen"?
>> I was thinking of using (x-)blockdev-reopen to change the file that is
>> used by the format node (e.g. from a null-co node to a real file); or to
>> change the filename of the protocol node.
>>
>> Kevin has pointed out (on IRC) that this will not allow you to change
>> the node that is directly attached to the device.  While I don=E2=80=99t=
 know
>> whether that=E2=80=99s really necessary in this case, if it were indeed
>> necessary, I=E2=80=99d prefer a method to change a guest device=E2=80=99=
s @drive option
>> because that seems more natural to me.
>>
>> In contrast, the approach taken in this patch seems not quite right to
>> me, because it overloads the whole blockdev-change-medium command with a
>> completely new and different implementation based on whether there=E2=80=
=99s a
>> removable medium or not.  If the implementation is so different (and the
>> interface is, too, because in one path you must give @medium whereas the
>> other doesn=E2=80=99t evaluate it at all), it should be a new command.
>>
>> I don=E2=80=99t know whether we need a new command at all, though.  On t=
he node
>> level, we have (x-)blockdev-reopen.  So assuming we need something to
>> change the link between the guest device and the block layer, I wonder
>> whether there isn=E2=80=99t something similar; specifically, I=E2=80=99d=
 prefer
>> something to simply change the device=E2=80=99s @drive option.
>>
>> Kevin has pointed out (on IRC again) that there is indeed one such
>> command, and that=E2=80=99s qom-set.  Unfortunately, this is what happen=
s if you
>> try to use it for @drive:
>>
>> {"error": {"class": "GenericError", "desc": "Attempt to set property
>> 'drive' on anonymous device (type 'virtio-blk-device') after it was
>> realized"}}
>>
>> However, Kevin has claimed it would be technically possible to make an
>> exception for @drive.  Maybe this is worth investigating?
>=20
> Is there any guess how complex it might be? In the case if it's quite=20
> complex may be it's worth to make the separate command?

I can translate the chat log for you:

<kevin> In theory that=E2=80=99s called qom-set
<kevin> However, I believe it doesn=E2=80=99t support qdev properties
<kevin> Hm, but that could be changed specifically for the drive property
<kevin> qdev keeps confusing me.  Drive isn=E2=80=99t supposed to call
qdev_prop_set_after_realize(), but the error message=E2=80=99s still there.
Where is that hidden call...?
<kevin> Ah, set_pointer() does
<kevin> Yes, then it should be possible to make that work rather locally

And that took him about 10 minutes.

So I suppose it would be to check in set_drive() and
set_drive_iothread() whether the device is already realized, and if so,
divert it to some other function that does the runtime change?

(No idea how the qdev maintainers think about doing that in set_drive()
and set_drive_iothread(), though)

>> (As for blockdev-change-medium, as I=E2=80=99ve said, I don=E2=80=99t re=
ally think this
>> fits there.  Furthermore, blockdev-change-medium is kind of a legacy
>> command because I think every command but blockdev-add that does a
>> bdrv_open() kind of is a legacy command.
> Out of curiosity, could you please explain why it's decided to be so?

Because we have blockdev-add, which supports all block device options
there are and so on.  blockdev-change-medium (which is basically just a
more rigid =E2=80=9Cchange=E2=80=9D) only gets filename, which isn=E2=80=99=
t as expressive.

We generally want users to add new nodes with blockdev-add and let all
other commands only take node-names.

(There=E2=80=99s also the fact that historically we=E2=80=99ve used filenam=
es to
identify BlockDriverStates, but that doesn=E2=80=99t work so well.  Thus I =
think
we should get away from using filenames as much as we can so people
don=E2=80=99t use them for identification again.)

Max


--AUBseFeO4D22R3MbbYlM5B3d2cDuyeB78--

--Yq8NydGKjYp9k4FX9oUmnRc7sOAggRN3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2vAY4ACgkQ9AfbAGHV
z0AQEAgAvBQ6QBU+0WgVzGoqF4rtlhyWdU8LjtqxYi7xzNmwGruNtXO0Z6MD6C1t
3W7CLyf7vzKspenAkxlMO6fhvUpO8z2oSL699bnhNDnyodF87+VpJYAZ3qI01Fh0
o8SoIp70sYierjnrgVVXfJraNF6nwbUGbUGvyP5Oj8BiGmn4xqrqkWCfQRXr9xN8
rxHoPx1y4etqUhuwkNrpJM+jH5Ko43pbmhvUZSylgKK+yXZ/BouNPOCoHrfPAm5g
itzfMrcHrljlsQABe2pWy0xjs5gQAlAKhVxZEz+QYEopJ1dmMyEK8oxJsVBqdMtC
QhJQapgqxBPFN3XN5PD8ISgBhEh7EQ==
=pcuO
-----END PGP SIGNATURE-----

--Yq8NydGKjYp9k4FX9oUmnRc7sOAggRN3o--


