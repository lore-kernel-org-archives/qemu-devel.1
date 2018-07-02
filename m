Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZuEF-0007OO-II
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZuE9-0005bh-Tn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:30:35 -0400
Date: Mon, 2 Jul 2018 10:30:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180702103019.5b333e33.cohuck@redhat.com>
In-Reply-To: <20180629170520.13671-1-david@redhat.com>
References: <20180629170520.13671-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: fix locking problem with
 tcg_s390_tod_updated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Fri, 29 Jun 2018 19:05:20 +0200
David Hildenbrand <david@redhat.com> wrote:

> tcg_s390_tod_updated() is always called with the iothread being locked
> (e.g. from S390TODClass->set() e.g. via HELPER(sck) or on incomming

s/incomming/incoming/

> migration). The helper we call takes the lock itself - bad.
> 
> Let's change that by factoring out updating the ckc timer. This now looks
> much nicer than having to call a helper from another function.
> 
> While touch it we also make sure that env->ckc is updated even if the new

s/touch/touching/

> value is -1ULL, for now it would not have been modified in that case.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This survives my tests and the iotests Christian mentioned.

OK, this will the last patch (I guess) before I send my final 3.0 pull
request.

> 
>  target/s390x/misc_helper.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Thanks, applied.
