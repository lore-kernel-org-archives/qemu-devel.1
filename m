Received: from eggs.gnu.org ([209.51.188.92]:38970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hBMPY-0006Jk-03
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hBMDu-0001VM-TV
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hBMDu-0001SG-G2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA5F43082134
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 16:25:17 +0000 (UTC)
References: <20190326131822.GD15011@stefanha-x1.localdomain>
	<55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
	<20190402161853.GE5352@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4f5997d-e42a-aaaa-e145-b55d5f6efd93@redhat.com>
Date: Tue, 2 Apr 2019 18:25:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190402161853.GE5352@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU event loop optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org

On 02/04/19 18:18, Kevin Wolf wrote:
> Am 26.03.2019 um 15:11 hat Paolo Bonzini geschrieben:
>> - but actually (and a precursor to using IOCB_CMD_POLL) it should be
>> possible to have just one LinuxAioState per AioContext, and then
>> it can simply share the AioContext's EventNotifier.  This removes
>> the need to do the event_notifier_test_and_clear in linux-aio.c.
> 
> Isn't having only one LinuxAioState per AioContext what we already do?
> See aio_get_linux_aio().

And I should have known that:

    commit 0187f5c9cb172771ba85c66e3bf61f8cde6d6561
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Mon Jul 4 18:33:20 2016 +0200

    linux-aio: share one LinuxAioState within an AioContext

    This has better performance because it executes fewer system calls
    and does not use a bottom half per disk.

    Originally proposed by Ming Lei.

The second point, which is to share the AioContext's EventNotifier,
still stands.

Paolo
