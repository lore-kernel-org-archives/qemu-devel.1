Received: from eggs.gnu.org ([2001:4830:134:3::10]:41847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQ8zE-0007h4-Rz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQ8zB-0002iW-Kw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:14:44 -0400
Date: Tue, 5 Jun 2018 12:14:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180605121437.4c360af3.cohuck@redhat.com>
In-Reply-To: <20180524175828.3143-2-pasic@linux.ibm.com>
References: <20180524175828.3143-1-pasic@linux.ibm.com>
	<20180524175828.3143-2-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited
 prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 24 May 2018 19:58:27 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> There is at least one guest (OS) such that although it does not rely on
> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
> P bit) not being set, it fails to tell this to the machine.
> 
> Usually this ain't a big deal, as the original purpose of the P bit is to
> allow for performance optimizations. vfio-ccw however can not provide the
> guarantees required if the bit is not set.
> 
> It is not possible to implement support for the P bit not set without
> transitioning to lower level protocols for vfio-ccw.  So let's give the
> user the opportunity to force setting the P bit, if the user knows this
> is safe.  For self modifying channel programs forcing the P bit is not
> safe.  If the P bit is forced for a self modifying channel program things
> are expected to break in strange ways.
> 
> Let's also avoid warning multiple about P bit not set in the ORB in case
> P bit is not told to be forced, and designate the affected vfio-ccw
> device.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
> 
> @Jason:
> I have kept the tags this time without consulting you because
> all that changed is the logging. Scream if that's not OK with you.
> 
> v2->v3:
> * tweak commit message (Connie)
> * designate subsystem (vfio-ccw) and devno in the log messages (Connie)
> * turn WARN_ONCE macro into inline function
> 
> ---
>  hw/s390x/css.c |  3 +--
>  hw/vfio/ccw.c  | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)

How shall we proceed with this? I currently don't have much
(understatement of the year...) queued, so we could wait until we
hashed out where to go with _once logging (although the discussion
seems to have died down a bit). If I merge a respin of David's tcg
patches, however, I'd be inclined to merge this in the current form as
well and transition to a common _once handling later.
