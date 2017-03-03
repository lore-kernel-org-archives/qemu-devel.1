Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjs2s-00082P-RP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjs2p-0008FI-Nw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:35:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjs2p-0008Eu-Is
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:35:11 -0500
Date: Fri, 3 Mar 2017 15:35:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170303183506.GE2778@thinpad.lan.raisama.net>
References: <1488271971-12624-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488271971-12624-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Print error message
 when using the -kernel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Feb 28, 2017 at 09:52:51AM +0100, Thomas Huth wrote:
> If the user currently tries to use the -kernel parameter, simply nothing
> happens, and the user might get confused that there is nothing loaded
> to memory, but also no error message has been issued. Since there is no
> real generic way to load a kernel on all CPU types (but on some targets,
> the generic loader can be used instead), issue an appropriate error
> message here now to avoid the possible confusion.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to my machine-next branch, but I'm unsure if we should
break soft freeze and include this on 2.9. I will probably hold
it for 2.10.

> ---
>  hw/core/null-machine.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 27c8369..864832d 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -40,6 +40,12 @@ static void machine_none_init(MachineState *mch)
>          memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
>          memory_region_add_subregion(get_system_memory(), 0, ram);
>      }
> +
> +    if (mch->kernel_filename) {
> +        error_report("The -kernel parameter is not supported "
> +                     "(use the generic 'loader' device instead).");
> +        exit(1);
> +    }
>  }
>  
>  static void machine_none_machine_init(MachineClass *mc)
> -- 
> 1.8.3.1
> 

-- 
Eduardo
