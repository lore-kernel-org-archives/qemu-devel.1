Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F543C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF13725587
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPkK5kEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF13725587
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwPP-0007PJ-9K
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jpwLA-00024s-Fe
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:09:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jpwL8-0001Zs-KF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593446942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EfBncah/tgRltTqBW5JcvfVrKw0SL0KJFj5x1XUO4Fs=;
 b=MPkK5kEip1VgFf6XmguIRnC+JTecBk7dD5XmQlkW4YDEyGa1lk5PH4TyTdXE25FNI6Qr6w
 JLlKX52BB6uRdys4/C2Ox6fPfBYoPKVq1LHsv0L45RYUhZ/huIPV4TftDLDPyOvH+ICm8I
 GjbKcZFw/hMH2/uXLPe/EuS6HoKqJhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-8dXlCgycNcqYLxQFK3doKw-1; Mon, 29 Jun 2020 12:08:47 -0400
X-MC-Unique: 8dXlCgycNcqYLxQFK3doKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4740C18FE863;
 Mon, 29 Jun 2020 16:08:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-124.ams2.redhat.com
 [10.36.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3648E60BF3;
 Mon, 29 Jun 2020 16:08:45 +0000 (UTC)
Subject: Re: Properly quitting qemu immediately after failing migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
 <20200629154104.GK2908@work-vm>
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
Message-ID: <fb611d49-4fd9-ef1a-1383-1d15137f658d@redhat.com>
Date: Mon, 29 Jun 2020 18:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629154104.GK2908@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6qRX1vAMpF8cXplitjnY50A2mIqaOYVLQ"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6qRX1vAMpF8cXplitjnY50A2mIqaOYVLQ
Content-Type: multipart/mixed; boundary="eVKKWB5xOcGtqyoBYuTePprjaIzQfcgE3"

--eVKKWB5xOcGtqyoBYuTePprjaIzQfcgE3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.06.20 17:41, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> Hi,
>>
>> In an iotest, I=E2=80=99m trying to quit qemu immediately after a migrat=
ion has
>> failed.  Unfortunately, that doesn=E2=80=99t seem to be possible in a cl=
ean way:
>> migrate_fd_cleanup() runs only at some point after the migration state
>> is already =E2=80=9Cfailed=E2=80=9D, so if I just wait for that =E2=80=
=9Cfailed=E2=80=9D state and
>> immediately quit, some cleanup functions may not have been run yet.
>=20
> Yeh this is hard; I always take the end of migrate_fd_cleanup to be the
> real end.

Yes, unfortunately I don=E2=80=99t seem to have a way to look for that end.=
 :(

> It always happens on the main thread I think (it's done as a bh in some
> cases).
>=20
>> This is a problem with dirty bitmap migration at least, because it
>> increases the refcount on all block devices that are to be migrated, so
>> if we don=E2=80=99t call the cleanup function before quitting, the refco=
unt will
>> stay elevated and bdrv_close_all() will hit an assertion because those
>> block devices are still around after blk_remove_all_bs() and
>> blockdev_close_all_bdrv_states().
>>
>> In practice this particular issue might not be that big of a problem,
>> because it just means qemu aborts when the user intended to let it quit
>> anyway.  But on one hand I could imagine that there are other clean-up
>> paths that should definitely run before qemu quits (although I don=E2=80=
=99t
>> know), and on the other, it=E2=80=99s a problem for my test.
>=20
> 'quit' varies - there are a lot of incoming failures that just assert;
> very few of them cause a clean exit (I think there are more clean ones
> after Peter's work on restartable postcopy a year or two ago).

Well, my problem is about the source side, where there is still a VM
running that I would expect to be in a sane state even after a failed
migration.

> I do see the end of migrate_fd_cleanup calls the notifier list; but it's
> not clear to me that it's alwyas going to see the first transition to
> 'failed' at that point.

What exactly do you mean?  It appears to me that both query-status and
the MIGRATION events signal the failed state before migrate_fd_cleanup()
is invoked.

If you mean I could add a notifier to that list to do something=E2=84=A2, I=
=E2=80=99m
not sure what exactly it is I=E2=80=99d so.  My test can=E2=80=99t do it, b=
ecause it=E2=80=99s
an iotest, and even if it could, I suppose I=E2=80=99d want to wait until e=
ven
after all notifiers have been invoked (which isn=E2=80=99t guaranteed if I=
=E2=80=99d add
a notifier myself).

>> I tried working around the problem for my test by waiting on =E2=80=9CUn=
able to
>> write=E2=80=9D appearing on stderr, because that indicates that
>> migrate_fd_cleanup()=E2=80=99s error_report_err() has been reached.  But=
 on one
>> hand, that isn=E2=80=99t really nice, and on the other, it doesn=E2=80=
=99t even work
>> when the failure is on the source side (because then there is no
>> s->error for migrate_fd_cleanup() to report).
>>
>> In all, I=E2=80=99m asking:
>> (1) Is there a nice solution for me now to delay quitting qemu until the
>> failed migration has been fully resolved, including the clean-up?
>=20
> In vl.c, I added a call to migration_shutdown in qemu_cleanup - although
> that seems to be mostly about cleaning up the *outgoing* side; you could
> add some incoming cleanup there.

So you mean waiting until migrate_fd_cleanup() has run?  Maybe I=E2=80=99ll=
 try
that tomorrow, although I=E2=80=99d hoped I could get this done without hav=
ing
to modify the code base...  (I.e., I=E2=80=99d hoped there would be some
QMP-queriable flag somewhere that could tell me whether the
migrate_fd_cleanup() has run)

>> (2) Isn=E2=80=99t it a problem if qemu crashes when you issue =E2=80=9Cq=
uit=E2=80=9D via QMP at
>> the wrong time?  Like, maybe lingering subprocesses when using =E2=80=9C=
exec=E2=80=9D?
>=20
> Yeh that should be cleaner, but isn't.

:(

OK then.  Thanks for your insights!

Max


--eVKKWB5xOcGtqyoBYuTePprjaIzQfcgE3--

--6qRX1vAMpF8cXplitjnY50A2mIqaOYVLQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl76EgsACgkQ9AfbAGHV
z0B0+wf9HJR2HPOe+DPQhgIdsg7KjFYCroS4HZc4m1LKMG+D2Sdj9Z9fi+2O6u5i
XR/E1wq7yF4gBsDXMC3CAOwNttv08Vaut6VB/XHRidHaTg9T/tK9gVxk3T97PHgj
Cyj88BN4p9KqlgsEFRf+NQzLromhtFcHd+aSw4WkIVoPWHjdZeiSBMgsfY4qtCDZ
WjGi2qrrdpCQHtlcUbwoMzQqoVsdU/JKpJJgfyi5z6L6dNnZNSU1YuaOwBeGYCUz
ebEjnntv3NmtJKLjtlB1Kg1u2hAMfikfMuXovIzlCopeTKDm0bC0DBAo5EFhd9rP
PjLHEO8rh3XBsFdR6xai7ziUXmKW+A==
=zrGn
-----END PGP SIGNATURE-----

--6qRX1vAMpF8cXplitjnY50A2mIqaOYVLQ--


