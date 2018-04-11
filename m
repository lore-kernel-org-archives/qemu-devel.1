Received: from eggs.gnu.org ([2001:4830:134:3::10]:53478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6CAK-0005j6-W5
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6CAG-0001St-44
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:35:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f6CAF-0001SW-Rf
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:35:40 -0400
Date: Wed, 11 Apr 2018 17:35:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411093526.GH13887@xz-mi>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
	<20180411034954.GC13887@xz-mi>
	<d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Apr 11, 2018 at 11:23:57AM +0200, Paolo Bonzini wrote:
> On 11/04/2018 05:49, Peter Xu wrote:
> > On Wed, Apr 11, 2018 at 09:45:32AM +0800, Stefan Hajnoczi wrote:
> >> On Tue, Apr 10, 2018 at 08:49:13PM +0800, Peter Xu wrote:
> >>> cur_mon was only used in main loop so we don't really need that to be
> >>> per-thread variable.  Now it's possible that we have more than one
> >>> thread to operate on it.  Let's start to let it be per-thread variable.
> >> Trying to understand the reason for this patch:
> >>
> >> Are there any users of per-thread cur_mon?
> > 
> > Currently no.  But if considering future OOB-capable commands, they
> > will modify cur_mon in monitor IOThread at least.
> 
> That's fine, but it shouldn't need the inheritance part.  The monitor
> IOThread can set cur_mon when it starts.

Yeah, the inheritance will only make sure cur_mon be initialized
always with correct value just like when we are without Out-Of-Band.
For example, it's still possible a thread is created within a QMP
handler.  If without current change, the cur_mon in the new thread
would be NULL.

AFAIU even if cur_mon==NULL we should mostly be fine (e.g.,
error_vprintf will handle that case well).  If any of you can help me
confirm this, then I agree that this patch is not really needed.

If so, maybe even we don't need to setup cur_mon at entry of monitor
iothread, since cur_mon is always used in the way like:

  old_mon = cur_mon;
  cur_mon = xxx;
  ... (do something)
  cur_mon = old_mon;

And it'll be fine old_mon==NULL here.  Then IMHO the only thing we
need to do is to mark cur_mon as per-thread and we're done.

Thanks,

-- 
Peter Xu
