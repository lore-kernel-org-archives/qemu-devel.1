Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E357C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAC0206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGbu2YHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAC0206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwwjy-0000Wv-5S
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwwix-000898-Ra
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwwiw-00043S-HD
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:26:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwwiw-00042x-EG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580340377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKsIym+21Q6XwBYINKkF4dvPTUCiZoZDpJo6RCpkqS4=;
 b=CGbu2YHwdJHOH2sH6rTk3Q0IWQCgZz0UqpTsRjNvzGwc7puwVR47d+DdtH5uLPNeQHDYXd
 v10fM9JXqGtEs0S3HxhNCyPElWPG9Td/zamflIC9BYdO6iRxyMPTUehBmmuzsWkwmHgFHk
 IPplyEeZ0vJvFMpEvJCWAnszsqeS0MI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Svw0WaNlO0ioIzz9stgLNA-1; Wed, 29 Jan 2020 18:26:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id v17so764699wrm.17
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PbrkYSnwiU3DoSTlouGRF5c1IXa/nXTFES9duMFGTrY=;
 b=lEhHcYx6Rq4eGKFcMPd8ueStx5UqJzr3SkqEr79NM8cw8+eo6vsHLwVpt30ipRUkY6
 Oa+/+smEZy/jOQfTUZ1c8Kjkkierx91eAOT/IJDwMJ9/aSG0jcQflzi1m8clYcYjnw6a
 kofwl+Iu1FhEJfoNPEWtY+39Tb9xcGM5UbU6BAe7FtIwURnqyc06pbuJ1UKSUFnWSIM+
 KguxHtiWivrOIPfOjOlEeKIJ9MCjBqe41VwVXaPJ8K2NA/aXG0nLUrIS/Z6HDQA6MzZq
 a8nfqEHyRLX9lWyalTazrVz3K+rsX/WG+HObdaOfgqA5M+RL0hAL77SH3kCP573tOd77
 fJzQ==
X-Gm-Message-State: APjAAAW/qDs+FmrSRCSAdBF1bGbirhZ8zYNi/HAdjD0yxSosQjsc5ofc
 bVQZbIEggl8g5M5EPjwbHuejzoJUgLprFaQMvYESJYX+//sIyvKqXlgcx/9nxBgLjMm0aTcXUJK
 9gtSGwNViLZoHTcE=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr1495626wmf.113.1580340373651; 
 Wed, 29 Jan 2020 15:26:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1n3IrgMfgqQ1+WQSEwVMHqN3A2wGQOOdLb1aNBc1ubEoCeFvHflpJZ5uUYXoQA2MJVuazzw==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr1495613wmf.113.1580340373428; 
 Wed, 29 Jan 2020 15:26:13 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 5sm5107649wrh.5.2020.01.29.15.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 15:26:12 -0800 (PST)
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200109095116.18201-1-thuth@redhat.com>
 <CAL1e-=jnAMtpNNHO1rqG-63K_5uM-QfVYoMcj0NZeHwKCWG4uQ@mail.gmail.com>
 <af4485d4-1706-c464-2320-dff3b5f29fd7@redhat.com>
 <CAL1e-=iT9Ve7nVFHeMpcfNzwxtLK8Q5C2hbLRSv4PreLfR+3pQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <957baaa5-f160-09de-c101-8873b73aea7b@redhat.com>
Date: Thu, 30 Jan 2020 00:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iT9Ve7nVFHeMpcfNzwxtLK8Q5C2hbLRSv4PreLfR+3pQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Svw0WaNlO0ioIzz9stgLNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 12:18 AM, Aleksandar Markovic wrote:
> 23:14 Sre, 29.01.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=20
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>  >
>  > Hi Aleksandar,
>  >
>  > On 1/9/20 1:49 PM, Aleksandar Markovic wrote:
>  > >
>  > >
>  > > On Thursday, January 9, 2020, Thomas Huth <thuth@redhat.com=20
> <mailto:thuth@redhat.com>
>  > > <mailto:thuth@redhat.com <mailto:thuth@redhat.com>>> wrote:
>  > >
>  > >=C2=A0 =C2=A0 =C2=A0Python 2 support has been removed, so we should n=
ow also remove
>  > >=C2=A0 =C2=A0 =C2=A0the announcement text for the deprecation.
>  > >
>  > >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Thomas Huth <thuth@redhat.com=20
> <mailto:thuth@redhat.com> <mailto:thuth@redhat.com=20
> <mailto:thuth@redhat.com>>>
>  > >=C2=A0 =C2=A0 =C2=A0---
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-deprecated.texi | 8 --------
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 8 deletions(-)
>  > >
>  > >
>  > > Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>
>  > > <mailto:amarkovic@wavecomp.com <mailto:amarkovic@wavecomp.com>>>
>  >
>  > I use pwclient to collect patchwork patches, this one is:
>  > https://patchwork.kernel.org/patch/11325373/
>  > Your comment is listed, but your tag is ignored... I am not sure why.
>  >
>  > John used:
>  > Content-Transfer-Encoding: 7bit
>  >
>  > You:
>  > Content-Transfer-Encoding: quoted-printable
>  >
>  > This might be why? I have no clue.
>  >
>=20
> It could be. I use a variety of mail clients. Not all provide the same=20
> level of control of sent mails format. Almost sure they have different=20
> settings. I may do some experimentation on a suitable patch series.=20
> Thanks for noticing it.
>=20
> OR: I wrote "Reviewed by:" without hyphen.

Oh you are right, I didn't notice.

>=20
> Reviewed-by: Aleksandar Markovic=C2=A0 <amarkovic@wavecomp.com=20
> <mailto:amarkovic@wavecomp.com>>
>=20
> Is now patchwork picking it up?

Yes (1 extra space after your name).

Thanks.

>=20
>  > >
>  > >=C2=A0 =C2=A0 =C2=A0diff --git a/qemu-deprecated.texi b/qemu-deprecat=
ed.texi
>  > >=C2=A0 =C2=A0 =C2=A0index 7033e531de..8b23e98474 100644
>  > >=C2=A0 =C2=A0 =C2=A0--- a/qemu-deprecated.texi
>  > >=C2=A0 =C2=A0 =C2=A0+++ b/qemu-deprecated.texi
>  > >=C2=A0 =C2=A0 =C2=A0@@ -341,14 +341,6 @@ they have no effect when use=
d with @option{-n}
>  > >=C2=A0 =C2=A0 =C2=A0to skip image creation.
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0Silently ignored options can be confusing,=
 so this combination of
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0options will be made an error in future ve=
rsions.
>  > >
>  > >=C2=A0 =C2=A0 =C2=A0-@section Build system
>  > >=C2=A0 =C2=A0 =C2=A0-
>  > >=C2=A0 =C2=A0 =C2=A0-@subsection Python 2 support (since 4.1.0)
>  > >=C2=A0 =C2=A0 =C2=A0-
>  > >=C2=A0 =C2=A0 =C2=A0-In the future, QEMU will require Python 3 to be =
available at
>  > >=C2=A0 =C2=A0 =C2=A0-build time.=C2=A0 Support for Python 2 in script=
s shipped with QEMU
>  > >=C2=A0 =C2=A0 =C2=A0-is deprecated.
>  > >=C2=A0 =C2=A0 =C2=A0-
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0@section Backwards compatibility
>  > >
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0@subsection Runnability guarantee of CPU m=
odels (since 4.1.0)
>  > >=C2=A0 =C2=A0 =C2=A0--
>  > >=C2=A0 =C2=A0 =C2=A02.18.1
>  > >
>  > >
>  >
>=20


