Received: from eggs.gnu.org ([2001:4830:134:3::10]:43227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d17p4-00065h-TT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d17p4-0004KY-0I
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:52:18 -0400
MIME-Version: 1.0
In-Reply-To: <1492677526-4739-1-git-send-email-lidongchen@tencent.com>
References: <1492677526-4739-1-git-send-email-lidongchen@tencent.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 20 Apr 2017 16:52:16 +0800
Message-ID: <CAOGPPbc=BC6LF4j0tRay+sjyDAHJ=NNXjKnzdVjsOE8WMPbyCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu-img: use blk_co_pwrite_zeroes for
 zero sectors when compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, qemu block <qemu-block@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 20, 2017 at 4:38 PM,  <jemmy858585@gmail.com> wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>
> when the buffer is zero, blk_co_pwrite_zeroes is more effectively than
> blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. this patch can reduces
> the time when converts the qcow2 image with lots of zero.
>

the original qcow2 file which have lots of cluster unallocated:
[root]# qemu-img info /mnt/img2016111016860868_old.qcow2
image: /mnt/img2016111016860868_old.qcow2
file format: qcow2
virtual size: 20G (21474836480 bytes)
disk size: 214M (224460800 bytes)
cluster_size: 65536
backing file: /baseimage/img2015122818606660/img2015122818606660.qcow2

the time used for qemu-img convert:
[root ~]# time /root/kvm/bin/qemu-img convert -c -p -o
backing_file=/baseimage/img2015122818606660/img2015122818606660.qcow2
-O
qcow2 /mnt/img2016111016860868.qcow2 /mnt/img2016111016860868_old.qcow2
    (100.00/100%)
real    0m29.456s
user    0m29.345s
sys     0m0.481s

run dd if=/dev/zero of=./test bs=65536 in guest os
then convert again.

before apply this patch:
[root~]# time /root/kvm/bin/qemu-img convert -c -p -o
backing_file=/baseimage/img2015122818606660/img2015122818606660.qcow2
-O qcow2 /mnt/img2016111016860868.qcow2 /mnt/img2016111016860868_new.qcow2
    (100.00/100%)

real    5m35.617s
user    5m33.417s
sys     0m10.699s

after apply this patch:
[root~]# time /root/kvm/bin/qemu-img convert -c -p -o
backing_file=/baseimage/img2015122818606660/img2015122818606660.qcow2
-O
qcow2 /mnt/img2016111016860868.qcow2 /mnt/img2016111016860868_new1.qcow2
    (100.00/100%)

real    0m51.189s
user    0m35.239s
sys     0m14.251s

the time reduce from 5m35.617s to 0m51.189s.

[root ]# ll /mnt/img2016111016860868* -h
-rw-r--r-- 1 root root 254M Apr 20 14:50 /mnt/img2016111016860868_new.qcow2
-rw-r--r-- 1 root root 232M Apr 20 15:27 /mnt/img2016111016860868_new1.qcow2

the size reduce from 254M to 232M.

> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  qemu-img.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf7..0256539 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1675,13 +1675,20 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>               * write if the buffer is completely zeroed and we're allowed to
>               * keep the target sparse. */
>              if (s->compressed) {
> -                if (s->has_zero_init && s->min_sparse &&
> -                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
> -                {
> -                    assert(!s->target_has_backing);
> -                    break;
> +                if (buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)) {
> +                    if (s->has_zero_init && s->min_sparse) {
> +                        assert(!s->target_has_backing);
> +                        break;
> +                    } else {
> +                        ret = blk_co_pwrite_zeroes(s->target,
> +                                           sector_num << BDRV_SECTOR_BITS,
> +                                           n << BDRV_SECTOR_BITS, 0);
> +                        if (ret < 0) {
> +                            return ret;
> +                        }
> +                        break;
> +                    }
>                  }
> -
>                  iov.iov_base = buf;
>                  iov.iov_len = n << BDRV_SECTOR_BITS;
>                  qemu_iovec_init_external(&qiov, &iov, 1);
> --
> 1.8.3.1
>
