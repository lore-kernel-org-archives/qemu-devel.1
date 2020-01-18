Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DF0C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E24824680
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyraxQWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E24824680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isu1X-0008Mi-Hq
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isthu-000232-Nc
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isths-0001oH-G9
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:24:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isths-0001nl-CZ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579375467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Yt0cLPEtWQSPHouvmP/tZdV+Nm8YIxHarzWfnOxaVo=;
 b=UyraxQWCtB5QRotNx/63Wiy7XZuOC5cpZZSTmpFKYiHlpQLvnx1swhqxQnoWNqB3JJnCEG
 vMfwb9gSY80u+4lkry5FssA1HaM8WXjlDxjYpIQfPD6Bxa0UPv0Dc7hP9SfqlTDyXkYzNc
 z0ch4ep+6d2GGbaG6lRwtEZ4X8im1Qo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-0Te6iRCSMuuRw4_8KlSZMA-1; Sat, 18 Jan 2020 14:24:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id r2so12014021wrp.7
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HVQGz5YSjkxifvvhIhHWjfL482L8+9+PoGYqgiTx25Q=;
 b=iy5OnxObRi4e51yXR8lUe+roMgYM13EVH05ps/4WF7LaT6YQk2bWAJ7D3KnagwMhK8
 bnqg+FA6BluI+aOMkPVPBEIGNQYVGzPnHkI67sD2dKWFvma6FtQMjzLgk3LEuYg0EqaF
 sdK9/s7wpBHU3UWV0phdtkgB7KcDtnMLow23J5OHsFywmqeCmSqfss18/zHkZ2vF1YSp
 g5jboH3zwzOYxviDa5aHwdYLfvrFecVHhV78ug5wZNwbchD8GeadA+xx6+qdodu4xjZ0
 UCb11a5W8W3JUswOE10ztbAiPhQjoK0lBZOpWEtWLlvWa+AXyd0e1R9hnaOPJck/2AGj
 VQeA==
X-Gm-Message-State: APjAAAVQg/BECXy0zKNSk2DgSd0QoTkd/vn67viUuyPyWxMYeNxEk1Vx
 sDuLF8Qf8yJBQAiPfdZ3grFaxT05tP1xctRqgewUBieVJ6w83+/PoqBKoyKnV0KnLncmjO2th3D
 twwW2cpAA4gvRhuM=
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr11144089wmg.178.1579375464908; 
 Sat, 18 Jan 2020 11:24:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzr2J7LFfbWffIMbkkV/P11lGmOvpf23+ujij+Fop3va/bWuyYFQlaPyZuyRXbCLuugRtCRlw==
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr11144060wmg.178.1579375464682; 
 Sat, 18 Jan 2020 11:24:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id h17sm41015708wrs.18.2020.01.18.11.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 11:24:24 -0800 (PST)
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
To: Markus Armbruster <armbru@redhat.com>,
 "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
References: <20191217173252.4672-1-philmd@redhat.com>
 <84fthiaahd.wl-Peter.Chubb@data61.csiro.au>
 <87a77q9njk.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97c34bbd-79d2-070e-a35e-4fdf68b2e291@redhat.com>
Date: Sat, 18 Jan 2020 20:24:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87a77q9njk.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: 0Te6iRCSMuuRw4_8KlSZMA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 07:05, Markus Armbruster wrote:
> "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
> writes:
>=20
>>>>>>> "Philippe" =3D=3D Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> w=
rites:
>>
>> Philippe> Fix some trivial warnings when building with -O3.
>>
>> For compatibility with lint and other older checkers, it'd be good to ke=
ep
>> this as /* FALLTHROUGH */ (which gcc should accept according to its
>> manual).
>=20
> We have hundreds of /* fall through */ comments already.
>=20
>> Fixing the comments' placement is a different matter, and should be
>> done.  Seems to me that until gcc started warning for this, noone had
>> actually run a checker, and the comments were just for human info.
>>
>> Peter C
>=20

Queued, thanks.

Paolo


