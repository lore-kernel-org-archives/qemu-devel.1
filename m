Received: from eggs.gnu.org ([2001:4830:134:3::10]:53433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkUx-0005ey-K9
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkUt-00041c-0U
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:04:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fFkUs-00041R-Sv
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:04:26 -0400
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
Date: Mon, 7 May 2018 13:04:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180507033214.19219-2-zyimin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, fiuczy@linux.ibm.com, jtomko@redhat.com, borntraeger@de.ibm.com, jferlan@redhat.com

On 05/06/2018 10:32 PM, Yi Min Zhao wrote:

In the subject line: s/avoid to compile/avoid compiling/

> If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remains

s/elevator/elevate/

> complied. This would make libvirt set the corresponding capability and

s/complied/compiled/

> then trigger the guest startup fails. So let's wrap the options with
> CONFIG_SECCOMP.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> ---
>   vl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index fce1fd12d8..cb07b19c02 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts = {
>               .name = "enable",
>               .type = QEMU_OPT_BOOL,
>           },
> +#ifdef CONFIG_SECCOMP
>           {
>               .name = "obsolete",
>               .type = QEMU_OPT_STRING,
> @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts = {
>               .name = "resourcecontrol",
>               .type = QEMU_OPT_STRING,
>           },
> +#endif

The commit message mentions only 'elevateprivileges' (once the typo is 
fixed), but you are also crippling 'obsolete', 'spawn', and 
'resourcecontrol'.  Perhaps the commit message should call that out 
better?  Or, since libvirt is looking at just 'elevateprivileges', per 
this line in libvirt's qemu_capabilities.c:

src/qemu/qemu_capabilities.c:    { "sandbox", "elevateprivileges", 
QEMU_CAPS_SECCOMP_BLACKLIST },

is it sufficient to just mask out that one option?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
