Received: from eggs.gnu.org ([2001:4830:134:3::10]:35387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHYnC-0002qR-N2
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHYn7-0002km-P9
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:26:34 -0500
Date: Wed, 22 Nov 2017 18:26:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122182624.6d7cfd6e.cohuck@redhat.com>
In-Reply-To: <20171122141832.94779-1-pasic@linux.vnet.ibm.com>
References: <20171122141832.94779-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x: deprecate s390-squash-mcss
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 22 Nov 2017 15:18:32 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> With the cssids unrestricted (commit <COMMIT HERE> "s390x/css: unrestrict

I think you can simply reference the title only. I plan to merge both
in one go.

> cssids") the s390-squash-mcss machine property should not be used.
> Actually libvirt never supported this, so the expectation is that
> removing it should be pretty painless.  But let's play nice and deprecate
> it first.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> I'm not sure about the warnig I generate if 's390-squash-mcss'
> is set to 'on':
> * There is prior art where we don't warn_report but info_report
> (commit 83926ad527) 

Tbh, I don't really care about one or the other.

> * Warning iff specified on the command line regardless of value
> would probably be cleaner. Yet I'm not sure where would I need
> to hook in to do that.

Yeah, I don't see a good way to do that either. OTOH, I don't really
think people set this to false explicitly.

> 
> I would like to reference a commit for "s390x/css: unrestrict cssids"
> which is currently in RFC status on the list.

As said, I'll just merge them in one go. We can reference the commit in
the changelog, though.

There also should be an entry in
https://wiki.qemu.org/Features/LegacyRemoval, and we should update the
advice in
https://wiki.qemu.org/index.php/Features/Channel_I/O_Passthrough.

> ---
>  hw/s390x/s390-virtio-ccw.c | 5 ++++-
>  qemu-doc.texi              | 6 ++++++
>  qemu-options.hx            | 6 +++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 6a57f94197..c71e1d7e55 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -554,6 +554,9 @@ static inline void machine_set_squash_mcss(Object *obj, bool value,
>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>  
>      ms->s390_squash_mcss = value;
> +    if (ms->s390_squash_mcss) {
> +        warn_report("the machine property 's390-squash-mcss' is deprecated");

s/the/The/

You should also add an explanation ("obsoleted by lifting the cssid
restrictions").

> +    }
>  }
>  
>  static inline void s390_machine_initfn(Object *obj)
> @@ -583,7 +586,7 @@ static inline void s390_machine_initfn(Object *obj)
>      object_property_add_bool(obj, "s390-squash-mcss",
>                               machine_get_squash_mcss,
>                               machine_set_squash_mcss, NULL);
> -    object_property_set_description(obj, "s390-squash-mcss",
> +    object_property_set_description(obj, "s390-squash-mcss", "(deprecated) "
>              "enable/disable squashing subchannels into the default css",
>              NULL);
>      object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index d383ac44d4..90aa92d8b9 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2500,6 +2500,12 @@ enabled via the ``-machine usb=on'' argument.
>  
>  The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
>  
> +@subsection -machine virtio-ccw,s390-squash-mcss=on|off (since 2.12.0)
> +
> +Since version 2.12.0 the cssid can be chosen freely. Instead of squashing
> +mcss for guest that don't support multiple channel subsystems we recommend
> +putting all devices into the default channel subsystem (that is 0xfe).

"The ``s390-squash-mcss=on`` property has been obsoleted by allowing the
cssid to be chosen freely. Instead of squashing subchannels into the
default channel subsystem image for guests that do not support multiple
channel subsystems, all devices can be put into the default channel
subsystem image."

> +
>  @section qemu-img command line arguments
>  
>  @subsection convert -s (since 2.0.0)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b4dd..53b13ec203 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>      "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
> -    "                s390-squash-mcss=on|off controls support for squashing into default css (default=off)\n",
> +    "                s390-squash-mcss=on|off (deprecated) controls support for squashing into default css (default=off)\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
> @@ -98,6 +98,10 @@ Enables or disables NVDIMM support. The default is off.
>  @item s390-squash-mcss=on|off
>  Enables or disables squashing subchannels into the default css.
>  The default is off.
> +NOTE: This property is deprecated and may be removed in future releases.

s/may/will/

Let them complain :)

> +Since version 2.12.0 the cssid can be chosen freely. Instead of squashing
> +mcss for guest that don't support multiple channel subsystems we recommend
> +putting all devices into the default channel subsystem (that is 0xfe).

I'd use the same text as above.

>  @item enforce-config-section=on|off
>  If @option{enforce-config-section} is set to @var{on}, force migration
>  code to send configuration section even if the machine-type sets the

I'd love to do that for 2.11 already, but it is a bit too late for
that, I think.
