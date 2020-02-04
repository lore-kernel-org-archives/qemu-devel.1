Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639BFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAAB20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLUyBwL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAAB20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz8P-0002iK-D6
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iyz7l-0001yZ-Ay
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iyz7k-0000kK-7r
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:24:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iyz7k-0000hs-4A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580826259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJtjQFV3f+n0VJ7ZzztDF+IjuetOEByHZdSqzc9CbdU=;
 b=CLUyBwL+TvTHNKiEXqYioTx+ssaGDNmIqMhy9SDvIHbPtUAPKJONlV824J2h5rENH27m5L
 8gUK5hp9US/m1U173LuakM5Dd68NMTPTfGe8+CbxAAYniN/F3cbF8jOIf3Mlz61F0pSn07
 F18nLZVsfOHDqhQAp+bHVtK6QXHOC0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109--62nlImOPiOtn7CLMNhIfA-1; Tue, 04 Feb 2020 09:24:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0258801E72;
 Tue,  4 Feb 2020 14:24:00 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0F35DA2C;
 Tue,  4 Feb 2020 14:24:00 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
Date: Tue, 4 Feb 2020 08:23:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -62nlImOPiOtn7CLMNhIfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:

>> I understand that it is safer to have restrictions now and lift them=20
>> later, than to allow use of the option at any time and leave room for=20
>> the user to shoot themselves in the foot with no way to add safety=20
>> later.=C2=A0 The argument against no backing file is somewhat=20
>> understandable (technically, as long as the backing file also reads as=
=20
>> all zeroes, then the overall image reads as all zeroes - but why have=20
>> a backing file that has no content?); the argument requiring -n is a=20
>> bit weaker (if I'm creating an image, I _know_ it reads as all zeroes,=
=20
>> so the --target-is-zero argument is redundant, but it shouldn't hurt=20
>> to allow it).
>=20
> I know that it reads as all zeroes, only if this format provides zero=20
> initialization..
>=20
>>
>>> +++ b/qemu-img.c
>>
>>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("Thi=
s will become an error in future QEMU=20
>>> versions.");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--target-is-z=
ero requires use of -n flag");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> So I think we could drop this hunk with no change in behavior.
>=20
> I think, no we can't. If we allow target-is-zero, with -n, we'd better=20
> to check that what we are creating is zero-initialized (format has=20
> zero-init), and if not we should report error.
>=20

Good call.  Yes, if we allow --target-is-zero without -n, we MUST insist=20
that bdrv_has_zero_init() returns 1 (or, after my followup series,=20
bdrv_known_zeroes() includes BDRV_ZERO_CREATE).  I can work that into v2=20
of my series, if desired.

>>
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s.src_num =3D argc - optind - 1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out_filename =3D s.src_num >=3D 1 ? argv=
[argc - 1] : NULL;
>>> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s.target_has_backing =3D (bool) out_base=
img;
>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && s.target_has_backing) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Cannot use --=
target-is-zero with a backing=20
>>> file");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>
>> while keeping this one makes sense.=C2=A0 At any rate, typo fixes are=20
>> minor, and whether or not we drop the hunk I claim is a needless=20
>> restriction against redundancy,
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


