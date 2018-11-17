Received: from eggs.gnu.org ([2001:4830:134:3::10]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gO94k-0004Oz-IB
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 17:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gO94j-0007DD-Nj
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 17:28:26 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08baf15a-7205-7a47-c806-dccadcaca291@redhat.com>
Date: Sat, 17 Nov 2018 15:31:34 -0600
MIME-Version: 1.0
In-Reply-To: <5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/16/18 11:20 AM, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
>> Add tests that validate it is possible to connect to an NBD server
>> running TLS mode. Also test mis-matched TLS vs non-TLS connections
>> correctly fail.
>> ---

>> +=3D=3D check TLS client to plain server fails =3D=3D
>> +option negotiation failed: read failed: Unexpected end-of-file before=
=20
>> all bytes were read
>=20
> Annoying message; I wonder if we can clean that up. But not this patch'=
s=20
> problem.
>=20

Actually, I tracked this message down to using socat (which actually=20
connects and then abruptly exits) when probing whether the socket is up=20
and listening.  That is, the message is being produced as a side effect=20
of nbd_server_wait_for_tcp_socket rather than during the actual=20
$QEMU_IMG command we are interested in testing.


>> =C2=A0 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
>> =C2=A0 function nbd_server_stop()
>> @@ -62,3 +63,49 @@ function nbd_server_start_unix_socket()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $QEMU_NBD -v -t -k "$nbd_unix_socket" $=
@ &
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_server_wait_for_unix_socket $!
>> =C2=A0 }
>> +
>> +function nbd_server_set_tcp_port()
>> +{
>> +=C2=A0=C2=A0=C2=A0 for port in `seq 10809 10909`
>> +=C2=A0=C2=A0=C2=A0 do
>> +=C2=A0=C2=A0=C2=A0 socat TCP:$nbd_tcp_addr:$port STDIO < /dev/null 1>=
/dev/null 2>&1
>=20
> This is the first use of socat in iotests.=C2=A0 Might not be the most=20
> portable, but I don't know if I have better ideas.=20
> nbdkit.git/tests/test-ip.sh greps the output of 'ss -ltn' to locate fre=
e=20
> ports, but I don't know if ss is any better than socat.

So, I'm planning to squash this in, to use ss instead of socat, as follow=
s:

diff --git i/tests/qemu-iotests/common.nbd w/tests/qemu-iotests/common.nb=
d
index 0483ea7c55a..d73af285abd 100644
--- i/tests/qemu-iotests/common.nbd
+++ w/tests/qemu-iotests/common.nbd
@@ -66,12 +66,12 @@ function nbd_server_start_unix_socket()

  function nbd_server_set_tcp_port()
  {
-    for port in `seq 10809 10909`
+    (ss --help) >/dev/null 2>&1 || _notrun "ss utility not found,=20
skipping test"
+
+    for ((port =3D 10809; port <=3D 10909; port++))
      do
-	socat TCP:$nbd_tcp_addr:$port STDIO < /dev/null 1>/dev/null 2>&1
-        if test $? !=3D 0
-	then
-	    nbd_tcp_port=3D$port
+        if ! ss -tln | grep -sqE ":$port\b"; then
+            nbd_tcp_port=3D$port
              return
          fi
      done
@@ -86,9 +86,7 @@ function nbd_server_wait_for_tcp_socket()

      for ((i =3D 0; i < 300; i++))
      do
-        socat TCP:localhost:$nbd_tcp_port STDIO < /dev/null 1>/dev/null=20
2>&1
-        if test $? =3D=3D 0
-	then
+        if ss -tln | grep -sqE ":$nbd_tcp_port\b"; then
              return
          fi
          kill -s 0 $pid 2>/dev/null
diff --git i/tests/qemu-iotests/233.out w/tests/qemu-iotests/233.out
index eaa410c2703..eb4077f9fd7 100644
--- i/tests/qemu-iotests/233.out
+++ w/tests/qemu-iotests/233.out
@@ -11,12 +11,10 @@ Generating a signed certificate...
  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864

  =3D=3D check TLS client to plain server fails =3D=3D
-option negotiation failed: read failed: Unexpected end-of-file before=20
all bytes were read
  qemu-img: Could not open=20
'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls-creds=3Dtls0': Denied by =
server=20
for option 5 (starttls)
  server reported: TLS not configured

  =3D=3D check plain client to TLS server fails =3D=3D
-option negotiation failed: read failed: Unexpected end-of-file before=20
all bytes were read
  qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation=20
required before option 8 (structured reply)
  server reported: Option 0x8 not permitted before TLS
  write failed (error message): Unable to write to socket: Broken pipe


Also, you have to sanitize 233.out to change 10809 into PORT, so the=20
test can still pass when it picked a different port.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
