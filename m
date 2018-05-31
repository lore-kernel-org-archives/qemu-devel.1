Received: from eggs.gnu.org ([2001:4830:134:3::10]:41446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOU0w-00047D-Nv
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOU0s-0000J3-4p
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:17:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOU0r-0000IT-VB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:17:34 -0400
Received: by mail-wm0-x243.google.com with SMTP id r15-v6so28488974wmc.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:17:33 -0700 (PDT)
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-14-berrange@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180116134217.8725-14-berrange@redhat.com>
Date: Thu, 31 May 2018 21:17:30 +0100
Message-ID: <871sdr1sx1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/14] travis: improve python version
 test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>


Daniel P. Berrange <berrange@redhat.com> writes:

> Currently travis declares ancient python 2.4 is desired. Update that to
> 2.6 which is the oldest version any targetted distros still needs. If we
> just list a python 3 version at the top level this will double the
> number of travis jobs we run which is unreasonable.
>
> So arbitrarily pick the clang test matrix entries to build with python
> 3.0 and 3.6, to extend coverage of python versions, without increasing
> job count or build time.

I'm sorry I didn't get to this when you posted it. However I'd like to
know what the minimum build configuration we can get which will still
ensure that the python is exercised? Would a
TARGET_LIST=3D"x86-64-softmmu" be good enough?

>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  .travis.yml | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index f583839755..708c886017 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,7 +1,7 @@
>  sudo: false
>  language: c
>  python:
> -  - "2.4"
> +  - "2.6"
>  compiler:
>    - gcc
>  cache: ccache
> @@ -115,15 +115,17 @@ matrix:
>          - sudo apt-get build-dep -qq qemu
>          - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule=
-git-seed.tar.xz | tar -xvJ
>          - git submodule update --init --recursive
> -    # Trusty System build with latest stable clang
> +    # Trusty System build with latest stable clang & python 3.0
>      - sudo: required
>        addons:
>        dist: trusty
>        language: generic
>        compiler: none
> +      python:
> +        - "3.0"
>        env:
>          - COMPILER_NAME=3Dclang CXX=3Dclang++-3.9 CC=3Dclang-3.9
> -        - CONFIG=3D"--disable-linux-user --cc=3Dclang-3.9 --cxx=3Dclang+=
+-3.9"
> +        - CONFIG=3D"--disable-linux-user --cc=3Dclang-3.9 --cxx=3Dclang+=
+-3.9 --python=3D/usr/bin/python3"
>        before_install:
>          - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo=
 apt-key add -
>          - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llv=
m-toolchain-trusty-3.9 main'
> @@ -134,15 +136,17 @@ matrix:
>          - git submodule update --init --recursive
>        before_script:
>          - ./configure ${CONFIG} || cat config.log
> -    # Trusty Linux User build with latest stable clang
> +    # Trusty Linux User build with latest stable clang & python 3.6
>      - sudo: required
>        addons:
>        dist: trusty
>        language: generic
>        compiler: none
> +      python:
> +        - "3.6"
>        env:
>          - COMPILER_NAME=3Dclang CXX=3Dclang++-3.9 CC=3Dclang-3.9
> -        - CONFIG=3D"--disable-system --cc=3Dclang-3.9 --cxx=3Dclang++-3.=
9"
> +        - CONFIG=3D"--disable-system --cc=3Dclang-3.9 --cxx=3Dclang++-3.=
9 --python=3D/usr/bin/python3"
>        before_install:
>          - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo=
 apt-key add -
>          - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llv=
m-toolchain-trusty-3.9 main'


--
Alex Benn=C3=A9e
