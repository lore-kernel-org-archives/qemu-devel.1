Received: from eggs.gnu.org ([2001:4830:134:3::10]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVSUL-0002pv-69
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVSUG-0006ZY-9e
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:00:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVSUF-0006Yv-UO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:00:12 -0400
Date: Thu, 13 Jul 2017 04:00:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713034755-mutt-send-email-mst@kernel.org>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499847753-8513-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
> We don't want to carry along old machine types forever. If we are able to
> remove the pc machines up to 0.13 one day for example, this would allow
> us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
> BARs directly to low memory). Everything up to pc-1.2 is also known to
> have issues with migration.  So let's start with a deprecation message
> for the old machine types so that the (hopefully) few users of these old
> systems start switching over to newer machine types instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Even if we mark all these old machines as deprecated, this ofcourse
>  doesn't mean that we also have to remove them all at once later when we
>  decide to finally really remove some. We could then also start by removing
>  0.10 and 0.11 only, for example (since there should really be no users left
>  for these), or only up to 0.13 (to be able to kill rombar=0).

So I generally think the main issue is that machine types are conflating
two things. One is saying "I want to be able to migrate from/to QEMU X".
Another is saying "I want to look to guests as if I am QEMU X
but I restart gurst on the new QEMU".

First is generally a superset of the second, but only a subset of
users needs the first. And while there's a very good chance we
are actually pretty close to supporting the second even for very
old machine types, I doubt we are actually able to migrate to/from
these old QEMU versions since it is so hard to test.

So IMHO, a more significant step with a long term impact would be to
support splitting these things up.



>  v3:
>  - Use a more generic approach by introducing a "deprecation_msg" in the
>    MachineClass instead.
> 
>  v2:
>  - Deprecate machines up to pc-1.2
> 
>  hw/i386/pc_piix.c   | 1 +
>  include/hw/boards.h | 1 +
>  vl.c                | 4 ++++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 22dbef6..8e70308 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -707,6 +707,7 @@ static void pc_i440fx_1_2_machine_options(MachineClass *m)
>  {
>      pc_i440fx_1_3_machine_options(m);
>      m->hw_version = "1.2.0";
> +    m->deprecation_msg = "Please use a newer machine type instead.";
>      SET_MACHINE_COMPAT(m, PC_COMPAT_1_2);
>  }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 76ce021..42a0264 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -112,6 +112,7 @@ struct MachineClass {
>      char *name;
>      const char *alias;
>      const char *desc;
> +    const char *deprecation_msg;
>  
>      void (*init)(MachineState *state);
>      void (*reset)(void);
> diff --git a/vl.c b/vl.c
> index f7560de..0058d41 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4115,6 +4115,10 @@ int main(int argc, char **argv, char **envp)
>      replay_configure(icount_opts);
>  
>      machine_class = select_machine();
> +    if (machine_class->deprecation_msg) {
> +        error_report("Machine type '%s' is deprecated. %s",
> +                     machine_class->name, machine_class->deprecation_msg);
> +    }
>  
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
>  
> -- 
> 1.8.3.1
