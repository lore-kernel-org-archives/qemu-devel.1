Received: from eggs.gnu.org ([2001:4830:134:3::10]:57930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emn9D-0004sg-O9
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emn9C-000668-KX
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:02:23 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-10-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e580b8b-1614-9c83-4ac9-48f5d3cff3dc@redhat.com>
Date: Fri, 16 Feb 2018 15:02:15 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-10-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: new test 206 for NBD
 BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/206     | 34 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/206.out |  2 ++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 37 insertions(+)
>   create mode 100644 tests/qemu-iotests/206
>   create mode 100644 tests/qemu-iotests/206.out

It's a race! Kevin already has test 206 and 207 claimed in his pending 
series:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02363.html
Whoever loses gets to rebase and renumber (or the maintainer on their 
behalf) ;)

> 
> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
> new file mode 100644

Oops, you forgot to mark this executable.  And oops, I forgot to flag 
that on test 205.  Other inconsistent tests: 096, 124, 129, 132, 136, 
139, 148, 152, 163. Separate cleanup patch coming up soon.

> index 0000000000..259e991ec6
> --- /dev/null
> +++ b/tests/qemu-iotests/206
> @@ -0,0 +1,34 @@
> +#!/usr/bin/env python
> +#
> +# Tests for NBD BLOCK_STATUS extension
> +#

> +import iotests
> +from iotests import qemu_img_create, qemu_io, qemu_img_verbose, qemu_nbd, \
> +                    file_path
> +
> +iotests.verify_image_format(supported_fmts=['qcow2'])

Don't we also need to blacklist v2 files (and only operate on v3 or 
newer), since the behavior of zero clusters is much worse on v2 images?

> +
> +disk, nbd_sock = file_path('disk', 'nbd-sock')
> +nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
> +
> +qemu_img_create('-f', iotests.imgfmt, disk, '1M')
> +qemu_io('-f', iotests.imgfmt, '-c', 'write 0 512K', disk)

Hopefully large enough for all the major filesystems with sparse support 
to show half-data, half-hole, and not run into any weird issues where 
granularity differences between filesystems change the outcome.

> +
> +qemu_nbd('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgfmt, disk)
> +qemu_img_verbose('map', '-f', 'raw', '--output=json', nbd_uri)
> diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
> new file mode 100644
> index 0000000000..0d29724e84
> --- /dev/null
> +++ b/tests/qemu-iotests/206.out
> @@ -0,0 +1,2 @@
> +[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true},
> +{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data": false}]

But definite evidence of getting block status over NBD! Progress!

And kudos for producing an .out file that I can actually read and 
reproduce without the aid of python (in contrast to the more 
"unit-test"-y ones like 205, where we had a big long side-discussion 
about that. No need to repeat it here).

> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index a2dfe79d86..2c3925566a 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -202,3 +202,4 @@
>   203 rw auto
>   204 rw auto quick
>   205 rw auto quick
> +206 rw auto quick
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
