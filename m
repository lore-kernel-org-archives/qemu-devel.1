Received: from eggs.gnu.org ([2001:4830:134:3::10]:43212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dLXRS-0001mc-Cc
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dLXRO-0001xt-Dl
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:16:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dLXRO-0001xZ-6q
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E53A085547
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 16:16:12 +0000 (UTC)
References: <20170615152852.GB2399@work-vm>
From: John Snow <jsnow@redhat.com>
Message-ID: <6e150052-91ca-d260-b0e9-6894f93fc15d@redhat.com>
Date: Thu, 15 Jun 2017 12:16:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170615152852.GB2399@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ahci-test failures with 'Failed to get "write"
 lock'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
Cc: stefanha@redhat.com, mreitz@redhat.com



On 06/15/2017 11:28 AM, Dr. David Alan Gilbert wrote:
> Hi,
>   Peter noticed that there were some hangs in the ahci-test;
> I can reproduce them on my laptop as long as the laptop has
> some other load on it (a few md5sum /dev/zero's help).
> 
> /x86_64/ahci/flush/migrate: qemu-system-x86_64: Failed to get "write" lock
> Is another process using the image?
> OK
> /x86_64/ahci/migrate/sanity: qemu-system-x86_64: Failed to get "write" lock
> Is another process using the image?
> 
> and that hangs in sanity.
> 
> That seems to be the common case, I've also had one:
> 
> /x86_64/ahci/migrate/ncq/halted: qemu-system-x86_64: Failed to get "write" lock
> Is another process using the image?
> qemu-system-x86_64: /home/dgilbert/git/qemu/block/io.c:1352: bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed.
> 
> 
> Neither of these always fail.
> 
> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

Haven't observed myself and I run the tests pretty frequently. I'll keep
an eye out. I see many similar problems in iotests for other areas, too.

AHCI tests *should* never overlap and *should* never be using images in
an unsafe way, and do a full set-up and tear-down for each individual
unit test.

Of course, maybe the migrate code isn't behaving quite so nicely with
loopback migrations...?
