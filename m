Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhnW-0001Pc-Og
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhnV-0001U7-L1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:20:50 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
Date: Fri, 16 Nov 2018 11:20:26 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
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
> Add tests that validate it is possible to connect to an NBD server
> running TLS mode. Also test mis-matched TLS vs non-TLS connections
> correctly fail.
> ---
>   tests/qemu-iotests/233        | 99 ++++++++++++++++++++++++++++++++++=
+
>   tests/qemu-iotests/233.out    | 33 ++++++++++++
>   tests/qemu-iotests/common.nbd | 47 +++++++++++++++++
>   tests/qemu-iotests/group      |  1 +
>   4 files changed, 180 insertions(+)
>   create mode 100755 tests/qemu-iotests/233
>   create mode 100644 tests/qemu-iotests/233.out

Adding tests is non-invasive, so I have no objection to taking the=20
entire series in 3.1.  Do you want me to touch up the nits I found=20
earlier, or should I wait for a v2?

Reviewed-by: Eric Blake <eblake@redhat.com>

> +# creator
> +owner=3Dberrange@redhat.com
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`

Dead code. Mao Zhongyi has a patch to remove it.  I'm thinking of=20
putting his patches in first, and then yours.


> +
> +echo
> +echo "=3D=3D check TLS client to plain server fails =3D=3D"
> +nbd_server_start_tcp_socket "$TEST_IMG"

The negative testing is just as important as positive testing, to prove=20
TLS is adding the promised authorization.

> +
> +$QEMU_IMG info --image-opts \
> +    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient=
,id=3Dtls0 \
> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0
> +
> +nbd_server_stop
> +
> +echo
> +echo "=3D=3D check plain client to TLS server fails =3D=3D"
> +
> +nbd_server_start_tcp_socket --object tls-creds-x509,dir=3D${tls_dir}/s=
erver1,endpoint=3Dserver,id=3Dtls0,verify-peer=3Dyes --tls-creds tls0 "$T=
EST_IMG"

Long line

> +
> +$QEMU_IMG info nbd://localhost:$nbd_tcp_port
> +
> +echo
> +echo "=3D=3D check TLS works =3D=3D"
> +$QEMU_IMG info --image-opts \
> +    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient=
,id=3Dtls0 \
> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0

Is it also worth reading or even writing, to ensure that more than just=20
the handshake is working?

> +
> +echo
> +echo "=3D=3D check TLS with different CA fails =3D=3D"
> +$QEMU_IMG info --image-opts \
> +    --object tls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclient=
,id=3Dtls0 \
> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0
> +
> +# success, all done

> +=3D=3D check TLS client to plain server fails =3D=3D
> +option negotiation failed: read failed: Unexpected end-of-file before =
all bytes were read

Annoying message; I wonder if we can clean that up. But not this patch's=20
problem.

> +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,t=
ls-creds=3Dtls0': Denied by server for option 5 (starttls)
> +server reported: TLS not configured

This 2-line message is better (and as such, explains why I think the=20
message about early EOF should be silenced in this case).

> +
> +=3D=3D check plain client to TLS server fails =3D=3D
> +option negotiation failed: read failed: Unexpected end-of-file before =
all bytes were read
> +qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation requ=
ired before option 8 (structured reply)
> +server reported: Option 0x8 not permitted before TLS

Same story about a redundant message.

> +write failed (error message): Unable to write to socket: Broken pipe

Hmm - is this the client complaining that it can't send more to the=20
server (that's a bug if the server hung up, since the protocol allows=20
the client to change its mind and try TLS after all), or the server=20
complaining that the client hung up abruptly without sending=20
NBD_OPT_ABORT? Qemu as client either tries TLS right away, or knows that=20
if the server requires TLS and the client has no TLS credentials then=20
the client will never succeed, so the client gives up - but it SHOULD be=20
giving up with NBD_OPT_ABORT rather than just disconnecting.  I'll have=20
to play with that.  Doesn't impact your patch, but might spur a followup=20
fix :)

> +
> +=3D=3D check TLS works =3D=3D
> +image: nbd://127.0.0.1:10809
> +file format: nbd
> +virtual size: 64M (67108864 bytes)
> +disk size: unavailable
> +

Again, also doing a read and/or write to ensure the encrypted data is=20
handled correctly would be nice. Can be in a followup patch.

> +=3D=3D check TLS with different CA fails =3D=3D
> +option negotiation failed: Verify failed: No certificate was found.
> +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,t=
ls-creds=3Dtls0': The certificate hasn't got a known issuer
> +*** done
> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.=
nbd
> index 61e9e90fee..0483ea7c55 100644
> --- a/tests/qemu-iotests/common.nbd
> +++ b/tests/qemu-iotests/common.nbd
> @@ -20,6 +20,7 @@
>   #
>  =20
>   nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
> +nbd_tcp_addr=3D"127.0.0.1"

Should this be in your earlier patch that created common.nbd? Maybe not,=20
as it doesn't get used until the functions you add here for tcp support.=20
Still, I wonder if we should split the addition of tcp support separate=20
from the new test.

>   nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
>  =20
>   function nbd_server_stop()
> @@ -62,3 +63,49 @@ function nbd_server_start_unix_socket()
>       $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &
>       nbd_server_wait_for_unix_socket $!
>   }
> +
> +function nbd_server_set_tcp_port()
> +{
> +    for port in `seq 10809 10909`
> +    do
> +	socat TCP:$nbd_tcp_addr:$port STDIO < /dev/null 1>/dev/null 2>&1

This is the first use of socat in iotests.  Might not be the most=20
portable, but I don't know if I have better ideas.=20
nbdkit.git/tests/test-ip.sh greps the output of 'ss -ltn' to locate free=20
ports, but I don't know if ss is any better than socat.

> +        if test $? !=3D 0
> +	then
> +	    nbd_tcp_port=3D$port
> +            return
> +        fi
> +    done
> +
> +    echo "Cannot find free TCP port for nbd in range 10809-10909"
> +    exit 1

Should we skip instead of fail in this case? Would we do well picking a=20
larger port range?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
