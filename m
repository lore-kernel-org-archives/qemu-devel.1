Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282ECC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AD020679
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDlk75J6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AD020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haZrL-0001FB-L8
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 02:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1haZpt-0000fy-Jh
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1haZpr-0000zG-Qz
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:00:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1haZpq-0000xq-1N
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:00:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so10680074ote.13
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=7n5/pm5NiHx4lZCC/Bp5PBB6WHBwDaF4uy/GdH+nUNo=;
 b=YDlk75J6pWr5aqGReGWs9Fv1CrtwT9pR9BzI1bzJT8xqi7iu71NDQIRdoia0b1hQqk
 R9gy3vA8ltaibz03nnDq1bszDwPAxFbcVwFcyTPnxPJ4X9MonCQl0LyFwYoarXaWJFCK
 BuGmBVllJM0q3WDTzxqHactXs7XCzjlYYKxz2+mKgbUOt0mZ/PsY7qpFlsWfVoQseiGK
 ErzlDoeQwiqcVk05E8B/exVn+i/Z5CdIJzSOYL+XNsQpEfuHC8nKOwDmPkkG4vZ2rcLG
 46mE+f9LSH85m+sxi5yMVBs3g1SniPbGiTBhhwXDnw6r9AuroIj4YSPhoGvT3j3bHdfM
 VMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=7n5/pm5NiHx4lZCC/Bp5PBB6WHBwDaF4uy/GdH+nUNo=;
 b=sdSNBFRXyK9TFYPpALbWKZHIIY/ZqiXKd2Hx45ytBd7T9TTdsoV3uwmPugtnVph9dP
 1gJi+1fMGft6Pis1zDZirNQSjouEALu5LJ/2cTWFwFJ0zX/m+Yn1V06568RSLgdQUXsn
 k2YnE/MCrEfJvYvcvjboeqP/xQU1jHap84GTETZJHdygbclx7VZhvLUFeq0/CrkFBBP5
 5i4W10Nk/2UbFZAUsHapCRTLMNZvHHP6oIyf1LtbFm+Z0lEwHuDHZ8xBB/BICNLk2BOm
 QHEOyTcz5wIk0RDiWCpAhCXYfctRrpm+weJQUjQeVlVYNBPZHXunA+Sn6FGJ8Eyg3XZc
 +qMA==
X-Gm-Message-State: APjAAAVbUxCmV6WpOi6JHUfQ+3ymR5Pqbo6JCP9JUh9GPN6e+6kB62Ba
 cG0n0OTdZf03d5aYc1VfCpW/DIfYCh4qiTUDrAw=
X-Google-Smtp-Source: APXvYqwtWTEUsuOqTnutz83TdvwsGWtTbf9BZCR/siGDdyASWUO3+ACceHva2AbXkAHAtcMvscgv9lgKYjRQ6yf7HO8=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr1479121oti.341.1560232840477; 
 Mon, 10 Jun 2019 23:00:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 10 Jun 2019 23:00:39
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 10 Jun 2019 23:00:39
 -0700 (PDT)
In-Reply-To: <20190610232059.GA30549@localhost.localdomain>
References: <1560196150-30436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20190610232059.GA30549@localhost.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 11 Jun 2019 08:00:39 +0200
Message-ID: <CAL1e-=ixiJhZBix-trQNJAG-X=ujp+35aOa9fYmhzXRwLwYYLA@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] tests/acceptance: Improve failure
 reporting in linux_ssh_mips_malta.py
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, f4bug@amsat.org,
 qemu-devel@nongnu.org, amarkovic@wavecomp.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 11, 2019 1:24 AM, "Cleber Rosa" <crosa@redhat.com> wrote:
