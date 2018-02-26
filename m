Received: from eggs.gnu.org ([2001:4830:134:3::10]:45051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqNpx-0007Qj-8n
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqNpu-00034y-4b
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:49:21 -0500
Date: Mon, 26 Feb 2018 19:48:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180226194857.01ce4a8c.cohuck@redhat.com>
In-Reply-To: <1519641757-12396-7-git-send-email-thuth@redhat.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
	<1519641757-12396-7-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL-for-s390x 06/14] s390-ccw: parse and set
 boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 26 Feb 2018 11:42:29 +0100
Thomas Huth <thuth@redhat.com> wrote:

> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> 
> Set boot menu options for an s390 guest and store them in
> the iplb. These options are set via the QEMU command line
> option:
> 
>     -boot menu=on|off[,splash-time=X]
> 
> or via the libvirt domain xml:
> 
>     <os>
>       <bootmenu enable='yes|no' timeout='X'/>
>     </os>
> 
> Where X represents some positive integer representing
> milliseconds.
> 
> Any value set for loadparm will override all boot menu options.
> If loadparm=PROMPT, then the menu will be enabled without a
> timeout.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ipl.h          |  9 +++++++--
>  pc-bios/s390-ccw/iplb.h |  9 +++++++--

Updating the header, but it is not consumed in the bios?

>  3 files changed, 66 insertions(+), 4 deletions(-)

> +static void s390_ipl_set_boot_menu(S390IPLState *ipl)
> +{
> +    QemuOptsList *plist = qemu_find_opts("boot-opts");
> +    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> +    uint8_t *flags = &ipl->qipl.qipl_flags;
> +    uint32_t *timeout = &ipl->qipl.boot_menu_timeout;
> +    const char *tmp;
> +    unsigned long splash_time = 0;
> +
> +    if (!get_boot_device(0)) {
> +        if (boot_menu) {
> +            error_report("boot menu requires a bootindex to be specified for "
> +                         "the IPL device.");
> +        }
> +        return;
> +    }
> +
> +    switch (ipl->iplb.pbt) {
> +    case S390_IPL_TYPE_CCW:
> +        break;
> +    default:
> +        error_report("boot menu is not supported for this device type.");

If I specify both a bootindex for a device and a -kernel parameter, I
get this error message. Looks a tad odd, but not sure how to avoid it.

Also, error_report() should not use trailing punctuation, but we can
fix that up with a follow-on patch.

> +        return;
> +    }
> +
> +    if (!boot_menu) {
> +        return;
> +    }
> +
> +    *flags |= QIPL_FLAG_BM_OPTS_CMD;
> +
> +    tmp = qemu_opt_get(opts, "splash-time");
> +
> +    if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
> +        error_report("splash-time is invalid, forcing it to 0.");
> +        *timeout = 0;
> +        return;
> +    }
> +
> +    if (splash_time > 0xffffffff) {
> +        error_report("splash-time is too large, forcing it to max value.");
> +        *timeout = 0xffffffff;
> +        return;
> +    }
> +
> +    *timeout = cpu_to_be32(splash_time);
> +}
> +
