Received: from eggs.gnu.org ([209.51.188.92]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw833-0000KU-L1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw831-0003Ju-QT
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:15:09 -0500
Date: Tue, 19 Feb 2019 16:14:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219161433.GO7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219160920.32705-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219160920.32705-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Avoid SIGPIPE death to certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, thuth@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Feb 19, 2019 at 10:09:20AM -0600, Eric Blake wrote:
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

I've actually prepared a patch which gets rid of the pipe entirely,
because in debugging this problem I found it unhelpful that we culled
stderr when certtool failed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
