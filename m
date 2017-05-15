Received: from eggs.gnu.org ([2001:4830:134:3::10]:36269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dADu6-0005lM-FT
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dADu5-0004u9-GE
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:11:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dADu5-0004tu-8z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77E3C80485
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 11:11:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170512175841.GK2069@work-vm> (David Alan Gilbert's message of
	"Fri, 12 May 2017 18:58:42 +0100")
References: <20170512160055.9081-1-quintela@redhat.com>
	<20170512160055.9081-13-quintela@redhat.com>
	<20170512175841.GK2069@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 13:10:59 +0200
Message-ID: <878tlyfk8s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/12] migration: migration.h was not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> This files don't use any function from migration.h, so drop it.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  block/qed.c             | 1 -
>>  hw/i386/pc_q35.c        | 1 -
>>  hw/virtio/vhost-user.c  | 1 -
>>  hw/virtio/vhost-vsock.c | 1 -
>>  hw/virtio/virtio.c      | 1 -
>>  monitor.c               | 1 -
>>  6 files changed, 6 deletions(-)
>> 
>> diff --git a/block/qed.c b/block/qed.c
>> index fd76817..8d899fd 100644
>> --- a/block/qed.c
>> +++ b/block/qed.c
>> @@ -19,7 +19,6 @@
>>  #include "trace.h"
>>  #include "qed.h"
>>  #include "qapi/qmp/qerror.h"
>> -#include "migration/migration.h"
>>  #include "sysemu/block-backend.h"
>>  
>>  static const AIOCBInfo qed_aiocb_info = {
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index dd792a8..76b08f8 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -46,7 +46,6 @@
>>  #include "hw/ide/ahci.h"
>>  #include "hw/usb.h"
>>  #include "qemu/error-report.h"
>> -#include "migration/migration.h"
>>  
>>  /* ICH9 AHCI has 6 ports */
>>  #define MAX_SATA_PORTS     6
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 9334a8a..ebc8ccf 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -17,7 +17,6 @@
>>  #include "sysemu/kvm.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/sockets.h"
>> -#include "migration/migration.h"
>>  
>>  #include <sys/ioctl.h>
>>  #include <sys/socket.h>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index b481562..49e0022 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -17,7 +17,6 @@
>>  #include "qapi/error.h"
>>  #include "hw/virtio/virtio-bus.h"
>>  #include "hw/virtio/virtio-access.h"
>> -#include "migration/migration.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/virtio/vhost-vsock.h"
>>  #include "qemu/iov.h"
>
> Aren't these including it to get vmstate macros?
> but have they picked up that instead somewhere?

hw/hw.h

hw/virtio/vhost-vsock.h -> hw/virtio/virtio.h -> hw/hw.h

Dropping vmstate.h from that file would have mean have to add one
hundred new includes or so.  And I didn't see any good reason for that.

My understanding is that all devices end including hw/hw.h one way or
another, so the only reason to add migration include files right now is:
- you use old registartion functions
- you use blockers
- you use migration notifiers

Otherwise, if you just use vmstate macros, they are there by hw/hw.h.

Later, Juan.
