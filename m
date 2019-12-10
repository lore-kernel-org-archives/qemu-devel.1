Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E408C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD932053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZg5a4+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD932053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecXx-0006Me-0w
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iecXK-0005qc-30
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iecXJ-0008HC-0j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:14:34 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iecXI-0008Gx-Or
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:14:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so19368927wru.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 02:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zAruH4m0uOqegwQDdstHAGXXPe8xIAwTv1lZVctd5bo=;
 b=pZg5a4+Q21HZz01Qsxmjq4y7qVYk91hPkTmH5QchyDQpIq9+L7CipPFdlJ0hjVQDCy
 PK0E+7elwH2iOhh2G0u/R3A7m38YHc6vizFHPsIGvr4pxgLyPMI8RBHTJqiqxVkPnxDN
 aYNZ5sWT843tl+/woH/pOTwCJPihIWcsleLOtDXCAgW0Wz+YbCqzBMfHiIUDORWltPeP
 0ypXulORlkP6Bw8TsReB4F6ddbMgWqY/xG2xwl44G0K9XQzwCpLa+98hCnML9/d/C9mc
 Xc4qxLhFxroI/qlZmuwXHB1tTSumbJZ8QjvpJBvKqWY0UpMXwOS7emwLirQvv7/hUAe0
 4kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zAruH4m0uOqegwQDdstHAGXXPe8xIAwTv1lZVctd5bo=;
 b=LvDiJGs+gxl3SAOHhcAhZ/Uw4a/55bsB7VaWU7Gz79bNNsv8oqTOa7yIM7X7+yKFuk
 tVupzTkP+a7n9ftCZbiMlnMXyOJmRkFDps7Wg4/6as/1zzwrpYi+kWxEdvIFIAoSUFkO
 btgLjbx3T6jAW92j6DsLFKjqVdhrQ9sBGwoaWi4D5IYMZU0uut1EW7OqiX1FaS9pLHcj
 jbElXz8GLLW7DStxX/ddKqvCPE0oYVs89uCRAX48gcNhTqe9XWhCBa73zIiRj00zvU3y
 wAksonG3ntlDO7IWqG5jYLVK2E264XhElbopGmShSZ/hp1+FEEXfKALNNwWFk9h2RPmO
 ExNg==
X-Gm-Message-State: APjAAAVv5p2GoA8zjH3lohFttbhrbYaG0Wb17GpBx/Ps25xyMvQURXNf
 2t/5XScXRtOwzKQLM918IObI5X0oec/Cex38xDs=
X-Google-Smtp-Source: APXvYqwukrj7R55O3vvxQnCokPcB0BkM4hVbIi0AoJfiOW2ylIFXWgFFfQ2HbXpHYSHUaRTvpQyRM5wfh1p7OdLniYs=
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr2340314wrr.312.1575972871207; 
 Tue, 10 Dec 2019 02:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-3-marcandre.lureau@redhat.com>
 <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
 <20191210025857.GQ498046@habkost.net>
In-Reply-To: <20191210025857.GQ498046@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Dec 2019 14:14:18 +0400
Message-ID: <CAJ+F1CL_0ytd2O4m1FcqQbFSLh3S5v=fLY=FyUZa4zg47uCOQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: QEMU <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Dec 10, 2019 at 6:59 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Fri, Dec 06, 2019 at 09:27:23AM -0500, Cleber Rosa wrote:
> > On Wed, Nov 27, 2019 at 02:10:38PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > Use int.from_bytes() from python 3.2 instead.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  scripts/analyze-migration.py | 35 +++++++++++++++++++---------------=
-
> > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration=
.py
> > > index 2b835d9b70..96a31d3974 100755
> > > --- a/scripts/analyze-migration.py
> > > +++ b/scripts/analyze-migration.py
> > > @@ -1,4 +1,4 @@
> > > -#!/usr/bin/env python
> > > +#!/usr/bin/env python3
> [...]
> >
> > Marc-Andr=C3=A9, I couldn't yet pinpoint the reason yet, but this patch
> > changes the parsing of bool fields.  This is a diff between the output
> > pre/post this patch on the same images:
> >
> > $ diff -u out_x8664_pre out_x8664_post
> > --- out_x8664_pre       2019-12-06 09:14:16.128943264 -0500
> > +++ out_x8664_post      2019-12-06 09:23:35.861378600 -0500
> > @@ -3039,7 +3039,7 @@
> >              "mac_reg[RADV]": "0x00000000",
> >              "mac_reg[TADV]": "0x00000000",
> >              "mac_reg[ITR]": "0x00000000",
> > -            "mit_irq_level": true
> > +            "mit_irq_level": false
> >          },
> >          "e1000/full_mac_state": {
> >              "mac_reg": [
> > @@ -36010,10 +36010,10 @@
> >              ],
> >              "smb_auxctl": "0x02",
> >              "smb_blkdata": "0x00",
> > -            "i2c_enable": true,
> > +            "i2c_enable": false,
> >              "op_done": true,
> > -            "in_i2c_block_read": true,
> > -            "start_transaction_on_status_read": true
> > +            "in_i2c_block_read": false,
> > +            "start_transaction_on_status_read": false
> >          },
> >          "ar.tmr.timer": "ff ff ff ff ff ff ff ff",
> >          "ar.tmr.overflow_time": "0x0000000000000000",
> >
> > This true/false flipping is consistent across various images (tried on
> > images generated on a few other targets).
>
> It looks like moving to python3 accidentally fixes a bug.
>
> This is VMSDFieldBool.read:
>
>     def read(self):
>         super(VMSDFieldBool, self).read()
>         if self.data[0] =3D=3D 0:
>             self.data =3D False
>         else:
>             self.data =3D True
>         return self.data
>
> On python2, MigrationFile.readvar() returned a string, so the
> (self.data[0] =3D=3D 0) check was never true.  This means all boolean
> fields were always initialized to True.
>
> On python3, MigrationFile.readvar() returns a bytearray, so the
> (self.data[0] =3D=3D 0) check now works as expected.

Ah! nice surprise. Do you mind updating the commit message on commit?
Or should I resend?

thanks

--=20
Marc-Andr=C3=A9 Lureau

