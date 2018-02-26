Received: from eggs.gnu.org ([2001:4830:134:3::10]:53569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqIK0-0002zF-6q
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqIJy-0004Jb-Oq
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:56:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eqIJy-0004JD-Hl
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:55:58 -0500
Date: Mon, 26 Feb 2018 13:55:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180226135549.34af5dbf@redhat.com>
In-Reply-To: <ED26CBA2FAD1BF48A8719AEF02201E365144EAAB@SHSMSX103.ccr.corp.intel.com>
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
	<20180207130635.4033f8b8@redhat.com>
	<8474af94-7bff-a7b5-e316-b8a0e332467e@intel.com>
	<20180208105111.7a776513@redhat.com>
	<53186984-2111-ed5e-0d47-65db12f22ea3@intel.com>
	<20180208123018.5b3c9da7@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E365144EAAB@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On Sat, 24 Feb 2018 03:11:30 +0000
"Tan, Jianfeng" <jianfeng.tan@intel.com> wrote:

> > -----Original Message-----
> > From: Tan, Jianfeng
> > Sent: Saturday, February 24, 2018 11:08 AM
> > To: 'Igor Mammedov'
> > Cc: Paolo Bonzini; Jason Wang; Maxime Coquelin; qemu-devel@nongnu.org;
> > Michael S . Tsirkin
> > Subject: RE: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
> > migration
> > 
> > Hi Igor and all,
> >   
> > > -----Original Message-----
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: Thursday, February 8, 2018 7:30 PM
> > > To: Tan, Jianfeng
> > > Cc: Paolo Bonzini; Jason Wang; Maxime Coquelin; qemu-  
> > devel@nongnu.org;  
> > > Michael S . Tsirkin
> > > Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
> > > migration
> > >  
> > [...]  
> > > > > It could be solved by adding memdev option to machine,
> > > > > which would allow to specify backend object. And then on
> > > > > top make -mem-path alias new option to clean thing up.  
> > > >
> > > > Do you mean?
> > > >
> > > > src vm: -m xG
> > > > dst vm: -m xG,memdev=pc.ram -object memory-backend-  
> > file,id=pc.ram,size=xG,mem-path=xxx,share=on ...  
> > > Yep, I've meant something like it
> > >
> > > src vm: -m xG,memdev=SHARED_RAM -object memory-backend-  
> > file,id=SHARED_RAM,size=xG,mem-path=xxx,share=on  
> > > dst vm: -m xG,memdev=SHARED_RAM -object memory-backend-  
> > file,id=SHARED_RAM,size=xG,mem-path=xxx,share=on
> > 
> > After a second thought, I find adding a backend for nonnuma pc RAM is
> > roundabout way.
> > 
> > And we actually have an existing way to add a file-backed RAM: commit
> > c902760fb25f ("Add option to use file backed guest memory"). Basically, this
> > commit adds two options, --mem-path and --mem-prealloc, without specify
> > a backend explicitly.
> > 
> > So how about just adding a new option --mem-share to decide if that's a
> > private memory or shared memory? That seems much straightforward way
Above options are legacy (which we can't remove for compat reasons),
their replacement is 'memory-backend-file' backend which has all of
the above including 'share' property.

So just add 'memdev' property to machine and reuse memory-backend-file
with it instead of duplicating functionality in the legacy code.

> > to me; after this change we can migrate like:
> > 
> > src vm: -m xG
> > dst vm: -m xG --mem-path xxx --mem-share
Even though it might work for now, that's still invalid configuration
for migration, src side must include the same
  "--mem-path xxx --mem-share"
options as dst.

It'd be better to fix management application to start QEMU
properly on SRC side.

 
> Attach the patch FYI. Look forward to your thoughts.
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 31612ca..5eaf367 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -127,6 +127,7 @@ extern bool enable_mlock;
>  extern uint8_t qemu_extra_params_fw[2];
>  extern QEMUClockType rtc_clock;
>  extern const char *mem_path;
> +extern int mem_share;
>  extern int mem_prealloc;
>  
>  #define MAX_NODES 128
> diff --git a/numa.c b/numa.c
> index 7b9c33a..322289f 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -456,7 +456,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>      if (mem_path) {
>  #ifdef __linux__
>          Error *err = NULL;
> -        memory_region_init_ram_from_file(mr, owner, name, ram_size, false,
> +        memory_region_init_ram_from_file(mr, owner, name, ram_size, mem_share,
>                                           mem_path, &err);
>          if (err) {
>              error_report_err(err);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 678181c..c968c53 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -389,6 +389,15 @@ STEXI
>  Allocate guest RAM from a temporarily created file in @var{path}.
>  ETEXI
>  
> +DEF("mem-share", 0, QEMU_OPTION_memshare,
> +    "-mem-share   make guest memory shareable (use with -mem-path)\n",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -mem-share
> +@findex -mem-share
> +Make file-backed guest RAM shareable when using -mem-path.
> +ETEXI
> +
>  DEF("mem-prealloc", 0, QEMU_OPTION_mem_prealloc,
>      "-mem-prealloc   preallocate guest memory (use with -mem-path)\n",
>      QEMU_ARCH_ALL)
> diff --git a/vl.c b/vl.c
> index 444b750..0ff06c2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -140,6 +140,7 @@ int display_opengl;
>  const char* keyboard_layout = NULL;
>  ram_addr_t ram_size;
>  const char *mem_path = NULL;
> +int mem_share = 0;
>  int mem_prealloc = 0; /* force preallocation of physical target memory */
>  bool enable_mlock = false;
>  int nb_nics;
> @@ -3395,6 +3396,9 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_mempath:
>                  mem_path = optarg;
>                  break;
> +            case QEMU_OPTION_memshare:
> +                mem_share = 1;
> +                break;
>              case QEMU_OPTION_mem_prealloc:
>                  mem_prealloc = 1;
>                  break;
