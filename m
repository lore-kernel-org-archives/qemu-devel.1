Received: from eggs.gnu.org ([2001:4830:134:3::10]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g842S-0006UB-Km
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g842N-0007jD-0s
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g842F-0007Sz-OJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:51:27 -0400
Date: Thu, 4 Oct 2018 14:51:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181004135110.GQ3667@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181003091344.24496-1-d.csapak@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181003091344.24496-1-d.csapak@proxmox.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Wed, Oct 03, 2018 at 11:13:43AM +0200, Dominik Csapak wrote:
> this patch aims to execute a script when qemu exits
> so that one can do cleanups when using --daemonize without
> having to use the qmp monitor

IMHO the idea of cleanup scripts run by QEMU itself is flawed.
QEMU will inevitably crash before cleanup scripts can be run,
so whatever mgmt app is using QEMU needs to be able to do
cleanup without QEMU's help.

I think this can be done more reliably with a wrapper script,
that spawns QEMU, waits for it to exit and then calls the
cleanup script. On Linux at least you can use prctl() with
PR_SET_CHILD_SUBREAPER so you can detect exit'ing of QEMU
even after it has daemonized.

Perhaps we could have such a wrapper script put in the
contrib directory

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
