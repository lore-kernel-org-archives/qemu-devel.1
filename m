Received: from eggs.gnu.org ([2001:4830:134:3::10]:55741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cFIVm-0004RR-Nc
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 05:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cFIVi-0000CZ-RP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 05:34:42 -0500
Date: Fri, 9 Dec 2016 10:34:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161209103430.GE2066@work-vm>
References: <1481224870-18247-1-git-send-email-duanj@linux.vnet.ibm.com>
	<1481224870-18247-5-git-send-email-duanj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481224870-18247-5-git-send-email-duanj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v16 4/4] migration: add error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jianjun Duan <duanj@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dmitry@daynix.com, peter.maydell@linaro.org, kraxel@redhat.com, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, veroniabahaa@gmail.com, quintela@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, rth@twiddle.net, aurelien@aurel32.net, leon.alrae@imgtec.com, blauwirbel@gmail.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com

* Jianjun Duan (duanj@linux.vnet.ibm.com) wrote:
> Added error_report where version_ids do not match in vmstate_load_state.
> 
> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>

Thanks,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/vmstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 2f9d4ba..8ddd230 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -85,6 +85,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      trace_vmstate_load_state(vmsd->name, version_id);
>      if (version_id > vmsd->version_id) {
> +        error_report("%s: incoming version_id %d is too new "
> +                     "for local version_id %d",
> +                     vmsd->name, version_id, vmsd->version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>          return -EINVAL;
>      }
> @@ -95,6 +98,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>              trace_vmstate_load_state_end(vmsd->name, "old path", ret);
>              return ret;
>          }
> +        error_report("%s: incoming version_id %d is too old "
> +                     "for local minimum version_id  %d",
> +                     vmsd->name, version_id, vmsd->minimum_version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
