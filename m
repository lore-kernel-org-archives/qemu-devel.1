Received: from eggs.gnu.org ([2001:4830:134:3::10]:41269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVy1L-0003J1-BH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVy1K-0006bA-Cq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:44:59 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d1712c4d-bb9a-b533-3672-786d72f2ede1@redhat.com>
Date: Thu, 21 Jun 2018 13:44:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180620100825.22476-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] s390x/tcg: properly implement the
 TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 20.06.2018 12:08, David Hildenbrand wrote:
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
> Introduce "tcg_s390x.h" just like "kvm_s390x.h" for tcg specific
> function declarations that should not go into cpu.h.
[...]
> diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
> index c1b3438452..7495d8c057 100644
> --- a/hw/s390x/tod.c
> +++ b/hw/s390x/tod.c
> @@ -30,6 +30,17 @@ void s390_init_tod(void)
>      qdev_init_nofail(DEVICE(obj));
>  }
>  
> +S390TODState *s390_get_tod(void)
> +{
> +    static S390TODState *ts;
> +
> +    if (!ts) {
> +        ts = S390_TOD(object_resolve_path_type("", TYPE_S390_TOD, NULL));
> +    }
> +
> +    return ts;
> +}

Could you please call that function s390_get_todstate or something
similar? Otherwise it sounds like it could be used to retrieve the time,
and not the state object.

 Thomas
