Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD6C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D185021741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byJiCR9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D185021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOjC-0003qY-3h
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izOiO-0003Jb-DW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izOiN-0002Ix-AS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:43:52 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izOiK-0002DQ-Pp; Wed, 05 Feb 2020 12:43:48 -0500
Received: by mail-pg1-x542.google.com with SMTP id k3so1314244pgc.3;
 Wed, 05 Feb 2020 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=m20qCS/ov/7+NPhM7zIEUTKoyl4bHuA+F0liqTdvC8A=;
 b=byJiCR9W/Myhs5sIIiQltATEvcrRCXdcCQxbOvneSvB/epzHzmU/JUY2sVomXt8FvF
 E8SF4yg7rEdtKrpDcam+i0LtGWrpG8MAgQRxPPPniWVSi0jy1MS5f9x6iVX+DEgsiSPa
 D1x1TiTFDFacMLIn+ZQiQut41Kp83MkGzSM6cycbkkX1K+C/OZKhXHFaNbPl2jqpkS0i
 sNnlgkmy3Gpql+iZ4GumjxOY+Li/3wm9FkLjv3Ry/z/r/OT0QljEjuKvK8CKVElRBsfO
 fnqLQTz2jzraWI9ic3SDxlTTvs4xGrnBZFqTZifYUmsQvx7C00jVdN8vbxJ3AgDatPvP
 4yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=m20qCS/ov/7+NPhM7zIEUTKoyl4bHuA+F0liqTdvC8A=;
 b=dBc/CQnDIQSXTMkCrN6GTzRHSm5wvJJRZZXSBv66a+pTVG+7Mm4UBfSiUsir2WX0Ro
 /1z6FZxn2RoqRlRzbCDZyteetoGVyPcldqtBhHMTcycMJ7WmTlMg3JH0b4+Z99eGJeWg
 /u2nhAROH1htChfo8m1b4Yr0gUF3TOtMEpPtZqLRYsFJ8aaR2DwAW0lDV8ukaNhUwOd0
 zJhLc0+Cw461uQTuMRUuonilhbeR+jLPui4kDeF4TSgUkyFR82GHJPxMpiiA9nigb+tI
 9n0xcQgMBMJvdPK+GDHLXLAEOo3XoNtUYETU8ia4tHrr1oeOcT+1lGunBUlULqOO8AiC
 ZbDA==
X-Gm-Message-State: APjAAAXrg0wCLEsCjYTVsuDf5Ml4Xkqt7W2JerL9TrNL9oVgMplX2S3/
 hdbasqICgdsApX/kuUNZJ0E=
X-Google-Smtp-Source: APXvYqx2czZ49r7Yu4FGrK2FmvUQc9iXDy9Bbei9Zzpq8GOWgIskOKOH4tONbIH0EES8iiQj6iARIQ==
X-Received: by 2002:a63:3154:: with SMTP id x81mr27267470pgx.32.1580924627389; 
 Wed, 05 Feb 2020 09:43:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id i6sm139610pfk.38.2020.02.05.09.43.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Feb 2020 09:43:46 -0800 (PST)
Date: Wed, 5 Feb 2020 09:43:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/3] m25p80: Improve command handling for Jedec and
 unsupported commands
Message-ID: <20200205174345.GA7754@roeck-us.net>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-2-linux@roeck-us.net>
 <accf297f-0c54-7475-8817-c1014999a57d@kaod.org>
 <7fe70871-c0e3-4ff6-bfda-17b45aa50c5e@roeck-us.net>
 <22a96987-9548-1335-8b04-00167ed9491d@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22a96987-9548-1335-8b04-00167ed9491d@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 11:08:07AM +0100, Cédric Le Goater wrote:
> On 2/4/20 3:28 PM, Guenter Roeck wrote:
> > On 2/4/20 12:53 AM, Cédric Le Goater wrote:
> >> On 2/3/20 7:09 PM, Guenter Roeck wrote:
> >>> Always report 6 bytes of JEDEC data. Fill remaining data with 0.
> >>>
> >>> For unsupported commands, keep sending a value of 0 until the chip
> >>> is deselected.
> >>>
> >>> Both changes avoid attempts to decode random commands. Up to now this
> >>> happened if the reported Jedec data was shorter than 6 bytes but the
> >>> host read 6 bytes, and with all unsupported commands.
> >>
> >> Do you have a concrete example for that ? machine and flash model.
> >>
> > 
> > I noticed it while tracking down the bug fixed in patch 3 of the series,
> > ie with AST2500 evb using w25q256 flash, but it happens with all machines
> > using SPI NOR flash (ie all aspeed bmc machines) when running the Linux
> > kernel. Most of the time it doesn't cause harm, unless the host sends
> > an "address" as part of an unsupported command which happens to include
> > a valid command code.
> 
> ok. we will need to model SFDP one day.
> 
> Are you using the OpenBMC images or do you have your own ? 
> 

I am running images built from upstream/stable kernel branches.

Guenter

> > 
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>>   hw/block/m25p80.c | 10 +++++++++-
> >>>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> >>> index 63e050d7d3..aca75edcc1 100644
> >>> --- a/hw/block/m25p80.c
> >>> +++ b/hw/block/m25p80.c
> >>> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
> >>>           for (i = 0; i < s->pi->id_len; i++) {
> >>>               s->data[i] = s->pi->id[i];
> >>>           }
> >>> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
> >>> +            s->data[i] = 0;
> >>> +        }
> >>
> >> It seems that data should be reseted in m25p80_cs() also.
> >>
> > Are you sure ?
> > 
> > The current implementation sets s->data[] as needed when command decode
> > is complete. That seems less costly to me.
> 
> ok.
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> 
> Thanks,
> 
> C.
>  
> > Thanks,
> > Guenter
> > 
> >>>   -        s->len = s->pi->id_len;
> >>> +        s->len = SPI_NOR_MAX_ID_LEN;
> >>>           s->pos = 0;
> >>>           s->state = STATE_READING_DATA;
> >>>           break;
> >>> @@ -1158,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
> >>>           s->quad_enable = false;
> >>>           break;
> >>>       default:
> >>> +        s->pos = 0;
> >>> +        s->len = 1;
> >>> +        s->state = STATE_READING_DATA;
> >>> +        s->data_read_loop = true;
> >>> +        s->data[0] = 0;
> >>>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", value);
> >>>           break;
> >>>       }
> >>>
> >>
> > 
> 

