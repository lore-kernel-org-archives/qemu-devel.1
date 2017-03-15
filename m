Received: from eggs.gnu.org ([2001:4830:134:3::10]:54318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3nM-0004te-VO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3nK-0003I7-0G
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3nJ-0003Hk-QX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:56:29 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 748724DD5F
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:56:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170314113941.15362-1-pbonzini@redhat.com>
Date: Wed, 15 Mar 2017 08:56:26 +0100
In-Reply-To: <20170314113941.15362-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Tue, 14 Mar 2017 12:39:41 +0100")
Message-ID: <87mvcnnfbp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] coverity-model: model
 address_space_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> When more complexity was added to facilitate inlining, Coverity
> lost the ability to use the address_space_rw model for
> address_space_read/write.

Got the commit hash of the change?

> This causes false positive defects when Coverity sees
> a length-8 write in address_space_read and a length-4
> (e.g. int*) buffer to read into.  As long as the size of
> the buffer is okay, this is a false positive.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-model.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
> index ee5bf9d..2e30150 100644
> --- a/scripts/coverity-model.c
> +++ b/scripts/coverity-model.c
> @@ -79,6 +79,25 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
>      return result;
>  }
>  
> +MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
> +                               MemTxAttrs attrs,
> +                               uint8_t *buf, int len)
> +{
> +    MemTxResult result;
> +    __bufwrite(buf, len);
> +    return result;
> +}
> +
> +MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
> +                                MemTxAttrs attrs,
> +                                const uint8_t *buf, int len)
> +{
> +    MemTxResult result;
> +    __bufread(buf, len);
> +    return result;
> +}
> +
> +
>  /* Tainting */
>  
>  typedef struct {} name2keysym_t;

Preferably with the commit hash of the change that necessitates this
update mentioned in the commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

I can stick this in a miscellaneous pull request due later today.
