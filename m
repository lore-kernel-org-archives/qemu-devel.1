Received: from eggs.gnu.org ([2001:4830:134:3::10]:53027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMvAB-0007iG-50
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMvA7-0005d9-Sx
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:20:27 -0500
Date: Thu, 7 Dec 2017 13:20:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171207132015.786b073b.cohuck@redhat.com>
In-Reply-To: <20171206144438.28908-3-pasic@linux.vnet.ibm.com>
References: <20171206144438.28908-1-pasic@linux.vnet.ibm.com>
	<20171206144438.28908-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x: deprecate s390-squash-mcss
 machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed,  6 Dec 2017 15:44:38 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> With the cssids unrestricted (commit "s390x/css: unrestrict cssids") the
> s390-squash-mcss machine property should not be used.  Actually Libvirt
> never supported this, so the expectation is that removing it should be
> pretty painless.  But let's play nice and deprecate it first.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> v1 -> v2:
> * Moved warning to machine initialization, and made it
>   warn if the command line option is specified
> * Dropped the r-b of Dong Jia because of the change above
> * Dropped machine name from the doc
> ---
>  hw/s390x/s390-virtio-ccw.c | 7 ++++++-
>  qemu-doc.texi              | 8 ++++++++
>  qemu-options.hx            | 8 +++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4d65a50334..91e12f3af9 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -308,6 +308,11 @@ static void ccw_init(MachineState *machine)
>      } else {
>          ret = css_create_css_image(VIRTUAL_CSSID, true);
>      }
> +    if (qemu_opt_get(qemu_get_machine_opts(), "s390-squash-mcss")) {
> +        warn_report("The machine property 's390-squash-mcss' is deprecated"
> +                    " (obsoleted by lifting the cssid restrictions).");
> +    }
> +

Oh, you found a way to make it warn whenever specified? Neat.

>      assert(ret == 0);
>      if (css_migration_enabled()) {
>          css_register_vmstate();
