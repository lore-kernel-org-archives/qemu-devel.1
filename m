Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418FC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9A620658
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBeYWbiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9A620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6oq-0006sM-GY
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH6no-00062I-Ib
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH6nn-0006Db-5n
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:14:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH6nn-0006Cx-2g
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585145677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grQqRuhXziR2vVbVzmwg83b5TH1xbADjsNkv713LiqQ=;
 b=JBeYWbiRGtUs9NkihEJyT5LO6OHuINeB76ozv/4A+ujp8lvdPluyIIaofwP5ceddIDRMjX
 S3bPCtDlPqS0g20Ohtp742PAvLpi+r4XC56RLAcc7tDETtCkCxJtDtjwAzKd/KVdPB81EK
 fr8K6FfVr5pYRlmEn8Vo6KF5XVsZejE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-WVZOJ2q3NCqpM-oChPpv4Q-1; Wed, 25 Mar 2020 10:14:36 -0400
X-MC-Unique: WVZOJ2q3NCqpM-oChPpv4Q-1
Received: by mail-ed1-f69.google.com with SMTP id i10so2227696edk.13
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lj0Hi/Uhpi+HMTGnD9kO4A2DGD/rq8kFsQ/Jl8ZeBAY=;
 b=IyuvItxP9u8KFoCQ4s4rhYP3HeX1qkPuAUSBIK7IZdW739N2I0I2Xmu06b866D7PFN
 jUlNEv0zvRGeZ3WBeQxJZcJqE3VyD7Z33qASnCCLiOSoSGQFtESOSBdCVC3sJZ1jc47o
 cCBpzqSfwL5hOMjlozZYgkg6Z2tLdvfxzU0qnPXyLw+YEcEgkDXhdM1BuzJ7VNqbKfVZ
 8PzYb955s+nkz6GX9mj9afAoGlVuaq1KnMVhKLBJTePDAIMAJSGQcd1bnMtoTcVCs8Do
 C4R0wtYYAl+7c/boW/pMeV67oGkX0jYrlQ47yClcmgJYcrPDXPEitHMWhSMwhXraS+x9
 cm+Q==
X-Gm-Message-State: ANhLgQ0k/AgiMaXwM2lcn4/GpNWFvuEg92kG7DVrgrbYEtv/4I/0na9N
 mgkHVuzUNO7688H6HH5ov3yiO56Yj8iMvArzFplF+nDtkN85lBIIeU3LDNeaiS6FSv/R7C0mKQJ
 xg04zEHA0gIXdKzg=
X-Received: by 2002:a50:fc83:: with SMTP id f3mr3003639edq.38.1585145674566;
 Wed, 25 Mar 2020 07:14:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsamI9eV35sXGteT6AwH27iovWi+kCCEmz3GULk+4/oLPhD0Llv/4Qz+5GBsS5iGgPG9zcppg==
X-Received: by 2002:a50:fc83:: with SMTP id f3mr3003601edq.38.1585145674232;
 Wed, 25 Mar 2020 07:14:34 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id k6sm5446ejr.32.2020.03.25.07.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 07:14:33 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v3] Acceptance test: Fix to EXEC migration
To: Oksana Voshchana <ovoshcha@redhat.com>
References: <20200325113138.20337-1-ovoshcha@redhat.com>
 <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
 <CAMXCgj6dop2SFBnN3Yr6otxpMVSMMrh9_DdJw9SB3RV7z+eQ2Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f644f1f2-90ab-0d6f-99c6-bae34f76df1f@redhat.com>
Date: Wed, 25 Mar 2020 15:14:32 +0100
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer Moschetta <wainersm@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Cleber Rosa Junior <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
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

OK, next time please add comment in the patch description too.

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

Cc'ing David since it is migration related.

>=20
>     Thanks,
>=20
>     Phil.
>=20
> Thanks


