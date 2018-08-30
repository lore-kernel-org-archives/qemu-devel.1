Received: from eggs.gnu.org ([2001:4830:134:3::10]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvRyr-0006OH-FF
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvRug-0005vt-3s
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:43:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvRuf-0005ve-Ta
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:43:25 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-9-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8b68066-8427-ba2f-9205-a9b316a926b5@redhat.com>
Date: Thu, 30 Aug 2018 13:43:23 -0500
MIME-Version: 1.0
In-Reply-To: <1535644031-848-9-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] qcow2: Read outside array bounds in
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

On 08/30/2018 10:47 AM, Liam Merwick wrote:
> The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
> add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to metadata_ol_names[].
> As a result, an array dereference of metadata_ol_names[8] in
> qcow2_pre_write_overlap_check() could result in a read outside of the array bounds.
> 
> Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')
> 
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> ---
>   block/qcow2-refcount.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)

The fix looks correct, but to prevent the problem from happening again, 
I'd suggest you also add a compile-time BUG_ON that fails if the array 
size gets out of sync again due to another addition of another overlap 
detection bit.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
