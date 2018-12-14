Received: from eggs.gnu.org ([2001:4830:134:3::10]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXcZT-0002OY-Qm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 20:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXcZS-0004F1-Ib
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 20:47:19 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gXcZS-0004DY-C2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 20:47:18 -0500
Received: by mail-io1-xd44.google.com with SMTP id n3so3237195iog.12
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 17:47:18 -0800 (PST)
MIME-Version: 1.0
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
	<154471686589.17726.17792356837247129570@02a1dbf831e2>
In-Reply-To: <154471686589.17726.17792356837247129570@02a1dbf831e2>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Dec 2018 09:46:41 +0800
Message-ID: <CAKXe6SLLrFDCaqBW8B_qBmcrYm6HM9jzv5C2VNyph+218sMeWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>, marcandre lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi all,

Here is the error.

  GTESTER check-qtest-x86_64
Unable to get file status flag on fd 21860: Bad file descriptor(errno=3D9)
  GTESTER check-qtest-aarch64
Broken pipe
GTester: last random seed: R02S3f0d6981dd97231d06e0b2966baf94b9
Unable to get file status flag on fd 21965: Bad file descriptor(errno=3D9)
Broken pipe
GTester: last random seed: R02S29fde958e7ee4c26c4f295ff4dbd47d4
Unable to get file status flag on fd 21890: Bad file descriptor(errno=3D9)
Broken pipe
GTester: last random seed: R02S6d074187e5c8501255c96b247f5c8e3f
Unable to get file status flag on fd 21923: Bad file descriptor(errno=3D9)
Broken pipe
GTester: last random seed: R02S446127f38eb9e8b4f181e6fc95026ba0
  GTESTER tests/test-qht-par
Could not access KVM kernel module: No such file or directory


The fd '21860' '21965', '21890', '21923' is a little strange. Following is
my guess.

21280 --> 0x5564
21965 --> 0x55CD
21890 --> 0x5582
21923 --> 0x55A3

Seems they are stack uninitialized value which 'fd's memory holds.
Seems 'qemu_chr_fe_get_msgfds' first failed, then the 'fd' is an
uninitialized value
cause my first patch 'assert' fails.

Thanks,
Li Qiang



<no-reply@patchew.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> Patchew URL:
> https://patchew.org/QEMU/1544701071-2922-1-git-send-email-liq3ea@gmail.co=
m/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the
> testing commands and
> their output below. If you have Docker installed, you can probably
> reproduce it
> locally.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D8
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> libpmem support   no
> libudev           no
>
> WARNING: Use of SDL 1.2 is deprecated and will be removed in
> WARNING: future releases. Please switch to using SDL 2.0
>
> NOTE: cross-compilers enabled:  'cc'
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>
>
> The full log is available at
>
> http://patchew.org/logs/1544701071-2922-1-git-send-email-liq3ea@gmail.com=
/testing.docker-quick@centos7/?type=3Dmessage
> .
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
