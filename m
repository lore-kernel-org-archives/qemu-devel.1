Received: from eggs.gnu.org ([2001:4830:134:3::10]:46396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmfb-0000sL-Tf
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmfX-0005ZJ-Ts
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:53:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvmfX-0005ZA-Op
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:53:11 -0400
References: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
	<1535733414-6812-9-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d2e5805-2d53-3c20-c34a-514614750dec@redhat.com>
Date: Fri, 31 Aug 2018 11:53:10 -0500
MIME-Version: 1.0
In-Reply-To: <1535733414-6812-9-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

On 08/31/2018 11:36 AM, Liam Merwick wrote:
> The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
> add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to metadata_ol_names[].
> As a result, an array dereference of metadata_ol_names[8] in
> qcow2_pre_write_overlap_check() could result in a read outside of the array bounds.
> 
> Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')
> 
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>   block/qcow2-refcount.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 

> +
> +/*
> + * Catch at compile time the case where an overlap detection bit
> + * was added to QCow2MetadataOverlap in block/qcow2.h but a
> + * corresponding entry to metadata_ol_names[] wasn't added.
> + */

I'm not sure the comment adds much value.  I'd be fine with dropping it.

> +QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=
> +    (sizeof(metadata_ol_names) / sizeof(metadata_ol_names[0])));

We have a macro for that.  Spell this:

QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR != ARRAY_SIZE(metadata_ol_names));

and then you can have

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
