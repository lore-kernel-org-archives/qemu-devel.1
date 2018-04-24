Received: from eggs.gnu.org ([2001:4830:134:3::10]:46509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fAyDW-0005HG-LW
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fAyDT-0007O3-BD
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:42:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fAyDS-0007NU-VQ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:42:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3ODbeEt017609
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 09:42:41 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hj523agvb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 09:42:39 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 24 Apr 2018 14:41:34 +0100
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
	<1524470305-26484-3-git-send-email-thuth@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 15:41:31 +0200
MIME-Version: 1.0
In-Reply-To: <1524470305-26484-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <13a57e92-10ff-d89c-907b-3e927f6a9f3d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] pc-bios/s390-ccw/net: Add support
 for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 23.04.2018 09:58, Thomas Huth wrote:
[...]
> +
> +static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
> +{
> +    int rc, idx;
> +    char basedir[256];
> +    int has_basedir;
> +
> +    cfgbuf[sizeof(cfgbuf) - 1] = 0;   /* Make sure that it is NUL-terminated */
> +
> +    /* Did we get a usable base directory via DHCP? */
> +    idx = strlen((char *)fn_ip->filename);
> +    if (idx > 0 && idx < sizeof(basedir) - 40 &&
> +        fn_ip->filename[idx - 1] == '/') {
> +        has_basedir = true;
> +        strcpy(basedir, (char *)fn_ip->filename);
> +    } else {
> +        has_basedir = false;
> +        strcpy(basedir, "pxelinux.cfg/");
> +    }
> +
> +    printf("Trying pxelinux.cfg files...\n");
> +
> +    /* Look for config file with MAC address in its name */
> +    sprintf((char *)fn_ip->filename, "%s%02x-%02x-%02x-%02x-%02x-%02x",
> +            basedir, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
Just noticed that the filename has to be <basedir>/pxelinux.cfg/01-<mac>
per [1].
> +    rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
> +    if (rc > 0) {
> +        return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
> +    }
> +
> +    /* Look for config file with IP address in its name */
> +    if (ip_version == 4) {
> +        for (idx = 0; (has_basedir && idx <= 7) || idx < 1; idx++) {
> +            sprintf((char *)fn_ip->filename, "%s%02X%02X%02X%02X", basedir,
> +                    (fn_ip->own_ip >> 24) & 0xff, (fn_ip->own_ip >> 16) & 0xff,
> +                    (fn_ip->own_ip >> 8) & 0xff, fn_ip->own_ip & 0xff);
> +            fn_ip->filename[strlen((char *)fn_ip->filename) - idx] = 0;
> +            rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
> +            if (rc > 0) {
> +                return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
> +            }
> +        }
> +    }
> +
> +    /* Try "default" config file */
> +    if (has_basedir) {
> +        sprintf((char *)fn_ip->filename, "%sdefault", basedir);
> +        rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
> +        if (rc > 0) {
> +            return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
> +        }
> +    }
> +
> +    return -1;
> +}
> +
[...]

[1
]https://www.syslinux.org/wiki/index.php?title=PXELINUX#Configuration_filename

-- 
Regards,
  Viktor Mihajlovski
