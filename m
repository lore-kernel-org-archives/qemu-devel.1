Received: from eggs.gnu.org ([209.51.188.92]:52755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gyfJH-0004dc-Ov
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gyfJD-0004Pe-Ph
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:10:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gyfJB-0004JJ-PO
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:10:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so15494901qtb.4
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:10:10 -0800 (PST)
Date: Tue, 26 Feb 2019 11:10:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190226110934-mutt-send-email-mst@kernel.org>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226073159.13434-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, somlo@cmu.edu

On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
> to define the attribute.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 039e0f91dba8..a1293cbd7adb 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
> +			       char *buf)
>  {
>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>  }
> -
> -static const struct {
> -	struct attribute attr;
> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> -} fw_cfg_rev_attr = {
> -	.attr = { .name = "rev", .mode = S_IRUSR },
> -	.show = fw_cfg_showrev,
> -};
> +static const struct kobj_attribute fw_cfg_rev_attr =
> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>  
>  /* fw_cfg_sysfs_entry type */
>  struct fw_cfg_sysfs_entry {


Looks like this will change the name from "rev" to "fw_cfg_rev".
That's a userspace visible change which we should not do lightly.
> -- 
> 2.19.1
