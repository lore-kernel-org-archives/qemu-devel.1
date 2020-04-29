Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21741C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E038F20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLnO938q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E038F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTi95-00087O-Vq
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTi81-0006yY-VR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTi7z-0003E4-8a
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:31:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTi7y-0003Dg-Ng
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588149092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VKp3aUQdyEFelk9vDnLw3PgaVuD0ugmN6jw6rC+cW+c=;
 b=LLnO938qNvxQ58GMJ59ilqHY8yassD1v/lLoPthfG/68fmb3vGZnHgtqsJy6goorxSUCRc
 s1OrdCFYK/eYKyNBfWeWFZ+7DbKQI5A5crkut1viBpUKXPT4+q56H8FRHTdqMbvuQQT90x
 FCSsCDOx1TqmKV23/mgg8JpRKeczLLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-shdPjpBxM_mvK90ZkpUiMQ-1; Wed, 29 Apr 2020 04:31:29 -0400
X-MC-Unique: shdPjpBxM_mvK90ZkpUiMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4EB85B695
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 08:31:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 349E4605CB;
 Wed, 29 Apr 2020 08:31:10 +0000 (UTC)
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Miklos Szeredi <mszeredi@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
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
Message-ID: <0da9422f-6399-6ef0-1042-4b2b90d49ed8@redhat.com>
Date: Wed, 29 Apr 2020 10:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428191523.GU2794@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fa6z0x3Hyua25I2PFGnHyAkbwADmM0xmU"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fa6z0x3Hyua25I2PFGnHyAkbwADmM0xmU
Content-Type: multipart/mixed; boundary="amDNFfKQLvJWzDQB1r9C5KjbfYuHngW6g"

--amDNFfKQLvJWzDQB1r9C5KjbfYuHngW6g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 21:15, Dr. David Alan Gilbert wrote:
> * Miklos Szeredi (mszeredi@redhat.com) wrote:
>> On Tue, Apr 28, 2020 at 4:52 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
>>>
>>> On Mon, Apr 27, 2020 at 06:59:02PM +0100, Dr. David Alan Gilbert wrote:
>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>> Currently, setup_mounts() bind-mounts the shared directory without
>>>>> MS_REC.  This makes all submounts disappear.
>>>>>
>>>>> Pass MS_REC so that the guest can see submounts again.
>>>>
>>>> Thanks!
>>>>
>>>>> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
>>>>
>>>> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>  tools/virtiofsd/passthrough_ll.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
>>>>> index 4c35c95b25..9d7f863e66 100644
>>>>> --- a/tools/virtiofsd/passthrough_ll.c
>>>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>>>> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
>>>>>      int oldroot;
>>>>>      int newroot;
>>>>>
>>>>> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
>>>>> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>>>>>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sourc=
e, source);
>>>>>          exit(1);
>>>>>      }
>>>>
>>>> Do we want MS_SLAVE to pick up future mounts that might happenf rom th=
e
>>>> host?
>>>
>>> There are two separate concepts:
>>>
>>> 1. Mount namespaces.  The virtiofsd process is sandboxed and lives in
>>>    its own mount namespace.  Therefore it does not share the mounts tha=
t
>>>    the rest of the host system sees.
>>>
>>> 2. Propagation type.  This is related to bind mounts so that mount
>>>    operations that happen in one bind-mounted location can also appear
>>>    in other bind-mounted locations.
>>>
>>> Since virtiofsd is in a separate mount namespace, does the propagation
>>> type even have any effect?
>>
>> It's a complicated thing.  Current setup results in propagation
>> happening to the cloned namespace, but not to the bind mounted root.
>>
>> Why?  Because setting mounts "slave" after unshare, results in the
>> propagation being stopped at that point.  To make it propagate
>> further, change it back to "shared".  Note: the result changing to
>> "slave" and then to "shared" results in breaking the backward
>> propagation to the original namespace, but allowing propagation
>> further down the chain.
>=20
> Do you mean on the "/" ?
>=20
> So our current sequence is:
>=20
>    (new namespace)
>  1)    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
>  2)   if (mount("proc", "/proc", "proc",
>            ....
>  3)   if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>  4)  (chdir newroot, pivot, chdir oldroot)
>  5)   if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
>  6)   if (umount2(".", MNT_DETACH) < 0) {
>=20
> So are you saying we need a:
>        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
>=20
>   and can this go straight after (1) ?

Isn=E2=80=99t MS_SHARED and MS_SLAVE mutually exclusive, that is, both are =
just
different propagation types?  So shouldn=E2=80=99t putting this after (1) b=
e
effectively the same as replacing (1)?

Max


--amDNFfKQLvJWzDQB1r9C5KjbfYuHngW6g--

--Fa6z0x3Hyua25I2PFGnHyAkbwADmM0xmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pO0wACgkQ9AfbAGHV
z0AcVAf/fevwv5zOzFlL6k+o2MbLUT3qtjfeX2Px9ONYHLV8ENTebgNk8XU6IVij
Ptkw8nkTyjoCccK0WejZzSrWun+dKlOLrEMsXNOEMsI7ildSLWXQq7dHkQH8xVRG
QUGtrSNoT/VoWgU0GjomKXYQbLqMYcgSnRn5oNVh+kGH2UYOD+1Z4k7p4mnnLyad
Gn94GElfFOvvVTduQPSYiUMj9r+TjWFr7Yfdq3QqrFmqCNPnr2PE2AyZy1sA7o4z
aS2t7ARU3qDHZ7b8dlyUXwg5GRt4o+F/mIcsotc1Y42t4/K63ju9StodN60yqS0i
PCWUNW5gF/HH5DypfXQHC3nzu9VBxQ==
=MqzQ
-----END PGP SIGNATURE-----

--Fa6z0x3Hyua25I2PFGnHyAkbwADmM0xmU--


