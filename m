Received: from eggs.gnu.org ([2001:4830:134:3::10]:55936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fShPF-00079A-3C
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fShPE-0004Zf-7d
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:24:09 -0400
Date: Tue, 12 Jun 2018 13:23:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180612112359.GB4355@localhost.localdomain>
References: <20180611213927.141894-1-eblake@redhat.com>
	<20180611213927.141894-3-eblake@redhat.com>
	<ff47b198-c6a7-a2f5-86d0-93e3b431806e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff47b198-c6a7-a2f5-86d0-93e3b431806e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Add test 221 to catch
 qemu-img map regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 12.06.2018 um 00:03 hat Eric Blake geschrieben:
> On 06/11/2018 04:39 PM, Eric Blake wrote:
> > Although qemu-img creates aligned files (by rounding up), it
> > must also gracefully handle files that are not sector-aligned.
> > Test that the bug fixed in the previous patch does not recur.
> > 
> > It's a bit annoying that we can see the (implicit) hole past
> > the end of the file on to the next sector boundary, so if we
> > ever reach the point where we report a byte-accurate size rather
> > than our current behavior of always rounding up, this test will
> > probably need a slight modification.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> 
> > +
> > +$QEMU_IO -c 'w 43008 1' "$TEST_IMG" # writing also rounds up
> 
> Shoot - missing a filter...
> 
> > +++ b/tests/qemu-iotests/221.out
> > @@ -0,0 +1,16 @@
> > +QA output created by 221
> > +
> > +=== Check mapping of unaligned raw image ===
> > +
> > +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=43009
> > +[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> > +[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> > +wrote 1/1 bytes at offset 43008
> > +1 bytes, 1 ops; 0.0001 sec (7.512 KiB/sec and 7692.3077 ops/sec)
> 
> ...which leaks volatile output.  Squash this in:

Thanks, applied to the block branch. (After fixing the patch corruption
caused by your mailer helpfully adding line breaks.)

Kevin
