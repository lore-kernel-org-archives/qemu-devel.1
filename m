Received: from eggs.gnu.org ([2001:4830:134:3::10]:33718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxEb-0003v6-7O
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxEX-0004Qb-Vz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:00:53 -0400
Date: Mon, 19 Jun 2017 15:00:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170619140034.GG2640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-14-berrange@redhat.com>
	<a2a698c4-9169-100c-e2a7-eeb324d70818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2a698c4-9169-100c-e2a7-eeb324d70818@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 13/20] qcow2: add support for LUKS
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

On Wed, Jun 07, 2017 at 07:19:28PM +0200, Max Reitz wrote:
> On 2017-06-01 19:27, Daniel P. Berrange wrote:
> > This adds support for using LUKS as an encryption format
> > with the qcow2 file, using the new encrypt.format parameter
> > to request "luks" format. e.g.
> > 
> >   # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encrypt.format=luks,encrypt.key-secret=sec0 \
> >        test.qcow2 10G
> > 
> > The legacy "encryption=on" parameter still results in
> > creation of the old qcow2 AES format (and is equivalent
> > to the new 'encryption-format=aes'). e.g. the following are
> > equivalent:
> > 
> >   # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encryption=on,encrypt.key-secret=sec0 \
> >        test.qcow2 10G
> > 
> >  # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encryption-format=aes,encrypt.key-secret=sec0 \
> >        test.qcow2 10G
> > 
> > With the LUKS format it is necessary to store the LUKS
> > partition header and key material in the QCow2 file. This
> > data can be many MB in size, so cannot go into the QCow2
> > header region directly. Thus the spec defines a FDE
> > (Full Disk Encryption) header extension that specifies
> > the offset of a set of clusters to hold the FDE headers,
> > as well as the length of that region. The LUKS header is
> > thus stored in these extra allocated clusters before the
> > main image payload.
> > 
> > Aside from all the cryptographic differences implied by
> > use of the LUKS format, there is one further key difference
> > between the use of legacy AES and LUKS encryption in qcow2.
> > For LUKS, the initialiazation vectors are generated using
> > the host physical sector as the input, rather than the
> > guest virtual sector. This guarantees unique initialization
> > vectors for all sectors when qcow2 internal snapshots are
> > used, thus giving stronger protection against watermarking
> > attacks.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow2-cluster.c      |   4 +-
> >  block/qcow2-refcount.c     |  10 ++
> >  block/qcow2.c              | 267 ++++++++++++++++++++++++++++++++++++++------
> >  block/qcow2.h              |   9 ++
> >  qapi/block-core.json       |   5 +-
> >  tests/qemu-iotests/082.out | 270 ++++++++++++++++++++++++++++++++++++---------
> >  6 files changed, 477 insertions(+), 88 deletions(-)
> 
> [...]
> 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 38c0420..30d0343 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> 
> [...]
> 
> > @@ -2072,22 +2253,30 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
> >      qdict_extract_subqdict(options, &encryptopts, "encrypt.");
> >      QDECREF(options);
> >  
> > -    if (!g_str_equal(encryptfmt, "aes")) {
> > -        error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
> > -                   encryptfmt);
> > -        ret = -EINVAL;
> > -        goto out;
> > +    int fmt = qcow2_crypt_method_from_format(encryptfmt);
> 
> Because I love nit picking: Variable declarations should be at the start
> of the surrounding block.

Opps, dunno what I was thinking there.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
