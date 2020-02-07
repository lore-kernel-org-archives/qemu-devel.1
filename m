Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82DBC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8325220726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPkM3VJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8325220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izywl-0000ik-LK
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izyw7-0008T4-A0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izyw6-0006oF-7D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:24:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izyw6-0006nv-4H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581063865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2vUiNG1LmE1ysXnqnm0CPhO3WM+5SSSkTkLhHYcojH0=;
 b=YPkM3VJQobW5vndz9BXJvb7qY9kuQpJ556gOw//sxVTsmI061e1gAQMyH1epOkU0KN8tQ3
 FX7UWRENpDMrcZaIslHI3++74Kfg9T7lHD/NzP1TCBxpsT4lZ+/36ncUiQKOrfIvY5Gp2w
 StAl7lsp1rxVEygB6cKfYgMCpNVAvKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-T2bqwGrsNZ2vxy9l8poKBQ-1; Fri, 07 Feb 2020 03:24:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B822101FC60;
 Fri,  7 Feb 2020 08:24:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-88.ams2.redhat.com
 [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257CB5C241;
 Fri,  7 Feb 2020 08:24:16 +0000 (UTC)
Subject: Re: [PATCH] tests/qemu_iotests: Minimize usage of used ports
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200203075955.28861-1-ldoktor@redhat.com>
 <fe6a7eb5-352a-3cb5-4e75-bd99baf6d54e@redhat.com>
 <595ffedf-4213-f000-96e1-3216e272b1c1@redhat.com>
 <726ca911-be83-c2d5-ff3f-efa32bc2233e@redhat.com>
 <797578d5-bfab-5eb7-8921-0fcf1f3ee40e@redhat.com>
 <6dcc60d8-3f3f-46bc-e3ca-c0569f9b0e23@redhat.com>
 <2958ad49-32c2-2157-2d88-7ec8ad14a5ef@redhat.com>
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
Message-ID: <7393918c-e8c8-f58c-ce6e-34591c27e85c@redhat.com>
Date: Fri, 7 Feb 2020 09:24:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2958ad49-32c2-2157-2d88-7ec8ad14a5ef@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: T2bqwGrsNZ2vxy9l8poKBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.02.20 19:33, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 06. 02. 20 v 17:59 Max Reitz napsal(a):
>> On 06.02.20 17:48, Eric Blake wrote:
>>> On 2/6/20 10:37 AM, Max Reitz wrote:

[...]

>>>> OTOH, would it work if we just did a %s/localhost/127.0.0.1/ in the
>>>> test?=C2=A0 We have specific cases for IPv6, so I think it makes sense=
 to
>>>> force IPv4 in all other cases.
>>>
>>> Except then it will fail on machines configured for IPv6-only.
>>
>> So we=E2=80=99ll just have to test whether IPv4 works, just like we alre=
ady do
>> for IPv6, no?
>>
>=20
> Sure, using ::1 for IPv6 and 127.0.0.1 for IPv4 cases would work. The que=
stion is whether the behavior is really expected. In migration it was consi=
dered dangerous, because you can have 2 VMs starting the migration at the s=
ame time. They both might attempt to get the same port, one would receive I=
Pv4 the other IPv6. Then depending on the order of start migrate you might =
end-up attempting to migrate the other VMs instead of the intended ones.
>=20
> The same can happen here, you might start 2 nbd exports at the same time,=
 get the same port without any failures and then depending on luck get the =
right or wrong export when attempting to connect. So I think bailing out in=
 case we fail to get all interfaces would be the most appropriate (note the=
 same situation is for 0.0.0.0 where you might end-up serving multiple diff=
erent disks on different interfaces). Anyway I leave it to you. If you deci=
de you don't want to fail than using ::1/127.0.0.1 sounds like a good idea.=
 Otherwise it'd make sense to create a test that especially uses ::1 and th=
en localhost to make sure it bails-out.

OK.  I=E2=80=99ll defer to Eric on that one. O:-)

Max


