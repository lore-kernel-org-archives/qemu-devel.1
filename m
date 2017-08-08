Received: from eggs.gnu.org ([2001:4830:134:3::10]:58720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df5XR-00077L-4A
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df5XP-0007nN-UJ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:31:17 -0400
Date: Tue, 8 Aug 2017 15:31:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808143101.GJ2081@work-vm>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-8-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502117160-24655-8-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 07/56] cpus: Make memsave,
 pmemsave sizes, addresses unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Sizes, virtual and physical addresses should use QAPI type 'size'
> (uint64_t).  memsave, pmemsave parameters @val, @size are 'int'
> (int64_t).  qmp_memsave() and qmp_pmemsave() implicitly convert to
> target_ulong or hwaddr.
> 
> Change the parameters to 'size'.
> 
> Both commands now accept size and address values between 2^63 and
> 2^64-1.  They accept negative values as before, because that's how the
> QObject input visitor works for backward compatibility.
> 
> The HMP commands' size parameters remain uint32_t, as HMP args_type
> strings can't do uint64_t byte counts: 'l' is signed, and 'o'
> multiplies by 2^20.  Their address parameters remain int64_t for the
> same reason.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  cpus.c           | 6 +++---
>  qapi-schema.json | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 9bed61e..8c5ee05 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1947,14 +1947,14 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>      return head;
>  }
>  
> -void qmp_memsave(int64_t addr, int64_t size, const char *filename,
> +void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
>                   bool has_cpu, int64_t cpu_index, Error **errp)
>  {
>      FILE *f;
>      uint32_t l;
>      CPUState *cpu;
>      uint8_t buf[1024];
> -    int64_t orig_addr = addr, orig_size = size;
> +    uint64_t orig_addr = addr, orig_size = size;
>  
>      if (!has_cpu) {
>          cpu_index = 0;

a little bit further down is a:
            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
                             " specified", orig_addr, orig_size);

that PRId64 should be a PRIu64 now

However, other than that;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> @@ -1994,7 +1994,7 @@ exit:
>      fclose(f);
>  }
>  
> -void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
> +void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
>                    Error **errp)
>  {
>      FILE *f;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f4a71df..80458fa 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2460,7 +2460,8 @@
>  #
>  ##
>  { 'command': 'memsave',
> -  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
> +  'data': {'val': 'size', 'size': 'size', 'filename': 'str',
> +           '*cpu-index': 'int'} }
>  
>  ##
>  # @pmemsave:
> @@ -2489,7 +2490,7 @@
>  #
>  ##
>  { 'command': 'pmemsave',
> -  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> +  'data': {'val': 'size', 'size': 'size', 'filename': 'str'} }
>  
>  ##
>  # @cont:
> -- 
> 2.7.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
