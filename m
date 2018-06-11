Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSPFc-0005Kc-TV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSPFY-0002s6-1j
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:01:01 -0400
Date: Mon, 11 Jun 2018 18:00:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180611180050.792fa5ef.cohuck@redhat.com>
In-Reply-To: <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
	<5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
	<20180607115442.6a779ed9.cohuck@redhat.com>
	<10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
	<20180607183407.1ea5ab89.cohuck@redhat.com>
	<0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for
 halt/clear subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>

On Fri, 8 Jun 2018 22:40:39 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

[I'm trying to not make the discussion branch out too much. Just
replying one more time here (and I'll add something to the wiki).]

> One can probably argue that setting cc 0 even if the host device
> responds to the host ssch with cc 3 because the device is not any more
> on the given subchannel or simply just disabled. It is probably true
> that the guest would not have any means to prove that we were 'lying'
> to it.

I would not frame this as 'lying'. We have an additional layer
inbetween, adding additional complications. As long as we reflect
something to the guest that (a) is covered by the architecture, and (b)
enables the guest to make reasonable decisions, we're fine.

> 
> But AFAIR this is not how the current implementation works. The pwrite
> in qemu basically depends on the cc of the host ssch. So if the host
> ssch completes with cc 3 the vfio-ccw kernel module map ist to pwrite
> reporting -ENODEV and vfio_ccw_handle_request makes sure that the
> guest instruction completes with cc 3 by mapping it to return code
> IOINST_CC_NOT_OPERATIONAL.

Will need to review the code again. But this behaviour is fine as well
by my reasoning above :)

> 
> I mentioned xsch in the other thread. I don't think we can tell if
> cc 0 or cc 2. In my reading xsch in simple words xsch completes with
> cc 2 and does nothing else if the channel subsystem already started talking
> to the cu/device. If in time it makes sure we don't start talking to the
> device, and clear away stuff. So if we don't consider cc of the xsch
> to be issued by the host the only safe bet seems to be cc 2. But that's
> effectively getting around implementing the desired functionality of
> xsch and still staying architecturally correct. Which however might
> be good enough for vfio-ccw. But I think I demonstrated it's kinda
> tricky business.

I'm wondering if we should simply give the guest a cc 2 in any case as
well.
> 
> I prefer to avoid tricky if there is no good reason not to.
