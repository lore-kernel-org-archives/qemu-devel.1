Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D60CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0694C21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMiwFXmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37535 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHZz-000368-1y
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNHYA-00024M-DD
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNHY8-0005JE-S8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:23:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNHY5-0005Fc-3I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571840618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=852MNNpWoxzU+vbzauULoBdshCgX7n7YuDCoOQFJXo8=;
 b=AMiwFXmrNrEY6tBCLw7oL5CN/3FYiqVxlTvjzi5CXsTNp4RugA8NUYpSU+mAys6IKtEUkb
 Wm+4TymokcACD/nq9wToeJ5V+yVr3xWy72R0A0/kEAkSiNM8rNu4RPzw2hZRsO59qj/dB4
 32Q6JBy6JXGKiBuMELDtpfvtgkSiP+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-rI9CsMl8OG2w6m6zMy4OlQ-1; Wed, 23 Oct 2019 10:23:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08BFC80183D;
 Wed, 23 Oct 2019 14:23:34 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AA311001DC0;
 Wed, 23 Oct 2019 14:23:33 +0000 (UTC)
Subject: Re: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
To: Frediano Ziglio <fziglio@redhat.com>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-3-fziglio@redhat.com>
 <5f20705e-60bc-08d5-8b6e-72438afabefe@vivier.eu>
 <c2836c58-5a3c-2356-6e94-9b2341ab2194@redhat.com>
 <1860840671.8198083.1571840126307.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <21fd3aa0-232c-06e8-1e20-b5c98f125468@redhat.com>
Date: Wed, 23 Oct 2019 09:23:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1860840671.8198083.1571840126307.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rI9CsMl8OG2w6m6zMy4OlQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 9:15 AM, Frediano Ziglio wrote:
>>
>> On 10/23/19 8:42 AM, Laurent Vivier wrote:
>>> Le 23/10/2019 =C3=A0 14:26, Frediano Ziglio a =C3=A9crit=C2=A0:
>>>> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
>>>> ---
>>>>    util/qemu-timer.c | 6 +-----
>>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>>>> index d428fec567..094a20a05a 100644
>>>> --- a/util/qemu-timer.c
>>>> +++ b/util/qemu-timer.c
>>>> @@ -322,11 +322,7 @@ int qemu_timeout_ns_to_ms(int64_t ns)
>>>>        ms =3D DIV_ROUND_UP(ns, SCALE_MS);
>>>>   =20
>>>>        /* To avoid overflow problems, limit this to 2^31, i.e. approx =
25
>>>>        days */
>>>> -    if (ms > (int64_t) INT32_MAX) {
>>>> -        ms =3D INT32_MAX;
>>>> -    }
>>>> -
>>>> -    return (int) ms;
>>>> +    return (int) MIN(ms, (int64_t) INT32_MAX);
>>>>    }
>>
>> Why so many casts?  It should also work as:
>>
>> return MIN(ms, INT32_MAX);
>>
>=20
> This was former version. Laurent pointed out that MIN macro
> is using ternary operator which is expected to find the same time
> on second and third part so the cast inside the MIN macro.
> The cast before MIN was kept from previous code.

The C rules for ternary type promotion guarantee that the MIN macro=20
produces the correct type without the cast ('cond ? int64_t : int32_t'=20
produces int64_t).  I agree that the (int) cast was pre-existing, but as=20
long as we are cleaning up useless casts, we might as well clean up both.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


