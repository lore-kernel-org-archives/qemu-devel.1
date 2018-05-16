Received: from eggs.gnu.org ([2001:4830:134:3::10]:54660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIskf-0005kA-IK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIske-00085W-M0
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:29:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fIske-00085N-HX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:29:40 -0400
References: <20180515134950.3755-1-muriloo@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <109f249c-eee7-5bc9-9f59-b64bca6da5aa@redhat.com>
Date: Wed, 16 May 2018 11:29:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180515134950.3755-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] HACKING: document preference for g_new
 instead of g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 15.05.2018 15:49, Murilo Opsfelder Araujo wrote:
> This patch documents the preference for g_new instead of g_malloc. The
> reasons were adapted from commit b45c03f585ea9bb1af76c73e82195418c294919d.
> 
> Discussion in QEMU's mailing list:
>   http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg03238.html
> 
> Cc: qemu-devel@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  HACKING | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/HACKING b/HACKING
> index 4125c97d8d..0fc3e0fc04 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -118,6 +118,15 @@ Please note that g_malloc will exit on allocation failure, so there
>  is no need to test for failure (as you would have to with malloc).
>  Calling g_malloc with a zero size is valid and will return NULL.
>  
> +Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
> +reasons:

Should we make this stronger? s/Prefer/Use/ ? Because I think that for
this use case we have an agreement (sizeof(T) vs. sizeof(*var)).

> +
> +  a. It catches multiplication overflowing size_t;
> +  b. It returns T * instead of void *, letting compiler catch more type
> +     errors.
> +
> +Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.
> +
>  Memory allocated by qemu_memalign or qemu_blockalign must be freed with
>  qemu_vfree, since breaking this will cause problems on Win32.
>  
> 

This seems to be the right place to start documenting such stuff.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
