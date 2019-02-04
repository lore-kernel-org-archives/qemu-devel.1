Received: from eggs.gnu.org ([209.51.188.92]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqczg-0004n4-PW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqczc-0007B5-U3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:04:54 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqcza-0006jG-ND
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:04:52 -0500
Received: by mail-wr1-f53.google.com with SMTP id r2so2386022wrv.10
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 04:04:21 -0800 (PST)
References: <20190201171229.3361-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3792ad53-69e1-e45e-1f0f-406288af0912@redhat.com>
Date: Mon, 4 Feb 2019 13:04:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190201171229.3361-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: separate tools and docs into
 another entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>

Hi Alex,

On 2/1/19 6:12 PM, Alex Bennée wrote:
> Re-building the tools and documents by default is a little wasteful as
> they are not really affected by the main build options. Split tools
> and documents into their own task with a minimal softmmu and
> linux-user target list just to check they don't interact badly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 87d9fa971c..1c8effcf63 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -61,6 +61,7 @@ env:
>    global:
>      - SRC_DIR="."
>      - BUILD_DIR="."
> +    - BASE_CONFIG="--disable-docs --disable-tools"
>      - TEST_CMD="make check -j3 V=1"
>  
>  
> @@ -71,7 +72,7 @@ git:
>  
>  before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
> +  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
>  script:
>    - make -j3 && ${TEST_CMD}
>  
> @@ -106,6 +107,15 @@ matrix:
>          - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
>  
>  
> +    # Check we can build docs and tools
> +    - env:
> +        - BASE_CONFIG=""

What about using explicit configure options?

   BASE_CONFIG="--enable-docs --enable-tools"

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        - CONFIG="--target-list=x86_64-softmmu,aarch64-linux-user"
> +      addons:
> +        apt:
> +          packages:
> +            - python-sphinx
> +
>      # Test out-of-tree builds
>      - env:
>          - CONFIG="--enable-debug --enable-debug-tcg"
> @@ -243,5 +253,5 @@ matrix:
>  
>  
>      - env:
> -        - CONFIG="--disable-system --disable-docs"
> +        - CONFIG="--disable-system"
>          - TEST_CMD="make -j3 check-tcg V=1"
> 
