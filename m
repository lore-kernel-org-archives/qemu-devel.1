Received: from eggs.gnu.org ([2001:4830:134:3::10]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1csWBN-00052T-SF
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1csWBK-0002dM-Kj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:03:45 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlipchuk@redhat.com>) id 1csWBK-0002aW-Ek
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:03:42 -0400
Received: by mail-it0-f49.google.com with SMTP id y18so77028484itc.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 08:03:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323180149.GI12560@stefanha-x1.localdomain>
References: <20170322111608.31230-1-stefanha@redhat.com>
	<CAMRbyysE0+GPze8mFZyaWqTywGMW67t+JKV1xX_CvX_dcu5q7A@mail.gmail.com>
	<20170323180149.GI12560@stefanha-x1.localdomain>
From: Maor Lipchuk <mlipchuk@redhat.com>
Date: Mon, 27 Mar 2017 18:02:57 +0300
Message-ID: <CAJ1JNOedOEzMthD_Rgqu7eK0YvCmEPfVjUjOScb0BoSzZwBQzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/8] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

On Thu, Mar 23, 2017 at 8:01 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Mar 22, 2017 at 07:29:07PM +0000, Nir Soffer wrote:
>> On Wed, Mar 22, 2017 at 2:28 PM Stefan Hajnoczi <stefanha@redhat.com>
wrote:
>>
>> > v3:
>> >  * Drop RFC, this is ready to go for QEMU 2.10
>> >  * Use "required size" instead of "required bytes" in qemu-img output
for
>> >    consistency [Nir]
>> >  * Clarify BlockMeasureInfo semantics [Max]
>> >  * Clarify bdrv_measure() opts argument and error handling [Nir]
>> >  * Handle -o backing_file= for qcow2 [Max]
>> >  * Handle snapshot options in qemu-img measure
>> >  * Probe input image for allocated data clusters for qcow2.  Didn't
>> > centralize
>> >    this because there are format-specific aspects such as the
>> > cluster_size.  It
>> >    may make sense to centralize it later (with a bit more complexity)
if
>> >    support is added to more formats.
>> >  * Add qemu-img(1) man page section for 'measure' sub-command [Max]
>> >  * Extend test case to cover additional scenarios [Nir]
>> >
>> > RFCv2:
>> >  * Publishing RFC again to discuss the new user-visible interfaces.
Code
>> > has
>> >    changed quite a bit, I have not kept any Reviewed-by tags.
>> >  * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
>> >  * Report both "required bytes" and "fully allocated bytes" to handle
the
>> > empty
>> >    image file and prealloc use cases [Nir and Dan]
>> >  * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
>> >  * Rename "err" label "out" in qemu-img-cmds.c [Nir]
>> >  * Add basic qcow2 support, doesn't support qemu-img convert from
existing
>> > files yet
>> >
>> > RFCv1:
>> >  * Publishing patch series with just raw support, no qcow2 yet.  Please
>> > review
>> >    the command-line interface and let me know if you are happy with
this
>> >    approach.
>> >
>> > Users and management tools sometimes need to know the size required
for a
>> > new
>> > disk image so that an LVM volume, SAN LUN, etc can be allocated ahead
of
>> > time.
>> > Image formats like qcow2 have non-trivial metadata that makes it hard
to
>> > estimate the exact size without knowledge of file format internals.
>> >
>> > This patch series introduces a new qemu-img sub-command that
calculates the
>> > required size for both image creation and conversion scenarios.
>> >
>> > The conversion scenario is:
>> >
>> >   $ qemu-img measure -f raw -O qcow2 input.img
>> >   required size: 1327680
>> >   fully allocated size: 1074069504
>> >
>> > Here an existing image file is taken and the output includes the space
>> > required
>> > for data from the input image file.
>> >
>> > The creation scenario is:
>> >
>> >   $ qemu-img measure -O qcow2 --size 5G
>> >   required size: 327680
>> >   fully allocated size: 1074069504
>> >
>> > Stefan Hajnoczi (8):
>> >   block: add bdrv_measure() API
>> >   raw-format: add bdrv_measure() support
>> >   qcow2: extract preallocation calculation function
>> >   qcow2: extract image creation option parsing
>> >   qcow2: add bdrv_measure() support
>> >   qemu-img: add measure subcommand
>> >   qemu-iotests: support per-format golden output files
>> >   iotests: add test 178 for qemu-img measure
>> >
>> >  qapi/block-core.json             |  25 +++
>> >  include/block/block.h            |   4 +
>> >  include/block/block_int.h        |   2 +
>> >  block.c                          |  35 ++++
>> >  block/qcow2.c                    | 362
>> > +++++++++++++++++++++++++++++----------
>> >  block/raw-format.c               |  22 +++
>> >  qemu-img.c                       | 227 ++++++++++++++++++++++++
>> >  qemu-img-cmds.hx                 |   6 +
>> >  qemu-img.texi                    |  25 +++
>> >  tests/qemu-iotests/178           | 144 ++++++++++++++++
>> >  tests/qemu-iotests/178.out.qcow2 | 242 ++++++++++++++++++++++++++
>> >  tests/qemu-iotests/178.out.raw   | 130 ++++++++++++++
>> >  tests/qemu-iotests/check         |   5 +
>> >  tests/qemu-iotests/group         |   1 +
>> >  14 files changed, 1136 insertions(+), 94 deletions(-)
>> >  create mode 100755 tests/qemu-iotests/178
>> >  create mode 100644 tests/qemu-iotests/178.out.qcow2
>> >  create mode 100644 tests/qemu-iotests/178.out.raw
>> >
>> > --
>> > 2.9.3
>> >
>>
>> Stefan, is this available in some public git repo?
>>
>> I would like to test it,  and downloading and applying 8 patches is lot
of
>> work.
>> (I'm probably not using the right tools for this).
>
> I've pushed the branch here:
> https://github.com/stefanha/qemu/tree/qemu-img-query-max-size
>
> In mutt you can tag multiple emails ('t') and then pipe them to git am
> in one go (';|git am').  Many other email clients offer no support for
> processing patches by default.
>
> Stefan

Hi Stefan,

Thank you for the branch, it was much helpful to verify and test the code
that way :)