>
> On Mon, Jun 10, 2019 at 09:49:10PM +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Rather than optputing a cryptic message:
> >
> > FAIL: True not found in [False],
> >
> > the following will be reported too, if the command output does not meet
> > specified expectations:
> >
> > 'lspci -d 11ab:4620' output doesn't contain the word 'GT-64120'
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  tests/acceptance/linux_ssh_mips_malta.py | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/acceptance/linux_ssh_mips_malta.py
b/tests/acceptance/linux_ssh_mips_malta.py
> > index aafb0c3..cbf1b34 100644
> > --- a/tests/acceptance/linux_ssh_mips_malta.py
> > +++ b/tests/acceptance/linux_ssh_mips_malta.py
> > @@ -147,20 +147,27 @@ class LinuxSSH(Test):
> >
> >      def run_common_commands(self):
> >          stdout, stderr =3D self.ssh_command('lspci -d 11ab:4620')
> > -        self.assertIn(True, ["GT-64120" in line for line in stdout])
> > +        self.assertIn(True, ["GT-64120a" in line for line in stdout],
>
> Looks like there's an extra, unintended, "a" in the expected output, that
is,
> s/GT-64120a/GT-64120/.
>
> > +                      "'lspci -d 11ab:4620' output doesn't contain "
> > +                      "the word 'GT-64120'")
> >
> >          stdout, stderr =3D self.ssh_command('cat
/sys/bus/i2c/devices/i2c-0/name')
> > -        self.assertIn(True, ["SMBus PIIX4 adapter" in line
> > -                             for line in stdout])
> > +        self.assertIn(True, ["SMBus PIIX4 adaptera" in line
>
> Here too (s/adaptera/adapter/).
>
> > +                             for line in stdout],
> > +                      "cat /sys/bus/i2c/devices/i2c-0/name' doesn't
contain "
> > +                      "the words 'SMBus PIIX4 adapter'")
> >
> >          stdout, stderr =3D self.ssh_command('cat /proc/mtd')
> > -        self.assertIn(True, ["YAMON" in line
> > -                             for line in stdout])
> > +        self.assertIn(True, ["YAMONa" in line
>
> Also here (s/YAMONa/YAMONa/).
>
> > +                             for line in stdout],
> > +                      "'cat /proc/mtd' doesn't contain the word
'YAMON'")
> >
> >          # Empty 'Board Config'
> >          stdout, stderr =3D self.ssh_command('md5sum /dev/mtd2ro')
> > -        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in lin=
e
> > -                             for line in stdout])
> > +        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193a" in
line
> > +                             for line in stdout],
>
> And finnaly in the hash
(s/0dfbe8aa4c20b52e1b8bf3cb6cbdf193a/0dfbe8aa4c20b52e1b8bf3cb6cbdf193/).
>
> > +                      "'md5sum /dev/mtd2ro' doesn't contain "
> > +                      "the word '0dfbe8aa4c20b52e1b8bf3cb6cbdf193'")
> >
> >      def do_test_mips_malta(self, endianess, kernel_path, uname_m):
> >          self.boot_debian_wheezy_image_and_ssh_login(endianess,
kernel_path)
> > --
> > 2.7.4
> >
> >
>
> With those changes, the tests pass for me.  I'd recommend though:
>
> 1) Not related to your patch, but it's good practice to name unused
>    variables "_", that is:
>
>    stdout, _ =3D self.ssh_command('lspci -d 11ab:4620')
>
> 2) Avoid repeating the expected content (which lead to the trailing
>    "a"s in this patch).  Something like:
>
>    cmd =3D 'lspci -d 11ab:4620'
>    stdout, _ =3D self.ssh_command(cmd)
>    exp =3D "GT-64120"
>    self.assertIn(True, [exp in line for line in stdout],
>                  '"%s" output does not contain "%s"' % (cmd, exp))
>
> 3) Optionally, create an utility function that would make the check
>    more obvious and avoid looping through all lines of the output
>    (and creating a list, which a list comprehension will do).  Example:
>
>    def ssh_command_output_contains(self, cmd, exp):
>        stdout, _ =3D self.ssh_command(cmd)
>        for line in stdout:
>            if exp in line:
>                break
>        else:
>            self.fail('"%s" output does not contain "%s"' % (cmd, exp))
>
>     def run_common_commands(self):
>         self.ssh_command_output_contains('lspci -d 11ab:4620', 'GT-64120'=
)
>         self.ssh_command_output_contains('cat
/sys/bus/i2c/devices/i2c-0/name',
>                                          'SMBus PIIX4 adapter')
>         self.ssh_command_output_contains('cat /proc/mtd', 'YAMON')
>         # Empty 'Board Config'
>         self.ssh_command_output_contains('md5sum /dev/mtd2ro',
>
 '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
>

Thank you for your review, Cleber! I am almost certain that in v2 (that I
am going to send soon), I will adopt the approach from point =E2=80=9C3=E2=
=80=9D of your
mail.

Yours,
Aleksandar

> Cheers,
> - Cleber.
>
