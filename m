Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5180C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C53E2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tsx45DPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEykc-0005cL-RT
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEyk1-0005DJ-86
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEyjz-0000np-Fm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:13:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEyjz-0000ng-7M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:13:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id g62so3248563wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tTjLfktiTjpuJwb8trN1hipbVlQbF8yOdPTN2IrKrN4=;
 b=Tsx45DPMrX4Z8GBmaKWsNCjzdKLA+BZ3FonbZp52yoxUtrlExoyQBDLzmy70HWGIYP
 G0vQI4lAVtqeCrVrke+2HMESCjFhOtFILHx+d4SVyXL0RQ9cTvAxANnJ9KKIRMlCzEEL
 Yxp9f77faEFJedm2WacAVdPYmQoZcTmjH3dNa5ZgT4FGP20EGzqT4AX/o366fgPa6jx3
 uoSx4EFJn3A77M5/9MAqhpqXSH6wak9+2oIyKk2Rc8sl5zpXmYZSu6B7yo199Gf80N4y
 N3qZizLSooAcRC/pXBxD5tg48GxdM4CzfRlZNB8JismzZAMhmyDuYT95fssvtTVaJjy4
 W5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tTjLfktiTjpuJwb8trN1hipbVlQbF8yOdPTN2IrKrN4=;
 b=OJdAoY1CiaU+vTZD0Vu9q3BryJohrk2i/V5p+zxI84KJfUbL9HQkrhWCc/m+gDtzwe
 dFb5iW5R3sdE8GkVNO6KfIPgsvykK9TZePAq+AfZJJrjK8hCk+Y7sRwzYd9l6liTTpdX
 2oQjZqwbLY8198GoiJO28xQAaq4WIxoGGC/N3k2hNMGgRthf4pz2HGmGXEQItRDg/GpD
 P9KT5Fc5gTBTiW9bOKQCKU3q5cFLAoxxS5HjvF/i89RZja7h0F/8cKFTS/fIJB9ayjMW
 wqXstZVmZybVTfPJOreALLL2h7SVNeBFnQPTM7q1mskkldMHy5EMbPj7fhXEBkF5m2A4
 fAMA==
X-Gm-Message-State: ANhLgQ1M6UEKZSEcqcAvH0fPYKnYaPuex951HeC9xU1kDqFP26iccCgj
 YuxQLRnbZYoOd4FUUJOTsdPw6w==
X-Google-Smtp-Source: ADFU+vs85Sf4Yv5dI6vKQsCMwXzVTO1OX8iPZ0o8vK64DJZ52UD3aFKeTJtbHtXc/uYYkWh8dsZe4w==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr5110552wmb.78.1584638033788; 
 Thu, 19 Mar 2020 10:13:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w204sm4192924wma.1.2020.03.19.10.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 10:13:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EBEB81FF7E;
 Thu, 19 Mar 2020 17:13:50 +0000 (GMT)
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-2-kraxel@redhat.com> <87wo7kjsfp.fsf@linaro.org>
 <80b6dd22-aae9-268f-21a9-7add0dd3fa51@redhat.com>
 <20200317224648.GB104204@localhost.localdomain>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 1/4] tests/vm: write raw console log
