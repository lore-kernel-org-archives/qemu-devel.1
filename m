Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1EC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BF7214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIS0YJ/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BF7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSfIm-000482-3d
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSfHZ-0003Ou-At
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSfHX-0003jT-0g
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:44:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSfHW-0003iy-Su
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573123490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aCBWCoqFsHTqYKr1TOyQ1eJE3PT6hwVPs18+e26nAvI=;
 b=QIS0YJ/RWdb7mdpHrx8A2Tp0VPtpXbT7e2I/CFpEWmXOAHSik2nBj+WNseNloXB2KoN1gl
 0k6QhG0/uigxIVajub1EgC52m3Rszzo6X4LVFIIwTscp6d++V90Le5liPYr4RGbsTXntCz
 yx4rQZa/3ceeH/GC+DRMTpJqBUqWRMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-wIeOwn0ZNKuoCoz1SjEv4g-1; Thu, 07 Nov 2019 05:44:47 -0500
X-MC-Unique: wIeOwn0ZNKuoCoz1SjEv4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6559F107ACC3;
 Thu,  7 Nov 2019 10:44:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-202.ams2.redhat.com
 [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05ED919C6A;
 Thu,  7 Nov 2019 10:44:44 +0000 (UTC)
Subject: Re: [RFC PATCH 18/18] qemu-storage-daemon: Add --monitor option
To: Kevin Wolf <kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-19-kwolf@redhat.com>
 <64d79019-711d-8eb1-da72-a9b95f999ff5@redhat.com>
 <20191107101235.GB5007@linux.fritz.box>
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
Message-ID: <604d1e6e-d96f-bcc0-9006-bbe3e9bfc5cb@redhat.com>
Date: Thu, 7 Nov 2019 11:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107101235.GB5007@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ykTLhdgefQ3KJpytlr8w76eawYTTMdoOQ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ykTLhdgefQ3KJpytlr8w76eawYTTMdoOQ
Content-Type: multipart/mixed; boundary="Gr6irilTxXFHX4fvewSmhEgJQqed3OpCa"

--Gr6irilTxXFHX4fvewSmhEgJQqed3OpCa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.19 11:12, Kevin Wolf wrote:
> Am 06.11.2019 um 15:32 hat Max Reitz geschrieben:
>> On 17.10.19 15:02, Kevin Wolf wrote:
>>> This adds and parses the --monitor option, so that a QMP monitor can be
>>> used in the storage daemon. The monitor offers commands defined in the
>>> QAPI schema at storage-daemon/qapi/qapi-schema.json.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  storage-daemon/qapi/qapi-schema.json | 15 ++++++++++++
>>>  qemu-storage-daemon.c                | 34 ++++++++++++++++++++++++++++
>>>  Makefile                             | 30 ++++++++++++++++++++++++
>>>  Makefile.objs                        |  4 ++--
>>>  monitor/Makefile.objs                |  2 ++
>>>  qapi/Makefile.objs                   |  5 ++++
>>>  qom/Makefile.objs                    |  1 +
>>>  scripts/qapi/gen.py                  |  5 ++++
>>>  storage-daemon/Makefile.objs         |  1 +
>>>  storage-daemon/qapi/Makefile.objs    |  1 +
>>>  10 files changed, 96 insertions(+), 2 deletions(-)
>>>  create mode 100644 storage-daemon/qapi/qapi-schema.json
>>>  create mode 100644 storage-daemon/Makefile.objs
>>>  create mode 100644 storage-daemon/qapi/Makefile.objs
>>
>> [...]
>>
>>> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
>>> index 3e04e299ed..03d256f0a4 100644
>>> --- a/qapi/Makefile.objs
>>> +++ b/qapi/Makefile.objs
>>> @@ -30,3 +30,8 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
>>>  obj-y +=3D qapi-events.o
>>>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
>>>  obj-y +=3D qapi-commands.o
>>> +
>>> +QAPI_MODULES_STORAGE_DAEMON =3D block block-core char common crypto in=
trospect
>>> +QAPI_MODULES_STORAGE_DAEMON +=3D job monitor qom sockets pragma transa=
ction
>>
>> I took a look into the rest, and I wonder whether query-iothreads from
>> misc.json would be useful, too.
>=20
> Possibly. It would be a separate patch, but I can add it.
>=20
> The question is just where to move query-iothreads. Do we have a good
> place, or do I need to separate misc.json and a new misc-sysemu.json?

I=E2=80=99d just put it in block.json because of the =E2=80=9Cio=E2=80=9D..=
. O:-)

>>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>>> index 796c17c38a..c25634f673 100644
>>> --- a/scripts/qapi/gen.py
>>> +++ b/scripts/qapi/gen.py
>>> @@ -44,6 +44,11 @@ class QAPIGen(object):
>>>          return ''
>>> =20
>>>      def write(self, output_dir):
>>> +        # Include paths starting with ../ are used to reuse modules of=
 the main
>>> +        # schema in specialised schemas. Don't overwrite the files tha=
t are
>>> +        # already generated for the main schema.
>>> +        if self.fname.startswith('../'):
>>> +            return
>>
>> Sorry, but I=E2=80=99m about to ask a clueless question: How do we ensur=
e that
>> the main schema is generated before something else could make sure of
>> the specialized schemas?
>=20
> "Make sure"?

Oops, s/ sure/ use/.

> I think the order of the generation doesn't matter because generating
> the storage daemon files doesn't actually access the main ones.
> Generated C files shouldn't be a problem either because if we link an
> object file into a binary, we have a make dependency for it.

I was mostly wondering about the fact that make mustn=E2=80=99t try to comp=
ile
the =E2=80=9Cgenerated files=E2=80=9D (which aren=E2=80=99t really generate=
d here) before they
are actually generated when the main schema is processed.

Max

> Maybe the only a bit trickier question is whether we have the
> dependencies right so that qemu-storage-daemon.c is only built after the
> header files of both the main schema and the specific one have been
> generated. If I understand the Makefile correctly, generated-files-y
> takes care of this, and this patch adds all new header files to it if I
> didn't miss any.
>=20
> Kevin
>=20



--Gr6irilTxXFHX4fvewSmhEgJQqed3OpCa--

--ykTLhdgefQ3KJpytlr8w76eawYTTMdoOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3D9ZsACgkQ9AfbAGHV
z0DezQf/ZXYjdG39dClKnwktM0ljTaCCzRLwL0EGCKWRHjgomMufsPDeyBD+5Gku
hv8N3CBISmWwNG4Ah86ZOQ1qirylnXJQuqhgt7GubIMfOKirlJ87gLRMH5RkxD86
d1AEf48fRnn0uaip9NUkKp4IzU3RuwrP8uPEx1gKk+9Pfa89S4YpFyiaxKak/Vs+
PicHb3PIweo0M61CT9gKpItL/3/JofKUPEGSa/opjP+xg7FR25EcXEOgo0Q6wuz7
e3bgXkAiorj76K2x4y3Pwg6SIU2aUfC6JjFFZVQPhuvADoSSRSEg/RyTLK2FL96B
OzlBPEpe8SdjjOu17RbNdyuLgO9oeQ==
=dNQu
-----END PGP SIGNATURE-----

--ykTLhdgefQ3KJpytlr8w76eawYTTMdoOQ--


