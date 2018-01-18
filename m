Received: from eggs.gnu.org ([2001:4830:134:3::10]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=549912947=ross.lagerwall@citrix.com>)
	id 1ecARa-0002iR-AG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=549912947=ross.lagerwall@citrix.com>)
	id 1ecARW-0001Vx-RU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:41:26 -0500
Received: from smtp.citrix.com ([66.165.176.89]:45348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=549912947=ross.lagerwall@citrix.com>)
	id 1ecARW-0001Vf-Kz
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:41:22 -0500
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-2-ross.lagerwall@citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <7645692e-d298-8742-c283-4a145a6ace7b@citrix.com>
Date: Thu, 18 Jan 2018 13:41:20 +0000
MIME-Version: 1.0
In-Reply-To: <20171101142526.1006-2-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] migration: Don't leak IO channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 11/01/2017 02:25 PM, Ross Lagerwall wrote:
> Since qemu_fopen_channel_{in,out}put take references on the underlying
> IO channels, make sure to release our references to them.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
> New in v2.
> 
>   migration/savevm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4a88228..87557dd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2259,6 +2259,7 @@ void qmp_xen_save_devices_state(const char *filename, Error **errp)
>       }
>       qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
>       f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
> +    object_unref(OBJECT(ioc));
>       ret = qemu_save_device_state(f);
>       qemu_fclose(f);
>       if (ret < 0) {
> @@ -2292,6 +2293,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>       }
>       qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-load-state");
>       f = qemu_fopen_channel_input(QIO_CHANNEL(ioc));
> +    object_unref(OBJECT(ioc));
>   
>       ret = qemu_loadvm_state(f);
>       qemu_fclose(f);
> 

Ping for review...

Thanks,
-- 
Ross Lagerwall