In-reply-to: <20200317224648.GB104204@localhost.localdomain>
Date: Thu, 19 Mar 2020 17:13:50 +0000
Message-ID: <87v9n0i7xt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> On Mon, Mar 16, 2020 at 03:22:07PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 3/16/20 3:16 PM, Alex Benn=C3=A9e wrote:
>> >=20
>> > Gerd Hoffmann <kraxel@redhat.com> writes:
>> >=20
>> > > Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
>> > > to watch the install console.
>> > >=20
>> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> >=20
>> > I suspect this is what's breaking "make check-acceptance" so I've
>> > dropped the series from testing/next for now.
>> >
>> >    2020-03-11 12:12:30,546 stacktrace       L0039 ERROR|
>> >    2020-03-11 12:12:30,546 stacktrace       L0042 ERROR| Reproduced tr=
aceback from: /home/alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/pyt=
hon3.6/site-packages/avocado/c\
>> >    ore/test.py:860
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| Traceback (mo=
st recent call last):
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home=
/alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-package=
s/avocado/core/test.py", line \
>> >    1456, in test
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     self.erro=
r(self.exception)
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home=
/alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-package=
s/avocado/core/test.py", line \
>> >    1064, in error
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     raise exc=
eptions.TestError(message)
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| avocado.core.=
exceptions.TestError: Traceback (most recent call last):
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/=
lib/python3.6/imp.py", line 235, in load_module
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     return lo=
ad_source(name, filename, file)
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/=
lib/python3.6/imp.py", line 172, in load_source
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     module =
=3D _load(spec)
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froz=
en importlib._bootstrap>", line 684, in _load
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froz=
en importlib._bootstrap>", line 665, in _load_unlocked
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froz=
en importlib._bootstrap_external>", line 678, in exec_module
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froz=
en importlib._bootstrap>", line 219, in _call_with_frames_removed
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home=
/alex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/machine_mips_malta.p=
y", line 15, in <module>
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from avoc=
ado_qemu import Test
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home=
/alex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init_=
_.py", line 22, in <module>
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu=
.machine import QEMUMachine
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home=
/alex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/../../.=
./python/qemu/machine.py", lin\
>> >    e 27, in <module>
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu=
.console_socket import ConsoleSocket
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| ModuleNotFoun=
dError: No module named 'qemu.console_socket'
>>=20
>> Cc'ing Wainer/Cleber in case...
>>
>
> I've applied the "[PATCH v4 00/10] tests/vm: Add support for aarch64
> VMs" series and this patch (on top of d649689a8) and could not
> replicate this issue with "make check-acceptance".
>
> Maybe I'm missing some other patch?
>
> - Cleber.
>
>> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|
>> >    2020-03-11 12:12:30,547 stacktrace       L0046 ERROR|
>> >    2020-03-11 12:12:30,548 test             L0865 DEBUG| Local variabl=
es:
>> >    2020-03-11 12:12:30,561 test             L0868 DEBUG|  -> self <cla=
ss 'avocado.core.test.TestError'>: 1-./tests/acceptance/machine_mips_malta.=
py:MaltaMachineFramebuffer.tes\
>> >    t_mips_malta_i6400_framebuffer_logo_1core
>> >=20
>> >=20
>> > > ---
>> > >   tests/vm/basevm.py | 6 ++++++
>> > >   1 file changed, 6 insertions(+)
>> > >=20
>> > > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
>> > > index 8400b0e07f65..c53fd354d955 100644
>> > > --- a/tests/vm/basevm.py
>> > > +++ b/tests/vm/basevm.py
>> > > @@ -213,6 +213,9 @@ class BaseVM(object):
>> > >       def console_init(self, timeout =3D 120):
>> > >           vm =3D self._guest
>> > >           vm.console_socket.settimeout(timeout)
>> > > +        self.console_raw_path =3D os.path.join(vm._temp_dir,
>> > > +                                             vm._name + "-console.r=
aw")
>> > > +        self.console_raw_file =3D open(self.console_raw_path, 'wb')
>> > >       def console_log(self, text):
>> > >           for line in re.split("[\r\n]", text):
>> > > @@ -234,6 +237,9 @@ class BaseVM(object):
>> > >           while True:
>> > >               try:
>> > >                   chars =3D vm.console_socket.recv(1)
>> > > +                if self.console_raw_file:
>> > > +                    self.console_raw_file.write(chars)
>> > > +                    self.console_raw_file.flush()
>> > >               except socket.timeout:
>> > >                   sys.stderr.write("console: *** read timeout ***\n")
>> > >                   sys.stderr.write("console: waiting for: '%s'\n" % =
expect)

Apologies - it looks like I got misled although I hope you'll forgive me
because it wasn't clear from the backtrace. I've re-based and bisected
and it turned out to be broken by:

  tests/acceptance: skip the mips_malta -smp tests on Travis

  These could potentially be MTTCG failures which are exacerbated by the
  reduced number of cores on Travis. Additionally the 1 core test
  started failing while I was re-basing the series. However the error
  message is inconsistent on the various systems I run on.

  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

  1 file changed, 6 insertions(+)
  tests/acceptance/machine_mips_malta.py | 6 ++++++

  modified   tests/acceptance/machine_mips_malta.py
  @@ -91,6 +91,8 @@ class MaltaMachineFramebuffer(Test):
               cv2.imwrite(debug_png, screendump_bgr)
           self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)

  +    # FIXME: this seems to be failing due to some sort of import error
  +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
       def test_mips_malta_i6400_framebuffer_logo_1core(self):
           """
           :avocado: tags=3Darch:mips64el
  @@ -99,6 +101,9 @@ class MaltaMachineFramebuffer(Test):
           """
           self.do_test_i6400_framebuffer_logo(1)

  +    # FIXME: There seems to be an MTTCG related bug that shows up more
  +    # on Travis due to the ease of hitting a race with less cores.
  +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
       def test_mips_malta_i6400_framebuffer_logo_7cores(self):
           """
           :avocado: tags=3Darch:mips64el
  @@ -108,6 +113,7 @@ class MaltaMachineFramebuffer(Test):
           """
           self.do_test_i6400_framebuffer_logo(7)

  +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
       def test_mips_malta_i6400_framebuffer_logo_8cores(self):
           """
           :avocado: tags=3Darch:mips64el

Which I had earlier in the patch series as it was failing on Travis.
I'll trigger another Travis run and see if I can drop them.

--=20
Alex Benn=C3=A9e

