Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA11EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4CB20729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BobM3l/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4CB20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hZy-0008Bk-Hb
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7hM7-00015s-6m
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:47:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7hM4-0008Ok-Re
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597679243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HN05WRduQCJrrui6EAIVX+942t3oRyS4MqLgr4JJZJo=;
 b=BobM3l/3DEP2+bdvy969rR4SsulGU1BS1Aix4RPOE0V5OAVjkCX0gjPoLKJzP/8vR+83dg
 yiDwmWV9bNHp3CEkTIyAFFrni9ntZNkp8rdgJmzJH1Xat49ENtgjUNIG8NxvNzNbvivYRT
 a28cmhW1KrgZpXti2OKyJ9EK53f5EGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-aHe5HBGfPKeyt6VZn0-rPQ-1; Mon, 17 Aug 2020 11:47:21 -0400
X-MC-Unique: aHe5HBGfPKeyt6VZn0-rPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA741DE01;
 Mon, 17 Aug 2020 15:47:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7AB7756AD;
 Mon, 17 Aug 2020 15:47:19 +0000 (UTC)
Subject: Re: [RFC PATCH 14/22] block/export: Move AioContext from NBDExport to
 BlockExport
To: Kevin Wolf <kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-15-kwolf@redhat.com>
 <2851aef1-176c-1b81-4941-dc4b08b6bfec@redhat.com>
 <20200817152259.GP11402@linux.fritz.box>
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
Message-ID: <95f08b8c-d2d7-aaca-0807-9361d667847d@redhat.com>
Date: Mon, 17 Aug 2020 17:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817152259.GP11402@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nYnehHWijXtu6CQE09V62WHFBzLEdn4Qe"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--nYnehHWijXtu6CQE09V62WHFBzLEdn4Qe
Content-Type: multipart/mixed; boundary="CM4Zro4hcKlLeX8AVMaF54aztoaSK3xfe"

--CM4Zro4hcKlLeX8AVMaF54aztoaSK3xfe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.20 17:22, Kevin Wolf wrote:
> Am 17.08.2020 um 16:56 hat Max Reitz geschrieben:
>> On 13.08.20 18:29, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/block/export.h |  6 ++++++
>>>  nbd/server.c           | 26 +++++++++++++-------------
>>>  2 files changed, 19 insertions(+), 13 deletions(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>> diff --git a/include/block/export.h b/include/block/export.h
>>> index f44290a4a2..5459f79469 100644
>>> --- a/include/block/export.h
>>> +++ b/include/block/export.h
>>> @@ -33,6 +33,12 @@ struct BlockExport {
>>>       * the export.
>>>       */
>>>      int refcount;
>>> +
>>> +    /*
>>> +     * The AioContex whose lock needs to be held while calling
>>
>> *AioContext
>>
>>> +     * BlockExportDriver callbacks.
>>
>> Hm.  But other blk_exp_* functions (i.e. the refcount manipulation
>> functions) are fair game?
>=20
> Hmm... The assumption was the ref/unref are only called from the main
> thread, but maybe that's not true? So maybe blk_exp_*() shouldn't lock
> the AioContext internally, but require that the lock is already held, so
> that they can be called both from within the AioContext (where we don't
> want to lock a second tim) and from the main context.
>=20
> I also guess we need a separate mutex to protect the exports list if
> unref can be called from different threads.
>=20
> And probably the existing NBD server code has already the same problems
> with respect to different AioContexts.
>=20
>>> +     */
>>> +    AioContext *ctx;
>>>  };
>>> =20
>>>  extern const BlockExportDriver blk_exp_nbd;
>>> diff --git a/nbd/server.c b/nbd/server.c
>>> index 2bf30bb731..b735a68429 100644
>>> --- a/nbd/server.c
>>> +++ b/nbd/server.c
>>
>> [...]
>>
>>> @@ -1466,7 +1464,7 @@ static void blk_aio_attached(AioContext *ctx, voi=
d *opaque)
>>> =20
>>>      trace_nbd_blk_aio_attached(exp->name, ctx);
>>> =20
>>> -    exp->ctx =3D ctx;
>>> +    exp->common.ctx =3D ctx;
>>
>> (Not sure if I=CD=84=E2=80=99m missing anything to that regard), but per=
haps after
>> patch 21 we can move this part to the common block export code, and
>> maybe make it call a BlockExportDriver callback (that handles the rest
>> of this function).
>=20
> Could probably be done. Not every export driver may support switching
> AioContexts, but we can make it conditional on having the callback.

Good point.

> So do I understand right from your comments to the series in general
> that you would prefer to make this series more complete, even if that
> means that it becomes quite a bit longer?

I=E2=80=99m not necessarily asking for this now, I=E2=80=99m mostly asking =
whether you
have the same idea as me on things like this.  I don=E2=80=99t mind too muc=
h
leaving this in an unfinished state as long as we both agree that it=E2=80=
=99s
kind of unfinished.

Sorry if this is a bit frustrating to you because you wrote in the cover
letter that indeed you are unsure about how complete you want to do
this.  The problem is that I don=E2=80=99t know exactly what things you=E2=
=80=99re
referring to, so I just point out everything that stands out to me.  If
you=E2=80=99re aware of those things, and we can work on them later, then t=
hat=E2=80=99s OK.

OTOH...  Yes, from a design standpoint, I think it makes sense to pull
out as much specialized code as possible from NBD into the generalized
block export code.  But I say that as a reviewer.  You would have to do
that, so I want to leave it to you how much work you think is reasonable
to put into that.  Leaving a couple of rough edges here and there
shouldn=E2=80=99t be a problem.  (Or maybe leaving something to me for when=
 I
add fuse export code.)

Max


--CM4Zro4hcKlLeX8AVMaF54aztoaSK3xfe--

--nYnehHWijXtu6CQE09V62WHFBzLEdn4Qe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86poYACgkQ9AfbAGHV
z0APSwf/bcGLb5/NAbHuMt1UPXowO1q0jCFv17j4roXgAis82rLwV1XOypM5ylQ5
FEndzowsve5STodkiUnoi90Eq76944MfaBnl2YODbgaShy8F6t5MnKIwZ+gqpf6E
da+HbGlfcDBSDaEO72LH73+2fnDi+Q4gSGCKyErRI3xIc/fLPThA5uGAPgtcWOuw
av3W43rXARbDWU0fOZRvGp6FkEIYxnc7MowtrWAzaHx8H/+mmN6TXpwYQz0lP5Lp
bqibHW2rxIf18OSx4tzJtmTewSCw/ucoBJFm19kWQq73nQsVAnib2yQFYfDhsjSh
UXVWpKLynvVFo555FPUljrdWpBfWjQ==
=sLRa
-----END PGP SIGNATURE-----

--nYnehHWijXtu6CQE09V62WHFBzLEdn4Qe--