I ran a test and created several files using python.
Some of the files that were converted to qcow2 seems to have larger size
than the measure size.

In the following example the converted file had an extra 65536 bits than
the measured size (*):

Creating test_qcow2 using python:
"""
import os
import io
MB = 1024 ** 2
filename = os.path.join("/home_folder", 'test_qcow2')
with io.open(filename, "wb") as f:
     f.truncate(1024 * MB)
     f.write("x" * MB)
     f.seek(512 * MB)
     f.write("x" * MB)
"""

Convert the file using qemu-img convert:
$ qemu-img convert -f raw -O qcow2 ~/test_qcow2 ~/test_qcow2_convert.qcow2


Validate the size:

Checking the size of the created file:
$ stat --printf="%s\n" ~/test_qcow2
1073741824

qemu-img measure returns required size of 2424832:
$ ./qemu-img measure -O qcow2 -f raw ~/test_qcow2
required size: 2424832
fully allocated size: 1074069504

The converted file has size of 2490368:
$ stat --printf="%s\n" ~/test_qcow2_convert.qcow
2490368


Looking at the following code:

file: block/qcow2.c
method: qcow2_calc_prealloc_size
lines: 2163 - 2166
    /* total size of refcount tables */
        nreftablee = nrefblocke / refblock_size;
        nreftablee = align_offset(nreftablee, cluster_size /
sizeof(uint64_t));
        meta_size += nreftablee * sizeof(uint64_t

it could be that when the result of nrefblocke / refblock_size is less than
1 the align_offset being done at line 2165 convert the float into int and
therefore it is 0, I assume that there should always be at lease one
cluster for nreftablee.
so maybe that might be the missing cluster?
I've tried to test this with the proposed fix and it seems to do the trick.

Please let me know what you think, if that is indeed the case maybe we will
be glad to send a patch.

Thanks,
Maor

(*) The files can be found here:
https://www.dropbox.com/sh/nid7wtgt6qxdrcz/AABbjoJL4Jj0bzwOui2SD56ta?dl=0
