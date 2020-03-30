Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51664C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C84720733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv6DO8mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C84720733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIscs-0007oO-Cd
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 07:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIsc1-0007Jd-Vd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 07:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIsc0-0005MO-8f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 07:29:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIsbz-0005Ki-VM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 07:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585567787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sN6F9QHgIcG/nVo+KA+QMxIB3SWceS48OgvGQUuLs18=;
 b=Iv6DO8mMp1gRtSFJIuQNITsoBsG7w52Kn15IrJQWtguqj50zCnA+bmXcdigD/bKKYRLkci
 7z7giNJH1p6k+zgSkNM9q1xKdevEMsiFb9W5sXjFpAOHzivDgmzOoZJVxwCy0ZdvzGI8Qr
 jGv7cLrRTrTHaCrrXCo6Z+GRtNKd8Eg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-tZT70Td5MMm61tUAF-8AQw-1; Mon, 30 Mar 2020 07:29:40 -0400
X-MC-Unique: tZT70Td5MMm61tUAF-8AQw-1
Received: by mail-wr1-f71.google.com with SMTP id f8so11131438wrp.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 04:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IuZBwXnn4ISM5sxqfX2r56IQ/nYSjMHc1VFMMCHYBPQ=;
 b=UvBsJqZporkuRgwy9ppxsGni7n5xyoS6cEA/ooxMkKuerlnRM1ZbOtMmbg16fmcefR
 80dMTGK4dI7DQKGjGImZcMnPnxLxFkbDgIlW4b4quAw9bnZ9hNPB0lJaiOb01hpJyMpX
 tIwqavIlVqG3E6Vabvtdj+RmSiWubNSNMWue6F/VD4VADY6S2l3jTIRJBLHw6W/dVls0
 wyLIn68G4Z11hwlJqSFlC1cmC+N9I29gNX3Inuv79y4kgwpyrGVuctqOSBRt+Z5Mpeh5
 lyejCLkvCBTHDajNrTuLWVssDmroYi2Ob6q2WcWeCTnDoVNgeBMCt7er4Lf14R25+mra
 /m/g==
X-Gm-Message-State: ANhLgQ3CTJ4niKxnKYmJ61217GwctQeqxSd/wFTaSkP1mTDzxx3a928t
 7huP8vLuzmnkSHR6CCWxPaRehkzSYEymua2RLm+aMiPVOh6DuYQrcylI8vKswAlGZQ+7dHbOd77
 8I44wuFNE30FTKFc=
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr10446930wme.88.1585567779617; 
 Mon, 30 Mar 2020 04:29:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt2gSoO1ASbTSE5KgB6z41nAOsqMpyqoY+HL5HNy5/MdqkZM0HLmXzQ7qO4HhGe5zKBfWO1kg==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr10446907wme.88.1585567779241; 
 Mon, 30 Mar 2020 04:29:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 195sm21050679wmb.8.2020.03.30.04.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 04:29:38 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v3] Acceptance test: Fix to EXEC migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200325113138.20337-1-ovoshcha@redhat.com>
 <c2007a51-318a-c935-dd77-232e45587b08@redhat.com>
 <CAMXCgj6dop2SFBnN3Yr6otxpMVSMMrh9_DdJw9SB3RV7z+eQ2Q@mail.gmail.com>
 <f644f1f2-90ab-0d6f-99c6-bae34f76df1f@redhat.com>
 <20200325151542.GB2589@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70de1163-060f-63fd-a080-c990e92017f5@redhat.com>
Date: Mon, 30 Mar 2020 13:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325151542.GB2589@work-vm>
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
 Oksana Voshchana <ovoshcha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer Moschetta <wainersm@redhat.com>, Cleber Rosa Junior <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 3/25/20 4:15 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> On 3/25/20 3:10 PM, Oksana Voshchana wrote:
