Received: from eggs.gnu.org ([2001:4830:134:3::10]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSV9X-0007xD-Tz
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSV9S-00058v-Mw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSV9S-00058M-DP
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:19:02 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A16F8762C
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 22:19:01 +0000 (UTC)
Date: Mon, 11 Jun 2018 19:18:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611221859.GE7451@localhost.localdomain>
References: <1528688464-17289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528688464-17289-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Mon, Jun 11, 2018 at 05:41:04AM +0200, Thomas Huth wrote:
> The oldest machine type which is still used in a maintained distribution
> is a pc-0.12 based machine type in RHEL6, so everything that is older
> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
> and pc-0.11 so that we can finally remove them in a future release.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  This is based on a patch that I already sent in 2017. But back then, we
>  were still in progress of discussing our deprecation policies (e.g. auto-
>  matic deprecation for old machine types), and there was no clear consensus
>  whether we should deprecate 0.10 - 0.11, all 0.x or even up to version 1.2.
>  After some iterations and too much discussion, I've forgotten about this
>  patch. Anyway, I think we agreed that at least 0.10 and 0.11 can certainly
>  be removed nowadays, so let's finally get at least those two machine types
>  marked as deprecated! If that works fine and we will finally have removed
>  these two types in v3.2, we can resume the discussion about newer machine
>  types afterwards.

Thanks!


>  
>  hw/i386/pc_piix.c   | 2 ++
>  include/hw/boards.h | 1 +
>  qemu-doc.texi       | 5 +++++
>  vl.c                | 9 +++++++--
>  4 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3d81136..fa61dc3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -955,6 +955,8 @@ static void pc_i440fx_0_11_machine_options(MachineClass *m)
>  {
>      pc_i440fx_0_12_machine_options(m);
>      m->hw_version = "0.11";
> +    m->deprecation_msg = "Old and unsupported machine version, "
> +                         "use a newer machine type instead.";

Sounds simple enough to me, but see comment about QMP below.


>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
>  }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef7457f..e1bd25f 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -166,6 +166,7 @@ struct MachineClass {
>      char *name;
>      const char *alias;
>      const char *desc;
> +    const char *deprecation_msg;

Let's document guidelines for deprecation_msg to avoid the
inconsistencies we saw in previous proposals?


>  
>      void (*init)(MachineState *state);
>      void (*reset)(void);
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 2effe66..2a597d6 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2965,6 +2965,11 @@ support page sizes < 4096 any longer.
>  
>  @section System emulator machines
>  
> +@subsection pc-0.10 and pc-0.11 (since 3.0)
> +
> +These machine types are very old and likely can not be used for life-migration
                                                                   ^^^^
"live"

I never know if the right way to spell it is "live-migration" or
"live migration".


> +from old QEMU versions anymore. A newer machine type should be used instead.
> +
>  @section Block device options
>  
>  @subsection "backing": "" (since 2.12.0)
> diff --git a/vl.c b/vl.c
> index 0603171..096814c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2560,8 +2560,9 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>              if (mc->alias) {
>                  printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
>              }
> -            printf("%-20s %s%s\n", mc->name, mc->desc,
> -                   mc->is_default ? " (default)" : "");
> +            printf("%-20s %s%s%s\n", mc->name, mc->desc,
> +                   mc->is_default ? " (default)" : "",
> +                   mc->deprecation_msg ? " (deprecated)" : "");
>          }
>      }
>  
> @@ -3952,6 +3953,10 @@ int main(int argc, char **argv, char **envp)
>      }
>  
>      machine_class = select_machine();
> +    if (machine_class->deprecation_msg) {
> +        error_report("Machine type '%s' is deprecated: %s",
> +                     machine_class->name, machine_class->deprecation_msg);
> +    }

Do you plan to add this info to 'query-machines' QMP command?

If we do that, maybe we should represent the common "this machine
type is too old, but there's a new version" case in a more
machine-friendly way?  Maybe a 'deprecation_reason' enum would be
better than a 'deprecation_msg' field?

(Note that I don't think any discussions about the QMP interface
should block this patch from being merged.  We can deprecate the
machines first, and decide about QMP later.)

>  
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
>  
> -- 
> 1.8.3.1
> 

-- 
Eduardo
