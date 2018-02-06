Received: from eggs.gnu.org ([2001:4830:134:3::10]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej1G3-00030A-Vc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej1G0-0000Ft-PD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej1G0-0000FZ-JQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:17:48 -0500
Date: Tue, 6 Feb 2018 11:17:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180206111743.GC2518@work-vm>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-2-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171101142526.1006-2-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] migration: Don't leak IO channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Ross Lagerwall (ross.lagerwall@citrix.com) wrote:
> Since qemu_fopen_channel_{in,out}put take references on the underlying
> IO channels, make sure to release our references to them.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Queued for migration.

Dave

> ---
> New in v2.
> 
>  migration/savevm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4a88228..87557dd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2259,6 +2259,7 @@ void qmp_xen_save_devices_state(const char *filename, Error **errp)
>      }
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
>      f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
> +    object_unref(OBJECT(ioc));
>      ret = qemu_save_device_state(f);
>      qemu_fclose(f);
>      if (ret < 0) {
> @@ -2292,6 +2293,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>      }
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-load-state");
>      f = qemu_fopen_channel_input(QIO_CHANNEL(ioc));
> +    object_unref(OBJECT(ioc));
>  
>      ret = qemu_loadvm_state(f);
>      qemu_fclose(f);
> -- 
> 2.9.5
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
