Received: from eggs.gnu.org ([2001:4830:134:3::10]:51186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmCQ-0002yI-PQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmCQ-0006o6-1S
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:50:50 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0b3fab9-15a0-a475-2445-1ead89436317@redhat.com>
Date: Tue, 13 Mar 2018 10:50:37 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] iotests: new test 209 for NBD
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

On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 


> +
> +iotests.verify_image_format(supported_fmts=['qcow2'])

Interesting that './check -nbd' doesn't run 209 (because that defaults 
to format -raw, but we need format -qcow2), but './check -nbd' and 
'./check -qcow2 -nbd' do run it, so I've tested that it passes, and is 
quick.

> +
> +disk, nbd_sock = file_path('disk', 'nbd-sock')
> +nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
> +
> +qemu_img_create('-f', iotests.imgfmt, disk, '1M')
> +qemu_io('-f', iotests.imgfmt, '-c', 'write 0 512K', disk)
> +
> +qemu_nbd('-k', nbd_sock, '-x', 'exp', '-f', iotests.imgfmt, disk)
> +qemu_img_verbose('map', '-f', 'raw', '--output=json', nbd_uri)

And this one is easy enough to reproduce, whether I use shell or python. 
  (Better than some of the python iotests that just have a line of 
'.....' where you have to scratch your head at how to reproduce failures).

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qemu-iotests/group
> @@ -202,3 +202,4 @@
>   203 rw auto
>   204 rw auto quick
>   205 rw auto quick
> +209 rw auto quick

the obvious context conflict as other tests land into master, but I 
don't mind that ;)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
