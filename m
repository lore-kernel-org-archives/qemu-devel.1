Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FB6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F361C206D5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzapCdL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F361C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9r4W-0003xA-Vw
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9r2h-0002Uc-7W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9r2f-0003RI-LT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:00:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9r2f-0003Q8-GB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583416800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bI0iCfiamLeEOlmfWmRkJ5EiM2hPPw5h7iy2jORdykg=;
 b=gzapCdL4smM/35amX+HE0qjAp/ZDYZ7NuyQWR/XLGW/vHQ0b2YeHYHy/pIjNBOH9uFJp87
 45H4+xTCiPxP3m86nBi7hdQJ3laaYnxnKrD2qIGANScF+fqsqtrD60ePzXFjiYiAfGSkVb
 vfR8cP+tISwIBnHTb3kUxP5Y3OJVR4Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-lQ3biu0-Pk28x00NPqrg4A-1; Thu, 05 Mar 2020 08:59:59 -0500
X-MC-Unique: lQ3biu0-Pk28x00NPqrg4A-1
Received: by mail-wr1-f70.google.com with SMTP id q18so2345830wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=u8jd0a0+Xax7mUAYuC9xZiQiejfDA6QnsCIrTtfC9sU=;
 b=LS/XhoWsSui+1LGxq8SzM6U46t19D+pMmaI6Gy3nO+ZX7E27LuguVlwx335Ba3P1Vl
 SwLpWViuXPn6aLBhOXyvevneC0+IWpGahjz13h7SJRTWK+R8M/dPSj8Viury+V/abJHx
 a2BMyiutTmHv6WEDdKU588eQL9Nz4LxbKelr8pnolxRkLylVUGiKAKDWeLs1MdIZM33F
 Pobvt3ao0zarvfsgX3JiTbicj0z3ZIbelniz1VFvvbD4R4lRCKXQfrswrxm+5+P5plA7
 bFp0IQhjlJX7IDD+Ou0jZdi3E5D+7o07VCCff0TKhrGpRvUpUQuyxfwffO/3ITFR8gAY
 QunA==
X-Gm-Message-State: ANhLgQ2P287B1raDUY9TnVLVaGZTP01jdrWWse97JurywxXudJYtpiv1
 YXB5bKR95tZ2BjQ3Yvb+U+1SQYBGWbFdm8RrSRNt5N+KVAFqdsIiHeQ16K3UYejngQyozeOpg6e
 35F5F97EWd64589I=
X-Received: by 2002:adf:d4d1:: with SMTP id w17mr4133194wrk.206.1583416798019; 
 Thu, 05 Mar 2020 05:59:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtjEL1EUYiWx20HGAbu7L3jUMDJx1yfopfkBinXSHcbx3hKoL/XDiW6l4gy3l9mbC3NbrZKUA==
X-Received: by 2002:adf:d4d1:: with SMTP id w17mr4133167wrk.206.1583416797769; 
 Thu, 05 Mar 2020 05:59:57 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id n11sm11090406wrw.11.2020.03.05.05.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 05:59:57 -0800 (PST)
Date: Thu, 5 Mar 2020 14:59:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/audio/fmopl: Move ENV_CURVE to .heap to save
 32KiB of .bss
Message-ID: <20200305135955.balxqnfpmxvsee5b@steredhat>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305124525.14555-3-philmd@redhat.com>
 <20200305134403.sagzdlf5iyk2iufs@steredhat>
 <20200305134837.ucdb6blcguyfrh6d@steredhat>
 <467b8f3a-7d11-8a10-009f-5e1affadea69@redhat.com>
MIME-Version: 1.0
In-Reply-To: <467b8f3a-7d11-8a10-009f-5e1affadea69@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 02:50:47PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/5/20 2:48 PM, Stefano Garzarella wrote:
> > On Thu, Mar 05, 2020 at 02:44:03PM +0100, Stefano Garzarella wrote:
> > > On Thu, Mar 05, 2020 at 01:45:18PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> > > > This buffer is only used by the adlib audio device. Move it to
> > > > the .heap to release 32KiB of .bss (size reported on x86_64 host).
> > > >=20
> > > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > ---
> > > >   hw/audio/fmopl.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> > > > index 173a7521f2..356d4dfbca 100644
> > > > --- a/hw/audio/fmopl.c
> > > > +++ b/hw/audio/fmopl.c
> > > > @@ -186,7 +186,7 @@ static int32_t *VIB_TABLE;
> > > >   /* envelope output curve table */
> > > >   /* attack + decay + OFF */
> > > > -static int32_t ENV_CURVE[2*EG_ENT+1];
> > > > +static int32_t *ENV_CURVE;
> > > >   /* multiple table */
> > > >   #define ML 2
> > > > @@ -1090,6 +1090,7 @@ FM_OPL *OPLCreate(int clock, int rate)
> > > >   =09OPL->clock =3D clock;
> > > >   =09OPL->rate  =3D rate;
> > > >   =09OPL->max_ch =3D max_ch;
> > > > +    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
> >=20
> > Should we use g_new0() ?
>=20
> No because the array is filled before being used. I can add a note about
> this.
>=20

Thanks for the clarification!
Yes, if you need to respin, maybe it's better.

Thanks,
Stefano