>>> Hi=C2=A0Philippe
>>> Thanks for the review
>>> I have some comments
>>>
>>> On Wed, Mar 25, 2020 at 2:30 PM Philippe Mathieu-Daud=C3=A9
>>> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>>>
>>>      Hi Oksana,
>>>
>>>      v2 was
>>>      https://www.mail-archive.com/qemu-devel@nongnu.org/msg682899.html,=
 so
>>>      this is v3. Please increment the version in the patch subject.
>>>
>>>      You could also send a simple "ping" to the specific patch, instead=
 of
>>>      resending it.
>>>
>>>      On 3/25/20 12:31 PM, Oksana Vohchana wrote:
>>>       > The exec migration test isn't run a whole test scenario.
>>>       > This patch fixes it
>>>       >
>>>       > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com
>>>      <mailto:ovoshcha@redhat.com>>
>>>
>>>      v1 of this patch has already received reviewers tags
>>>      (https://www.mail-archive.com/qemu-devel@nongnu.org/msg679629.html=
),
>>>      please collect them and keep them when you resend the same patch:
>>>
>>> I have reposted patch without this fix because this change isn't relate=
d
>>> to the series:
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06919.html
>>> Is it make sense to keep this fix as a separate patch?
>>>
>>>      Fixes: 2e768cb682bf
>>>      Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>>>      <mailto:philmd@redhat.com>>
>>>      Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com
>>>      <mailto:wainersm@redhat.com>>
>>>
>>>       > ---
>>>       >=C2=A0 =C2=A0tests/acceptance/migration.py | 6 +++---
>>>       >=C2=A0 =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>>>       >
>>>       > diff --git a/tests/acceptance/migration.py
>>>      b/tests/acceptance/migration.py
>>>       > index a8367ca023..0365289cda 100644
>>>       > --- a/tests/acceptance/migration.py
>>>       > +++ b/tests/acceptance/migration.py
>>>       > @@ -70,8 +70,8 @@ class Migration(Test):
>>>       >
>>>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0@skipUnless(find_command('nc', defaul=
t=3DFalse), "'nc'
>>>      command not found")
>>>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_migration_with_exec(self):
>>>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>>>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 The test works for both netcat-tra=
ditional and
>>>      netcat-openbsd packages
>>>       > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 """
>>>       > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 """The test works for both netcat-=
traditional and
>>>      netcat-openbsd packages."""
>>>
>>>      Btw why are you changing the comment style?
>>>
>>> I got failure=C2=A0in PEP257
>>
>> OK, next time please add comment in the patch description too.
>>
>>>
>>>
>>>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_port =3D self._get=
_free_port()
>>>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest_uri =3D 'exec:nc -=
l localhost %u' % free_port
>>>       > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_uri =3D 'exec:nc localhost %u'=
 % free_port
>>>       > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_migrate(dest_uri, src_uri)
>>>       >
>>>
>>>      Alex, if there is no Python testing pullreq, can you take this pat=
ch
>>>      via
>>>      your testing tree?
>>
>> Cc'ing David since it is migration related.
>=20
> I tend to leave the tests/acceptance to someone other than the migration
> tree; so feel free to take them via testing or trivial given the size.

Acceptance tests are in the same tests/acceptance directory for no=20
particular reason. We thought they would share some common code but this=20
code is in the python/qemu/ directory.

Similarly to C Qtests stored in the tests/qtest, acceptance are in=20
tests/acceptance. tests/qtest have various maintainers, when a=20
maintainer has interest in a qtest (subsystem covered by the test), the=20
test is added to the subsystem maintained section. I'd rather see the=20
same with acceptance tests. For example with Oksana's test, I can review=20
that it correctly uses the acceptance testing framework, and it doesn't=20
break the rest of the tests, but I have no idea if it properly tests the=20
migration features it aims to.

Back to this particular patch, if Eduardo/Cleber ack I can send a=20
pullreq for rc2.

>=20
> Dave
>=20
>>>
>>>      Thanks,
>>>
>>>      Phil.
>>>
>>> Thanks
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


