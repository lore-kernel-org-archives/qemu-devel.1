Received: from eggs.gnu.org ([2001:4830:134:3::10]:35371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAMrs-0007Ho-AT
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAMrp-0005Lk-0c
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:22:12 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAMro-0005LN-Qb
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:22:08 -0400
Received: by mail-wm1-f46.google.com with SMTP id 185-v6so7350434wmt.2
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:22:08 -0700 (PDT)
References: <20181010213102.8373-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb3c5064-ea2a-8a28-ebc9-4cacba3c9810@redhat.com>
Date: Thu, 11 Oct 2018 00:22:05 +0200
MIME-Version: 1.0
In-Reply-To: <20181010213102.8373-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On 10/10/2018 23:31, Philippe Mathieu-Daudé wrote:
> Both Python 2.7 and 3 support the same io.StringIO to
> handle unicode strings.
> 
> Use the common form to use indistinctly Python 2.7 or 3.
> 
> http://python-future.org/compatible_idioms.html#stringio
> 
> This fixes running tests on the Fedora Docker image,
> which uses Python3 since 356dc290f:
> 
>   $ make docker-test-block@fedora
>   [...]
>   045         [failed, exit status 1] - output mismatch (see 045.out.bad)
>   --- /tmp/qemu-test/src/tests/qemu-iotests/045.out       2018-07-17 16:56:18.000000000 +0000
>   +++ /tmp/qemu-test/build/tests/qemu-iotests/045.out.bad 2018-07-17 17:19:22.448409007 +0000
>   @@ -1,5 +1,6 @@
>   -...........
>   -----------------------------------------------------------------------
>   -Ran 11 tests
>   -
>   -OK
>   +Traceback (most recent call last):
>   +  File "045", line 178, in <module>
>   +    iotests.main(supported_fmts=['raw'])
>   +  File "/tmp/qemu-test/src/tests/qemu-iotests/iotests.py", line 682, in main
>   +    import StringIO
>   +ModuleNotFoundError: No module named 'StringIO'
>   132         [failed, exit status 1] - output mismatch (see 132.out.bad)
>   152         [failed, exit status 1] - output mismatch (see 152.out.bad)
> 
>   Failures: 045 132 152
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/iotests.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 4e67fbbe96..cd9be1bd9c 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -679,13 +679,13 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
>  
>      # We need to filter out the time taken from the output so that qemu-iotest
>      # can reliably diff the results against master output.
> -    import StringIO
> +    from io import StringIO
>      if debug:
>          output = sys.stdout
>          verbosity = 2
>          sys.argv.remove('-d')
>      else:
> -        output = StringIO.StringIO()
> +        output = StringIO()
>  
>      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
