Received: from eggs.gnu.org ([2001:4830:134:3::10]:58923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1epBN5-0006Mt-E6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1epBN2-0001rZ-7t
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:18:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45570
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1epBN2-0001oo-0h
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:18:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NBFLJj088927
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:18:30 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gafyscsfh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:18:30 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 11:18:29 -0000
Date: Fri, 23 Feb 2018 12:18:25 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180223113146.5121ca64.cohuck@redhat.com>
References: <1519316579-7162-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519316579-7162-2-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180223113146.5121ca64.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180223121825.4d58fd69@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/sclp: proper support of
 larger send and receive masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Fri, 23 Feb 2018 11:31:46 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 22 Feb 2018 17:22:57 +0100
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> 
> > Until 67915de9f0383ccf4a ("s390x/event-facility: variable-length
> > event masks") we only supported sclp event masks of size exactly 4
> > bytes, even though  
> 
> s/of size/of a size of/

will fix

> > the archiecture allows the guests to set up sclp event masks from 1
> > to  
> 
> s/archiecture/architecture/

will fix

> > 1021 bytes in length.
> > After that patch, the behaviour was almost compliant, but some
> > issues were still remaining, in particular regarding the handling
> > of selective reads and migration.
> > 
> > When setting the sclp event mask, a mask size is also specified.
> > Until now we only considered the size in order to decide which bits
> > to save in the internal state. On the other hand, when a guest
> > performs a selective read, it sends a mask, but it does not specify
> > a size; the implied size is the size of the last mask that has been
> > set.
> > 
> > Specifying bits in the mask of selective read that are not
> > available in the internal mask should return an error, and bits
> > past the end of the mask should obviously be ignored. This can only
> > be achieved by keeping track of the lenght of the mask.
> > 
> > The mask length is thus now part of the internal state that needs
> > to be migrated.
> > 
> > This patch fixes the handling of selective reads, whose size will
> > now match the length of the event mask, as per architecture.
> > 
> > While the default behaviour is to be compliant with the
> > architecture, when using older machine models the old broken
> > behaviour is selected (allowing only masks of size exactly 4), in
> > order to be able to migrate toward older versions.
> > 
> > Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length
> > event masks") Signed-off-by: Claudio Imbrenda
> > <imbrenda@linux.vnet.ibm.com> ---
> >  hw/s390x/event-facility.c  | 91
> > +++++++++++++++++++++++++++++++++++++++-------
> > hw/s390x/s390-virtio-ccw.c |  8 +++- 2 files changed, 85
> > insertions(+), 14 deletions(-)  
> 
> Looks reasonable.
> 
