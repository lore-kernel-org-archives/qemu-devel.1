Received: from eggs.gnu.org ([2001:4830:134:3::10]:44344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPo75-0000xf-AC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fPo71-0006l4-Dq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:57:27 -0400
Date: Mon, 4 Jun 2018 13:57:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180604135718.559ac812.cohuck@redhat.com>
In-Reply-To: <20180525113708.29856-4-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/7] s390x/tcg: properly implement the
 TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>

On Fri, 25 May 2018 13:37:04 +0200
David Hildenbrand <david@redhat.com> wrote:

> Right now, each CPU has its own TOD. Especially, the TOD will differ
> based on creation time of a CPU - e.g. when hotplugging a CPU the times
> will differ quite a lot, resulting in stall warnings in the guest.
> 
> Let's use a single TOD by implementing our new TOD device. Prepare it
> for TOD-clock epoch extension.
> 
> Most importantly, whenever we set the TOD, we have to update the CKC
> timer.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/tod-qemu.c        | 45 ++++++++++++++++++++++++++++++++++----
>  hw/s390x/tod.c             | 11 ++++++++++
>  include/hw/s390x/tod.h     | 19 ++++++++++++++++
>  target/s390x/cpu.c         |  8 +------
>  target/s390x/cpu.h         |  6 ++++-
>  target/s390x/internal.h    | 15 -------------
>  target/s390x/misc_helper.c | 32 ++++++++++++++++++++++-----
>  7 files changed, 103 insertions(+), 33 deletions(-)

> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> index 43ed71600f..5491245b86 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -30,6 +30,9 @@ typedef struct S390TOD {
>  typedef struct S390TODState {
>      /* private */
>      DeviceState parent_obj;
> +
> +    /* unused by KVM implementation */
> +    S390TOD base;

Does this need some kind of migration handling?

>  } S390TODState;
>  
>  typedef struct S390TODClass {
