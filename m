Received: from eggs.gnu.org ([209.51.188.92]:41899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gpBan-000795-Oy
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gpBam-0004Qd-Uw
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:37:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36574
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gpBam-0004QR-P7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:37:16 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VCb4Ex033258
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 07:37:16 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qbyprm5tg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 07:37:07 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 31 Jan 2019 12:35:00 -0000
Date: Thu, 31 Jan 2019 13:34:55 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190131125220.285a4bc8.cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<20190130195127.5ff3c849@oc2783563651>
	<20190131125220.285a4bc8.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190131133455.3097613f@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 31 Jan 2019 12:52:20 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 30 Jan 2019 19:51:27 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Wed, 30 Jan 2019 14:22:07 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > When we get a solicited interrupt, the start function may have
> > > been cleared by a csch, but we still have a channel program
> > > structure allocated. Make it safe to call the cp accessors in
> > > any case, so we can call them unconditionally.  
> > 
> > I read this like it is supposed to be safe regardless of
> > parallelism and threads. However I don't see any explicit
> > synchronization done for cp->initialized.
> > 
> > I've managed to figure out how is that supposed to be safe
> > for the cp_free() (which is probably our main concern) in
> > vfio_ccw_sch_io_todo(), but if fail when it comes to the one
> > in vfio_ccw_mdev_notifier().
> > 
> > Can you explain us how does the synchronization work?
> 
> You read that wrong, I don't add synchronization, I just add a check.
> 

Now I'm confused. Does that mean we don't need synchronization for this?

Regards,
Halil
