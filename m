Received: from eggs.gnu.org ([2001:4830:134:3::10]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgva-0006nh-UD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgvY-0001XQ-SP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:25:06 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b3037a5-0a6d-c530-6d2d-2d9d8a3ca36e@redhat.com>
Date: Fri, 16 Nov 2018 10:24:54 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] tests: check if qemu-nbd is still
 alive before waiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> If the qemu-nbd UNIX socket has not shown up, the tests will sleep a bi=
t
> and then check again repeatedly for upto 30 seconds. This is pointless

s/upto/up to/

> if the qemu-nbd process has quit due to an error, so check whether the
> pid is still alive before waiting and retrying.

"But our tests are perfect and qemu-nbd never fails" :)

Yes, this makes sense.  Not 3.1 material on its own (after all, our=20
testsuite isn't showing such failures, so we aren't wasting that time at=20
the moment) - but worth including if the later patches end up in 3.1.

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/qemu-iotests/common.nbd | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.=
nbd
> index f920a578f1..61e9e90fee 100644
> --- a/tests/qemu-iotests/common.nbd
> +++ b/tests/qemu-iotests/common.nbd
> @@ -37,11 +37,19 @@ function nbd_server_stop()
>  =20
>   function nbd_server_wait_for_unix_socket()
>   {
> +    pid=3D$1
> +
>       for ((i =3D 0; i < 300; i++))
>       do
>           if [ -r "$nbd_unix_socket" ]; then
>               return
>           fi
> +        kill -s 0 $pid 2>/dev/null
> +        if test $? !=3D 0
> +        then
> +            echo "qemu-nbd unexpectedly quit"
> +            exit 1

Maybe the echo should be redirected to stderr.  But we aren't=20
consistently doing that in other tests (_init_error does it, but other=20
spots in check are not), so I'm not changing it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
