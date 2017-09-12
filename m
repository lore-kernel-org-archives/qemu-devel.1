Received: from eggs.gnu.org ([2001:4830:134:3::10]:44003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlEl-0003e9-GE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlEh-0007rc-Fk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:28:23 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-10-eblake@redhat.com>
	<8c2d1317-5b95-b8de-cf97-0b2618c86b25@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c70cd17a-4d29-8f23-e5dd-bb409182ac55@redhat.com>
Date: Tue, 12 Sep 2017 08:28:05 -0500
MIME-Version: 1.0
In-Reply-To: <8c2d1317-5b95-b8de-cf97-0b2618c86b25@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NLQdxkVLx4D8sfgJMii7XAIbrk7oafVPN"
Subject: Re: [Qemu-devel] [PATCH v7 09/38] libqos: Track QTestState with
 QVirtioBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NLQdxkVLx4D8sfgJMii7XAIbrk7oafVPN
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:virtio-blk" <qemu-block@nongnu.org>
Message-ID: <c70cd17a-4d29-8f23-e5dd-bb409182ac55@redhat.com>
Subject: Re: [PATCH v7 09/38] libqos: Track QTestState with QVirtioBus
References: <20170911172022.4738-1-eblake@redhat.com>
 <20170911172022.4738-10-eblake@redhat.com>
 <8c2d1317-5b95-b8de-cf97-0b2618c86b25@redhat.com>
In-Reply-To: <8c2d1317-5b95-b8de-cf97-0b2618c86b25@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 02:21 AM, Thomas Huth wrote:
> On 11.09.2017 19:19, Eric Blake wrote:
>> When initializing a QVirtioDevice (which always has an associated
>> QVirtioBus), we want to track which QTestState to use for all
>> I/O processed through that bus and device.  Copy the paradigm
>> used for QPCIBus, and track the test state at the bus level; this
>> in turn requires a separate bus object per device (and associated
>> cleanup) rather than just sharing a const version of the dispatch
>> table.
> I fail to see why we need a separate bus object here for each device.
> The bus is only available one time, not multiple times, isn't it? So
> there should also only be one bus object floating around, not multiple
> ones... or do I miss something?

You are right that there is only one bus for the machine - the problem
is that the object representing the bus is dynamically created on the
fly at the point where the device is first grabbed, rather than up front
as part of creating the machine (in other words, the device search is
not performed on a pre-existing bus object).

Contrast qpci_device_find() (lookup based on a pre-existing bus) with
qvirtio_mmio_init_device() (lookup that did not use a pre-existing bus);
also note that qvirtio_pci_device_find() takes a pre-existing QPCIBus
(since on that architecture, the QVirtioBus is itself a device on the
QPCIBus).

I suppose that we could indeed refactor the code to require callers to
create the QVirtioBus object up front, and then make the device lookup
(both qvirtio_mmio_init_device() and qvirtio_pci_device_find()) take a
QVirtioBus parameter instead of QTestState or QPCIBus.  That's slightly
more work, but I'm happy to attempt it if you think it will be better.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NLQdxkVLx4D8sfgJMii7XAIbrk7oafVPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm34OUACgkQp6FrSiUn
Q2o8tggAn01J7hxuJKtH8Jz0BVSlApjCbpmruK3ScPu/OkZ2jTvl3DCltoShGSgt
gf9+UL2UsHbr2Q+/ygXfLMR1ChDjMOPg8Gyn1i4sYUBnIHFJpsBqeHSqW5uN3x5I
nUcoVgRZ1HFhmkq/HXlT576Fz8D3Cc86V20/52gdkaqHcXVm19O5EbpoEVhPwoii
YqGt536K1SMrJXAkSIToZixRdJb185mS9dBIAWTe5xeWYPAqiDPtNtdKXH4V/1Xt
1N38CciyIG7jCjpwuKnLRkkNA/y/I9gy96SlVQiP6GN4iv2Fi+wHVwjtRaIpqBTN
xqTYro40ojZnxWNQJVG/6BipXVMuRg==
=xHyO
-----END PGP SIGNATURE-----

--NLQdxkVLx4D8sfgJMii7XAIbrk7oafVPN--
