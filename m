Received: from eggs.gnu.org ([2001:4830:134:3::10]:54687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drLcp-0005BC-Vl
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drLcm-00083C-0N
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drLcl-00082w-QT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:07:27 -0400
Date: Mon, 11 Sep 2017 12:07:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911120722.17236996.cohuck@redhat.com>
In-Reply-To: <20170908152446.14606-5-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/css: fix incorrect length
 indication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri,  8 Sep 2017 17:24:46 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> We report incorrect length via SCSW program check instead of incorrect
> length check (SCWS word 2 bit 10 instead of bit 9). Since we have there
> is no fitting errno for incorrect length, and since I don't like what we
> do with the errno's, as part of the fix, errnos used for control flow in
> ccw interpretation are replaced with an enum using more speaking names.

I'm not sure whether this is the way to go. I mainly dislike the size
of the patch (and the fact that it mixes a fix and a change of function
signature).

Can we instead choose a mapping for incorrect length, and defer a
possible rework?

(Another idea would be to have the callback prepare the scsw via helper
functions. We'd just keep -EAGAIN to keep processing a chain and 0 to
stop.)

> 
> For virtio, if incorrect length checking is suppressed we keep the
> current behavior (channel-program check).

Confused. If it is suppressed, there should not be an error, no?

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/3270-ccw.c    |  24 +++++-----
>  hw/s390x/css.c         |  67 +++++++++++++++-----------
>  hw/s390x/virtio-ccw.c  | 128 ++++++++++++++++++++++++-------------------------
>  include/hw/s390x/css.h |  13 ++++-
>  4 files changed, 127 insertions(+), 105 deletions(-)
