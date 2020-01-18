Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B037AC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 11:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C3B24690
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 11:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwWzWAbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C3B24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ismP2-0000Pf-IX
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 06:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ismOC-000872-Uo
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 06:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ismOB-0003CX-Qr
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 06:35:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39960
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ismOB-0003C5-NG
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 06:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579347338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4QR0ZKq3MS2NLz/3tqGoGy1CYBJkhQVXpdaP8HtB7w=;
 b=FwWzWAbdbrI8lyDQniVx8tnZzQNDL5I+gaqS4/0xIzYzRioAH4ymC+dPkchiTA+Evi7LuU
 asVQSDGGpKC6ct11FAVLXeu3FOmaPdZ0KrC+k3m3nNql2jrpWHOORCvNaROeTtW/tHLeW9
 4gxx/ZQICrGixDuFHwr0VzpRSnFk8ko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-3oAveUSZMEiYYl1QM1CBfA-1; Sat, 18 Jan 2020 06:35:32 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so11603799wrm.23
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 03:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A4QR0ZKq3MS2NLz/3tqGoGy1CYBJkhQVXpdaP8HtB7w=;
 b=h+XfvS1Rk0zL2zHahVQZmKppezHeUpTdjhw49dYCaVblK09ZMldt89oOuOrgWkMsi5
 Hj1FDVV43HlhjES6MNhqMO8bhgEA1DABkRaTRazeI1d3gHsSZ39dhZa8SdrihVBa0Pi6
 4TGOF/9l4JyrBU+/NjfB8PA+yAGgaO8OpPvHp+fCPmnGcjY4WiASND8j43DSclx5dnqS
 s3dvlwrVzK2FmLi6fsQDNAFG2waQ03iU23vYQzZrIygxuTojUB5Q185tIVLTZPwrDnoB
 3woty3P6LIyl2/uCk8xkswFSPL7NLYAOqS5u6dhpcCbXF4qX0tU44EiejwokE6IF5nWH
 o4pg==
X-Gm-Message-State: APjAAAVMfC6sdvPlG3oykNPKIeTAE4h0EEsOlyfAsjTZ1NbMn7FKAHv+
 /Q9VG+Qa5lHtEZMuAYIyE3sQ0xOOZlS4Dw1pHzTaOptzwkUnd5RdcVlTBb4kfbOd+Wll0/jlde/
 COgIFQXbArt8lt0C8bU0188NASNVaOdM=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr9919587wmb.137.1579347330655; 
 Sat, 18 Jan 2020 03:35:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5+eHFiM2LJtpvuKWYm98Vghz34uAcQ6qKpjl+X4xiFx39BQcvRkHHf1DAH6TRz7jcit2GQwJpzzmzg+2dENg=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr9919575wmb.137.1579347330476; 
 Sat, 18 Jan 2020 03:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-8-f4bug@amsat.org>
 <276200e0-9754-6770-496d-195b80587866@redhat.com>
In-Reply-To: <276200e0-9754-6770-496d-195b80587866@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 18 Jan 2020 12:35:19 +0100
Message-ID: <CAP+75-Whdmppj_XAgvfj=5YSiFY1937V5+iAWfjJ12a9FdTgdg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] tests/ssh_linux_malta: Run tests using a
 snapshot image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
X-MC-Unique: 3oAveUSZMEiYYl1QM1CBfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 18, 2020 at 12:32 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Cleber, Eduardo: ping?

Oops wrong patch =3D)

> On 10/19/19 5:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > If a test fails, it can corrupt the underlying QCow2 image,
> > making further tests failing.
> > Fix this by running each test with a snapshot.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   tests/acceptance/linux_ssh_mips_malta.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptanc=
e/linux_ssh_mips_malta.py
> > index ffbb06f846..27907e8fbd 100644
> > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > @@ -90,7 +90,7 @@ class LinuxSSH(Test):
> >           self.vm.add_args('-no-reboot',
> >                            '-kernel', kernel_path,
> >                            '-append', kernel_command_line,
> > -                         '-hda', image_path,
> > +                         '-drive', 'file=3D%s,snapshot=3Don' % image_p=
ath,
> >                            '-netdev', 'user,id=3Dvnet,hostfwd=3D:127.0.=
0.1:0-:22',
> >                            '-device', 'pcnet,netdev=3Dvnet')
> >           self.vm.launch()
> >


