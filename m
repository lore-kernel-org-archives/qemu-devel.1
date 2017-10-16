Received: from eggs.gnu.org ([2001:4830:134:3::10]:56326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e41wJ-0005zj-6o
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e41wF-0001Iu-9K
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e41wF-0001Ie-2m
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:43:59 -0400
Date: Mon, 16 Oct 2017 17:43:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171016094352.GI4166@pxdev.xzpeter.org>
References: <20171016065216.18162-1-peterx@redhat.com>
	<150814110349.320.16460633442467345552@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150814110349.320.16460633442467345552@b58463cdfd5f>
Subject: Re: [Qemu-devel] [PATCH v3 00/32] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, aarcange@redhat.com, quintela@redhat.com, a.perevalov@samsung.com, dgilbert@redhat.com

On Mon, Oct 16, 2017 at 01:05:04AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20171016065216.18162-1-peterx@redhat.com
> Subject: [Qemu-devel] [PATCH v3 00/32] Migration: postcopy failure recovery
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> time make docker-test-block@fedora
> === TEST SCRIPT END ===

[...]

>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/gdbstub-xml.o
>   CC      aarch64-softmmu/trace/generated-helpers.o
>   LINK    aarch64-softmmu/qemu-system-aarch64.exe
> ../migration/savevm.o: In function `postcopy_pause_incoming':
> /tmp/qemu-test/src/migration/savevm.c:2174: undefined reference to `postcopy_fault_thread_notify'

I'm moving postcopy_fault_thread_notify() after the #endif of:

#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)

Then problem solved.

Will hold before reposting until I got more comments.  Thanks,

-- 
Peter Xu
