Received: from eggs.gnu.org ([2001:4830:134:3::10]:49414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxUDg-00021O-Ch
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxUDf-0006CV-60
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:30:56 -0400
Date: Thu, 28 Sep 2017 09:30:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170928083041.GD12919@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927125340.12360-1-berrange@redhat.com>
	<8afc1fd5-5fdd-05d9-cc79-e05f52057c21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8afc1fd5-5fdd-05d9-cc79-e05f52057c21@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Misc improvements to crypto block
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Sep 27, 2017 at 11:06:24PM +0200, Max Reitz wrote:
> On 2017-09-27 14:53, Daniel P. Berrange wrote:
> > This is a followup to
> > 
> >   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00781.html
> >   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06464.html
> >   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02923.html
> > 
> > This collection of patches first improves the performance of the
> > crypto block driver and then does various cleanups to improve ongoing
> > maint work.
> > 
> > Changed in v4:
> > 
> >   - Drop intermediate patch that replaced '512' with a constant (Max)
> >   - Use MIN() macro where needed (Max)
> >   - Fix bounce buffer size at 1MB instead of varying per sector size (Max)
> >   - Convert missing qcrypto_block_encrypt call to sectors in qcow.c (Max)
> > 
> > Changed in v3:
> > 
> >   - Support passthrough of BDRV_REQ_FUA (Eric)
> >   - Fix potential truncation of payload offset values (Eric)
> >   - Use encryption scheme sector size instead of BDRV_SECTOR_SIZE (Kevin)
> >   - Use QEMU_IS_ALIGNED where appropriate (Eric)
> >   - Remove unused 'sector_num' variable (Eric)
> >   - Fix whitespace alignment (Eric)
> >   - Fix math error in qcow conversion (Eric)
> > 
> > Daniel P. Berrange (6):
> >   block: use 1 MB bounce buffers for crypto instead of 16KB
> >   crypto: expose encryption sector size in APIs
> >   block: fix data type casting for crypto payload offset
> >   block: convert crypto driver to bdrv_co_preadv|pwritev
> >   block: convert qcrypto_block_encrypt|decrypt to take bytes offset
> >   block: support passthrough of BDRV_REQ_FUA in crypto driver
> > 
> >  block/crypto.c         | 130 ++++++++++++++++++++++++++-----------------------
> >  block/qcow.c           |  11 +++--
> >  block/qcow2-cluster.c  |   8 ++-
> >  block/qcow2.c          |   4 +-
> >  crypto/block-luks.c    |  18 ++++---
> >  crypto/block-qcow.c    |  13 +++--
> >  crypto/block.c         |  26 +++++++---
> >  crypto/blockpriv.h     |   5 +-
> >  include/crypto/block.h |  29 ++++++++---
> >  9 files changed, 148 insertions(+), 96 deletions(-)
> 
> Thanks; hoping that is OK with you, I've applied this series to my block
> branch:
> 
> https://github.com/XanClic/qemu/commits/block

Yes, that is fine - preferrable to merge via an main block tree since
it touches qcow2.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
