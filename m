Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59497C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BE32070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI66YyeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BE32070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmgS-0007s3-Ap
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iwmfs-0007TV-EK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iwmfr-0001Pt-2p
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:42:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iwmfq-0001PF-UI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580301746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aY1sWr4irpfzVsn1QLhKIPpO5PJ/ND1arLb9MahDEwk=;
 b=aI66YyeL6TGoE+SUrTVhiFPnQBMNqUORtfHsLgXmOIbDdjwcScaeTSW+RgSN8MxZzYwXMf
 All8EZaBjSBKAP3YtjKxjJfbl8Q1xSCEO5EXF9sOrAUj65+upKD09GhfvNeXdDmlrZgkPi
 dIwyuyS0pzvnnqLq6HPdxYEzRuvLRAc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-eBK_D0P5Og2azg1KN-pjrw-1; Wed, 29 Jan 2020 07:42:21 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so9906482wrm.18
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 04:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yJBYgakaPu3h3vluFvcgbuWgcqDmE1VEiR1wFSkRqxc=;
 b=BhWgNI8MzcDVWivxWffjUHwoD5PAKKa1xNlM4F3iv18XA5JyxkVLlpxGdauWnvh1TC
 Dq7Ka3OqqJDlhBfd3ni6iWOTFRQ6SnZlGU4vFR0q7QKvsjJe3pXndo1AsoKRfVsFHaLZ
 rMvjQUkjAco2crOv3eBbSfE1mJKYOxva2xaOZePOAp3JNt/UX/dYCdb2L0rl5o3aM1Ry
 CI8RJsKKAfYAGTcIwV3pCltKdPtwXGFUuP+/dIac1Wh7nBi55fRJqf+OkKx5NxpZpCpd
 iacOhnI5tZGt4oBFD/yV6bKqdrmc8LMzIXdEldIkC7tPAEgrzZ3wOxh84Cslq3i1RrW1
 PMQg==
X-Gm-Message-State: APjAAAWo1SJX/CIAQkxx4vXWzTRqVdWVrNbGPesZYYQzJbCxOfwJocAN
 8sYnRZS9j8MFXhGmg9dYyIhIM15Akbx3IoxWOvR6WCP7UrSXIVkvRYn93/un9N3eYS+Uxt2NMbD
 xFGii+wFELP1FPew=
X-Received: by 2002:adf:806c:: with SMTP id 99mr939942wrk.328.1580301740493;
 Wed, 29 Jan 2020 04:42:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlkemR0hATfq9l8Pw6FkvD5f7xoECb8LMP91WxmgAf+c24zDZjNcIzgK+EeF/37Jh1jFVyNA==
X-Received: by 2002:adf:806c:: with SMTP id 99mr939915wrk.328.1580301740127;
 Wed, 29 Jan 2020 04:42:20 -0800 (PST)
Received: from [10.43.2.11] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id q130sm2180555wme.19.2020.01.29.04.42.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Jan 2020 04:42:19 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Integrating QOM into QAPI
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <20200128100356.GF1446339@redhat.com>
Date: Wed, 29 Jan 2020 13:42:18 +0100
Message-Id: <2DCB83EB-D123-487D-9173-0260B73F60D6@redhat.com>
References: <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
 <CAFEAcA9xtwNzZQS7biDy=LtZEiLDis3iQztOcP2+2NnCj80c0Q@mail.gmail.com>
 <B442E0A6-E0C5-426A-8234-EE6491AE4BB0@redhat.com>
 <20200128100356.GF1446339@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-MC-Unique: eBK_D0P5Og2azg1KN-pjrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 28 Jan 2020, at 11:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
>=20
> On Mon, Jan 27, 2020 at 08:05:36PM +0100, Christophe de Dinechin wrote:
>>=20
>>=20
>>> On 26 Jan 2020, at 16:04, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>>>=20
>>> On Sun, 26 Jan 2020 at 08:10, Christophe de Dinechin
>>> <dinechin@redhat.com> wrote:
>>>> I=E2=80=99m still puzzled as to why anybody would switch to something =
like
>>>> GObject when there is C++.
>>>=20
>>> I'm fairly strongly against using C++.
>>=20
>> Just to be clear, so am I ;-)
>>=20
>>> C++'s language design
>>> is an "everything including the kitchen sink, lots of "this
>>> is here for back compat but it's a bear trap", lots of new
>>> stuff arriving all the time.
>>=20
>> Actually, the new stuff is not that bad, overall.
>>=20
>> I do agree C++ is an overly complicated language, and that in
>> practice, there is zero chance of qemu moving to it. But that does
>> not invalidate my point that creating a class in C++ is easier
>> than creating a class in any C-based macro-heavy reinvention
>> of basic OO concepts.
>>=20
>> (I write this after having read Paolo=E2=80=99s response, which points
>> out IMO better reasons for GObject, which I will discuss there).
>>=20
>>> It's just too big to keep in
>>> your head all at once. C has its faults, absolutely, but at
>>> least it tries to be a reasonably sized vaguely coherent
>>> language.
>>>=20
>>> You'd have more luck persuading me we should move to Rust:
>>> at least then we'd get some clear benefits (no more buffer
>>> overrun security bugs) for the upheaval :-)
>>=20
>> This is largely a myth as soon as you need to do =E2=80=9Cyour own stuff=
=E2=80=9D.
>> Example: CVE-2019-18960, https://seclists.org/oss-sec/2019/q4/141.
>=20
> Calling it a "myth" from from that one data point is not really credible.

A single failure is enough to credibly counter any =E2=80=9Cno more X=E2=80=
=9D claim ;-)

Also, I carefully qualified that as for =E2=80=9Cyour own stuff=E2=80=9D. I=
OW, if you write
your own buffer management, Rust does not help. Well, dealing with
guest memory forces us to have our own buffer management.

>=20
> No language is perfect & such that it can eliminate all possible CVEs.
> Rust *can*, however, eliminate a very large set of bugs which lead to=20
> memory corruption in unchecked languages like C/C++.

The Rust hype today eerily reminds me so strongly of the C++ hype
20 years ago. C++ too was supposed to be a safer C. And indeed,
if you stick to the standard library, you _do_ eliminate a very large set
of bugs which lead to memory corruption, leaks, etc in C. So the
claim C++ made was not wrong. The claim Rust makes is not wrong
either. The false sense of safety that some people get from it is.


>  You'll still have
> CVEs to deal with, but they'll be different classes of bugs, or rare
> edge cases like the one you show above.

How exactly was it an =E2=80=9Cedge case=E2=80=9D? From what I saw, it was =
the most
basic kind of range check, exactly the kind that you see in 99.9% of all
range checks.

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20


