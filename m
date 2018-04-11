Received: from eggs.gnu.org ([2001:4830:134:3::10]:56171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6CDn-0008FF-N7
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6CDi-0003la-J3
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:39:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f6CDi-0003ki-CE
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:39:14 -0400
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
	<20180411034954.GC13887@xz-mi>
	<d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
	<20180411093526.GH13887@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4183b7d5-83c5-5401-3ac4-937bb40a14e8@redhat.com>
Date: Wed, 11 Apr 2018 11:38:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180411093526.GH13887@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 11/04/2018 11:35, Peter Xu wrote:
> Yeah, the inheritance will only make sure cur_mon be initialized
> always with correct value just like when we are without Out-Of-Band.
> For example, it's still possible a thread is created within a QMP
> handler.  If without current change, the cur_mon in the new thread
> would be NULL.
> 
> AFAIU even if cur_mon==NULL we should mostly be fine (e.g.,
> error_vprintf will handle that case well).  If any of you can help me
> confirm this, then I agree that this patch is not really needed.

Yes, though the solution is to not use error_vprintf from auxiliary
threads. :)  Just make sure all the communication happens through a
struct that's passed in the thread entry point, and possibly bottom
halves from the auxiliary thread to the monitor iothread.

Paolo

> If so, maybe even we don't need to setup cur_mon at entry of monitor
> iothread, since cur_mon is always used in the way like:
