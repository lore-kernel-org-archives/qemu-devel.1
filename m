Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2823C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7F72077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyJf7J4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7F72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if614-0002mE-EA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1if606-0001Xr-9r
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1if605-0006kN-7i
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:42:14 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1if605-0006iT-1D
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:42:13 -0500
Received: by mail-wr1-x442.google.com with SMTP id q6so3508647wro.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7w2qYRD1PyIQCryf1XrpwNFROnS6qXPOLPmjqika46w=;
 b=OyJf7J4+sSpG4JhvpglwjZ40BXPMX96S5mNktFw+FI1FIIozN3F33CTucsirfEthlh
 8zgK1E/Zvnc2BC8gAenRKcEBKMbGqN5Flzn2GQkTGksEfH7PaHp+UM6sa+JTY7j7jee9
 WqJCzHxPzYRJsLoioiHqulSUcDqZH2Io/dLBkU30KdsDA5GSc33rbZbmAVeTHOYiY7N3
 PfKotTWxbBpLsZwmbzJSsNjteN+/88rIhClNbYhl6Lq3kfqK5Pc84iCX5cr4s6L+H2E0
 IOahHGY0NJ/EUO4iJEGUCeDSDudQysHODeAGYDll2DB/8skTWnNGtDnYpYA63PkKMRo0
 lrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7w2qYRD1PyIQCryf1XrpwNFROnS6qXPOLPmjqika46w=;
 b=Y2VJevWsqUdRG5e81h/CCI2V9/fFmHHoeA4hvxZyCKktL5Bm/LXIe6H9QXC29QSMjq
 pOGnwP6ZU6LbKv+EX1mcM3SOFSq9wQS4/VRr/cq0nXldvUv5RS+SG9Qy1VX+Q1oTZwjv
 MEr6j5p7+Aup5TlanbLsO61kVDdch19Dl3dpcqIoLxXVL6HWbAX1QCDQA0NEZeTzHwZN
 CDhM0sWYMH5zrra+pD++5yZujYzZRux5jxHTrjt3K3/v6GIn+G7IXeI332bqOvwfA4d1
 pq4kv3x0SdMQJSwqsa127Gma0kNitz4dGmFV9C6RhsW9GsJr5HJx4N6U2pomsLRpNxuD
 hCKg==
X-Gm-Message-State: APjAAAWQ1qTk0/fRrbiUAQocVyuRH/MLM6AZIz62lF2i4LgAgoaaN4VL
 ORaU0qhMjFJnqIP6Un/KCCbHUFiIL97MQQ3jM7CxTk1J
X-Google-Smtp-Source: APXvYqzWDcGlHx3aFm2diLCMEPyjAR0AZTJojl2XGSybnrnoMDkg9VdDKEEYUkLJym8neev7AecYuy4xRhfrwFhowiI=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr1075035wro.202.1576086131257; 
 Wed, 11 Dec 2019 09:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
 <20191201111531.1136947-26-marcandre.lureau@redhat.com>
 <fdf74ec2-5916-b885-c251-c768e9810584@redhat.com>
In-Reply-To: <fdf74ec2-5916-b885-c251-c768e9810584@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Dec 2019 21:41:56 +0400
Message-ID: <CAJ+F1CK9x0Q13M3f8PRjzVMxmgBfj6_bk80MmmykYpHkOvsB1Q@mail.gmail.com>
Subject: Re: [PATCH 25/26] qapi/qmp: add ObjectPropertyInfo.default-value
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Dec 11, 2019 at 8:12 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 12/1/19 5:15 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Report the default value associated with a property.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qapi/qom.json      | 7 ++++++-
> >   qom/qom-qmp-cmds.c | 4 ++++
> >   2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 32db96ffc4..471e4b484b 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -26,10 +26,15 @@
> >   #
> >   # @description: if specified, the description of the property.
> >   #
> > +# @default-value: the default value, if any (since 5.0)
> > +#
> >   # Since: 1.2
> >   ##
> >   { 'struct': 'ObjectPropertyInfo',
> > -  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> > +  'data': { 'name': 'str',
> > +            'type': 'str',
> > +            '*description': 'str',
> > +            '*default-value': 'str' } }
>
> Do we always want to output the stringized value, or would it be wise to
> make this 'any' and output integers where that makes sense?

Good point, it should work with 'any', I'll give it a try.

thanks


--=20
Marc-Andr=C3=A9 Lureau

