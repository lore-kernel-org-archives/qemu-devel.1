Received: from eggs.gnu.org ([209.51.188.92]:59961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1DYS-0007ys-55
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1DYR-0003yI-G6
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:08:36 -0500
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-7-armbru@redhat.com>
	<87bm2qzfyn.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d610dae9-9c16-9ccc-762a-79cff5ed2be8@redhat.com>
Date: Tue, 5 Mar 2019 18:08:11 +0100
MIME-Version: 1.0
In-Reply-To: <87bm2qzfyn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com

On 03/04/19 18:50, Markus Armbruster wrote:

> Alright, we can call object_get_class(dev_obj)->unparent(dev_obj).
> 
> Final complication: if I call just that, the device's reference counter
> goes down to zero in the middle of device_unparent(), and we use after
> free.  So I bracket he call with object_ref() and object_unref().

I don't think that requiring such a bracketing is necessarily a problem.
I vaguely remember reviewing a kernel patch 6 or so years ago where the
patch used the same idea, with those "get" and "put" functions (the bug
the patch was fixing was that the last reference was "temporarily" lost
mid-operation).

So perhaps this can be addressed, for the general case, by extending the
documentation of device_unparent(). (The function has no documentation
at all, at the moment.)

Thanks
Laszlo
