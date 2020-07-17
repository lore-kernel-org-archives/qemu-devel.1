Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CD2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406792067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5r5DsEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406792067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQV8-0004Cr-IK
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jwQUW-0003gc-Md
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:33:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jwQUT-0006k5-0n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594992807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OOmko8daqDpaMRX+ApVwXmLC/XqslQquugbMFnKwOE=;
 b=A5r5DsEEi6OGnZ3rT6xY9ct0GbKJrs5UX1nQh0R1wVC4ry+1kAkQPs1Ag7wnCfJixgR5PS
 FLnw48yZJeza6mbIt1DiJknb7Sh3GQNxsmGHlQLOl6MydN7W91Ui9ITYL066Y6lbQBzPRS
 9j2cdamUOzvuZGeht7tr4e8tzjZU654=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-TaB4pZBEMvOoRaLtOmM_QQ-1; Fri, 17 Jul 2020 09:33:23 -0400
X-MC-Unique: TaB4pZBEMvOoRaLtOmM_QQ-1
Received: by mail-ed1-f72.google.com with SMTP id cn4so5850516edb.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 06:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3OOmko8daqDpaMRX+ApVwXmLC/XqslQquugbMFnKwOE=;
 b=gWmdnDfj9nrph56lyMYabTNMJ3N/FAlQtsmr+ZCCW9vPBo9Jh2n6byEDWR3jGiPlGF
 lKLpFuHopxubws1oDgfO9h+KyypDo7QpfMFZ9TsbLBCed0DgOH/eqotUtid0CHGuIlCn
 X946BX4PYWtaitB8KWMSPx6xybozq8pF6KdTKTz713K+Hj7KDDGY9qhZeJR/CFlQ7vdp
 wOtjGK2X/YA9IOvWfVMz2kdX16+OWanBnAUFLNE6n62oqG8hLs5sYOqw9eC/r4oCrCFJ
 g4gXlIli9C9FuLjyd+Us2Y1j2fSCGGqIjqjCcJ8omS/bXIBPZcRiAC9tmUsSL7zkHakI
 zqow==
X-Gm-Message-State: AOAM533cIfaz0YR9KMqd3LALrJB+RsClQC0FQn3qWvi8Aw6LJZZLg8gZ
 JK3k1+FG7pRiDWsukBmrFjrK4zqc9kLqbFKlLy+FOosmk8haEeHKojd+35Il2A22njYvqyORWCF
 4ZiW/l3kMsIWb3Szm+Igs0WAzI+Gq6lc=
X-Received: by 2002:a17:906:e213:: with SMTP id
 gf19mr8474804ejb.433.1594992802363; 
 Fri, 17 Jul 2020 06:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTUZGKp8uyR5WewxET6cYjhjyW+uoR+WeZqk21dz6v/FjfNKz5yMN2N21ew1489JwCWIOZhdKxxn6D7efNYRo=
X-Received: by 2002:a17:906:e213:: with SMTP id
 gf19mr8474782ejb.433.1594992802063; 
 Fri, 17 Jul 2020 06:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <20200706164155.24696-29-pbonzini@redhat.com>
 <CAFEAcA-Ha4+ub=QQASREraok747+U2tUcNkSYu6PFnoc29_Jrw@mail.gmail.com>
 <CABgObfaFYmsiR-aYsq5vBEruL5Z2=qD0Z6Zf0d0C2N1cbfq4kQ@mail.gmail.com>
 <CAFEAcA_ncNaas_22k=07RUH-VGwp+pe7hYjt-OVoXdEEzLVXKg@mail.gmail.com>
In-Reply-To: <CAFEAcA_ncNaas_22k=07RUH-VGwp+pe7hYjt-OVoXdEEzLVXKg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Jul 2020 15:33:09 +0200
Message-ID: <CABgObfaLuCGZZrqCWrfu2S_jJbEhZ7SQr2A0Jjr78S+fnpbQhw@mail.gmail.com>
Subject: Re: [PULL 28/53] Makefile: simplify MINIKCONF rules
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000062fd7e05aaa333cc"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000062fd7e05aaa333cc
Content-Type: text/plain; charset="UTF-8"

Il ven 17 lug 2020, 15:01 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> When you do a "make clean" those .d files get deleted
> (but the config-devices.mak files do not).


I think that's the bug, both should be removed by "make clean" (since the
.mak files are built by "make" and not "configure").

Paolo

--00000000000062fd7e05aaa333cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 17 lug 2020, 15:01 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">When you do a &quot;make clean&=
quot; those .d files get deleted<br>
(but the config-devices.mak files do not).</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I think that&#39;s the bug, both shou=
ld be removed by &quot;make clean&quot; (since the .mak files are built by =
&quot;make&quot; and not &quot;configure&quot;).</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div></div>

--00000000000062fd7e05aaa333cc--


