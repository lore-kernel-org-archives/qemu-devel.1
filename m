Received: from eggs.gnu.org ([2001:4830:134:3::10]:58518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eluCw-0007S5-Dz
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eluCr-0000gv-Bs
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:22:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eluCr-0000gf-7n
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:22:29 -0500
Date: Wed, 14 Feb 2018 10:22:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180214102210.GA5131@work-vm>
References: <20180206163039.23661-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206163039.23661-1-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] migration/xen: Check return value of
 qemu_fclose
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Ross Lagerwall (ross.lagerwall@citrix.com) wrote:
> QEMUFile uses buffered IO so when writing small amounts (such as the Xen
> device state file), the actual write call and any errors that may occur
> only happen as part of qemu_fclose(). Therefore, report IO errors when
> saving the device state under Xen by checking the return value of
> qemu_fclose().
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Queued.

> ---
>  migration/savevm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b7908f6..4b9d5be 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2267,8 +2267,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
>      f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
>      ret = qemu_save_device_state(f);
> -    qemu_fclose(f);
> -    if (ret < 0) {
> +    if (ret < 0 || qemu_fclose(f) < 0) {
>          error_setg(errp, QERR_IO_ERROR);
>      } else {
>          /* libxl calls the QMP command "stop" before calling
> -- 
> 2.9.5
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
