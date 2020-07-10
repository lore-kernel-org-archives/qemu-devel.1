Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A273C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CE220720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYPGxku5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CE220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvdx-0000UY-LL
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtvdG-0008QP-Tq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:12:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtvdD-0004ms-UB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594397530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uo/tqg+mAZQO4FzkorI9aJlkBABUAuJHgD/eZ+8AmlM=;
 b=bYPGxku5DewwteZgKBtxi8zJ4b1PNPxzG9zGOAGgnEBmfcO035xGRNtOC0lJKFL33Xz0KG
 jN4Vg0JxZX0965qixWK3byUeyx3QluLdINT396KMDBZG02YaWapwahoeDzxQIzaAvogGhk
 godXbaznPJYjVDos9hGfgVh8QqB2JwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-KYm94O0hNS-3S4pvdTSe3Q-1; Fri, 10 Jul 2020 12:12:08 -0400
X-MC-Unique: KYm94O0hNS-3S4pvdTSe3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1FF18FF661;
 Fri, 10 Jul 2020 16:12:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D08578A45;
 Fri, 10 Jul 2020 16:12:05 +0000 (UTC)
Subject: Re: [PATCH for-5.1] file-posix: Mitigate file fragmentation with
 extent size hints
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200707142329.48303-1-kwolf@redhat.com>
 <20200707161741.GG7002@linux.fritz.box>
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
Message-ID: <451ed32d-72e8-0238-8793-f5a80ae991c4@redhat.com>
Date: Fri, 10 Jul 2020 18:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707161741.GG7002@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Rd55P4OmxNat95E0BBHNw3m88C4tcEMlC"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rd55P4OmxNat95E0BBHNw3m88C4tcEMlC
Content-Type: multipart/mixed; boundary="cwY92oLKOF5Rt91MZGoqMUruUHWHC4eFX"

--cwY92oLKOF5Rt91MZGoqMUruUHWHC4eFX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.07.20 18:17, Kevin Wolf wrote:
> Am 07.07.2020 um 16:23 hat Kevin Wolf geschrieben:
>> Espeically when O_DIRECT is used with image files so that the page cache
>> indirection can't cause a merge of allocating requests, the file will
>> fragment on the file system layer, with a potentially very small
>> fragment size (this depends on the requests the guest sent).
>>
>> On Linux, fragmentation can be reduced by setting an extent size hint
>> when creating the file (at least on XFS, it can't be set any more after
>> the first extent has been allocated), basically giving raw files a
>> "cluster size" for allocation.
>>
>> This adds an create option to set the extent size hint, and changes the
>> default from not setting a hint to setting it to 1 MB. The main reason
>> why qcow2 defaults to smaller cluster sizes is that COW becomes more
>> expensive, which is not an issue with raw files, so we can choose a
>> larger file. The tradeoff here is only potentially wasted disk space.
>>
>> For qcow2 (or other image formats) over file-posix, the advantage should
>> even be greater because they grow sequentially without leaving holes, so
>> there won't be wasted space. Setting even larger extent size hints for
>> such images may make sense. This can be done with the new option, but
>> let's keep the default conservative for now.
>>
>> The effect is very visible with a test that intentionally creates a
>> badly fragmented file with qemu-img bench (the time difference while
>> creating the file is already remarkable) and then looks at the number of
>> extents and the take a simple "qemu-img map" takes.
>>
>> Without an extent size hint:
>>
>>     $ ./qemu-img create -f raw -o extent_size_hint=3D0 ~/tmp/test.raw 10=
G
>>     Formatting '/home/kwolf/tmp/test.raw', fmt=3Draw size=3D10737418240 =
extent_size_hint=3D0
>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S=
 8192 -o 0
>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (sta=
rting at offset 0, step size 8192)
>>     Run completed in 25.848 seconds.
>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S=
 8192 -o 4096
>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (sta=
rting at offset 4096, step size 8192)
>>     Run completed in 19.616 seconds.
>>     $ filefrag ~/tmp/test.raw
>>     /home/kwolf/tmp/test.raw: 2000000 extents found
>>     $ time ./qemu-img map ~/tmp/test.raw
>>     Offset          Length          Mapped to       File
>>     0               0x1e8480000     0               /home/kwolf/tmp/test=
.raw
>>
>>     real    0m1,279s
>>     user    0m0,043s
>>     sys     0m1,226s
>>
>> With the new default extent size hint of 1 MB:
>>
>>     $ ./qemu-img create -f raw -o extent_size_hint=3D1M ~/tmp/test.raw 1=
0G
>>     Formatting '/home/kwolf/tmp/test.raw', fmt=3Draw size=3D10737418240 =
extent_size_hint=3D1048576
>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S=
 8192 -o 0
>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (sta=
rting at offset 0, step size 8192)
>>     Run completed in 11.833 seconds.
>>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S=
 8192 -o 4096
>>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (sta=
rting at offset 4096, step size 8192)
>>     Run completed in 10.155 seconds.
>>     $ filefrag ~/tmp/test.raw
>>     /home/kwolf/tmp/test.raw: 178 extents found
>>     $ time ./qemu-img map ~/tmp/test.raw
>>     Offset          Length          Mapped to       File
>>     0               0x1e8480000     0               /home/kwolf/tmp/test=
.raw
>>
>>     real    0m0,061s
>>     user    0m0,040s
>>     sys     0m0,014s
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> I also need to squash in a few trivial qemu-iotests updates, for which I
> won't send a v2:

The additional specifications in 243 make it print a warning on tmpfs
(because the option doesn=E2=80=99t work there).  I suppose the same may be=
 true
on other filesystems as well.  Should it be filtered out?

Max


--cwY92oLKOF5Rt91MZGoqMUruUHWHC4eFX--

--Rd55P4OmxNat95E0BBHNw3m88C4tcEMlC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8Ik1QACgkQ9AfbAGHV
z0Ds5AgAi7Mvr1uQbZ0r5ww5hOrfurAk4xkpyx+xf/cMBPUpStu8nRdldA56/Vfw
C59oKSudjY29LNrSzmedvxZOComNN5OOYX2Ama28IUano1kIU2uW3POo9eBbxh9H
M3o56wgPxwkqgcEFwWfl2qrioy245dZAc/Ixw69VBmjizG3Kfs4F5wDfBvv3jpXE
XxFVOxGXTUqpMjjPRSIb7SGUSsUmsYkvEw2YrN342SnXjK7+F6JKbTmREX4NKyxr
l33KL+y87Z3LkjHwF5nMXfMt0vyOgQGtolLu2MOK9ul9heqI1VN6ON3fT/dNbYoy
+R9MStQ8VZ0zFLr7mZYBTslULhFN7w==
=9HhK
-----END PGP SIGNATURE-----

--Rd55P4OmxNat95E0BBHNw3m88C4tcEMlC--


