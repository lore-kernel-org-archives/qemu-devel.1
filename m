Received: from eggs.gnu.org ([2001:4830:134:3::10]:37996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIIbn-0000zx-Ed
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIIbh-0002nG-TA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:49:35 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIIbh-0002n4-Lx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:49:29 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v111so50857414wrc.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 10:49:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606025135.2685-2-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
	<20170606025135.2685-2-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 18:49:08 +0100
Message-ID: <CAFEAcA9arhJuzCs=ec4dW+_cgSodi0NWTnBB+-4mwAjSGMaLDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 01/17] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>

On 6 June 2017 at 03:51, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: Laurent Vivier <lvivier@redhat.com>
>
> We can replace the four remaining calls of register_savevm() by
> calls to register_savevm_live(). So we can remove the function and
> as we don't allocate anymore the ops pointer with g_new0()
> we don't have to free it then.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/net/vmxnet3.c            |  8 ++++++--
>  hw/s390x/s390-skeys.c       |  9 +++++++--
>  hw/s390x/s390-virtio-ccw.c  |  8 ++++++--
>  include/migration/vmstate.h |  8 --------
>  migration/savevm.c          | 16 ----------------
>  slirp/slirp.c               |  8 ++++++--
>  6 files changed, 25 insertions(+), 32 deletions(-)

Great to see register_savevm() finally disappearing.

Any chance of an update to docs/migration.txt, which still
mentions register_savevm(), but on the other hand doesn't
say anything about register_savevm_live() and unregister_savevm().
(Doc comments in the .h file for those functions would be
nice too...)

Things that would be interesting to explain/document:
 * what is special about vmxnet3 that makes it the only pci device
   that needs to use this rather than having a vmstate struct?
 * why does s390-skeys call the register function with a NULL
   pointer but the unregister pointer with a device pointer?

(Could we replace the uses of these which pass a dev pointer
with vmstate structs and then drop the dev parameter?)

thanks
-- PMM
