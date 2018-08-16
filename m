Received: from eggs.gnu.org ([2001:4830:134:3::10]:40835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqNSm-00076O-68
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqNSh-0006hj-L4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:57:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fqNSh-0006hV-Ej
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:57:35 -0400
Date: Thu, 16 Aug 2018 19:57:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180816185731.GG2664@work-vm>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<08abbfe999a37182099280e20964525d36dd3606.1534409363.git.simon@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08abbfe999a37182099280e20964525d36dd3606.1534409363.git.simon@ruderich.org>
Subject: Re: [Qemu-devel] [PATCH v4 7/7] hmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

* Simon Ruderich (simon@ruderich.org) wrote:
> Adapted patch from Baojun Wang [1] with the following commit message:
> 
>     I found this could be useful to have qemu-softmmu as a cross
>     debugger (launch with -s -S command line option), then if we can
>     have a command to load guest physical memory, we can use cross gdb
>     to do some target debug which gdb cannot do directly.
> 
> This patch contains only the hmp changes of the original patch.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.html
> 
> Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands.hx | 14 ++++++++++++++
>  hmp.c           | 12 ++++++++++++
>  hmp.h           |  1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5715bd7b51..c39d745a22 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -842,6 +842,20 @@ STEXI
>  @item pmemsave @var{addr} @var{size} @var{file}
>  @findex pmemsave
>  save to disk physical memory dump starting at @var{addr} of size @var{size}.
> +ETEXI
> +
> +    {
> +        .name       = "pmemload",
> +        .args_type  = "val:l,size:l,offset:l,filename:F",
> +        .params     = "addr size offset file",
> +        .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
> +        .cmd        = hmp_pmemload,
> +    },
> +
> +STEXI
> +@item pmemload @var{addr} @var{size} @var{offset} @var{file}
> +@findex pmemload
> +load from disk physical memory dump starting at @var{addr} of size @var{size} at file offset @var{offset}.
>  ETEXI
>  
>      {
> diff --git a/hmp.c b/hmp.c
> index 1fb0724107..293e067ed5 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1120,6 +1120,18 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +void hmp_pmemload(Monitor *mon, const QDict *qdict)
> +{
> +    uint64_t size = qdict_get_int(qdict, "size");
> +    uint64_t offset = qdict_get_int(qdict, "offset");
> +    const char *filename = qdict_get_str(qdict, "filename");
> +    uint64_t addr = qdict_get_int(qdict, "val");
> +    Error *err = NULL;
> +
> +    qmp_pmemload(addr, filename, true, size, true, offset, &err);
> +    hmp_handle_error(mon, &err);
> +}
> +
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
>  {
>      const char *chardev = qdict_get_str(qdict, "device");
> diff --git a/hmp.h b/hmp.h
> index 33354f1bdd..f2b2a72a29 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -48,6 +48,7 @@ void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
> +void hmp_pmemload(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
>  void hmp_cont(Monitor *mon, const QDict *qdict);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
