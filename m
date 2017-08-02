Received: from eggs.gnu.org ([2001:4830:134:3::10]:44629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dd1Bi-0000fu-5c
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dd1Bd-0004VM-8v
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dd1Bc-0004VB-Vf
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:28:13 -0400
Date: Thu, 3 Aug 2017 00:28:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170803002709-mutt-send-email-mst@kernel.org>
References: <1501663295-18774-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501663295-18774-1-git-send-email-bhumirks@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] firmware: add const to bin_attribute
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, somlo@cmu.edu, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On Wed, Aug 02, 2017 at 02:11:35PM +0530, Bhumika Goyal wrote:
> Add const to bin_attribute structures as they are only passed to the
> functions sysfs_{remove/create}_bin_file. The arguments passed are of
> type const, so declare the structures to be const.
> 
> Done using Coccinelle.
> 
> @m disable optional_qualifier@
> identifier s;
> position p;
> @@
> static struct bin_attribute s@p={...};
> 
> @okay1@
> position p;
> identifier m.s;
> @@
> (
> sysfs_create_bin_file(...,&s@p,...)
> |
> sysfs_remove_bin_file(...,&s@p,...)
> )
> 
> @bad@
> position p!={m.p,okay1.p};
> identifier m.s;
> @@
> s@p
> 
> @change depends on !bad disable optional_qualifier@
> identifier m.s;
> @@
> static
> +const
> struct bin_attribute s={...};
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

For qemu bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge.,

> ---
>  drivers/firmware/dell_rbu.c          | 6 +++---
>  drivers/firmware/dmi-sysfs.c         | 2 +-
>  drivers/firmware/google/gsmi.c       | 2 +-
>  drivers/firmware/google/memconsole.c | 2 +-
>  drivers/firmware/qemu_fw_cfg.c       | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
> index 2f452f1..a771360 100644
> --- a/drivers/firmware/dell_rbu.c
> +++ b/drivers/firmware/dell_rbu.c
> @@ -675,18 +675,18 @@ static ssize_t write_rbu_packet_size(struct file *filp, struct kobject *kobj,
>  	return count;
>  }
>  
> -static struct bin_attribute rbu_data_attr = {
> +static const struct bin_attribute rbu_data_attr = {
>  	.attr = {.name = "data", .mode = 0444},
>  	.read = read_rbu_data,
>  };
>  
> -static struct bin_attribute rbu_image_type_attr = {
> +static const struct bin_attribute rbu_image_type_attr = {
>  	.attr = {.name = "image_type", .mode = 0644},
>  	.read = read_rbu_image_type,
>  	.write = write_rbu_image_type,
>  };
>  
> -static struct bin_attribute rbu_packet_size_attr = {
> +static const struct bin_attribute rbu_packet_size_attr = {
>  	.attr = {.name = "packet_size", .mode = 0644},
>  	.read = read_rbu_packet_size,
>  	.write = write_rbu_packet_size,
> diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
> index d5de6ee..936e656 100644
> --- a/drivers/firmware/dmi-sysfs.c
> +++ b/drivers/firmware/dmi-sysfs.c
> @@ -440,7 +440,7 @@ static ssize_t dmi_sel_raw_read(struct file *filp, struct kobject *kobj,
>  	return find_dmi_entry(entry, dmi_sel_raw_read_helper, &state);
>  }
>  
> -static struct bin_attribute dmi_sel_raw_attr = {
> +static const struct bin_attribute dmi_sel_raw_attr = {
>  	.attr = {.name = "raw_event_log", .mode = 0400},
>  	.read = dmi_sel_raw_read,
>  };
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index c8f169b..1ad29f7 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -508,7 +508,7 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
>  
>  }
>  
> -static struct bin_attribute eventlog_bin_attr = {
> +static const struct bin_attribute eventlog_bin_attr = {
>  	.attr = {.name = "append_to_eventlog", .mode = 0200},
>  	.write = eventlog_write,
>  };
> diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
> index 166f07c..b11a02c 100644
> --- a/drivers/firmware/google/memconsole.c
> +++ b/drivers/firmware/google/memconsole.c
> @@ -33,7 +33,7 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
>  	return memconsole_read_func(buf, pos, count);
>  }
>  
> -static struct bin_attribute memconsole_bin_attr = {
> +static const struct bin_attribute memconsole_bin_attr = {
>  	.attr = {.name = "log", .mode = 0444},
>  	.read = memconsole_read,
>  };
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 0e20116..f254977 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -343,7 +343,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
>  	return count;
>  }
>  
> -static struct bin_attribute fw_cfg_sysfs_attr_raw = {
> +static const struct bin_attribute fw_cfg_sysfs_attr_raw = {
>  	.attr = { .name = "raw", .mode = S_IRUSR },
>  	.read = fw_cfg_sysfs_read_raw,
>  };
> -- 
> 1.9.1
