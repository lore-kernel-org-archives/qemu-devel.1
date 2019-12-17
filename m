Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7515DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403F720663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfcTeXli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403F720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDd9-0004Jp-8x
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ihDax-0001U2-TR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ihDat-0007Ex-Ee
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:13:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ihDat-0007DU-8Q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576591978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIJyItGW3B3r9ZdfHE3Ip9JfHiaX/x7roJ1pTIQl5tc=;
 b=WfcTeXlilsZajOKxeaNCHBdSj2Y8jwUhDK8P5B64Y2nRIQvNb0XC4rl9nn84sUEhqC8Zt8
 Vs481TmOSd/pMBbyCwkTlu7JjduQPzkikBYDpECWJsYm0eIcc9/lAxEpFN9WyetnVglx9v
 7h7AvZvP2h+jfzPcsg0W3pZuT7x1Sso=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-CB0uFGaNMeCsBnKVs1w6PQ-1; Tue, 17 Dec 2019 09:12:56 -0500
Received: by mail-wm1-f69.google.com with SMTP id 7so601007wmf.9
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=GnQl3AJ6NBwV0jqXmnjdp4U2S899O4TWHpt8NW46D7A=;
 b=FhKyINdQp3JRprbPlLmBjfqswED9B6vCpWhodsuvWYiHjn4AGx/OkDPN+wzh8TX9dm
 QKZtNbxpJOCj0EgFb0rCdLbe2c/X++swEexsGGlGAGOz7C90stfRlEZDRHX3peAm1K5g
 TtL6SJ9Fj4VD7/3NVKjJ2AYrUs8QEOffsP4m5DZxcfCIHl8mkL5H+b3/yCreB4J+gwEV
 EKM2vOc/f9CTkivXh+2/Z+piVHBhNjO+eKVjY9FyiLDIsiuKTEzg+5qxcruned4ADmBE
 BZt7gsWjMnx66m+ynSwOyTOwpWW9c0bO8YOwT+fGwe/BKW4irxjpEOZ1GV1tggaZWC+Y
 Tpug==
X-Gm-Message-State: APjAAAXLyXK7SHJMcJcdaHYw0PVk2UZ9Auhhdxvu3D7UtXLw7fSldQUU
 ZDlijLfD1FxBkEZSfzOlwCCRMEsy94HhxRsIzF/CdxNmcWUEWJDHBNttvS+CxJO3EuoYyh7P5n5
 gzsjNE2SZe6sixw8=
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr36881751wrj.225.1576591975297; 
 Tue, 17 Dec 2019 06:12:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4QgGJ6VQaoAV03eJE6XrD6U8vNZ1XfCTA1mUScXK/0SxYtfGcvQl5Bi0ufBXWfLN6KlYlOw==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr36881731wrj.225.1576591975027; 
 Tue, 17 Dec 2019 06:12:55 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1c42:ed63:2256:4add?
 ([2a01:e0a:466:71c0:1c42:ed63:2256:4add])
 by smtp.gmail.com with ESMTPSA id n14sm3064533wmi.26.2019.12.17.06.12.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 06:12:54 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <87v9qfcae1.fsf@dusky.pond.sub.org>
Date: Tue, 17 Dec 2019 15:12:52 +0100
Message-Id: <50B6643C-78A7-4724-8A0B-3D51B1898FFE@redhat.com>
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <64E0F779-B750-4766-9978-58A8B4737839@redhat.com>
 <87v9qfcae1.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: CB0uFGaNMeCsBnKVs1w6PQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: mdroth@linux.vnet.ibm.com, Tao Xu <tao3.xu@intel.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Dec 2019, at 15:08, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Christophe de Dinechin <dinechin@redhat.com> writes:
>=20
>>> On 5 Dec 2019, at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
>>>=20
>>> Tao Xu <tao3.xu@intel.com> writes:
>>>=20
>>>> Parse input string both as a double and as a uint64_t, then use the
>>>> method which consumes more characters. Update the related test cases.
>>>>=20
>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>> ---
>>> [...]
>>>> diff --git a/util/cutils.c b/util/cutils.c
>>>> index 77acadc70a..b08058c57c 100644
>>>> --- a/util/cutils.c
>>>> +++ b/util/cutils.c
>>>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const ch=
ar **end,
>>>>                      const char default_suffix, int64_t unit,
>>>>                      uint64_t *result)
>>>> {
>>>> -    int retval;
>>>> -    const char *endptr;
>>>> +    int retval, retd, retu;
>>>> +    const char *suffix, *suffixd, *suffixu;
>>>>    unsigned char c;
>>>>    int mul_required =3D 0;
>>>> -    double val, mul, integral, fraction;
>>>> +    bool use_strtod;
>>>> +    uint64_t valu;
>>>> +    double vald, mul, integral, fraction;
>>>=20
>>> Note for later: @mul is double.
>>>=20
>>>> +
>>>> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
>>>> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);
>>>> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);
>>>> +
>>>> +    /*
>>>> +     * Parse @nptr both as a double and as a uint64_t, then use the m=
ethod
>>>> +     * which consumes more characters.
>>>> +     */
>>>=20
>>> The comment is in a funny place.  I'd put it right before the
>>> qemu_strtod_finite() line.
>>>=20
>>>> +    if (use_strtod) {
>>>> +        suffix =3D suffixd;
>>>> +        retval =3D retd;
>>>> +    } else {
>>>> +        suffix =3D suffixu;
>>>> +        retval =3D retu;
>>>> +    }
>>>>=20
>>>> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>>>>    if (retval) {
>>>>        goto out;
>>>>    }
>>>=20
>>> This is even more subtle than it looks.
>>=20
>> But why it is even necessary?
>>=20
>> The =E2=80=9Ccontract=E2=80=9D for the function used to be that it retur=
ned rounded values
>> beyond 2^53, which in itself is curious.
>>=20
>> But now it=E2=80=99s a 6-dimensional matrix of hell with NaNs and barfno=
ts, when the
>> name implies it=E2=80=99s simply doing a text to u64 conversion=E2=80=A6
>>=20
>> There is certainly a reason, but I=E2=80=99m really curious what it is :=
-)
>=20
> It all goes back to commit 9f9b17a4f0 "Introduce strtosz() library
> function to convert a string to a byte count.".  To support "convenient"
> usage like "1.5G", it parses the number part with strtod().  This limits
> us to 53 bits of precision.  Larger sizes get rounded.
>=20
> I guess the excuse for this was that when you're dealing with sizes that
> large (petabytes!), your least significant bits are zero anyway.
>=20
> Regardless, the interface is *awful*.  We should've forced the author to
> spell it out in all its glory in a proper function contract.  That tends
> to cool the enthusiasm for "convenient" syntax amazingly fast.
>=20
> The awful interface has been confusing people for close to a decade now.
>=20
> What to do?

I see. Thanks for the rationale. I knew it had to make sense :-)

I=E2=80=99d probably avoid strtod even with the convenient syntax above.
Do you want 1.33e-6M to be allowed? Do we want to ever
accept or generate NaN or Inf values?

>=20
> Tao Xu's patch tries to make the function do what its users expect,
> namely parse a bleepin' 64 bit integer, without breaking any of the
> "convenience" syntax.  Turns out that's amazingly subtle.  Are we making
> things less confusing or more?


