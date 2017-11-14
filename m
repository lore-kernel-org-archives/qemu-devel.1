Received: from eggs.gnu.org ([2001:4830:134:3::10]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eETHH-0003ow-MB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eETHD-0002Bi-GS
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:56:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eETHD-0002Au-7j
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:56:47 -0500
Date: Tue, 14 Nov 2017 12:56:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171114045642.GB6821@xz-mi>
References: <20171113183517.890-1-danielhb@linux.vnet.ibm.com>
	<20171113183517.890-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171113183517.890-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] migration/ram.c: do not set
 'postcopy_running' in POSTCOPY_INCOMING_END
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com, quintela@redhat.com

On Mon, Nov 13, 2017 at 04:35:17PM -0200, Daniel Henrique Barboza wrote:
> When migrating a VM with 'migrate_set_capability postcopy-ram on'
> a postcopy_state is set during the process, ending up with the
> state POSTCOPY_INCOMING_END when the migration is over. This
> postcopy_state is taken into account inside ram_load to check
> how it will load the memory pages. This same ram_load is called when
> in a loadvm command.
> 
> Inside ram_load, the logic to see if we're at postcopy_running state
> is:
> 
> postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING
> 
> postcopy_state_get() returns this enum type:
> 
> typedef enum {
>     POSTCOPY_INCOMING_NONE = 0,
>     POSTCOPY_INCOMING_ADVISE,
>     POSTCOPY_INCOMING_DISCARD,
>     POSTCOPY_INCOMING_LISTENING,
>     POSTCOPY_INCOMING_RUNNING,
>     POSTCOPY_INCOMING_END
> } PostcopyState;
> 
> In the case where ram_load is executed and postcopy_state is
> POSTCOPY_INCOMING_END, postcopy_running will be set to 'true' and
> ram_load will behave like a postcopy is in progress. This scenario isn't
> achievable in a migration but it is reproducible when executing
> savevm/loadvm after migrating with 'postcopy-ram on', causing loadvm
> to fail with Error -22:
> 
> Source:
> 
> (qemu) migrate_set_capability postcopy-ram on
> (qemu) migrate tcp:127.0.0.1:4444
> 
> Dest:
> 
> (qemu) migrate_set_capability postcopy-ram on
> (qemu)
> ubuntu1704-intel login:
> Ubuntu 17.04 ubuntu1704-intel ttyS0
> 
> ubuntu1704-intel login: (qemu)
> (qemu) savevm test1
> (qemu) loadvm test1
> Unknown combination of migration flags: 0x4 (postcopy mode)
> error while loading state for instance 0x0 of device 'ram'
> Error -22 while loading VM state
> (qemu)
> 
> This patch fixes this problem by changing the existing logic for
> postcopy_advised and postcopy_running in ram_load, making them
> 'false' if we're at POSTCOPY_INCOMING_END state.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  migration/ram.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 8620aa400a..021d583b9b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2798,6 +2798,18 @@ static int ram_load_postcopy(QEMUFile *f)
>      return ret;
>  }
>  
> +static bool postcopy_is_advised(void)
> +{
> +    PostcopyState ps = postcopy_state_get();
> +    return ps >= POSTCOPY_INCOMING_ADVISE && ps < POSTCOPY_INCOMING_END;
> +}
> +
> +static bool postcopy_is_running(void)
> +{
> +    PostcopyState ps = postcopy_state_get();
> +    return ps >= POSTCOPY_INCOMING_LISTENING && ps < POSTCOPY_INCOMING_END;
> +}
> +

If there is a new version, maybe we can put these into
postcopy-ram.c.  But may not worth a repost since after all we have
postcopy helpers in ram.c already.

Reviewed-by: Peter Xu <peterx@redhat.com>

>  static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  {
>      int flags = 0, ret = 0, invalid_flags = 0;
> @@ -2807,9 +2819,9 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>       * If system is running in postcopy mode, page inserts to host memory must
>       * be atomic
>       */
> -    bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
> +    bool postcopy_running = postcopy_is_running();
>      /* ADVISE is earlier, it shows the source has the postcopy capability on */
> -    bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
> +    bool postcopy_advised = postcopy_is_advised();
>  
>      seq_iter++;
>  
> -- 
> 2.13.6
> 

-- 
Peter Xu
