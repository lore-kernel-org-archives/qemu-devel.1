Received: from eggs.gnu.org ([209.51.188.92]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1xdB-0002zH-Pt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1xdB-0000oZ-2i
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:20:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h1xdA-0000o2-RV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:20:33 -0500
Received: by mail-wr1-x434.google.com with SMTP id w6so18586922wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:20:32 -0800 (PST)
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
Date: Thu, 07 Mar 2019 18:20:30 +0000
Message-ID: <87h8cefswh.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/03/19 14:09, Peter Maydell wrote:
>> On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> In any case, this wouldn't change; as you suggest below, configure could
>>> remain as a front-end (well, in-srcdir builds are not supported by
>>> Meson, so "../configure && ninja" perhaps).
>>
>> As an aside, it might be a nice idea to drop the in-srcdir
>> build altogether for QEMU anyway -- it's not really a very
>> good idea and it means our build system has to cope with two
>> different ways of working to no particularly useful end.
>
> I was actually going to propose that, but I was afraid of throwing two
> bombs in the same day. :)

I have just discovered that gcovr has issues with out-of-srcdir builds
because it has difficulty finding the generated trace header files:

  Gathered coveraged data for 41 files
  Traceback (most recent call last):
    File "/usr/bin/gcovr", line 11, in <module>
      load_entry_point('gcovr=3D=3D4.1', 'console_scripts', 'gcovr')()
    File "/usr/lib/python3/dist-packages/gcovr/__main__.py", line 588, in m=
ain
      print_html_report(covdata, options)
    File "/usr/lib/python3/dist-packages/gcovr/html_generator.py", line 275=
, in print_html_report
      errors=3D'replace')
  FileNotFoundError: [Errno 2] No such file or directory: 'builds/gprof/i38=
6-softmmu/accel/tcg/trace-root.h'

So it would be useful to fix the runes for that as well before we
totally deprecate in-srcdir builds.

>
>> Of the various hosts I do builds on:
>>  * OSX is 2.7 only
>>  * the ppc64 box in the gcc compile farm is 2.7 and 3.4
>>    ("Centos 7.5.1804")
>>  * the aarch64 box in the gcc compile farm is 2.7 and 3.4
>>    ("Ubuntu 14.04.5 LTS", aka trusty)
>
> OS X will need to get Python 3 from Homebrew sooner or later anyway.
>
> Trusty does have a python3.5 package, perhaps you could ask the
> maintainers to install it.
>
> CentOS 7 doesn't have "native" Python 3 (even the 3.4 version you have
> there is probably coming from Fedora) but it has software collections,
> where you have to do "scl enable rh-python35 './configure && make'".
> You can check if scl and the rh-python35 software collections are
> already installed.
>
> Paolo


--
Alex Benn=C3=A9e
