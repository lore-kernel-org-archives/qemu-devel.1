Received: from eggs.gnu.org ([2001:4830:134:3::10]:41198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpi6Q-00034Q-2W
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpi6L-0003GX-8A
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:43:18 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-17-eblake@redhat.com>
	<2ad3ad60-1f03-4585-45e1-d12ab593008f@redhat.com>
	<CABgObfYCUmUO8oTp3oM56t1d9cX-t7FdRTE4e5SaDVqp4UAS0g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44ecdf8c-dc4f-7318-414e-24c7c4cbf6aa@redhat.com>
Date: Wed, 6 Sep 2017 16:42:58 -0500
MIME-Version: 1.0
In-Reply-To: <CABgObfYCUmUO8oTp3oM56t1d9cX-t7FdRTE4e5SaDVqp4UAS0g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="neN1beGBIt9biPBTMnRM88gx1KJf8comH"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6 16/29] libqos: Use explicit
 QTestState for virtio operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--neN1beGBIt9biPBTMnRM88gx1KJf8comH
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 armbru@redhat.com
Message-ID: <44ecdf8c-dc4f-7318-414e-24c7c4cbf6aa@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH v6 16/29] libqos: Use explicit
 QTestState for virtio operations
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-17-eblake@redhat.com>
 <2ad3ad60-1f03-4585-45e1-d12ab593008f@redhat.com>
 <CABgObfYCUmUO8oTp3oM56t1d9cX-t7FdRTE4e5SaDVqp4UAS0g@mail.gmail.com>
In-Reply-To: <CABgObfYCUmUO8oTp3oM56t1d9cX-t7FdRTE4e5SaDVqp4UAS0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 07:43 AM, Paolo Bonzini wrote:
>>  typedef struct QVirtioDevice {
>>      const QVirtioBus *bus;
>> +    QTestState *qts;
>>      /* Device type */
>>      uint16_t device_type;
>>  } QVirtioDevice;
>> @@ -35,12 +36,14 @@ typedef struct QVirtQueue {
>>      uint16_t last_used_idx;
>>      bool indirect;
>>      bool event;
>> +    QTestState *qts;
>>  } QVirtQueue;
>>
>>  typedef struct QVRingIndirectDesc {
>>      uint64_t desc; /* This points to an array fo struct vring_desc */=

>>      uint16_t index;
>>      uint16_t elem;
>> +    QTestState *qts;
>>  } QVRingIndirectDesc;
>=20
> Adding QTestState to QVRingIndirectDesc and QVirtQueue sounds somewhat
> ugly to me. I think they should either rather have a pointer to the
> associated QVirtioDevice, or the functions where this is needed
> (qvring_init() for example) should get a "QTestState *" parameter inste=
ad.
>=20
>=20
> I agree with Thomas and even extend it to QVirtioDevice. If there is a
> has-a hierarchy between libqos objects, only the topmost one (such as t=
he
> virtio mmio bus device, and the PCI host bridge---or possibly even the
> machine object exclusively) should have a QTestState. Everyone else can=

> access it implicitly through operations on its bus.

[Paolo, gmail is really messing up with your quoting style ;( ]

Okay, so if I understand correctly, at most a QVRingIndirectDesc can
have a pointer back to the QVirtioDevice that owns it, and in turn the
QVirtioDevice has a pointer back to the QPCIBus that the device is on,
and anywhere that needs a QTestState follows the chain back to the
QPCIBus to get it.  I'll play with the idea, as it may still allow for
more compact code than passing an explicit QTestState parameter through
every call.

>=20
> Test code on the other hand can use global_qtest implicitly when they
> prepare/read buffers that the devices do DMA from/to.

Not when I'm done - my next series gets rid of implicit global_qtest
everywhere.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--neN1beGBIt9biPBTMnRM88gx1KJf8comH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwa+IACgkQp6FrSiUn
Q2qcjAf/Y+/es6j7cSsPgeBXoKk/hImkHAp24EAzdyTTgDAk6AKQZ0cxORa9MRZo
EbRAHJRct/mthbnabwLJ+GzzkkL0Xy3UUnY67O6ooaZBFNEERtMJZD/bm2sUJGFP
RQ3XghwH3pXpTqLq8V62mK9x16tTePilhC9VZJZE7NJoe5q4LlqTg4elOLzxpz16
56gRgKELWUp01jqhBUk0Qsvj6m7azA7nZWZ8XObbYi04LShmVEDGXtMXOj5LCXCU
TFcHDl6yb/5js5961Vg9bz6H9QNJcY4aTvEOYICJEI1vpQizpk8DU0g/waHI7oht
E6Vd3X90mITSlnYnX2nYS2kKRzBVrA==
=breO
-----END PGP SIGNATURE-----

--neN1beGBIt9biPBTMnRM88gx1KJf8comH--
