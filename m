Received: from eggs.gnu.org ([209.51.188.92]:44521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw81w-0007gS-7i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw81s-0002pl-1H
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:00 -0500
References: <20190219160920.32705-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf588063-baf0-5f43-62bf-0af542ffd799@redhat.com>
Date: Tue, 19 Feb 2019 17:13:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190219160920.32705-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Avoid SIGPIPE death to certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 19/02/2019 17.09, Eric Blake wrote:
> Our use of 'head -1' to log less output of certtool during
> iotest 233 could result in certtool dying early due to SIGPIPE
> if it generates enough output; if that happens, the certificate
> it was supposed to generate may be zero length, which causes
> failures such as:
> 
>   == check TLS client to plain server fails ==
>  -qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Denied by server for option 5 (starttls)
>  -server reported: TLS not configured
>  -qemu-nbd: Denied by server for option 5 (starttls)
>  -server reported: TLS not configured
>  +qemu-nbd: Unable to import client certificate /tmp/qemu-iotests-quick-28354/tls/client1/client-cert.pem: Base64 unexpected header error.
> 
> Fix the pipelines to consume all output.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.tls | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tls
> index eae81789bbc..15c6e8c8425 100644
> --- a/tests/qemu-iotests/common.tls
> +++ b/tests/qemu-iotests/common.tls
> @@ -74,7 +74,7 @@ EOF
>      certtool --generate-self-signed \
>               --load-privkey "${tls_dir}/key.pem" \
>               --template "${tls_dir}/ca.info" \
> -             --outfile "${tls_dir}/$name-cert.pem" 2>&1 | head -1
> +             --outfile "${tls_dir}/$name-cert.pem" 2>&1 | sed -n 1p
> 
>      rm -f "${tls_dir}/ca.info"
>  }
> @@ -103,7 +103,7 @@ EOF
>               --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
>               --load-privkey "${tls_dir}/key.pem" \
>               --template "${tls_dir}/cert.info" \
> -             --outfile "${tls_dir}/$name/server-cert.pem" 2>&1 | head -1
> +             --outfile "${tls_dir}/$name/server-cert.pem" 2>&1 | sed -n 1p
>      ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
>      ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/server-key.pem"
> 
> @@ -132,7 +132,7 @@ EOF
>               --load-ca-certificate "${tls_dir}/$caname-cert.pem" \
>               --load-privkey "${tls_dir}/key.pem" \
>               --template "${tls_dir}/cert.info" \
> -             --outfile "${tls_dir}/$name/client-cert.pem" 2>&1 | head -1
> +             --outfile "${tls_dir}/$name/client-cert.pem" 2>&1 | sed -n 1p
>      ln -s "${tls_dir}/$caname-cert.pem" "${tls_dir}/$name/ca-cert.pem"
>      ln -s "${tls_dir}/key.pem" "${tls_dir}/$name/client-key.pem"
> 

Thanks, this fixes the issue for me!

Tested-by: Thomas Huth <thuth@redhat.com>
