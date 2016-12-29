Received: from eggs.gnu.org ([2001:4830:134:3::10]:57419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMavj-0003yx-Lz
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMavg-00041Y-IJ
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:39:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMavg-00040C-92
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:39:36 -0500
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
	<20161219135529.GE17374@stefanha-x1.localdomain>
	<aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
	<4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
	<f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e937c652-41c4-4b6b-c4d5-7a77ace3342e@redhat.com>
Date: Thu, 29 Dec 2016 07:39:32 -0600
MIME-Version: 1.0
In-Reply-To: <f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XAn27CPKHb381PbHqoHDuabErhrfWOvuW"
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Pereira <kripper@imatronix.cl>, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAn27CPKHb381PbHqoHDuabErhrfWOvuW
From: Eric Blake <eblake@redhat.com>
To: Christopher Pereira <kripper@imatronix.cl>,
 Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <e937c652-41c4-4b6b-c4d5-7a77ace3342e@redhat.com>
Subject: Re: [Qemu-devel] Can qemu reopen image files?
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
 <20161219010743.GA2719@lemon>
 <20161219135529.GE17374@stefanha-x1.localdomain>
 <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
 <4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
 <f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
In-Reply-To: <f8f625d2-fd0d-f152-7521-6ef2b3d74309@imatronix.cl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2016 10:24 AM, Christopher Pereira wrote:
> Hi Eric,
>=20
> Thanks for your great answer.
>=20
> On 19-Dec-16 12:48, Eric Blake wrote:
>=20
>>
>>> Then we do the rebase while the VM is suspended to make sure the imag=
e
>>> files are reopened.
>> That part is where you are liable to break things.  Qemu does NOT have=
 a
>> graceful way to reopen the backing chain, so rebasing snap3 to point t=
o
>> snap2' behind qemu's back is asking for problems.  Since qemu may be
>> caching things it has already learned about snap2, you have invalidate=
d
>> that cached data by making snap3 point to snap2', but have no way to
>> force qemu to reread the backing chain to start reading from snap2'.
> We are actually doing a save, rebase and restore to reopen the backing
> chain.

In which case, after the save, qemu is not running, and therefore
anything you do with qemu-img is not operating behind qemu's back, and
then the restore should work okay if the guest-visible data is identical
even though the backing chain has changed.

It is unsafe to edit a backing chain WHILE qemu is also using the same
chain, but it sounds like you are taking care (at the expense of guest
downtime) to have no qemu process active during the time of your edits,
which can indeed be safe.

> We only touch files (rebase) while the VM is down.
> Can you please confirm this is 100% safe?

I can't confirm 100% safety without seeing actual transcripts of what
you did, of course, but the idea is sound.

But your original problem statement said the VM is suspended (which
implies there is still a qemu process with the chain open, where
resuming the VM involves another command to that qemu process to resume
the cpus - not safe), not saved (which implies that you have created a
migration stream and ended the qemu process, and resuming the VM
involves starting a new qemu process on an incoming migration stream -
can be safe).

>=20
>> Or, if you don't want to merge into "base'", you can use block-stream =
to
>> merge the other direction, so that "base <- snap1 <- snap2" is convert=
ed
>> into "snap2'" - but that depends on patches that were only barely adde=
d
>> in qemu 2.8 (intermediate block-commit has existed a lot longer than
>> intermediate block-stream).  But the point remains that you are still
>> using qemu to do the work, and therefore with no external qemu-img
>> process interfering with the chain, you don't need any guest downtime =
or
>> any risk of breaking qemu operation by invalidating data it may have
>> cached.
> Right. Since images are backed up remotely, we don't want to merge into=

> base nor touch the backing chain at all (only the active snapshot shoul=
d
> be modified). This is to keep things simple and avoid to re-syncs of
> images (remote backups).
>=20
> Besides, we don't want to merge the whole backing chain, but an
> intermediate point, so it seems that the clean way is to use the
> "intermediate block-stream" feature.
>=20
> We didn't try it, because when we researched we got the impression that=

> the patches were not stable yet or not included in the qemu versions
> shipped with CentOS, so we went with 'qemu-img convert' because we
> needed something known, simple and stable (we are dealing with critical=

> information for gov. orgs.).

CentOS tracks downstream Red Hat RHEL releases, which indeed tend to use
older (but proven stable) qemu releases + patch backports as
appropriate.  But CentOS is self-supported, so you have no control over
which patches are backported, if you don't upgrade to a full Red Hat
support contract.  On this list, we tend to focus on upstream
development, questions about particular features (what has been
backported or not) are better directed to downstream vendors that
maintain those backports.  So whether a particular CentOS build includes
intermediate block-stream capabilities is more a question to CentOS
lists or Red Hat support contracts, not this list.

>=20
>> If block-commit and block-stream don't have enough power to do what yo=
u
>> want, then we should patch them to expose that power, rather than
>> worrying about how to use qemu-img to modify the backing chain behind
>> qemu's back.
> "intermediate block-stream" seems to be the right solution for our use
> case.
> Does it also allow QCOW2 compression?

Hmm. In the current upstream qapi/block-core.json file, the DriveBackup
and 'BlockdevBackup' structs include an optional 'compress':'bool'
parameter, but 'block-stream' does not yet do so.  It's probably a
simple enough patch to add, by basing it on what was done for
blockdev-backup, but no one has written it yet.  It's certainly worth
adding though, as it (should be) fairly obvious that a streaming
operation is going to be a write-once action where compressing the
resulting sectors being written probably has a benefit.

> Compression is interesting, especially when files are sync'ed via netwo=
rk.
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XAn27CPKHb381PbHqoHDuabErhrfWOvuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYZRIUAAoJEKeha0olJ0NqHDoH/i/+71oZxaL2ES49cWlVU2rg
SLE8gwlNz+YEmy+M+XnjiK9ofNuYTktf0YXxHvc1b7U/mr3iIF8/6AYH+fIvf/4x
o81UztuMVTthsBj/hqr2ifKir2u7xIsX2SGbmx7+TqoBhLmwPgp6ZNr6tJZkQTJB
wVMuKOpnHdiuFLiYq4NxK1YHgenz4LXzK/1F/E8vk0JYQOfJjH092/TPo+5wXIzF
YHMSEBgLztqdHMaHDNR3x/qwaCyZ3qyDDUh4+lExEBk9SDang8lJWOxNSKSMSyFz
VhIukJIw5aVduhvefIYeluXA5AdmicQwZko3N1+FgB5EOms4Mc/sj41+S4y3uOU=
=438U
-----END PGP SIGNATURE-----

--XAn27CPKHb381PbHqoHDuabErhrfWOvuW--
