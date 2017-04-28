Received: from eggs.gnu.org ([2001:4830:134:3::10]:41242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d48HR-0002IT-Pu
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d48HN-0004ss-9b
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d48HN-0004sj-0f
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:57:57 -0400
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<20170428080821.GB2085@work-vm>
	<3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
	<20170428152729.GI2085@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <550a4e37-c4b3-181d-876c-64d73e96e78c@redhat.com>
Date: Fri, 28 Apr 2017 10:57:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170428152729.GI2085@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wmvwLKOR7Vrce4GsrUoopHEwxOcujeQ4t"
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wmvwLKOR7Vrce4GsrUoopHEwxOcujeQ4t
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>
Message-ID: <550a4e37-c4b3-181d-876c-64d73e96e78c@redhat.com>
Subject: Re: [PATCH v5 2/4] shutdown: Prepare for use of an enum in
 reset/shutdown_request
References: <20170428021317.24711-1-eblake@redhat.com>
 <20170428021317.24711-3-eblake@redhat.com> <20170428080821.GB2085@work-vm>
 <3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
 <20170428152729.GI2085@work-vm>
In-Reply-To: <20170428152729.GI2085@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 10:27 AM, Dr. David Alan Gilbert wrote:

>>>> +# Enumeration of various causes for shutdown.
>>>> +#
>>>> +# @host-qmp: Reaction to a QMP command, such as 'quit'
>>>> +# @host-signal: Reaction to a signal, such as SIGINT
>>>> +# @host-ui: Reaction to a UI event, such as closing the window
>>>> +# @host-replay: The host is replaying an earlier shutdown event
>>>> +# @host-error: Qemu encountered an error that prevents further use =
of the guest
>>>> +# @guest-shutdown: The guest requested a shutdown, such as via ACPI=
 or
>>>> +#                  other hardware-specific action
>>>> +# @guest-reset: The guest requested a reset, and the command line
>>>> +#               response to a reset is to instead trigger a shutdow=
n
>>>> +# @guest-panic: The guest panicked, and the command line response t=
o
>>>> +#               a panic is to trigger a shutdown
>>>

> At a higher level, using your tags, I'm not sure where a reset triggere=
d
> by a fault detected by the hypervisor lives - e.g. an x86 triple fault
> where the guest screws up so badly that it just gets reset.  Is
> that a guest-reset or a guest-panic or what - neither case
> was actually asked for by the guest itself.

Wouldn't that be host-error (qemu detected an error that prevents
further execution of the guest without a reset - and a triple fault
seems to fall into the category of the guest getting itself wedged
rather than actually trying to reset)?  Except patch 3 only used
SHUTDOWN_TYPE_HOST_ERROR in the xen portion of the patch.

So if any x86 expert has an opinion on where triple-fault handling is
emulated, and what category should be used there, I'm welcome to
tweaking this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wmvwLKOR7Vrce4GsrUoopHEwxOcujeQ4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA2aAAAoJEKeha0olJ0Nq/uQH/i8cBEqzsb4+dNLvKx8xxVaQ
X1H7kL3mY5sN80wBjzFiGk0bjOU2rMxb8i0QA3MnF/4Cyu6ZfdW7oMuOW1BLYiDH
OorlxFPY6nIdN9gF0hFHWzkPbZumKzbn5Itlh44WOzqmMSj/CtKBGoqlq4dzczth
zN1hrciq+E/dNtbrshqdYtEl/1O5oUTB770Uc/mUqEKu/IazJ0NqIu6V2QvedlEq
5Mtd1qMiM2/poHGoy15SiGwOcEf+dk6DThPsw1/6HraJ0DqTy+9/+fHR+3kDZXja
ST0bHKrGs9wMdOgISfxXoeCbfEbwPjYCdokQOpPVlL+9wSpYSltnnm63Xrzkm+s=
=V6t7
-----END PGP SIGNATURE-----

--wmvwLKOR7Vrce4GsrUoopHEwxOcujeQ4t--
