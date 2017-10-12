Received: from eggs.gnu.org ([2001:4830:134:3::10]:55589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2cL5-0008Pv-Av
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2cL1-0006Qd-Vc
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2cL1-0006QQ-M5
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:11:43 -0400
Date: Thu, 12 Oct 2017 14:11:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171012141137.07fb0391.cohuck@redhat.com>
In-Reply-To: <3e560962-d748-ccfa-ccab-c54f1a30bab4@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
	<20171010150733.444aa2fe.cohuck@redhat.com>
	<aed45050-fd0e-4a81-679c-c59c23d75a98@linux.vnet.ibm.com>
	<3e560962-d748-ccfa-ccab-c54f1a30bab4@linux.vnet.ibm.com>
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Thu, 12 Oct 2017 14:06:42 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 10/10/2017 04:36 PM, Halil Pasic wrote:
> > 
> > 
> > On 10/10/2017 03:07 PM, Cornelia Huck wrote:  
> >> On Wed,  4 Oct 2017 17:41:39 +0200
> >> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >>  
> >>> Simplify the error handling of the SSCH and RSCH handler avoiding
> >>> arbitrary and cryptic error codes being used to tell how the instruction
> >>> is supposed to end.  Let the code detecting the condition tell how it's
> >>> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
> >>> in one go as the emulation of the two shares a lot of code.
> >>>
> >>> For passthrough this change isn't pure refactoring, but changes the
> >>> way kernel reported EFAULT is handled. After clarifying the kernel
> >>> interface we decided that EFAULT shall be mapped to unit exception.
> >>> Same goes for unexpected error codes.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>> ---
> >>>
> >>> AFAIR we decided in the previous round to rather do transformation
> >>> and fixing in one patch than touch stuff twice. Hence this patch
> >>> ain't pure transformation any more.
> >>> ---
> >>>  hw/s390x/css.c              | 83 +++++++++++++--------------------------------
> >>>  hw/s390x/s390-ccw.c         | 11 +++---
> >>>  hw/vfio/ccw.c               | 30 ++++++++++++----
> >>>  include/hw/s390x/css.h      | 24 +++++++++----
> >>>  include/hw/s390x/s390-ccw.h |  2 +-
> >>>  target/s390x/ioinst.c       | 53 ++++-------------------------
> >>>  6 files changed, 77 insertions(+), 126 deletions(-)  
> >>
> >> After browsing through this patch, I think the change will work just as
> >> well if you use e.g. #defines instead of the structure, won't it?
> >>  
> > 
> > Sure. We just loose type safety. For example if someone ever should try to
> > propagate a normal errno via return do_something() the compiler won't
> > catch it we effectively use int for both.
> > 
> >  
> 
> @Connie: Discussion seems to have died down quite a bit, and besides
> of the struct vs enum vs int and the point of Dong Jia I've seen no
> complaints.
> 
> I would like to do a re-spin to accommodate the complaints, but before
> I abandon the IOInstEnding struct I would like to confirm, that this
> patch, and it's behavioral changes are OK. I would hate to do the dance
> backwards, because in the next iteration it turns out that we want to
> keep the "program_interrupt(env, PGM_ADDRESSING, 4);". Could you please
> pass your judgment on this patch (assuming I fix the issues found by
> Dong Jia)?

I don't think I really have complaints. Currently quite busy with other
things, though.
