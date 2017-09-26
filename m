Received: from eggs.gnu.org ([2001:4830:134:3::10]:60069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwirq-0001sw-9U
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwirn-0003JC-83
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:57:14 -0400
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA9GtLniZNyO7Uv=vL9HiSBGjvWRYdR-Zi1E+W4N9qiB6A@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <55782343-4bb4-d5ed-2c5d-4dd0fc5764dd@msgid.tls.msk.ru>
Date: Tue, 26 Sep 2017 08:57:00 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9GtLniZNyO7Uv=vL9HiSBGjvWRYdR-Zi1E+W4N9qiB6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/31] Trivial patches for 2017-09-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Eduardo Otubo <otubo@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

26.09.2017 02:22, Peter Maydell wrote:
[]
>> trivial patches for 2017-09-25
> 
> This fails 'make check' on most of my configs:
> 
>   GTESTER check-qtest-ppc64
> qemu-system-ppc64: -object
> filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0:
> Device 'qtest-bn0' not found
> Broken pipe
> GTester: last random seed: R02Sb816ff80b7d08ef6a5328ff373d8cd65
> 
> GLib-CRITICAL **: void g_hook_destroy_link(GHookList *, GHook *):
> assertion `hook != NULL' failed
> aborting...

For what it's worth, this time I just _forgot_ to run tests. What a shame..

It fails due to:

Author: Eduardo Otubo <otubo@redhat.com>
Date:   Mon Aug 21 17:50:05 2017 +0200

    filter-mirror: segfault when specifying non existent device

    When using filter-mirror like the example below where the interface
    'ndev0' does not exist on the host, QEMU crashes into segmentation
    fault.

     $ qemu-system-x86_64 -S -machine pc -netdev user,id=ndev0 -object filter-mirror,id=test-object,netdev=ndev0

    This happens because the function filter_mirror_setup() does not checks
    if the device actually exists and still keep on processing calling
    qemu_chr_find(). This patch fixes this issue.

    Signed-off-by: Eduardo Otubo <otubo@redhat.com>
    Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Reverting this patch makes it run again. Cc'ing Eduardo.

I'll remove this patch, patch "hw/isa/pc87312: Mark the device with
user_creatable = false" (will be replaced with a better variant),
and update another patch stripping one more trailing whitespace,
and resend.

Thanks,

/mjt
