Received: from eggs.gnu.org ([2001:4830:134:3::10]:47067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fco9d-0005q9-Cl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fco9c-0002zl-HC
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:37:49 -0400
Date: Tue, 10 Jul 2018 10:37:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710083741.GA5852@localhost.localdomain>
References: <20180703175049.27669-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703175049.27669-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix attaching drained child node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

Am 03.07.2018 um 19:50 hat Kevin Wolf geschrieben:
> This fixes the following case that was reported by Max and was caused by
> not correctly waiting for activity to cease on the parent node before
> attaching a drained child node:
> 
> $ ./qemu-img create -f qed foo.qed 64M
> Formatting 'foo.qed', fmt=qed size=67108864 cluster_size=65536
> $ echo "{'execute':'qmp_capabilities'}
>         {'execute':'blockdev-snapshot',
>          'arguments':{'node':'backing','overlay':'overlay'}}
>         {'execute':'quit'}" | \
>     x86_64-softmmu/qemu-system-x86_64 -qmp stdio -nodefaults \
>         -blockdev "{'node-name':'backing','driver':'null-co'}" \
>         -blockdev "{'node-name':'overlay','driver':'qed',
>                     'file':{'driver':'file','filename':'foo.qed'}}"
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
> "package": "v2.12.0-1422-g0109e7e6f8"}, "capabilities": []}}
> {"return": {}}
> qemu-system-x86_64: block.c:3434: bdrv_replace_node: Assertion
> `!atomic_read(&to->in_flight)' failed.
> [1]    5252 done                 echo  |
>        5253 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
> stdio -nodefaults -blockdev  -blockdev

Applied to the block branch.

Kevin
