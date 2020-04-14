Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4D0206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGm5Te2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4D0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOGK7-0001ek-E1
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jOGJM-0001DF-NO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jOGJK-0002qg-CH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:48:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jOGJK-0002qT-8I
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586850525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twpzvntTn8Um27vixu8yDWfBjRwKdU8Dm3J2N5ZZTxk=;
 b=hGm5Te2/Hm8IWanpcdKeXGtZUAVW+rQ1oSHPSpsqmKwTx8F7mErKCKGTHQsL4FtUqz+aC/
 R8DMvOKpkyk7YdhVxB4RD7ktzismZkPGewgueJTTjrFiS/sTfKstPPgYG3ZGKfeSf7OKKM
 Ep96LGJQnenSY5q9/E1nfP1dZYahPFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-qgf1FMJjNw-udspqS2clog-1; Tue, 14 Apr 2020 03:48:40 -0400
X-MC-Unique: qgf1FMJjNw-udspqS2clog-1
Received: by mail-wr1-f69.google.com with SMTP id p16so5461534wro.16
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 00:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=s4bLaFWwyqtVFcvWVGTkyWfe0c2fDdQ7YnETX8DZY2o=;
 b=pGO+QoKH6YCtqYuPh45FzmOUTR3M+FsEqMbLCxb8XuRwAJRfdkc5ZiSrKGfSTVtd+O
 tPnLz36MvrV2KASEOrPziCNKPytJsSkKPc68OHSio8y6FEAzC/m4czEucW04q9GfPCZX
 vWEM9q16vnVav1BwpTnAyehRCuyh6OBtl7JUKa8yfjJTmHimHSClrzTE6HhVfOHG9Jtk
 yTKtWmhB3JXgCKaRYIWuyW3cDXsMJ/QKdxqOqQU2eGkLmtvughNdpb1KhaDagnPqrKSv
 YvOxBD6UrTAdHsr06dEVf9uYKtNc/lrmA2D8leoFyLqPmI3oz0RNNfZ5wsNOFZJg49Mg
 9zyw==
X-Gm-Message-State: AGi0PuaCDtC2uizuN05bLWylXHttSNlrbx6DxQ7Uc87lY4CzhgWVZWhR
 LV1g8iQIVBkTiIOodmev2pnrX7vBm28XnH1jd9VZUJJEN4Qn+HKJ+NntBy3cX4JazSE0M4jpIL9
 mGn71RJs3cu9MGJQ=
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr16715467wmc.49.1586850518920; 
 Tue, 14 Apr 2020 00:48:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypI3H7P64cH9yjaBnfSVQLFz3nr/+OEtuP4G7JKhDdN4DCmaRgSweRmRwsfZsiXbUoA3bNX33A==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr16715437wmc.49.1586850518606; 
 Tue, 14 Apr 2020 00:48:38 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id t13sm1763371wre.70.2020.04.14.00.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 00:48:37 -0700 (PDT)
Date: Tue, 14 Apr 2020 09:48:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 09/11] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Message-ID: <20200414074835.z2hsatgk6wosbgae@steredhat>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-10-alex.bennee@linaro.org>
 <20200410130805.cniysjvluyz52apy@steredhat>
 <87tv1q89i8.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87tv1q89i8.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 11, 2020 at 01:58:07PM +0100, Alex Benn=E9e wrote:
>=20
> Stefano Garzarella <sgarzare@redhat.com> writes:
>=20
> > On Thu, Apr 09, 2020 at 10:15:27PM +0100, Alex Benn=E9e wrote:
> >> From: Peter Xu <peterx@redhat.com>
> >>=20
> >> We should only pass in gdb_get_reg16() with the GByteArray* object
> >> itself, no need to shift.  Without this patch, gdb remote attach will
> >> crash QEMU.
> >>=20
> >> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> Message-Id: <20200409164954.36902-3-peterx@redhat.com>
> >> ---
> >>  target/i386/gdbstub.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> >> index f3d23b614ee..b98a99500ae 100644
> >> --- a/target/i386/gdbstub.c
> >> +++ b/target/i386/gdbstub.c
> >> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)
> >>      } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
> >>          floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
> >>          int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> >> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> >> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
> >>          return len;
> >>      } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS)=
 {
> >>          n -=3D IDX_XMM_REGS;
> >> --=20
> >> 2.20.1
> >>=20
> >>
> >
> > I had the following issue while attaching to qemu started with gdbserve=
r
> > listening:
> >
> > (gdb) target remote :1234
> > Remote debugging using :1234
> > Remote communication error.  Target disconnected.: Connection reset by =
peer.
> >
> > $ qemu-system-x86_64 -m 1G -smp 4 ... -s
> > ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed: (len =
=3D=3D gdbserver_state.mem_buf->len)
> > Bail out! ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion
> > failed: (len =3D=3D gdbserver_state.mem_buf->len)
>=20
> I'll see if the new gdb testcases can be generalised - they would have
> caught these snafus.

Yeah, that would be great!

Thanks,
Stefano


