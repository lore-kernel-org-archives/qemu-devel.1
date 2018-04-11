Received: from eggs.gnu.org ([2001:4830:134:3::10]:33527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6CMf-0003ZQ-Lo
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f6CMb-00014g-Pq
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:48:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f6CMb-00014C-Lp
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:48:25 -0400
Date: Wed, 11 Apr 2018 17:48:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411094812.GI13887@xz-mi>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
	<20180411034954.GC13887@xz-mi>
	<d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
	<20180411093526.GH13887@xz-mi>
	<4183b7d5-83c5-5401-3ac4-937bb40a14e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4183b7d5-83c5-5401-3ac4-937bb40a14e8@redhat.com>
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

On Wed, Apr 11, 2018 at 11:38:58AM +0200, Paolo Bonzini wrote:
> On 11/04/2018 11:35, Peter Xu wrote:
> > Yeah, the inheritance will only make sure cur_mon be initialized
> > always with correct value just like when we are without Out-Of-Band.
> > For example, it's still possible a thread is created within a QMP
> > handler.  If without current change, the cur_mon in the new thread
> > would be NULL.
> > 
> > AFAIU even if cur_mon==NULL we should mostly be fine (e.g.,
> > error_vprintf will handle that case well).  If any of you can help me
> > confirm this, then I agree that this patch is not really needed.
> 
> Yes, though the solution is to not use error_vprintf from auxiliary
> threads. :)  Just make sure all the communication happens through a
> struct that's passed in the thread entry point, and possibly bottom
> halves from the auxiliary thread to the monitor iothread.

Okay. :) Thanks for confirming.  Then let me repost this patch without
touching the qemu-threads.

Btw, do you want me to repost the first patch separately too, or keep
the code as is?  I believe it depends on whether you treat that one as
a cleanup or not.  Thanks,

-- 
Peter Xu
