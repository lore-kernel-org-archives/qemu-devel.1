Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD5C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B29205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNbMccy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B29205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQxw-0004o6-Tg
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:07:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTQx0-0003xK-FN
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTQwy-0002nS-OG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:06:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hTQwy-0002kN-6F
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:06:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id 15so2137732wmg.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=gok4u72BbEisv/vBRFjWD9ydNQf3TCYkN9ifNXoOnkU=;
	b=XNbMccy5jyv1iiF8YHxgfqaubnxVE0RPQ91Eezf7w2m1tTJpaXbeyQAMo59uhrnOoX
	l6xG23LLh+RGA4OXj5tgzjDKI2Fddcvtwl5NVlq7Lr7Mpq6spgsH4JnPi2i8mN3sXCMi
	EYpMOC3bF6PwNnfIALcU9LHdiyqt+LN/ethSy4wsUF5FSHEjlMQxhvlcNv7sZnmaPbhz
	lPX8sxXAsKyv7r4RFstMYfRzdZTaY/47coPrqZhG7nd/C1+hvXiaafU4UYRxJ5Y5yJtB
	Eh+JKA1QPx8NtyND+wuesW8VBa0T/PQoAzQndJTx7on2tsDgP+jbzu3MtEPzDHFX0A13
	DCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=gok4u72BbEisv/vBRFjWD9ydNQf3TCYkN9ifNXoOnkU=;
	b=qBTmyuilGUt+Wj7Re7Zz4qYpfmUo7afnD8nWF//0jkYoIHijw0TR55tSj3Ag3PVE5Z
	36CAYy1WnyojcPwAHyrAJAzeuO31H4lZl/Nh75cKckH2dhcPrsmQBjSYMP2ZH3ertdLA
	2CnNy+64pPXXzU1xMqk3tpJqxI4emG41k8W2gHGoW00btdorjbkJKSpFNSZ9zPxDQViQ
	O28TH7FEyTBlA2Rk4D/sQoLILoy0js/VNE9/aYMf6tGohMY4oFi4UrAOlTUV5sSn3eRH
	qoU1l55A8ht7FHw+K9umeSPNIbfjlkWJ2ye5+KMfB0gTKqkZnaUl3rljncBcqnw+b3N3
	Olbg==
X-Gm-Message-State: APjAAAUIusWyrkvCxhyONrRY+kJ1IYoE/Ff8edL4isGfL0Q/8/x+CAER
	adh9LZNpdQKHT02PiRK/G9wy7w/C+GdQ6aZ0zhk=
X-Google-Smtp-Source: APXvYqyza9V2ewzJd/Ab5PvRZx/x8Fep1M29gH51x3ZqZB80EFU1uAYc57rmzTSp2NVyoNG3MVsZMN6JgHkI6QwGDt4=
X-Received: by 2002:a1c:c706:: with SMTP id x6mr1564966wmf.35.1558530388999;
	Wed, 22 May 2019 06:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190514104126.6294-1-marcandre.lureau@redhat.com>
	<20190514104126.6294-3-marcandre.lureau@redhat.com>
	<36d35842-d872-427b-accf-2d206a6c6b61@redhat.com>
	<CAJ+F1CL3KJpE_+XCXUMyffuCPwUOaqZCzHpxqv2q_BKdQVF_4w@mail.gmail.com>
	<20190522052322.wd4b5vynbd7ae6bm@sirius.home.kraxel.org>
In-Reply-To: <20190522052322.wd4b5vynbd7ae6bm@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 May 2019 15:06:17 +0200
Message-ID: <CAJ+F1CKcb2v4J-qH2Buq_pFMVWHasrmapXufa95Fe+hK7uXQJw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v4 2/3] libvhost-user: fix -Werror=format=
 on ppc64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, May 22, 2019 at 7:23 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, May 14, 2019 at 02:33:41PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, May 14, 2019 at 2:10 PM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> > >
> > > Hi Marc-Andr=C3=A9,
> > >
> > > On 5/14/19 12:41 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > > That should fix the following warning:
> > > >
> > > > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> > > > =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
> > > > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error=
:
> > > > format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98lon=
g long unsigned int=E2=80=99, but
> > > > argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> > > >          DPRINT("%s: region %d: Registered userfault for %llx + %ll=
x\n",
> > > >          ^
> > > > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error=
:
> > > > format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98lon=
g long unsigned int=E2=80=99, but
> > > > argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> > > > cc1: all warnings being treated as errors
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  contrib/libvhost-user/libvhost-user.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvho=
st-user/libvhost-user.c
> > > > index 40443a3daa..ab85166b15 100644
> > > > --- a/contrib/libvhost-user/libvhost-user.c
> > > > +++ b/contrib/libvhost-user/libvhost-user.c
> > > > @@ -663,8 +663,10 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, Vho=
stUserMsg *vmsg)
> > > >                       __func__, i);
> > > >              return false;
> > > >          }
> > > > -        DPRINT("%s: region %d: Registered userfault for %llx + %ll=
x\n",
> > > > -                __func__, i, reg_struct.range.start, reg_struct.ra=
nge.len);
> > > > +        DPRINT("%s: region %d: Registered userfault for %"
> > > > +               PRIu64 " + %" PRIu64 "\n", __func__, i,
> > >
> > > I guess you want PRIx64 in both places here.
> > >
> > > I'd put the '%' on the next line:
> > >
> > >            DPRINT("%s: region %d: Registered userfault for "
> > >                   "%" PRIx64 " + %" PRIx64 "\n", __func__, i,
> > >
> > > Using PRIx64:
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > indeed, thanks
> > Gerd, can you change it on commit?
>
> Fixed & queued.
>
> What is the status of the vhost-gpu series btw?
> It doesn't apply cleanly (simliar to v3 of this series),
> IIRC I've mentioned that a while back ...

I thought I replied to you. It is strange, because the last series I
sent did apply succesfully in patchew:
https://patchew.org/QEMU/20190513184433.21038-1-marcandre.lureau@redhat.com=
/

It didn't change much since then, I updated the doc to mention the
pixman format of bitmaps, and fixed some conflicts on rebase:
https://github.com/elmarco/qemu/tree/vhost-user-gpu

I'll resend once the input series is merged, unless you have more
comments to make on v7.

thanks!

--=20
Marc-Andr=C3=A9 Lureau

