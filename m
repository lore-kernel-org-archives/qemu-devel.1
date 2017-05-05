Received: from eggs.gnu.org ([2001:4830:134:3::10]:45567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6dlk-00011h-Kj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6dlf-00043M-RV
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:59:40 -0400
Date: Fri, 5 May 2017 14:59:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505135931.GH11350@stefanha-x1.localdomain>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Refactor DMG driver to have chunk
 size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2017 at 01:36:30PM +0530, Ashijeet Acharya wrote:
> This series helps to provide chunk size independence for DMG driver to prevent
> denial-of-service in cases where untrusted files are being accessed by the user.

The core of the chunk size dependence problem are these lines:

    s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
                                              ds.max_compressed_size + 1);
    s->uncompressed_chunk = qemu_try_blockalign(bs->file->bs,
                                                512 * ds.max_sectors_per_chunk);

The refactoring needs to eliminate these buffers because their size is
controlled by the untrusted input file.

After applying your patches these lines remain unchanged and we still
cannot use input files that have a 250 MB chunk size, for example.  So
I'm not sure how this series is supposed to work.

Here is the approach I would take:

In order to achieve this dmg_read_chunk() needs to be scrapped.  It is
designed to read a full chunk.  The new model does not read full chunks
anymore.

Uncompressed reads or zeroes should operate directly on qiov, not
s->uncompressed_chunk.  This code will be dropped:

    data = s->uncompressed_chunk + sector_offset_in_chunk * 512;
    qemu_iovec_from_buf(qiov, i * 512, data, 512);

Compressed reads still buffers.  I suggest the following buffers:

1. compressed_buf - compressed data is read into this buffer from file
2. uncompressed_buf - a place to discard decompressed data while
                      simulating a seek operation

Data is read from compressed chunks by reading a reasonable amount
(64k?) into compressed_buf.  If the user wishes to read at an offset
into this chunk then a loop decompresses data we are seeking over into
uncompressed_buf (and refills compressed_buf if it becomes empty) until
the desired offset is reached.  Then decompression can continue
directly into the user's qiov and uncompressed_buf isn't used to
decompress the data requested by the user.

Sequential compressed reads can be optimized by keeping the compression
state across read calls.  That means the zlib/bz2 state plus
compressed_buf and the current offset.  That way we don't need to
re-seek into the current compressed chunk to handle sequential reads.

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDIVDAAoJEJykq7OBq3PIK8YIAJ0Tv4cCpwtKJxfCLX2rsDgh
fMU/vvGmHBm3t7nkEcl0C+PBm057OLiyhsjgFfjcvGc+O85vem90FZ/tmHhbQURf
P05voWBjQGzpQ+gmnwMguI8o19s72QkYBygnzZo/uroJyIN5zOrbvNudjb2r/9ps
tJPidlwTr00/+S7/pU33gHaIiVjwvBshyRYT3GW2czPmm7W/8KNJ+gco8Sx6zaz9
zOEvYM3yGvXS8rClvwskP06Qu8B43t7S9K23h/tHQ4sYkwIiinUQp4NgPbFjTzin
TZPyj6F31k2WHrNOBiNbzk9LnOkcA5mOUJoQ8aIAzckg0P/tt9Jhe+fw9ZO7F9k=
=FMwi
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--
