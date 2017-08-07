Received: from eggs.gnu.org ([2001:4830:134:3::10]:52503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedfM-0007Db-Gp
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedfJ-00017b-3c
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dedfI-00015R-Qf
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:45:33 -0400
Date: Mon, 7 Aug 2017 09:45:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170807084524.GF18259@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
	<7c4ddf95a57f7dfa546c11f8a08a9091b8bd1ceb.1501362828.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c4ddf95a57f7dfa546c11f8a08a9091b8bd1ceb.1501362828.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] tests: Add test-listen - a stress
 test for QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Sat, Jul 29, 2017 at 11:18:15PM +0200, Knut Omang wrote:
> There's a potential race condition between multiple bind()'s
> attempting to bind to the same port, which occasionally
> allows more than one bind to succeed against the same port.
> 
> When a subsequent listen() call is made with the same socket
> only one will succeed.
> 
> The current QEMU code does however not take this situation into account
> and the listen will cause the code to break out and fail even
> when there are actually available ports to use.
> 
> This test exposes two subtests:
> 
> /socket/listen-serial
> /socket/listen-compete
> 
> The "compete" subtest creates a number of threads and have them all trying to bind
> to the same port with a large enough offset input to
> allow all threads to get it's own port.
> The "serial" subtest just does the same, except in series in a
> single thread.
> 
> The serial version passes, probably in most versions of QEMU.
> 
> The parallel version exposes the problem in a relatively reliable way,
> eg. it fails a majority of times, but not with a 100% rate, occasional
> passes can be seen. Nevertheless this is quite good given that
> the bug was tricky to reproduce and has been left undetected for
> a while.
> 
> The problem seems to be present in all versions of QEMU.
> 
> The original failure scenario occurred with VNC port allocation
> in a traditional Xen based build, in different code
> but with similar functionality.
> 
> Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> ---
>  tests/Makefile.include |   2 +-
>  tests/test-listen.c    | 253 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 255 insertions(+)
>  create mode 100644 tests/test-listen.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7af278d..b37c0c8 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -128,6 +128,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
>  gcov-files-check-bufferiszero-y = util/bufferiszero.c
>  check-unit-y += tests/test-uuid$(EXESUF)
>  check-unit-y += tests/ptimer-test$(EXESUF)
> +#check-unit-y += tests/test-listen$(EXESUF)
>  gcov-files-ptimer-test-y = hw/core/ptimer.c
>  check-unit-y += tests/test-qapi-util$(EXESUF)
>  gcov-files-test-qapi-util-y = qapi/qapi-util.c
> @@ -769,6 +770,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
>  tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
>  tests/numa-test$(EXESUF): tests/numa-test.o
>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
> +tests/test-listen$(EXESUF): tests/test-listen.o $(test-util-obj-y)
>  
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>  	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/test-listen.c b/tests/test-listen.c
> new file mode 100644
> index 0000000..5c07537
> --- /dev/null
> +++ b/tests/test-listen.c
> @@ -0,0 +1,253 @@
> +/*
> + * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
> + *    Author: Knut Omang <knut.omang@oracle.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.

Can you change that to "version 2 or later" - per the LICENSE file, we don't
accept contributions under "version 2 only" except for 4 specific subdirs:


  "As of July 2013, contributions under version 2 of the GNU General Public
   License (and no later version) are only accepted for the following files
   or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*."


> + *
> + * Test parallel port listen configuration with
> + * dynamic port allocation
> + */


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
