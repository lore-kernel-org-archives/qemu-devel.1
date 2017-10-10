Received: from eggs.gnu.org ([2001:4830:134:3::10]:52360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uG8-00072p-DI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uG2-0004TK-H4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:07:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1uG2-0004T0-B9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:07:38 -0400
Date: Tue, 10 Oct 2017 15:07:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171010150733.444aa2fe.cohuck@redhat.com>
In-Reply-To: <20171004154144.88995-4-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed,  4 Oct 2017 17:41:39 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Simplify the error handling of the SSCH and RSCH handler avoiding
> arbitrary and cryptic error codes being used to tell how the instruction
> is supposed to end.  Let the code detecting the condition tell how it's
> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
> in one go as the emulation of the two shares a lot of code.
> 
> For passthrough this change isn't pure refactoring, but changes the
> way kernel reported EFAULT is handled. After clarifying the kernel
> interface we decided that EFAULT shall be mapped to unit exception.
> Same goes for unexpected error codes.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> AFAIR we decided in the previous round to rather do transformation
> and fixing in one patch than touch stuff twice. Hence this patch
> ain't pure transformation any more.
> ---
>  hw/s390x/css.c              | 83 +++++++++++++--------------------------------
>  hw/s390x/s390-ccw.c         | 11 +++---
>  hw/vfio/ccw.c               | 30 ++++++++++++----
>  include/hw/s390x/css.h      | 24 +++++++++----
>  include/hw/s390x/s390-ccw.h |  2 +-
>  target/s390x/ioinst.c       | 53 ++++-------------------------
>  6 files changed, 77 insertions(+), 126 deletions(-)

After browsing through this patch, I think the change will work just as
well if you use e.g. #defines instead of the structure, won't it?
