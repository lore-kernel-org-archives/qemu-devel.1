Received: from eggs.gnu.org ([2001:4830:134:3::10]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYxq-0003WZ-Bg
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYxp-0007EO-Hp
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:12:30 -0400
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-10-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88257975-71f6-ebe9-4888-9134e786d040@redhat.com>
Date: Fri, 6 Jul 2018 17:12:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180705073701.10558-10-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] block: Use common write req
 handling in truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 07/05/2018 02:37 AM, Fam Zheng wrote:
> Truncation is the last to convert from open coded req handling to
> reusing helpers. This time the permission check in prepare has to adapt
> to the new caller: it checks a different permission bit, and don't

did you mean "won't" or "doesn't"?

> trigger the before write notifier.
> 
> Also, truncation should always trigger a bs->total_sectors update and in
> turn call parent resize_cb. Update the condition in finish helper, too.
> 
> It's intended to do a duplicated bs->read_only check before calling
> bdrv_co_write_req_prepare() so that we can be more informative with the
> error message, as bdrv_co_write_req_prepare() doesn't have Error
> parameter.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/io.c | 54 +++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 33 insertions(+), 21 deletions(-)
> 
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
