Received: from eggs.gnu.org ([2001:4830:134:3::10]:54917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvRyt-0006rc-S1
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvRsm-000573-5V
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:41:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvRsm-00056p-03
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:41:28 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-7-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13bca354-a3d1-fa51-3581-322bd1351059@redhat.com>
Date: Thu, 30 Aug 2018 13:41:26 -0500
MIME-Version: 1.0
In-Reply-To: <1535644031-848-7-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/8] block: dump_qlist() may dereference a
 Null pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

On 08/30/2018 10:47 AM, Liam Merwick wrote:
> A NULL 'list' passed into function dump_qlist() isn't correctly
> validated and can be passed to qlist_first() where it is dereferenced.

But dump_qlist() is static, and it is easy to prove that it will never 
be called with a NULL 'list' parameter (it's lone caller did switch 
(qobject_type(obj)), and calls dump_qlist() only for QTYPE_QLIST, which 
implies that the qobject_to(QList, obj) will succeed and never be NULL).

> 
> This could be resolved by checking if the list is NULL in dump_qlist()
> and returning immediately. However, the general case can be handled by
> adding a NULL arg check to to qlist_first() and qlist_next() and all
> the callers to those functions handle that cleanly.

NACK.  If anything, I'd be happier with:

assert(list);

in dump_qlist() to shut up the lint checker, as we do not want to slow 
down the common case of qlist_first() for something that does not 
happen.  That is, the null dereference in qlist_first() is a feature for 
detecting buggy code, and not something we need to change.

> 
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>	
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> 
> ---
>   include/qapi/qmp/qlist.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
> index 8d2c32ca2863..1ec716e2eb9e 100644
> --- a/include/qapi/qmp/qlist.h
> +++ b/include/qapi/qmp/qlist.h
> @@ -58,11 +58,17 @@ void qlist_destroy_obj(QObject *obj);
>   
>   static inline const QListEntry *qlist_first(const QList *qlist)
>   {
> +    if (!qlist) {
> +        return NULL;
> +    }
>       return QTAILQ_FIRST(&qlist->head);
>   }
>   
>   static inline const QListEntry *qlist_next(const QListEntry *entry)
>   {
> +    if (!entry) {
> +        return NULL;
> +    }
>       return QTAILQ_NEXT(entry, next);
>   }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
