Received: from eggs.gnu.org ([209.51.188.92]:45506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBCz3-0000MK-BC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBCyx-0000Hw-PF
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBCyw-0000DM-5g
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:33:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190311060823.18360-2-richardw.yang@linux.intel.com>
Date: Tue, 02 Apr 2019 08:33:08 +0200
In-Reply-To: <20190311060823.18360-2-richardw.yang@linux.intel.com> (Wei
	Yang's message of "Mon, 11 Mar 2019 14:08:22 +0800")
Message-ID: <87pnq4hq6z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] vl.c: make find_default_machine() local
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

Wei Yang <richardw.yang@linux.intel.com> writes:

> Function find_default_machine() is introduced by commit 2c8cffa599b7
> "vl: make find_default_machine externally visible", while it seems no
> one outside use it.
It was used outside of vl.c until commit a904410af5f.

> This patch make it local again.

Suggest:

  Commit a904410af5f removed the only user of find_default_machine()
  outside vl.c, but neglected to make it static.  Do that now.

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  include/hw/boards.h | 1 -
>  vl.c                | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 21212f0859..e911d56c28 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -57,7 +57,6 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>  #define MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
>  
> -MachineClass *find_default_machine(void);
>  extern MachineState *current_machine;
>  
>  void machine_run_board_init(MachineState *machine);
> diff --git a/vl.c b/vl.c
> index 502857a176..3688e2bc98 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1441,7 +1441,7 @@ static MachineClass *find_machine(const char *name)
>      return mc;
>  }
>  
> -MachineClass *find_default_machine(void)
> +static MachineClass *find_default_machine(void)
>  {
>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
>      MachineClass *mc = NULL;
> @@ -2538,7 +2538,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>                    object_class_get_name(OBJECT_CLASS(mc1)));
>  }
>  
> - static MachineClass *machine_parse(const char *name)
> +static MachineClass *machine_parse(const char *name)
>  {
>      MachineClass *mc = NULL;
>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);

Not related to this patch's stated purpose.  Should go into PATCH 2,
where you're changing this line anyway.
