Received: from eggs.gnu.org ([2001:4830:134:3::10]:53169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOLUC-0005P8-5i
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOLUB-0006yI-0I
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:06:44 -0400
Date: Fri, 23 Jun 2017 11:06:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170623100629.GD28635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170619173455.18805-1-berrange@redhat.com>
	<20170619173455.18805-14-berrange@redhat.com>
	<79345f33-2cf6-bec1-c96d-981fc7e3fedd@redhat.com>
	<c481d014-f9f0-74c8-4011-1b81ace887be@redhat.com>
	<48afe1ce-e500-e7a7-18de-2ed67d808df3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48afe1ce-e500-e7a7-18de-2ed67d808df3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 13/20] qcow2: add support for LUKS
 encryption format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Wed, Jun 21, 2017 at 04:59:02PM +0200, Max Reitz wrote:
> On 2017-06-21 16:46, Max Reitz wrote:
> > On 2017-06-21 16:42, Max Reitz wrote:
> >> On 2017-06-19 19:34, Daniel P. Berrange wrote:
> >>> This adds support for using LUKS as an encryption format
> >>> with the qcow2 file, using the new encrypt.format parameter
> >>> to request "luks" format. e.g.
> >>>
> >>>   # qemu-img create --object secret,data=123456,id=sec0 \
> >>>        -f qcow2 -o encrypt.format=luks,encrypt.key-secret=sec0 \
> >>>        test.qcow2 10G
> >>>
> >>> The legacy "encryption=on" parameter still results in
> >>> creation of the old qcow2 AES format (and is equivalent
> >>> to the new 'encryption-format=aes'). e.g. the following are
> >>> equivalent:
> >>>
> >>>   # qemu-img create --object secret,data=123456,id=sec0 \
> >>>        -f qcow2 -o encryption=on,encrypt.key-secret=sec0 \
> >>>        test.qcow2 10G
> >>>
> >>>  # qemu-img create --object secret,data=123456,id=sec0 \
> >>>        -f qcow2 -o encryption-format=aes,encrypt.key-secret=sec0 \
> >>>        test.qcow2 10G
> >>>
> >>> With the LUKS format it is necessary to store the LUKS
> >>> partition header and key material in the QCow2 file. This
> >>> data can be many MB in size, so cannot go into the QCow2
> >>> header region directly. Thus the spec defines a FDE
> >>> (Full Disk Encryption) header extension that specifies
> >>> the offset of a set of clusters to hold the FDE headers,
> >>> as well as the length of that region. The LUKS header is
> >>> thus stored in these extra allocated clusters before the
> >>> main image payload.
> >>>
> >>> Aside from all the cryptographic differences implied by
> >>> use of the LUKS format, there is one further key difference
> >>> between the use of legacy AES and LUKS encryption in qcow2.
> >>> For LUKS, the initialiazation vectors are generated using
> >>> the host physical sector as the input, rather than the
> >>> guest virtual sector. This guarantees unique initialization
> >>> vectors for all sectors when qcow2 internal snapshots are
> >>> used, thus giving stronger protection against watermarking
> >>> attacks.
> >>>
> >>> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>> Reviewed-by: Alberto Garcia <berto@igalia.com>
> >>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >>> ---
> >>>  block/qcow2-cluster.c      |   4 +-
> >>>  block/qcow2-refcount.c     |  10 ++
> >>>  block/qcow2.c              | 268 ++++++++++++++++++++++++++++++++++++++------
> >>>  block/qcow2.h              |   9 ++
> >>>  qapi/block-core.json       |   5 +-
> >>>  tests/qemu-iotests/082.out | 270 ++++++++++++++++++++++++++++++++++++---------
> >>>  6 files changed, 478 insertions(+), 88 deletions(-)
> >>
> >> Reviewed-by: Max Reitz <mreitz@redhat.com>
> > 
> > (But due to the split of do_perform_cow(), this will need the same
> > changes that patch 10 and 11 will need (in this case only contextual, in
> > the cases of 10 and 11 there are also functional changes required).)
> 
> (Turns out it will need a functional change, too, because
> do_perform_cow_encrypt() doesn't take the host offset yet.)

Yep, I've just rebased to kevin/block and resolved these problems


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
