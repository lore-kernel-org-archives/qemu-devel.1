Received: from eggs.gnu.org ([2001:4830:134:3::10]:34317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4px-0000rA-Rj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4pt-0002yi-Ng
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:40:21 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw4pt-0002yK-H7
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:40:17 -0400
Received: by mail-wr0-x243.google.com with SMTP id o21so5002991wrb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:40:17 -0700 (PDT)
Date: Thu, 6 Apr 2017 11:40:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406104013.GD21895@stefanha-x1.localdomain>
References: <CA+Vqw5nfvdR-sE6DfmxMJmbE6+khoYLZSh+JAPD_9vVHtfdBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <CA+Vqw5nfvdR-sE6DfmxMJmbE6+khoYLZSh+JAPD_9vVHtfdBpg@mail.gmail.com>
Subject: Re: [Qemu-devel] Performance problem and improvement about block
 drive on NFS shares with libnfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jaden Liang <jaden1q84@gmail.com>
Cc: qemu-devel@nongnu.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 01:23:46PM +0800, Jaden Liang wrote:
> Hello,
>=20
> I ran qemu with drive file via libnfs recently, and found some performance
> problem and an improvement idea.
>=20
> I started qemu with 6 drives parameter like nfs://127.0.0.1/dir/vm-disk-x=
=2Eqcow2
> which linked to a local NFS server, then used iometer in guest machine to=
 test
> the 4K random read or random write IO performance. I found that while the=
 IO
> depth go up, the IOPS hit a bottleneck. I looked into the causes, found t=
hat the
> main thread of qemu used 100% CPU. From the perf data, it show the CPU he=
ats are
> send / recv calls in libnfs. By reading the source code of libnfs and qem=
u block
> drive of nfs.c, libnfs only support single work thread, and the network e=
vents
> of nfs interface in qemu are all registered in the epoll of main thread. =
That is
> the cause why main thread uses 100% CPU.
>=20
> After the analysis above, there is an improvement idea comes up. I start a
> thread for every drive while libnfs open drive file, then create an epoll=
 in
> every drive thread to handle all of the network events. I have finished a=
n demo
> modification in block/nfs.c, then rerun iometer in the guest machine, the
> performance increased a lot. Random read IOPS increases almost 100%, rand=
om
> write IOPS increases about 68%.
>=20
> Test model details
> VM configure: 6 vdisks in 1 VM
> Test tool and parameter: iometer with 4K random read and randwrite
> Backend physical drive: 2 SSDs, 6 vdisks are seperated in 2 SSDs
>=20
> Before modified:
> IO Depth           1        2          4           8       16         32
> 4K randread  16659  28387   42932   46868   52108   55760
> 4K randwrite  12212   19456   30447   30574   35788   39015
>=20
> After modified:
> IO Depth            1         2          4          8        16          =
32
> 4K randread   17661   33115   57138   82016   99369   109410
> 4K randwrite  12669   21492   36017   51532   61475   65577
>=20
> I could put a up to coding standard patch later. Now I want to get some a=
dvise
> about this modification. Is this a reasonable solution to improve perform=
ance in
> NFS shares? Or there is another better way?
>=20
> Any suggestions would be great! Also please feel free to ask question.

Did you try using -object iothread,id=3Diothread1 -device
virtio-blk-pci,iothread=3Diothread1,... to define IOThreads for each
virtio-blk-pci device?

The block/nfs.c code already supports IOThread so you can run multiple
threads and don't need to use 100% CPU in the main loop.

Stefan

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5hsNAAoJEJykq7OBq3PI5RkH/1uvI33ztiNZ1teiiZjROU6f
MWe1aV8FFofTey6d4ddOivWN3FthJL9/uybXOiwYgBFJU8lD/AJe4P/pFhEeUAre
PTK0I1oW+bBPoErMmHZ0cQPe8jkQJ5YpZlN9UaCQMglXWbw8Yj1yLpWoDzhZ4BUe
wkUKDuFuxZe/+7oPmtPeZP2UGoFLo02PxsZSc8Hvnay3WojKB7yn2s4uU+PGPTTj
Y/Iu0LA8DX3zWC4JySL+wyoCayUnLn85++ae1GZ88ByUNbaqq7wH/vkDtxklXG30
k2q4AY2S+Ipbbl3BJniMsqD1KJdlemy2VJE1/tn5ET9lu6ZKTp4Bs5QSEvy8s1w=
=BsAW
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
