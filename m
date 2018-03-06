Received: from eggs.gnu.org ([2001:4830:134:3::10]:54243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1et8t6-0003UZ-Er
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1et8t2-0007W2-CL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:28:00 -0500
Date: Tue, 6 Mar 2018 10:27:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180306102752.168548c7.cohuck@redhat.com>
In-Reply-To: <d16953b5-e47d-937e-dd61-f0acf302d949@de.ibm.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<90dab7d2-be2a-4ab6-ed08-4ce8cac5664f@de.ibm.com>
	<20180305162710.70f680ff.cohuck@redhat.com>
	<d16953b5-e47d-937e-dd61-f0acf302d949@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 3/3] s390x/sclp: extend
 SCLP event masks to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 6 Mar 2018 09:23:23 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/05/2018 04:27 PM, Cornelia Huck wrote:
> > On Fri, 2 Mar 2018 10:44:46 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 02/23/2018 06:42 PM, Claudio Imbrenda wrote:  
> >>> Extend the SCLP event masks to 64 bits.
> >>>
> >>> Notice that using any of the new bits results in a state that cannot be
> >>> migrated to an older version.
> >>>
> >>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> >>> ---
> >>>  hw/s390x/event-facility.c         | 56 ++++++++++++++++++++++++++++++---------
> >>>  include/hw/s390x/event-facility.h |  2 +-
> >>>  2 files changed, 45 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> >>> index e04ed9f..c3e39ee 100644
> >>> --- a/hw/s390x/event-facility.c
> >>> +++ b/hw/s390x/event-facility.c
> >>> @@ -30,7 +30,7 @@ struct SCLPEventFacility {
> >>>      SysBusDevice parent_obj;
> >>>      SCLPEventsBus sbus;
> >>>      /* guest's receive mask */
> >>> -    sccb_mask_t receive_mask;
> >>> +    uint32_t receive_mask_pieces[2];    
> >>
> >>
> >> Before the change, we basically use be32_to_cpu to transfer the byte field into a cpu
> >> endianess value. In the end it is actually a bitfield, but for compat we need to keep
> >> he reversal. So it will be hard to get this fixed without some kind of ugliness.  
> > 
> > Could we also use a compat mask callback/handler for older machines and
> > switch to 64 bit handlers for the default case? Probably would be even
> > more ugly, though.  
> 
> Claudio had a version with a pre/post/load/save handler. Claudio can you repost this
> version so that we can have a look what is "less ugly"?
> 

Would that other version be independent of the first two patches (i.e.,
only replace this patch)?

I would like to apply patch 1 as it is a fix, and patch 2 seems
uncontroversial as a cleanup.
