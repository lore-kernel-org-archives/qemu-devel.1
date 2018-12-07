Received: from eggs.gnu.org ([2001:4830:134:3::10]:58221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGU0-0007ji-JF
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGTx-0003my-EI
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:47:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gVGTx-0003l9-4h
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:47:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 377DA811D3
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 13:47:52 +0000 (UTC)
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-3-pbonzini@redhat.com>
	<87ftv93ie6.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d8d2f30-d926-15d0-c8d3-b1a5f52ba1d6@redhat.com>
Date: Fri, 7 Dec 2018 14:47:47 +0100
MIME-Version: 1.0
In-Reply-To: <87ftv93ie6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] qemu/queue.h: leave head structs
 anonymous unless necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/12/18 08:28, Markus Armbruster wrote:
> 
>     $ git-grep 'Q[A-Z]*_HEAD([^,]' | grep -v '#define' | grep -v QTAILQ_HEAD
>     block/qcow2-bitmap.c:typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
>     include/block/block.h:typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
>     include/hw/vfio/vfio-common.h:typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>     qemu-bridge-helper.c:typedef QSIMPLEQ_HEAD(ACLList, ACLRule) ACLList;
> 
> Are these four names left in intentionally?

Yes, they are the ones which are used in extern global variables or in
function parameters.  If they are static variables or struct fields, on
the other hand, you don't need the typedef.

The same is also true of the handful of QTAILQ head structs that are
typedefed in 3/6.

I'll add this to the commit message.

> If the name is indeed not needed for lists of other kinds, should we
> simplify the macros so their users don't have to supply an empty first
> argument?

No, it's just a coincidence.  For example QTAILQ needs it (patch 3/6).

Paolo
