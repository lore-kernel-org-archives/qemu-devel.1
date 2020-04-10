Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9370C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8822078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBq9RkYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8822078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMtOu-0004UH-LC
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jMtOK-00040T-7s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jMtOI-0007lW-8W
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:08:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jMtOI-0007kq-3r
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586524093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyTJr5y6Vv+Gwf6XpO1zfFLIYY8MP5QQAoCvilLBN3g=;
 b=EBq9RkYqGb/AZ6mfmf8bRTQKa4tq+pq/vBUTIZoYDn0HoT8y+D4iJL8LELkc45hZt0K5oH
 BgQFIqiqC7Btyn4EhCgTk4Lzci2pmz9L5MS4m0WhiBNg+zqKsyALatosO9iHCSh66icK9V
 WoCn8MfJo+F6QjZ1MbJXj2PJI2lMC8g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-hfD6DYcRN3qrq-FYy1u-Iw-1; Fri, 10 Apr 2020 09:08:10 -0400
X-MC-Unique: hfD6DYcRN3qrq-FYy1u-Iw-1
Received: by mail-wm1-f72.google.com with SMTP id v8so728726wml.8
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=L2EEZmeR0JnVHVCZc65hRo/yzWT1ai2zHQQXr35IM2c=;
 b=oXzvTNVMzmuDA/am0tG6R7wLj7SnSd2tpC3+ir0nD4MbgdpiBVhFiyuAS/NRUhXn2v
 +AngY7iNBZSqxCYw7ukQmVNtnBXrbeieThxwfVp7XFTEBBOZwh82lhcFixNgmLDwISlA
 9+yUIDQFryqQ9TdDgwvV1tPVIdKlFfsoe/hf8k3Bf7EvbC9BZDHdYzBO1RPZEul3Qw8A
 bjNZrdYGWUpcvw1mIT3PlJpLB6CzEZ6tHPcsrDR7veMTCbGPxLi9Wvllbw8Ebv+RR1RQ
 bsipF0QVxuUfJS+bSo4D/qwTOx/N+6nEq5Qg4HpqodsmJ8p4G4UsKX79DQZM2RJHUCwe
 WVKw==
X-Gm-Message-State: AGi0PubgPvBN0RCxI/qCxDVZgJVqlj1hDdo6fo+Mq7Oxy4C+BlDLUIL2
 YVxr5+4wxmNhvbDE3W5gbZY4o4sgtOUBKqUguFNH1QFZgYyPPwYEq9G+1bzBbq81CLTItmb2SM3
 fbJ62IPjIDCd/8e8=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr4977802wmi.53.1586524089841; 
 Fri, 10 Apr 2020 06:08:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKhqE5/YWyhuxYbG6XiUTsx47OaInBHnmfNzxIJc854hBubRvpMyRUZ3Old0QWxoXB3cQGuxw==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr4977774wmi.53.1586524089503; 
 Fri, 10 Apr 2020 06:08:09 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id f4sm2774578wrp.80.2020.04.10.06.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 06:08:07 -0700 (PDT)
Date: Fri, 10 Apr 2020 15:08:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 09/11] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Message-ID: <20200410130805.cniysjvluyz52apy@steredhat>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-10-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-10-alex.bennee@linaro.org>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 10:15:27PM +0100, Alex Benn=E9e wrote:
> From: Peter Xu <peterx@redhat.com>
>=20
> We should only pass in gdb_get_reg16() with the GByteArray* object
> itself, no need to shift.  Without this patch, gdb remote attach will
> crash QEMU.
>=20
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Message-Id: <20200409164954.36902-3-peterx@redhat.com>
> ---
>  target/i386/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index f3d23b614ee..b98a99500ae 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>      } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>          floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>          int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>          return len;
>      } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>          n -=3D IDX_XMM_REGS;
> --=20
> 2.20.1
>=20
>

I had the following issue while attaching to qemu started with gdbserver
listening:

(gdb) target remote :1234
Remote debugging using :1234
Remote communication error.  Target disconnected.: Connection reset by peer=
.

$ qemu-system-x86_64 -m 1G -smp 4 ... -s
ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed: (len =3D=
=3D gdbserver_state.mem_buf->len)
Bail out! ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed:=
 (len =3D=3D gdbserver_state.mem_buf->len)


Thanks to Philippe, I tried this patch and it solves my issue:

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


