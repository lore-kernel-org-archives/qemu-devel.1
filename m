Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCBC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF5820775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWRl5KZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF5820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7JP-0002zH-FA
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH7FC-0004BV-Q3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH7FA-0005hq-Lv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH7FA-0005hP-FG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585147375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfAomNY8/uNK7WZwlgyNTLtpWt6Kuc5QfhpyyVDI7PU=;
 b=GWRl5KZCwHNza/MTVu/VtAx2kj+4lun7o8VQeJGMsnBe37Imv2mqOZ5CviUf3BTAByi9sx
 fglOgTBu7BQggslYy+S2O4JkNsH7sIt6ZFJRs61EL+0NEBzB1j/j+cEMbtBScCMhrTScD3
 N1laoUymw298cPA2JNOQvJF/9OQOGE4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-9SpLq2v-MoebrXzhZraf6Q-1; Wed, 25 Mar 2020 10:42:52 -0400
X-MC-Unique: 9SpLq2v-MoebrXzhZraf6Q-1
Received: by mail-ed1-f71.google.com with SMTP id g7so2276445edm.20
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ko9mlVfrpCcl+CXuMvXwstQcTvUsmkMhv256HkwxEdE=;
 b=g9PnqXtyjOjg0yS4i+R0pZZ2qYInQHpNrl+R0nMTEZBQCrDW+nlbpdjIpzu1Y+BXot
 mm5Yn8TJCNwJI7ZM9XBJuqolX8WUY6/+P/UKWy8JicYAlr9m3qZ5GT6Xl8Ac0q3AMCiR
 r5MrdBzo3pTyHd0Uvr2nsiOdS3Vw0xeSplNlBK+ohRdxai2PeAKg3rWeFE9OH8s0svWf
 OhcZRhEhNyKT6Grjhlgbzqj7SHLo0KNNC8r7fwvmVPEMvxtLWGSkylRh54e9JoBSrwKL
 p2AuZHvusAkfJtOO8+2DqDzeByzP5RIVnKTU/muzJB0eUwmz/wI8h+LCcefRA0WQAwxF
 8B7g==
X-Gm-Message-State: ANhLgQ0DqGzzO6flFyALKwVZWwHiQ6ZhO69Sq38aSZGs95cGLBG+vRh3
 hFc17x77zflONZbB3VdHVGS/hCgVc0WO9u4VnBGmiaeEExyr7enxfenGulBofY+ERirN+Oac2rr
 cCbvBJ0EgnvXlQbU=
X-Received: by 2002:a50:f104:: with SMTP id w4mr3345003edl.258.1585147370470; 
 Wed, 25 Mar 2020 07:42:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv4G3zXtKetzjp/GqQd8JWYqoRim2hD1K/n3WQ4aX8Ia3b1RzUbpq4xa7wuemzO2b0tjzmV5w==
X-Received: by 2002:a50:f104:: with SMTP id w4mr3344981edl.258.1585147370200; 
 Wed, 25 Mar 2020 07:42:50 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d11sm102140ejd.2.2020.03.25.07.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 07:42:49 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v3] Acceptance test: Fix to EXEC migration
To: Oksana Voshchana <ovoshcha@redhat.com>
References: <20200325113138.20337-1-ovoshcha@redhat.com>
 <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
 <CAMXCgj6dop2SFBnN3Yr6otxpMVSMMrh9_DdJw9SB3RV7z+eQ2Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8335f630-c903-5fbd-f0e5-9dba1ed57b4a@redhat.com>
Date: Wed, 25 Mar 2020 15:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMXCgj6dop2SFBnN3Yr6otxpMVSMMrh9_DdJw9SB3RV7z+eQ2Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:10 PM, Oksana Voshchana wrote:
> Hi=C2=A0Philippe
> Thanks for the review
> I have some comments
>=20
> On Wed, Mar 25, 2020 at 2:30 PM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Oksana,
>=20
>     v2 was
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg682899.html, so
>     this is v3. Please increment the version in the patch subject.
>=20
>     You could also send a simple "ping" to the specific patch, instead of
>     resending it.
>=20
>     On 3/25/20 12:31 PM, Oksana Vohchana wrote:
>      > The exec migration test isn't run a whole test scenario.
>      > This patch fixes it
>      >
>      > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com
>     <mailto:ovoshcha@redhat.com>>
>=20
>     v1 of this patch has already received reviewers tags
>     (https://www.mail-archive.com/qemu-devel@nongnu.org/msg679629.html),
>     please collect them and keep them when you resend the same patch:
>=20
> I have reposted patch without this fix because this change isn't related=
=20
> to the series:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06919.html
> Is it make sense to keep this fix as a separate patch?

As we are in freeze and this is a fix, it is fine to reply to your own=20
patch with

"Ping? As this is a fix, can we get this single patch merged for 5.0=20
please? Thanks!"

You are responsible of tracking your own patches and ping them (every=20
week) if they are ignored.

>=20
>     Fixes: 2e768cb682bf
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com
>     <mailto:wainersm@redhat.com>>
>=20
>      > ---
>      >=C2=A0 =C2=A0tests/acceptance/migration.py | 6 +++---
>      >=C2=A0 =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>      >
>      > diff --git a/tests/acceptance/migration.py
>     b/tests/acceptance/migration.py
>      > index a8367ca023..0365289cda 100644
>      > --- a/tests/acceptance/migration.py
>      > +++ b/tests/acceptance/migration.py
>      > @@ -70,8 +70,8 @@ class Migration(Test):
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0@skipUnless(find_command('nc', default=
=3DFalse), "'nc'
>     command not found")
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_migration_with_exec(self):
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 The test works for both netcat-tradit=
ional and
>     netcat-openbsd packages
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 """The test works for both netcat-tra=
ditional and
>     netcat-openbsd packages."""
>=20
>     Btw why are you changing the comment style?
>=20
> I got failure=C2=A0in PEP257
>=20
>=20
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_port =3D self._get_fr=
ee_port()
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_uri =3D 'exec:nc -l l=
ocalhost %u' % free_port
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_uri =3D 'exec:nc localhost %u' % =
free_port
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_uri, src_uri)
>      >
>=20
>     Alex, if there is no Python testing pullreq, can you take this patch
>     via
>     your testing tree?
>=20
>     Thanks,
>=20
>     Phil.
>=20
> Thanks


