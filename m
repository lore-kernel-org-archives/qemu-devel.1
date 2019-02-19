Received: from eggs.gnu.org ([209.51.188.92]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw2tX-0006jb-AW
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw2tW-0006wt-CB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:44:59 -0500
Date: Tue, 19 Feb 2019 10:44:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219104445.GB7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cd28473f-b768-0c3e-82be-1e07e9c3e786@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd28473f-b768-0c3e-82be-1e07e9c3e786@redhat.com>
Subject: Re: [Qemu-devel] Failing qemu-iotest 233
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Feb 19, 2019 at 07:36:07AM +0100, Thomas Huth wrote:
> 
>  Hi Eric, hi Daniel,
> 
> QEMU iotest 233 is failing for me on RHEL7:
> 
> 233                [07:29:30] [07:29:30] [failed, exit status 1] - output mismatch (see 233.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/233.out	2019-02-19 07:14:45.000000000 +0100
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/233.out.bad	2019-02-19 07:29:30.000000000 +0100
> @@ -13,45 +13,7 @@
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  
>  == check TLS client to plain server fails ==
> -qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Denied by server for option 5 (starttls)
> -server reported: TLS not configured
> -qemu-nbd: Denied by server for option 5 (starttls)
> -server reported: TLS not configured
> +qemu-nbd: Unable to import client certificate /tmp/qemu-iotests-quick-28354/tls/client1/client-cert.pem: Base64 unexpected header error.

This is fun, because it is actually non-determinstic, failing in a different
place in the test everytime it is run !

Turns out that piping certtool to "head -1" is bad because it causes
certtool to get a broken pipe making it quit before it has written
the certificate to disk leaving a zero length file. This in turn
causes the base64 error above.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
