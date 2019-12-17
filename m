Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E96A21582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJLvT7dE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E96A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDXS-0007dr-I2
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihDWr-0007Bk-F8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihDWo-000298-62
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:08:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihDWn-000288-UE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576591724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wK2Bn89Z3S517rx4oPUqolKMCqVn1ATMoPralDA8AwY=;
 b=iJLvT7dERiR5OMyOcMaR+vNKvFLdgs2+0zXRQBj/t0w0JyiKCp/1YnQa9U20Gem5Zchf6o
 CTU3hnSwn2pHRFvOklfSj+kX/ZLPudW7JMGL4AXJybuVrsFM7PU5lX777QPqECpe+F8qJu
 WhMKgPaQ138Gi9lhju33ILyClyzoyMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-W8Y60UMeNcieBrxjQxTjwQ-1; Tue, 17 Dec 2019 09:08:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76488107ACE3;
 Tue, 17 Dec 2019 14:08:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC95F1001281;
 Tue, 17 Dec 2019 14:08:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8018311386A7; Tue, 17 Dec 2019 15:08:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <64E0F779-B750-4766-9978-58A8B4737839@redhat.com>
Date: Tue, 17 Dec 2019 15:08:38 +0100
In-Reply-To: <64E0F779-B750-4766-9978-58A8B4737839@redhat.com> (Christophe de
 Dinechin's message of "Tue, 17 Dec 2019 13:04:22 +0100")
Message-ID: <87v9qfcae1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: W8Y60UMeNcieBrxjQxTjwQ-1
X-Mimecast-Spam-Score: 0
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
Cc: mdroth@linux.vnet.ibm.com, Tao Xu <tao3.xu@intel.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

>> On 5 Dec 2019, at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> Tao Xu <tao3.xu@intel.com> writes:
>>=20
>>> Parse input string both as a double and as a uint64_t, then use the
>>> method which consumes more characters. Update the related test cases.
>>>=20
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
>> [...]
>>> diff --git a/util/cutils.c b/util/cutils.c
>>> index 77acadc70a..b08058c57c 100644
>>> --- a/util/cutils.c
>>> +++ b/util/cutils.c
>>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const cha=
r **end,
>>>                       const char default_suffix, int64_t unit,
>>>                       uint64_t *result)
>>> {
>>> -    int retval;
>>> -    const char *endptr;
>>> +    int retval, retd, retu;
>>> +    const char *suffix, *suffixd, *suffixu;
>>>     unsigned char c;
>>>     int mul_required =3D 0;
>>> -    double val, mul, integral, fraction;
>>> +    bool use_strtod;
>>> +    uint64_t valu;
>>> +    double vald, mul, integral, fraction;
>>=20
>> Note for later: @mul is double.
>>=20
>>> +
>>> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
>>> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);
>>> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);
>>> +
>>> +    /*
>>> +     * Parse @nptr both as a double and as a uint64_t, then use the me=
thod
>>> +     * which consumes more characters.
>>> +     */
>>=20
>> The comment is in a funny place.  I'd put it right before the
>> qemu_strtod_finite() line.
>>=20
>>> +    if (use_strtod) {
>>> +        suffix =3D suffixd;
>>> +        retval =3D retd;
>>> +    } else {
>>> +        suffix =3D suffixu;
>>> +        retval =3D retu;
>>> +    }
>>>=20
>>> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>>>     if (retval) {
>>>         goto out;
>>>     }
>>=20
>> This is even more subtle than it looks.
>
> But why it is even necessary?
>
> The =E2=80=9Ccontract=E2=80=9D for the function used to be that it return=
ed rounded values
> beyond 2^53, which in itself is curious.
>
> But now it=E2=80=99s a 6-dimensional matrix of hell with NaNs and barfnot=
s, when the
> name implies it=E2=80=99s simply doing a text to u64 conversion=E2=80=A6
>
> There is certainly a reason, but I=E2=80=99m really curious what it is :-=
)

It all goes back to commit 9f9b17a4f0 "Introduce strtosz() library
function to convert a string to a byte count.".  To support "convenient"
usage like "1.5G", it parses the number part with strtod().  This limits
us to 53 bits of precision.  Larger sizes get rounded.

I guess the excuse for this was that when you're dealing with sizes that
large (petabytes!), your least significant bits are zero anyway.

Regardless, the interface is *awful*.  We should've forced the author to
spell it out in all its glory in a proper function contract.  That tends
to cool the enthusiasm for "convenient" syntax amazingly fast.

The awful interface has been confusing people for close to a decade now.

What to do?

Tao Xu's patch tries to make the function do what its users expect,
namely parse a bleepin' 64 bit integer, without breaking any of the
"convenience" syntax.  Turns out that's amazingly subtle.  Are we making
things less confusing or more?


