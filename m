Received: from eggs.gnu.org ([2001:4830:134:3::10]:41009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB5LT-0007Gj-Qh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB5LO-0000eF-8U
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:51:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gB5LM-0000ZL-7T
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:51:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so14133607wmf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 14:51:32 -0700 (PDT)
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f0f98dd7-a62b-1107-b7a9-ea4f6f76fd75@redhat.com>
Date: Fri, 12 Oct 2018 23:51:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181012165347.2117-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] Travis support for the acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi Cleber,

On 12/10/2018 18:53, Cleber Rosa wrote:
> This enables the execution of the acceptance tests on Travis.
> 
> Because the Travis environment is based on Ubuntu Trusty, it requires
> the python3-pip and python3.4-venv packages.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 95be6ec59f..f55f799c52 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -36,6 +36,8 @@ addons:
>        - liburcu-dev
>        - libusb-1.0-0-dev
>        - libvte-2.90-dev
> +      - python3-pip
> +      - python3.4-venv

I'd prefer not put Python specific version in the generic addons list...

>        - sparse
>        - uuid-dev
>        - gcovr
> @@ -117,6 +119,9 @@ matrix:
>      - env: CONFIG="--target-list=x86_64-softmmu"
>        python:
>          - "3.6"
> +    # Acceptance (Functional) tests
> +    - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
> +           TEST_CMD="make AVOCADO_SHOW=app check-acceptance"

... but rather in the single test that requires it:

         addons:
           apt:
             packages:
               - python3-pip
               - python3.4-venv

Alex what do you prefer?

>      # Using newer GCC with sanitizers
>      - addons:
>          apt:
> 

Both configs:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
