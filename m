Received: from eggs.gnu.org ([209.51.188.92]:39527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvnZL-0003KZ-Ja
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvnZG-0007ua-0J
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:23:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gvnZF-0007qQ-FA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:23:01 -0500
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
Date: Mon, 18 Feb 2019 13:22:56 -0500
MIME-Version: 1.0
In-Reply-To: <1550058881-16351-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 2/13/19 6:54 AM, Thomas Huth wrote:
> This is very convenient for people like me who store their QEMU git tre=
es
> on gitlab.com: Automatic CI pipelines are now run for each branch that =
is
> pushed to the server - useful for some extra-testing before sending PUL=
L-
> requests for example. Since the runtime of the jobs is limited to 1h, t=
he
> jobs are distributed into multiple pipelines - this way everything fini=
shs
> fine within time (ca. 30 minutes currently).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  An example can be seen here: https://gitlab.com/huth/qemu/pipelines/
>=20
>  I'd really like to get this into the main QEMU repository, so that I d=
on't
>  have to cherry-pick this patch onto my testing branches anymore each t=
ime
>  I want to test before sending a PULL request...
>=20
>  .gitlab-ci.yml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  MAINTAINERS    |  5 ++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 .gitlab-ci.yml
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 0000000..79d02cf
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,73 @@
> +before_script:
> + - apt-get update -qq
> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev ge=
nisoimage
> +
> +build-system1:
> + script:
> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard=
-dev
> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
> + - ./configure --enable-werror --target-list=3D"aarch64-softmmu alpha-=
softmmu
> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazee=
l-softmmu
> +      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-=
softmmu"
> + - make -j2
> + - make -j2 check
> +
> +build-system2:
> + script:
> + - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev liba=
io-dev
> +      libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-de=
v
> + - ./configure --enable-werror --target-list=3D"tricore-softmmu unicor=
e32-softmmu
> +      microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh=
4-softmmu
> +      sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k=
-softmmu"
> + - make -j2
> + - make -j2 check
> +
> +build-disabled:
> + script:
> + - ./configure --enable-werror --disable-rdma --disable-slirp --disabl=
e-curl
> +      --disable-capstone --disable-live-block-migration --disable-glus=
terfs
> +      --disable-replication --disable-coroutine-pool --disable-smartca=
rd
> +      --disable-guest-agent --disable-curses --disable-libxml2 --disab=
le-tpm
> +      --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
> +      --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
> +      --target-list=3D"i386-softmmu ppc64-softmmu mips64-softmmu i386-=
linux-user"
> + - make -j2
> + - make -j2 check-qtest SPEED=3Dslow
> +
> +build-tcg-disabled:
> + script:
> + - apt-get install -y -qq clang libgtk-3-dev libbluetooth-dev libusb-d=
ev
> + - ./configure --cc=3Dclang --enable-werror --disable-tcg --audio-drv-=
list=3D""
> + - make -j2
> + - make check-unit
> + - make check-qapi-schema
> + - cd tests/qemu-iotests/
> + - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 03=
3 048
> +            052 063 077 086 101 104 106 113 147 148 150 151 152 157 15=
9 160
> +            163 170 171 183 184 192 194 197 205 208 215 221 222 226 22=
7 236
> + - ./check -qcow2 001 002 003 004 005 007 008 009 010 011 012 013 017 =
018 019
> +            020 021 022 024 025 027 028 029 031 032 033 034 035 036 03=
7 038
> +            039 040 042 043 046 047 048 049 050 051 052 053 054 056 05=
7 058
> +            060 061 062 063 065 066 067 068 069 071 072 073 074 079 08=
0 082
> +            085 086 089 090 091 095 096 097 098 099 102 103 104 105 10=
7 108
> +            110 111 114 117 120 122 124 126 127 129 130 132 133 134 13=
7 138
> +            139 140 141 142 143 144 145 147 150 151 152 154 155 156 15=
7 158
> +            161 165 170 172 174 176 177 179 184 186 187 190 192 194 19=
5 196
> +            197 200 202 203 205 208 209 214 215 216 217 218 222 226 22=
7 229 234
> +

On the matter of "make check-block" or "./check xxx", I've seen
arguments for both sides.  I've sent a similar (but using make
check-block) patch for Travis:

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02334.html

I'd be nice to hear from the qemu-iotest's maintainers which approach
is preferable for upstream + shared computing resources kind of environme=
nt.

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
> +      xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev li=
brbd-dev
> + - ./configure --cc=3Dclang --cxx=3Dclang++ --enable-werror
> +      --target-list=3D"alpha-softmmu arm-softmmu m68k-softmmu mips64-s=
oftmmu
> +                     ppc-softmmu s390x-softmmu x86_64-softmmu arm-linu=
x-user"
> + - make -j2
> + - make -j2 check
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a2da141..191138c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2484,6 +2484,11 @@ S: Maintained
>  F: .cirrus.yml
>  W: https://cirrus-ci.com/github/qemu/qemu
> =20
> +GitLab Continuous Integration
> +M: Thomas Huth <thuth@redhat.com>
> +S: Maintained
> +F: .gitlab-ci.yml
> +
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

Even though I'm not a GitLab user (yet?), I've gone through the file,
and job results, and they LGTM.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
