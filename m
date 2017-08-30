Received: from eggs.gnu.org ([2001:4830:134:3::10]:41469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn3kU-00086T-21
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn3kP-0003gi-P3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:13:41 -0400
Date: Wed, 30 Aug 2017 16:13:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170830161327.4b199e9a.cohuck@redhat.com>
In-Reply-To: <1504100343-26607-1-git-send-email-thuth@redhat.com>
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 30 Aug 2017 15:39:03 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The "slow" ivshmem-tests currently fail when they are running on a
> big endian host:
> 
> $ uname -m
> ppc64
> $ V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/ivshmem-test -m slow
> /x86_64/ivshmem/single: OK
> /x86_64/ivshmem/hotplug: OK
> /x86_64/ivshmem/memdev: OK
> /x86_64/ivshmem/pair: OK
> /x86_64/ivshmem/server-msi: qemu-system-x86_64:
>  -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
> Broken pipe
> 
> The problem is that the server side code in ivshmem_server_send_one_msg()
> correctly translates all messages IDs into little endian 64-bit values,
> but the client side code in the ivshmem_recv_msg() function does not swap
> the byte order back. Fix it by passing the value through le64_to_cpu().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/misc/ivshmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 47a015f..b3ef3ec 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -653,7 +653,7 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int *pfd, Error **errp)
>      } while (n < sizeof(msg));
>  
>      *pfd = qemu_chr_fe_get_msgfd(&s->server_chr);
> -    return msg;
> +    return le64_to_cpu(msg);
>  }
>  
>  static void ivshmem_recv_setup(IVShmemState *s, Error **errp)

This fixes the "invalid ID message" problem on s390x for me as well,
and I run now into the same error as on x86 (which you also have a fix
for IIRC), so I guess this is

Tested-by: Cornelia Huck <cohuck@redhat.com>
