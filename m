Received: from eggs.gnu.org ([2001:4830:134:3::10]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etYg4-0003B5-B1
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etYg0-0002rq-FH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:00:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etYg0-0002rZ-AV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 08:00:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C58B8424D
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 13:00:08 +0000 (UTC)
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
	<1520342370-123606-20-git-send-email-pbonzini@redhat.com>
	<20180307134952.06e877a2.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <219ccfa2-3fe1-cea7-a8c6-88891374efbe@redhat.com>
Date: Wed, 7 Mar 2018 14:00:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180307134952.06e877a2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 19/34] address_space_access_valid:
 address_space_to_flatview needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/03/2018 13:49, Cornelia Huck wrote:
> On Tue,  6 Mar 2018 14:19:15 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> address_space_access_valid is calling address_space_to_flatview but it can
>> be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
>> pair up from flatview_access_valid to address_space_access_valid.
>>
>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  exec.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> This one kills my s390x guests when running under tcg:
> 
> qemu-system-s390x: /home/cohuck/git/qemu/include/qemu/rcu.h:89: void rcu_read_unlock(void): Assertion `p_rcu_reader->depth != 0' failed.
> 
> Easy to reproduce with the moon buggy image from the QEMU Advent
> Calendar:
> 
> s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio -nographic -smp 2 -kernel ~/Downloads/s390-moon-buggy/s390-bb.kernel -initrd ~/Downloads/s390-moon-buggy/s390-moon-buggy.initrd

This is the fix for all of these:

diff --git a/exec.c b/exec.c
index 604f03c535..a9181e6417 100644
--- a/exec.c
+++ b/exec.c
@@ -3393,7 +3393,6 @@ static bool flatview_access_valid(FlatView *fv,
hwaddr addr, int len,
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
-                rcu_read_unlock();
                 return false;
             }
         }

Paolo
