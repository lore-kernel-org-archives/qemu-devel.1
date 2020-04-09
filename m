Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FEDC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A1820757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRS5mbhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A1820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbgb-0004Td-E9
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMbfW-0003uk-15
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMbfU-0007sI-FS
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:12:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMbfS-0007rb-Q7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586455966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IXa8RUGDBPKm56T+87pLbPjMdLGVDlWxGE9es6gP3mE=;
 b=iRS5mbhc0Kr1Lx8Tc12GUWsbooYluZDP2cWOqWAoCA9dKb8EPJ89zPS2RX82D7tDeEvudi
 9gB/RUEgf9AT1C5top2syDC/K5zKRN/mqXWW1ilqwHwYKpZyMG9UYzD8gnJsm0kN26Rnl2
 Nzvi0iMnj1sA0GtheBo7WK6FBA544ks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-TkpPnjgENeiz98uuisc8Dg-1; Thu, 09 Apr 2020 14:12:44 -0400
X-MC-Unique: TkpPnjgENeiz98uuisc8Dg-1
Received: by mail-wr1-f69.google.com with SMTP id k13so2722460wrn.15
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=t5Ch8qeJERIre+1l/5o/B6Ov89ySf/wtmbDe3518glU=;
 b=X8zT0Q9x6XyMYMQxMUxiXAmhi3kvdx+eSXGmU7Grtzl8BSyP4US2W4Vxpbh0+2GjPC
 QbGXznFYmepnzeOH9xfQXSnBEmGjs5vHgTMsZRdBz52vq177V5EdwPMq5iFxLlCQepDo
 Jku0SZGyzgWiAC88IFM47yRJMtjChkJEaT8a9nxAIlXisMQVLbFjHkGvcUwlGvxfTKQu
 1PQnn+3p83SgiDKIGsEAMTx89K3r8HI7/eIMceCNASRFFcqV1ursQdvzGVMJTWuGjfJP
 b/lnKyFdSEUfyJtD749nNdKGc5levjuGcNzjiyIZ5Ia3r+3XxZuVcS4Sm4r92kBJVGVL
 ET0A==
X-Gm-Message-State: AGi0PuYDeRTLQHvSkAOtamY5VDBZD9kY0N44NJ4ScsMdcQmL8XTOC537
 RbBu91xK2AdXgk34Sp/ok4JRrI8xKg1/3tzcebqBJBeckQWbAYQDA1NHRjpWNl26n0p+Nlv3luH
 gvQaGuGja9Q1BDeQ=
X-Received: by 2002:a5d:510d:: with SMTP id s13mr354216wrt.353.1586455963370; 
 Thu, 09 Apr 2020 11:12:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIqwnNpJQaFngK1OoWUN5KpXC3kxDGovpdM95vBiqRznueEKKct/uoghBU/pTVtcY3eIrcimQ==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr354191wrt.353.1586455963115; 
 Thu, 09 Apr 2020 11:12:43 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id r5sm25136686wrt.8.2020.04.09.11.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:12:42 -0700 (PDT)
Date: Thu, 9 Apr 2020 14:12:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] gdbstub: Assert len read from each register
Message-ID: <20200409181240.GB10061@xz-x1>
References: <20200409164954.36902-1-peterx@redhat.com>
 <20200409164954.36902-2-peterx@redhat.com>
 <0121e4b2-c6dd-d0c4-a7d5-490e08bee923@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0121e4b2-c6dd-d0c4-a7d5-490e08bee923@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 07:51:49PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 4/9/20 6:49 PM, Peter Xu wrote:
> > This can expose the issue earlier on which register returned the wrong
> > result.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   gdbstub.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 171e150950..f763545e81 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -911,17 +911,22 @@ static int gdb_read_register(CPUState *cpu, GByte=
Array *buf, int reg)
> >       CPUClass *cc =3D CPU_GET_CLASS(cpu);
> >       CPUArchState *env =3D cpu->env_ptr;
> >       GDBRegisterState *r;
> > +    int len =3D 0, orig_len =3D buf->len;
> >       if (reg < cc->gdb_num_core_regs) {
> > -        return cc->gdb_read_register(cpu, buf, reg);
> > +        len =3D cc->gdb_read_register(cpu, buf, reg);
>=20
> This change the code flow. We could add ...:

I didn't expect the "if" and "for" would collapse each other, but yeah
that could still be better.

Thanks,

>=20
>            goto out;
>=20
> >       }
>=20
> ... or use else?
> >       for (r =3D cpu->gdb_regs; r; r =3D r->next) {
> >           if (r->base_reg <=3D reg && reg < r->base_reg + r->num_regs) =
{
> > -            return r->get_reg(env, buf, reg - r->base_reg);
> > +            len =3D r->get_reg(env, buf, reg - r->base_reg);
> > +            break;
> >           }
> >       }
> > -    return 0;
> > +
>=20
>   out:
>=20
> > +    assert(len =3D=3D buf->len - orig_len);
> > +
> > +    return len;
> >   }
> >   static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int re=
g)
> >=20
>=20

--=20
Peter Xu


