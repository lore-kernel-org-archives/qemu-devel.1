Received: from eggs.gnu.org ([2001:4830:134:3::10]:38182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTXXL-0002lU-5Q
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTXXH-000459-Vv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:27:11 -0500
References: <1484666391-15089-1-git-send-email-skiver.cloud.yzy@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c1e01bb3-6dd1-dfe1-1659-8b7b9b683d63@redhat.com>
Date: Tue, 17 Jan 2017 18:27:04 +0100
MIME-Version: 1.0
In-Reply-To: <1484666391-15089-1-git-send-email-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gdbstub.c: fix GDB connection segfault
 caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Ziyue Yang <yzylivezh@hotmail.com>

On 17.01.2017 16:19, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
> 
> This patch is to fix the segmentation fault caused by attaching
> GDB to a QEMU instance initialized with "-M none" option.
> 
> The bug can be reproduced by
> 
>> ./qemu-system-x86_64 -M none -nographic -S -s
> 
> and attach a GDB to it by
> 
>> gdb -ex 'target remote :1234
> 
> The segmentation fault was originally caused by trying to read
> the information about CPU when communicating with GDB. However,
> it's impossible for any control flow to exist on an empty machine,
> nor can CPU's be hot plugged to an empty machine later by QOM
> commands. So I think simply disabling GDB connections on empty
> machines makes sense.

Yes, this sounds like a proper and easy fix for the problem.

> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
> ---
>  gdbstub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index de62d26..413e817 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1731,6 +1731,12 @@ int gdbserver_start(const char *device)
>      CharDriverState *mon_chr;
>      ChardevCommon common = { 0 };
>  
> +    if (!first_cpu) {
> +        fprintf(stderr, "gdbstub: meaningless to attach gdb to a "
> +                "machine without any CPU.\n");
> +        return -1;
> +    }

Could you maybe rather use error_report() instead of fprintf()? I think
that's the preferred way to print out an error in QEMU nowadays.

 Thomas
