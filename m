Received: from eggs.gnu.org ([209.51.188.92]:36428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpAn-0007mB-RC
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpAk-0002II-Fs
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:05:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gvpAi-0002CO-D4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:05:48 -0500
References: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2cbb158f-a869-e24c-96cc-23f7f61a946b@redhat.com>
Date: Mon, 18 Feb 2019 14:05:35 -0600
MIME-Version: 1.0
In-Reply-To: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: handle TypeError for Python3 in
 test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>

[adding Eduardo for some python 2-vs-3 advice]

On 2/18/19 1:59 PM, Andrey Shinkevich wrote:
> To write one byte to disk, Python2 may use 'chr' type.
> In Python3, conversion to 'byte' type is required.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/242 | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
> index 16c65ed..6b1f7b8 100755
> --- a/tests/qemu-iotests/242
> +++ b/tests/qemu-iotests/242
> @@ -65,9 +65,14 @@ def toggle_flag(offset):
>      with open(disk, "r+b") as f:
>          f.seek(offset, 0)
>          c = f.read(1)
> -        toggled = chr(ord(c) ^ bitmap_flag_unknown)
> +        toggled = ord(c) ^ bitmap_flag_unknown
>          f.seek(-1, 1)
> -        f.write(toggled)
> +        try:
> +            # python2
> +            f.write(chr(toggled))
> +        except TypeError:
> +            # python3
> +            f.write(bytes([toggled]))

Looks like it works, but I'm not enough of a python expert to know if
there is a more Pythonic elegant approach.

If someone else picks it up before my next NBD pull request,
Acked-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
