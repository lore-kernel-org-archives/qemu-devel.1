Received: from eggs.gnu.org ([209.51.188.92]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gttJB-0005y4-Uk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gttJ9-0001kz-2v
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:06:33 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gttJ5-0001Xj-Pv
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:06:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so2147717wrt.13
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 04:06:21 -0800 (PST)
MIME-Version: 1.0
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1550058881-16351-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Feb 2019 13:06:07 +0100
Message-ID: <CAJ+F1CJLHPa3LtviMGQuuwjv-PMzeeR4tJGoHHOz_JqfRR927A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add a gitlab-ci file for Continuous
 Integration testing on Gitlab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi

On Wed, Feb 13, 2019 at 12:55 PM Thomas Huth <thuth@redhat.com> wrote:
>
> This is very convenient for people like me who store their QEMU git trees
> on gitlab.com: Automatic CI pipelines are now run for each branch that is
> pushed to the server - useful for some extra-testing before sending PULL-
> requests for example. Since the runtime of the jobs is limited to 1h, the
> jobs are distributed into multiple pipelines - this way everything finish=
s
> fine within time (ca. 30 minutes currently).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  An example can be seen here: https://gitlab.com/huth/qemu/pipelines/
>
>  I'd really like to get this into the main QEMU repository, so that I don=
't
>  have to cherry-pick this patch onto my testing branches anymore each tim=
e
>  I want to test before sending a PULL request...
>
>  .gitlab-ci.yml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  MAINTAINERS    |  5 ++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 .gitlab-ci.yml
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 0000000..79d02cf
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,73 @@
> +before_script:
> + - apt-get update -qq
> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geni=
soimage
> +
> +build-system1:
> + script:
> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-d=
ev
> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
> + - ./configure --enable-werror --target-list=3D"aarch64-softmmu alpha-so=
ftmmu
> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-=
softmmu
> +      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-so=
ftmmu"
> + - make -j2

Have you tried $(nproc) ?

> + - make -j2 check
> +
> +build-system2:
> + script:
> + - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio=
-dev
> +      libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
> + - ./configure --enable-werror --target-list=3D"tricore-softmmu unicore3=
2-softmmu
> +      microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-=
softmmu
> +      sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-s=
oftmmu"
> + - make -j2
> + - make -j2 check
> +
> +build-disabled:
> + script:
> + - ./configure --enable-werror --disable-rdma --disable-slirp --disable-=
curl
> +      --disable-capstone --disable-live-block-migration --disable-gluste=
rfs
> +      --disable-replication --disable-coroutine-pool --disable-smartcard
> +      --disable-guest-agent --disable-curses --disable-libxml2 --disable=
-tpm
> +      --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
> +      --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
> +      --target-list=3D"i386-softmmu ppc64-softmmu mips64-softmmu i386-li=
nux-user"
> + - make -j2
> + - make -j2 check-qtest SPEED=3Dslow
> +
> +build-tcg-disabled:
> + script:
> + - apt-get install -y -qq clang libgtk-3-dev libbluetooth-dev libusb-dev
> + - ./configure --cc=3Dclang --enable-werror --disable-tcg --audio-drv-li=
st=3D""
> + - make -j2
> + - make check-unit
> + - make check-qapi-schema
> + - cd tests/qemu-iotests/
> + - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 =
048
> +            052 063 077 086 101 104 106 113 147 148 150 151 152 157 159 =
160
> +            163 170 171 183 184 192 194 197 205 208 215 221 222 226 227 =
236
> + - ./check -qcow2 001 002 003 004 005 007 008 009 010 011 012 013 017 01=
8 019
> +            020 021 022 024 025 027 028 029 031 032 033 034 035 036 037 =
038
> +            039 040 042 043 046 047 048 049 050 051 052 053 054 056 057 =
058
> +            060 061 062 063 065 066 067 068 069 071 072 073 074 079 080 =
082
> +            085 086 089 090 091 095 096 097 098 099 102 103 104 105 107 =
108
> +            110 111 114 117 120 122 124 126 127 129 130 132 133 134 137 =
138
> +            139 140 141 142 143 144 145 147 150 151 152 154 155 156 157 =
158
> +            161 165 170 172 174 176 177 179 184 186 187 190 192 194 195 =
196
> +            197 200 202 203 205 208 209 214 215 216 217 218 222 226 227 =
229 234
> +
> +build-user:
> + script:
> + - ./configure --enable-werror --disable-system --disable-guest-agent
> +               --disable-capstone --disable-slirp --disable-fdt
> + - make -j2
> + - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
> +
> +build-clang:
> + script:
> + - apt-get install -y -qq clang libsdl2-dev
> +      xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev libr=
bd-dev
> + - ./configure --cc=3Dclang --cxx=3Dclang++ --enable-werror
> +      --target-list=3D"alpha-softmmu arm-softmmu m68k-softmmu mips64-sof=
tmmu
> +                     ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-=
user"
> + - make -j2
> + - make -j2 check
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a2da141..191138c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2484,6 +2484,11 @@ S: Maintained
>  F: .cirrus.yml
>  W: https://cirrus-ci.com/github/qemu/qemu
>
> +GitLab Continuous Integration
> +M: Thomas Huth <thuth@redhat.com>
> +S: Maintained
> +F: .gitlab-ci.yml
> +
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> --
> 1.8.3.1
>
>

Despite the duplication of CI files, which is not really a problem imho,

lgtm,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau
