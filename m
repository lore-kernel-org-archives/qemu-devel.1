Received: from eggs.gnu.org ([2001:4830:134:3::10]:54150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d2y1G-0001j0-SA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d2y1D-0002QU-Lp
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:48:28 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:34006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1d2y1D-0002QB-Fs
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:48:27 -0400
Received: by mail-oi0-x22f.google.com with SMTP id x184so167357734oia.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 03:48:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Tue, 25 Apr 2017 16:18:26 +0530
Message-ID: <CAC2QTZaJZ8umA8XfgC75RgtY4K_7R6_T-M0YTUt2TrfHaQX=ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Wu <peter@lekensteyn.nl>

Hi,

cc'ing Peter Wu in...

Currently I have completed the task for zlib, uncompressed and zeroed
chunks in a DMG file using the approach we discussed earlier.
Unfortunately, this approach is not appropriate for bz2 chunks since
we cannot restart our decompression from the access point we cached
since bz2 decompression checks for a special magic key 'BZh' before it
starts decompressing. Since our cached point can be pointing to any
random location inside the compressed stream and not necessarily the
start of a "block", dmg_uncompress_bz2_do() fails with an error value
BZ_DATA_ERROR_MAGIC (-5) and thus our approach fails.
This blog post here explains this limitation too ->
https://blastedbio.blogspot.in/2011/11/random-access-to-bzip2.html

Now, there is an interesting thing I found out about bz2 compressed
streams i.e. the size of a compressed block varies from 0 to a max of
900 KiB. This is guaranteed and can be verified because each block has
a 4 byte header attached to it at the beginning in which the first
three bytes are the magic key "BZh" followed by a number from 1-9.
These help us find the max size that block will have as the size
increments by 100KiB for each value (eg. BZh3 has a max of 300KiB).

Now the wikipedia page here
(https://en.wikipedia.org/wiki/Bzip2#File_format) states that a 900KiB
block can expand to a max of 46MiB in its uncompressed form. Thus we
need not worry about QEMU allocating wild sized memory at once as we
have a limit of 64MiB as of now and stick to the approach of
decompressing the whole block every time we enter it. This solves our
problem of caching an access point and ultimately failing with this
error value BZ_DATA_ERROR_MAGIC (-5).

I am hesitant in this approach because I am not sure yet that "blocks"
and "chunks" mean the same thing and are just two different
terminologies (i.e. chunks == blocks) OR chunks are made up of blocks
(i.e chunks = x * blocks).

I approached Peter Wu (who worked on DMG a few years ago) about this
and he's not sure either.

(Peter, you may skip this part as I already explained you this earlier :-) )
I did a little naive test of my own, where I downloaded one of the bz2
DMG images and tried reading it with a HEX editor.

First, I manually calculated the size between the appearance of two
sequential magic keys ('BZh') offsets which marked the length of a
block starting at the offset of first magic key. Next I compared it to
the size of the corresponding chunk whose size (s->lenghts[chunk]) we
get by reading the mish blocks and all that stuff while opening the
image in QEMU, and interestingly both the sizes appeared to be equal.
I repeated it for quite a few chunks and this test stayed valid for
all.

Peter thinks we cannot rely on this test thus I wouldn't mind more
views on it...

Ashijeet
