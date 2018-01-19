Received: from eggs.gnu.org ([2001:4830:134:3::10]:58109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eccet-0003HV-2J
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eccep-0001ZC-SP
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:49:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eccep-0001WY-Ho
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:48:59 -0500
References: <20180119162554.27270-1-marcandre.lureau@redhat.com>
	<0bf279e2-0f90-06ee-2779-1a3f67665ecf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86c60f49-bdf9-c3a5-7c0e-c05f6dd11db5@redhat.com>
Date: Fri, 19 Jan 2018 13:48:54 -0600
MIME-Version: 1.0
In-Reply-To: <0bf279e2-0f90-06ee-2779-1a3f67665ecf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jEVVuZADFOHFgexmypmC1Y89M56QQzKPw"
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix python 2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jEVVuZADFOHFgexmypmC1Y89M56QQzKPw
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <86c60f49-bdf9-c3a5-7c0e-c05f6dd11db5@redhat.com>
Subject: Re: [PATCH v2] dump-guest-memory.py: fix python 2 support
References: <20180119162554.27270-1-marcandre.lureau@redhat.com>
 <0bf279e2-0f90-06ee-2779-1a3f67665ecf@redhat.com>
In-Reply-To: <0bf279e2-0f90-06ee-2779-1a3f67665ecf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 01:18 PM, Laszlo Ersek wrote:
> On 01/19/18 17:25, Marc-Andr=C3=A9 Lureau wrote:
>> Python GDB support may use Python 2 or 3.
>>
>> Inferior.read_memory() may return a 'buffer' with Python 2 or a
>> 'memoryview' with Python 3 (see also
>> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>>
>> The elf.add_vmcoreinfo_note() method expects a "bytes" object. Wrap
>> the returned memory with bytes(), which works with both 'memoryview'
>> and 'buffer'.
>>

If I understand it, the issue stems from the fact that vmcoreinfo is a
bytes buffer under python2, but a memoryview under python3.  Let's
compare the patches:

The V1 patch:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg04010.html

>
>          if vmcoreinfo:
> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
> +            # Python 2.7 returns a buffer
> +            vmciview =3D memoryview(vmcoreinfo)
> +            self.elf.add_vmcoreinfo_note(vmciview.tobytes())

did an unconditional memoryview(vmcoreinfo) followed by a .tobytes()
call. Under python 2.7, vmcoreinfo is converted from a buffer to a
memoryview, then back to bytes; under python 3, memoryview(vmcoreinfo)
is a no-op (since it is already a memory view), then that is converted
to bytes; the double conversion was necessary because bytes.tobytes()
doesn't exist.  But python 2.6 doesn't have the memoryview conversion,
so we've excluded older python users.

Now looking at the V2 patch:


>> @@ -564,7 +564,7 @@ shape and this command should mostly work."""
>> =20
>>          vmcoreinfo =3D self.phys_memory_read(addr, size)
>>          if vmcoreinfo:
>> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
>> +            self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))

Under python2, and bytes(buffer) is still bytes; under python3,
vmcoreinfo is a memoryview but bytes(buffer) is equivalent to
buffer.to_bytes().  We've avoided the intermediate conversion through
memoryview, and thus work regardless of python version.

> Ugh, can you please point me to the v1->v2 difference?

Hope that helped (and hope I got it right, I'm learning as well from
this thread).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jEVVuZADFOHFgexmypmC1Y89M56QQzKPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpiS6YACgkQp6FrSiUn
Q2r55QgApzu4ILcGwcMAvH2kjXPOL28R/fWZ4epuziDeNCqBS+XUT5IuEN6s7YOy
szimXHyl2gGCP8ATrHzWAT5eoLGea7/9FfCUjvJa3Q1ldsYeNcD3YCbLJyCe83T5
P5zEST0x1S115LtBdpnBgF5J3yFBfsfsZvCRmxTpywmCJc2UuQ7B56EtPiQPDts5
RHqevpX5SPF7uaHOYXtmXL40pJuQ67fC6fVwcYwrQrfelMxYXWuhkSh5XoxEURIQ
xIjqWgqQ3w0VNHMr444OdM52o8W27cXGR5a0w6L8pEmgZEXfkOCE3k8Vt4Uxw0/A
yL0mN8o+QBk70g3BCrdF4S04bT0X/A==
=eiim
-----END PGP SIGNATURE-----

--jEVVuZADFOHFgexmypmC1Y89M56QQzKPw--
