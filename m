Received: from eggs.gnu.org ([209.51.188.92]:36560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyhjy-0002zS-A1
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyhjx-0002q3-JB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:46:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyhjx-0002W6-8y
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:46:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so15112433wrt.11
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:45:48 -0800 (PST)
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf6ad77d-6514-57b3-141b-530f46500b57@redhat.com>
Date: Tue, 26 Feb 2019 19:45:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190226073159.13434-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, mst@redhat.com

Hi Wei,

On 2/26/19 8:31 AM, Wei Yang wrote:
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

Why not keep S_IRUSR?

>  
>  /* fw_cfg_sysfs_entry type */
>  struct fw_cfg_sysfs_entry {
> 
