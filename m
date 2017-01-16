Received: from eggs.gnu.org ([2001:4830:134:3::10]:48880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cTERK-0005CR-0O
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cTERG-0007tO-Rz
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:03:42 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cardoe@cardoe.com>) id 1cTERG-0007t5-Md
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:03:38 -0500
Received: by mail-it0-x243.google.com with SMTP id v14so13564409itb.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 13:03:37 -0800 (PST)
References: <20170112114612.14520-1-stefanha@redhat.com>
	<fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
	<20170113120240.GB9142@stefanha-x1.localdomain>
	<75cb767b-2850-4a87-50fc-d957e3a793ac@cardoe.com>
	<20170116104613.GB12351@stefanha-x1.localdomain>
From: Doug Goldstein <cardoe@cardoe.com>
Message-ID: <f8b3d861-09a3-a4c8-dca7-e4fb384c2a73@cardoe.com>
Date: Mon, 16 Jan 2017 16:03:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170116104613.GB12351@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="0LpjANfcv712XnxoHcdEnBbeXWhApJjRi"
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0LpjANfcv712XnxoHcdEnBbeXWhApJjRi
From: Doug Goldstein <cardoe@cardoe.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <f8b3d861-09a3-a4c8-dca7-e4fb384c2a73@cardoe.com>
Subject: Re: [PATCH 0/2] virtio: revert virtio_queue_set_notification()
 nesting
References: <20170112114612.14520-1-stefanha@redhat.com>
 <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
 <20170113120240.GB9142@stefanha-x1.localdomain>
 <75cb767b-2850-4a87-50fc-d957e3a793ac@cardoe.com>
 <20170116104613.GB12351@stefanha-x1.localdomain>
In-Reply-To: <20170116104613.GB12351@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/16/17 5:46 AM, Stefan Hajnoczi wrote:
> On Fri, Jan 13, 2017 at 09:15:49AM -0600, Doug Goldstein wrote:
>> On 1/13/17 6:02 AM, Stefan Hajnoczi wrote:
>>> On Thu, Jan 12, 2017 at 10:57:53AM -0600, Doug Goldstein wrote:
>>>> On 1/12/17 5:46 AM, Stefan Hajnoczi wrote:
>>>>> The virtio_queue_set_notification() nesting introduced for AioConte=
xt polling
>>>>> raised an assertion with virtio-net (even in non-polling mode).  Co=
nverting
>>>>> virtio-net and virtio-crypto to use virtio_queue_set_notification()=
 in a
>>>>> nesting fashion would be invasive and isn't worth it.
>>>>>
>>>>> Patch 1 contains the revert to resolve the bug that Doug noticed.
>>>>>
>>>>> Patch 2 is a less efficient but safe alternative.
>>>>>
>>>>> Stefan Hajnoczi (2):
>>>>>   Revert "virtio: turn vq->notification into a nested counter"
>>>>>   virtio: disable notifications again after poll succeeded
>>>>>
>>>>>  hw/virtio/virtio.c | 21 +++++++++------------
>>>>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>>>>
>>>>
>>>> So I just gave this series a whirl and it fixes the assert but cause=
s
>>>> another issue for me. While iPXE is getting a DHCP address the scree=
n
>>>> immediately flashes over to the UEFI shell. Its like a timeout is
>>>> getting hit and just dropping me to the shell.
>>>
>>> Sounds like an separate problem.
>>>
>>> Stefan
>>>
>>
>> Is there any debug output that I can provide to help troubleshoot it?
>> I've built 23425cc and UEFI via OVMF is able to get an IP address via
>> DHCP inside of iPXE. I've also taken master and only applied the first=

>> patch in this series (the revert) and it too works. Its only when I ad=
d
>> the 2nd patch into the mix or don't revert out the "virtio: turn
>> vq->notification into a nested counter" patch that it fails.
>=20
> The code in Patch 2 should not be executed in your QEMU configuration,
> so I wonder how Patch 2 can cause the DHCP failure.
>=20
> Please verify as follows:
>=20
>   $ gdb --args path/to/qemu-system-x86_64 ...
>   (gdb) handle SIGUSR1 noprint nostop pass
>   (gdb) handle SIGPIPE noprint nostop pass
>   (gdb) b virtio_queue_host_notifier_aio_poll_begin
>   (gdb) r
>=20
> I predict the breakpoint will not be hit.
>=20
> Stefan
>=20


Correct. That did not hit. I reapplied both patches to my current master
and it did not hit but it still dropped me to the EFI shell while iPXE
was negotiating DHCP.

I then rebased on top of the latest master
(2ccede18bd24fce5db83fef3674563a1f256717b) and applied both patches. The
iPXE issue went away and the assert issue went away.

So I will concur with you, the issue was not in either of these patches
and is now resolved.

--=20
Doug Goldstein


--0LpjANfcv712XnxoHcdEnBbeXWhApJjRi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0

iQJ8BAEBCgBmBQJYfTUjXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBNTM5MEQ2RTNFMTkyNzlCNzVDMzIwOTVB
MkJDMDNEQzg3RUQxQkQ0AAoJEKK8A9yH7RvUvbwP/RHoH7yMC4YXL6T8RljWK0Ks
IuttsqnXZJS7/RUrVCpwD3bvml+Qi91xAYhyRxBD9vTePNM+JduRAkSaBGcyi702
oOGP1nhCSYYc41qsc66PZBu/44U9kJBtkd/5LrqFvuDVgqvyyrlTYLCfUAZLqdZW
E/alOS6Jf0agtWq9XhIRSY1BbjFfwG5+b3Vo+qlRrk+lRrnZwJQ6OSPq6sZUjT9N
qFTt5C/Vi+MMoljzjoiVcJjWl2nc/llj4kwVxs+74q45OC9IVdVcDemjAoZxF9s4
7XbTDFleI62ncYXyY5hC2OqnkYRaiW6D0G4gBgIoIhpAUIx1ugHXyVXQd575M/AW
OgftAF5EBJWmzMkFw1ROmj4QY3Iq3n5M2X7cFzgPFafCKISbASUSX6JwLCVfBMWx
P79XCq97zgJjpmLRpUcEChTEdRF2rJW5jmHak+RpFO2hgekEoXHu5XdJ6BXcdYYR
9JZK4hKeIgsBgrnPdZGtStNSrQOJ4YQtxL2GzadJwsIt2zG0tcDTx0Uz0gMMNf03
GodZuwRDM+0rz0s0TT1hpOSX/fo3NFtt2Yz1OH3Nby0YLrqx7KB/g6HBcIhbl4rN
IBwB8KcSZCsXzx2KoyU4Demn6HDtuAZZBcKU4Ge9mtONU7zU7CIo42My3a6k/+aw
K1J2CL1J0rd1juxC/827
=6inU
-----END PGP SIGNATURE-----

--0LpjANfcv712XnxoHcdEnBbeXWhApJjRi--
