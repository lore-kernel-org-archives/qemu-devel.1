Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXV2n-0002Sz-74
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXV2l-0004am-I0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:12:49 -0400
References: <20180621032539.134944-1-eblake@redhat.com>
	<7570accb-ecb1-1481-4737-5a5004a2106a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c4ce0abf-7c24-bc7e-de70-08bda5378165@redhat.com>
Date: Mon, 25 Jun 2018 13:12:33 -0400
MIME-Version: 1.0
In-Reply-To: <7570accb-ecb1-1481-4737-5a5004a2106a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kJ7l8Ns20VgE2bfAyO2RXvuu43ae3jneK"
Subject: Re: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for
 testing server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kJ7l8Ns20VgE2bfAyO2RXvuu43ae3jneK
From: John Snow <jsnow@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <c4ce0abf-7c24-bc7e-de70-08bda5378165@redhat.com>
Subject: Re: [PATCH] nbd/client: add x-block-status hack for testing server
References: <20180621032539.134944-1-eblake@redhat.com>
 <7570accb-ecb1-1481-4737-5a5004a2106a@redhat.com>
In-Reply-To: <7570accb-ecb1-1481-4737-5a5004a2106a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/25/2018 09:50 AM, Max Reitz wrote:
> On 2018-06-21 05:25, Eric Blake wrote:
>> In order to test that the NBD server is properly advertising
>> dirty bitmaps, we need a bare minimum client that can request
>> and read the context.  This patch is a hack (hence the use of
>> the x- prefix) that serves two purposes: first, it lets the
>> client pass a request of more than one context at a time to
>> the server, to test the reaction of the server to various
>> contexts (via the list command).  Second, whatever the first
>> context in the user's list becomes the context wired up to the
>> results visible in bdrv_block_status(); this has the result
>> that if you pass in 'qemu:dirty-bitmap:b' instead of the usual
>> 'base:allocation', and the server is currently serving a named
>> bitmap 'b', then commands like 'qemu-img map' now output status
>> corresponding to the dirty bitmap (dirty sections look like
>> holes, while clean sections look like data, based on how the
>> status bits are mapped over the NBD protocol).
>>
>> Since the hack corrupts the meaning of bdrv_block_status(), I
>> would NOT try to run 'qemu-img convert' or any other program
>> that might misbehave based on thinking clusters have a different
>> status than what the normal 'base:allocation' would provide.
>>
>> The hack uses a semicolon-separated list embedded in a single
>> string, as that was easier to wire into the nbd block driver than
>> figuring out the right incantation of flattened QDict to represent
>> an array via the command line.  Oh well, just one more reason that
>> this hack deserves the 'x-' prefix.
>=20
> Without having looked at the patch, would an "x-debug-" prefix work
> better?  We have that for x-debug-block-dirty-bitmap-sha256.  The reaso=
n
> is that just "x-" means "experimental", which at least to me implies
> "once we have done all of our experiments, it will no longer be
> experimental and the prefix is dropped".  "x-debug-" means that it is
> actually not experimental, but just a debugging interface that will
> never be stable.
>=20
> (Yes, I know we haven't documented the meaning of x-debug- anywhere...)=

>=20
> Max
>=20

I'm not sure we actually want to check this in even temporarily, but we
do need to make use of it as a debugging facility in the meantime.

As such, x-debug- works perfectly well, but it may not matter.

--js

>> As a demo, I was able to prove things work with the following sequence=
:
>>
>> $ qemu-img info file
>> image: file
>> file format: qcow2
>> virtual size: 2.0M (2097152 bytes)
>> disk size: 2.0M
>> cluster_size: 65536
>> Format specific information:
>>     compat: 1.1
>>     lazy refcounts: false
>>     refcount bits: 16
>>     corrupt: false
>>
>> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdi=
o
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "=
package": "v2.12.0-1531-g3ab98aa673d"}, "capabilities": []}}
>> {'execute':'qmp_capabilities'}
>> {"return": {}}
>> {'execute':'blockdev-add','arguments':{'driver':'qcow2','node-name':'n=
','file':{'driver':'file','filename':'file'}}}
>> {"return": {}}
>> {'execute':'block-dirty-bitmap-add','arguments':{'node':'n','name':'b'=
,'persistent':true}}
>> {"return": {}}
>> {'execute':'quit'}
>> {"return": {}}
>> {"timestamp": {"seconds": 1529548814, "microseconds": 472828}, "event"=
: "SHUTDOWN", "data": {"guest": false}}
>>
>> $ ./qemu-io -f qcow2 file
>> qemu-io> r -v 0 1
>> 00000000:  01  .
>> read 1/1 bytes at offset 0
>> 1 bytes, 1 ops; 0.0001 sec (4.957 KiB/sec and 5076.1421 ops/sec)
>> qemu-io> w -P 1 0 1
>> wrote 1/1 bytes at offset 0
>> 1 bytes, 1 ops; 0.0078 sec (127.502231 bytes/sec and 127.5022 ops/sec)=

>> qemu-io> q
>>
>> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdi=
o
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "=
package": "v2.12.0-1531-g3ab98aa673d"}, "capabilities": []}}
>> {'execute':'qmp_capabilities'}
>> {"return": {}}
>> {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data=
':{'host':'localhost','port':'10809'}}}}
>> {"return": {}}
>> {'execute':'blockdev-add','arguments':{'driver':'qcow2','node-name':'n=
','file':{'driver':'file','filename':'file'}}}
>> {"return": {}}
>> {'execute':'nbd-server-add','arguments':{'device':'n'}}
>> {"return": {}}
>> {'execute':'x-nbd-server-add-bitmap','arguments':{'name':'n','bitmap':=
'b'}}
>> {"error": {"class": "GenericError", "desc": "Bitmap 'b' is enabled"}}
>> {'execute':'x-block-dirty-bitmap-disable','arguments':{'node':'n','nam=
e':'b'}}
>> {"return": {}}
>> {'execute':'x-nbd-server-add-bitmap','arguments':{'name':'n','bitmap':=
'b'}}
>> {"return": {}}
>> ... leave running
>>
>> $ ./qemu-img map --output=3Djson --image-opts driver=3Dnbd,export=3Dn,=
server.type=3Dinet,server.host=3Dlocalhost,server.port=3D10809
>> [{ "start": 0, "length": 1114112, "depth": 0, "zero": false, "data": t=
rue},
>> { "start": 1114112, "length": 458752, "depth": 0, "zero": true, "data"=
: false},
>> { "start": 1572864, "length": 524288, "depth": 0, "zero": false, "data=
": true}]
>>
>> $ ./qemu-img map --output=3Djson --image-opts driver=3Dnbd,export=3Dn,=
server.type=3Dinet,server.host=3Dlocalhost,server.port=3D10809,x-block-st=
atus=3Dqemu:dirty-bitmap:b
>> [{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": fal=
se},
>> { "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data"=
: true}]
>>
>> The difference between the two runs shows that base:allocation status
>> is thus different from the contents of dirty bitmap 'b'; and that the
>> dirty bitmap 'b' indeed tracked the first 64k of the file as being
>> dirty due to the qemu-io write at offset 0 performed between the creat=
ion
>> of bitmap b in the first qemu, and the disabling it prior to exporting=
 it
>> in the second qemu.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>=20


--kJ7l8Ns20VgE2bfAyO2RXvuu43ae3jneK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+ber27ys35W+dsvQfe+BBqr8OQ4FAlsxIocACgkQfe+BBqr8
OQ7yiA/8CY4w25UMjd5HwkgLC91tTSfZrMsYwIDBfOS3TBVHQFX8FSQ0JgGdSVzU
1Jpd+KwTRPBMkHw0gWCYPS+sOQ6EOFUrdJL9Q4pSKjv4l48XPYCyj/WxQK6t2BqA
zLlrhsaspS2FbkI4TjrB4wJ7jYEWuLMWPgFOBguKZjGzqE9/5aKDvbm0YqwlqBRx
CBwB0nzGNwWVUFrkklj1hIbC29Gda3X6/u/uQGd2kx7CZhlrf33CRXf21WZwI54A
5ImVJHFiQfsk9uuiXzT1MMDKAL6zonNwpsatvXR/9X//q8oMGgPGLr0Poz/nZfmb
C3VSaINON35ZPwlvpCpAGEblRJSQR8/PnZ55frcHeSdv/undm3Wb9mTnZ7yMptgb
IFio4uK5Mkpth0kQTzUckflQ2IWYiM/cD8iLQ2XUdpu2JYbiCPo6I/zWM7d3RhO4
pMAcvB8ji3TJsZIgAAHRZuL52ZJqgSCFDZTfzftkhTUt7QQWLYRmcAM2IN7dSJ27
PVGzEhKLz2WZDADUuMnJccEos3v8tvEwmGY0nogGjYv6OMa+XiH36NF3v1KG3O3w
XhGtrDs2D5AdHGKmwuG1a5FKqwN0RQmxDXXSzU6J2bXs8sJN5mubG92Qts0UMY5b
O3/3QWhVKIouRnwUK+uFt4yq5IwUTE1aXpJnI6GEijJg+Bbk0Sk=
=Xqy0
-----END PGP SIGNATURE-----

--kJ7l8Ns20VgE2bfAyO2RXvuu43ae3jneK--
