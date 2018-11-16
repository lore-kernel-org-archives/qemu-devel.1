Received: from eggs.gnu.org ([2001:4830:134:3::10]:55679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNevk-0008Nm-1i
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNevj-0006tO-9d
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:17:08 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20181011072135.588-1-famz@redhat.com>
	<20181011072135.588-3-famz@redhat.com>
	<w51tvkjkbmc.fsf@maestria.local.igalia.com>
	<8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
	<w51lg5tunti.fsf@maestria.local.igalia.com>
	<1baf27e0-fa37-0d84-5d08-c4dcd788a67e@redhat.com>
Message-ID: <4c70596f-d6e3-f243-7512-6ef9176b9d52@redhat.com>
Date: Fri, 16 Nov 2018 15:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <1baf27e0-fa37-0d84-5d08-c4dcd788a67e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SMq7PWO0M8lLLYHpRX5fBs2Ha5BDVdpf5"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/3] file-posix: Drop
 s->lock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SMq7PWO0M8lLLYHpRX5fBs2Ha5BDVdpf5
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <4c70596f-d6e3-f243-7512-6ef9176b9d52@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 2/3] file-posix: Drop s->lock_fd
References: <20181011072135.588-1-famz@redhat.com>
 <20181011072135.588-3-famz@redhat.com>
 <w51tvkjkbmc.fsf@maestria.local.igalia.com>
 <8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
 <w51lg5tunti.fsf@maestria.local.igalia.com>
 <1baf27e0-fa37-0d84-5d08-c4dcd788a67e@redhat.com>
In-Reply-To: <1baf27e0-fa37-0d84-5d08-c4dcd788a67e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.11.18 15:02, Max Reitz wrote:
> On 16.11.18 14:58, Alberto Garcia wrote:
>> On Fri 16 Nov 2018 02:34:25 PM CET, Max Reitz wrote:
>>> To me that looks like a problem in the general reopen code.
>>> raw_reopen_prepare() is called and succeeds.  Then
>>> bdrv_reopen_prepare() notices the option wasn't handled and therefore=

>>> fails.  bdrv_reopen_multiple() thus doesn't set bs_entry->prepared to=

>>> true, which means raw_reopen_abort() won't be called.
>>>
>>> We should always call either BlockDriver.bdrv_reopen_commit() or
>>> BlockDriver.bdrv_reopen_abort() when BlockDriver.bdrv_reopen_prepare(=
)
>>> succeeded.
>>
>> So you mean getting rid of BlockReopenQueueEntry.prepared altogether?
>=20
> I mean just calling .bdrv_reopen_abort() in bdrv_reopen_prepare() if
> there was an error after .bdrv_reopen_prepare() succeeded.
>=20
> I have a patch, I'm just trying to think of a useful test...

To elaborate, I didn't want to use your test for two reasons.  First, it
seemed generally too dependant on what file-posix's implementation does.
 Second, I couldn't get it to work in any shorter form (which seemed
weird) and why would it even print something about consistent_read?
That seemed weird, too.

I would've thought that just any case where bdrv_reopen_prepare() fails
after a successful .bdrv_reopen_prepare() could trigger the issue, but
that's not the case.

This is because the file locks are not applied to the new FD just by
duping it, they are only applied in raw_reopen_commit().  So if you
prepare without abort without any commit before, the problem disappears.

So there had to be something wrong in raw_reopen_commit(), too.  It
turns out that this is indeed in the above commit, it should pass
"s->locked_shared_perm" instead of "~s->locked_shared_perm" to
raw_apply_lock_bytes().

Max


--SMq7PWO0M8lLLYHpRX5fBs2Ha5BDVdpf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvu0VcACgkQ9AfbAGHV
z0AIhwf6AgBvVKMBeIH0eoXkhZAT9OV3AUTuo/61ga0tRe3KO/ic8aDcYuvoZ5ub
XAhr3jd+fUMkrqrVsYaRxyCVsLTGjwltzlCn64KtqJEsAdOlcFScf5WXMbZ7BPjT
SGTFl0VxsID12i3cOf3KQKsYPict9rw0Lgh858BfxQt9U51YvHecUiipqxLVC4FI
RQ/qeQhRIwssyDGnzWoXJPFfKNl0zzYLudWbzuUtjoQ2oa3TCCawA0RDNNi9W3fS
VBsyVujaNnRjmKTA987xMh1TGVyqtiOa46o50Gs6sHt9dg+Dc0iEqGFKndOegWHt
Nl/qzpM7Aae3c0jE8Go8ou9K3aldCw==
=0HRK
-----END PGP SIGNATURE-----

--SMq7PWO0M8lLLYHpRX5fBs2Ha5BDVdpf5--
