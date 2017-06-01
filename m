Received: from eggs.gnu.org ([2001:4830:134:3::10]:49856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dGOmG-0007d3-O6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dGOmC-00006x-T2
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:00:32 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dGOmC-00005U-OQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:00:28 -0400
Received: by mail-it0-x242.google.com with SMTP id 67so5630461itx.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:00:27 -0700 (PDT)
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <14af6adf-9076-1368-75bb-8001ed667150@gmail.com>
Date: Thu, 1 Jun 2017 20:00:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170526023213.18741-1-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RESEND PATCH 1/2] nvdimm: warn if the backend is
 not a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>



On 05/26/2017 10:32 AM, Haozhong Zhang wrote:

> +static void nvdimm_check_dax(HostMemoryBackend *hostmem)
> +{
> +    char *mem_path =
> +        object_property_get_str(OBJECT(hostmem), "mem-path", NULL);
> +    char *dev_name = NULL, *sysfs_path = NULL;
> +    bool is_dax = false;
> +
> +    if (!mem_path) {
> +        goto out;
> +    }
> +
> +    if (!g_str_has_prefix(mem_path, "/dev/dax")) {
> +        goto out;
> +    }
> +
> +    dev_name = mem_path + strlen("/dev/");
> +    sysfs_path = g_strdup_printf("/sys/class/dax/%s", dev_name);
> +    if (access(sysfs_path, F_OK)) {
> +        goto out;
> +    }
> +
> +    is_dax = true;
> +

So only dax raw disk has write-persistence guaranty， a pre-allocated
file which locates on a DAX-enabled filesystem can not?
