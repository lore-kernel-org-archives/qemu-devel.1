Received: from eggs.gnu.org ([2001:4830:134:3::10]:53810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ9hR-0003w4-K2
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZ9hO-0003YS-FZ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:17:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZ9hO-0003XB-8v
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:17:18 -0500
Date: Wed, 10 Jan 2018 14:17:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110061711.GA5984@xz-mi>
References: <20180107122336.29333-1-richiejp@f-m.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180107122336.29333-1-richiejp@f-m.fm>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Palethorpe <richiejp@f-m.fm>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com, rpalethorpe@suse.com

On Sun, Jan 07, 2018 at 01:23:35PM +0100, Richard Palethorpe wrote:
> Add QAPI wrapper functions for the existing snapshot functionality. These
> functions behave the same way as the HMP savevm, loadvm and delvm
> commands. This will allow applications, such as OpenQA, to programmatically
> revert the VM to a previous state with no dependence on HMP or qemu-img.
> 
> I used the term snapshot instead of VM because I think it is less ambiguous
> and matches the internal function names.
> 
> Signed-off-by: Richard Palethorpe <richiejp@f-m.fm>
> ---
>  migration/savevm.c | 27 ++++++++++++++++++++++
>  qapi-schema.json   | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b7908f62be..d7bc0f0d41 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2242,6 +2242,11 @@ int save_snapshot(const char *name, Error **errp)
>      return ret;
>  }
>  
> +void qmp_save_snapshot(const char *name, Error **errp)
> +{
> +    save_snapshot(name, errp);
> +}
> +
>  void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>                                  Error **errp)
>  {
> @@ -2404,6 +2409,28 @@ err_drain:
>      return ret;
>  }
>  
> +void qmp_load_snapshot(const char *name, Error **errp)
> +{
> +    int saved_vm_running = runstate_is_running();
> +
> +    vm_stop(RUN_STATE_RESTORE_VM);
> +
> +    if (!load_snapshot(name, errp) && saved_vm_running) {
> +        vm_start();
> +    }
> +}

Hi, Richard,

I think it's good to have, but from interface POV for sure I'll leave
it for maintainers.

For the code, I would prefer at least unify the code instead of
duplicating it.  I think calling qmp_*() functions in hmp_*() would be
good since that's what we do now mostly AFAICT.

Also, comparing to exposing snapshot operations, I am curious about
what would be the difference if we just migrate (which can use QMP) to
a file and then load that file using incoming migration.  Thanks,

-- 
Peter Xu
