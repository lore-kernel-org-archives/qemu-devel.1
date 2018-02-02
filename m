Received: from eggs.gnu.org ([2001:4830:134:3::10]:40558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehd7p-0006QC-IK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehd7k-0004YN-Ey
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:37 -0500
Date: Fri, 2 Feb 2018 11:33:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180202113301.0522c7bc.cohuck@redhat.com>
In-Reply-To: <8d3af693-3dd8-20b7-c7c1-38d7c6cce65d@de.ibm.com>
References: <20180202094241.59537-1-borntraeger@de.ibm.com>
	<8d3af693-3dd8-20b7-c7c1-38d7c6cce65d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: fix event mask handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, qemu-stable@nongnu.org

On Fri, 2 Feb 2018 10:43:18 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/02/2018 10:42 AM, Christian Borntraeger wrote:
> > commit 67915de9f038 ("s390x/event-facility: variable-length event
> > masks") switches the sclp receive/send mask. This broke the sclp
> > lm console.

Hum. Probably should add sclp-lm to my test setup.

> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length event masks")
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>  
> 
> opps. Please fixup yourself Conny :-)

Well, you did cc: the original author :)

> 
> > Cc: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> > Cc: qemu-stable@nongnu.org
> > ---
> >  hw/s390x/event-facility.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > index b0f71f4554..155a69467b 100644
> > --- a/hw/s390x/event-facility.c
> > +++ b/hw/s390x/event-facility.c
> > @@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
> >      ef->receive_mask = be32_to_cpu(tmp_mask);
> > 
> >      /* return the SCLP's capability masks to the guest */
> > -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> > +    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> >      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
> >                mask_length, sizeof(tmp_mask));
> > -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> > +    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> >      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
> >                mask_length, sizeof(tmp_mask));
> >   
> 

Thanks, applied.
