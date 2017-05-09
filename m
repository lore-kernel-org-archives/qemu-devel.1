Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85ly-0002ej-RW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85lt-0007gW-Pl
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:05:54 -0400
Date: Tue, 9 May 2017 15:05:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170509140538.GJ1669@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-14-berrange@redhat.com>
	<b3f9f0dd-8925-4528-807e-3cf97a199298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3f9f0dd-8925-4528-807e-3cf97a199298@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 13/18] qcow2: add support for LUKS
 encryption format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Wed, Apr 26, 2017 at 12:46:18PM -0500, Eric Blake wrote:
> On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> > This adds support for using LUKS as an encryption format
> > with the qcow2 file, using the new encrypt.format parameter
> > to request "luks" format. e.g.
> > 
> >   # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encrypt.-format=luks,encrypt.key-secret=sec0 \
> 
> s/encrypt.-format/encrypt.format/
> 
> >        test.qcow2 10G
> > 
> 
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
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> 
> > @@ -165,6 +246,47 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
> >              }
> >              break;
> >  
> > +        case QCOW2_EXT_MAGIC_CRYPTO_HEADER: {
> > +            unsigned int cflags = 0;
> > +            if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
> > +                error_setg(errp, "CRYPTO header extension only "
> > +                           "expected with LUKS encryption method");
> > +                return -EINVAL;
> > +            }
> > +            if (ext.len != sizeof(Qcow2CryptoHeaderExtension)) {
> > +                error_setg(errp, "CRYPTO header extension size %u, "
> > +                           "but expected size %zu", ext.len,
> > +                           sizeof(Qcow2CryptoHeaderExtension));
> > +                return -EINVAL;
> > +            }
> > +
> > +            ret = bdrv_pread(bs->file, offset, &s->crypto_header, ext.len);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret,
> > +                                 "Unable to read CRYPTO header extension");
> > +                return ret;
> > +            }
> > +            be64_to_cpus(&s->crypto_header.offset);
> > +            be64_to_cpus(&s->crypto_header.length);
> > +
> > +            if ((s->crypto_header.offset % s->cluster_size) != 0) {
> > +                error_setg(errp, "Encryption header offset '%" PRIu64 "' is "
> > +                           "not a multiple of cluster size '%u'",
> > +                           s->crypto_header.offset, s->cluster_size);
> > +                return -EINVAL;
> > +            }
> 
> Do we need to sanity check that crypto_header.length is not bogus?

The only sanity check I can see would be to put an arbitrary size limit
on the length ? I'm a little loathe to do that since LUKSv2 is going to
make the header extensible, and/or future LUKSv1 changes might adjust
padding, both making the header longer than it would be today. I would
like qemu-img to be able to open such future files, even if it then
refuses support for the features.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
