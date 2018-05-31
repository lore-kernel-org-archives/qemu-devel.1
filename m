Received: from eggs.gnu.org ([2001:4830:134:3::10]:44475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQ96-0006im-59
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQ92-0007va-52
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:09:48 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQ92-0007uy-13
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:09:44 -0400
Received: by mail-qk0-x242.google.com with SMTP id c198-v6so17601234qkg.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:09:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-14-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9c970db-61ff-d65f-37f0-b7baa9b028f8@amsat.org>
Date: Thu, 31 May 2018 13:09:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180116134217.8725-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

Hi Daniel,

On 01/16/2018 10:42 AM, Daniel P. Berrange wrote:
> Currently travis declares ancient python 2.4 is desired. Update that to
> 2.6 which is the oldest version any targetted distros still needs. If we
> just list a python 3 version at the top level this will double the
> number of travis jobs we run which is unreasonable.
> 
> So arbitrarily pick the clang test matrix entries to build with python
> 3.0 and 3.6, to extend coverage of python versions, without increasing
> job count or build time.

I'm seeing 3.0 builds taking the double time than 3.6 builds (and
triggering the 50min timeout), any idea what could cause this huge
difference?

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
>          - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
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
>          - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
> -        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9"
> +        - CONFIG="--disable-linux-user --cc=clang-3.9 --cxx=clang++-3.9 --python=/usr/bin/python3"
>        before_install:
>          - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
>          - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
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
>          - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
> -        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9"
> +        - CONFIG="--disable-system --cc=clang-3.9 --cxx=clang++-3.9 --python=/usr/bin/python3"
>        before_install:
>          - wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
>          - sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-3.9 main'
> 
