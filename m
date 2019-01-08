Received: from eggs.gnu.org ([209.51.188.92]:55834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggqel-0002Ks-2I
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggqed-0003pK-Cz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:38:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1545633323-10818-1-git-send-email-dongli.zhang@oracle.com>
Date: Tue, 08 Jan 2019 13:38:35 +0100
In-Reply-To: <1545633323-10818-1-git-send-email-dongli.zhang@oracle.com>
	(Dongli Zhang's message of "Mon, 24 Dec 2018 14:35:23 +0800")
Message-ID: <87ef9nnx2s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] qdev: rename qdev_create() argument to
 sync with qdev_try_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Dongli Zhang <dongli.zhang@oracle.com> writes:

> The second argument used by qdev_create() is typename and 'name' is very
> confusing. Rename it from 'name' to 'type', which is the same used by
> qdev_try_create().
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/core/qdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6b3cc55..1d65e8f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -113,17 +113,17 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>  /* Create a new device.  This only initializes the device state
>     structure and allows properties to be set.  The device still needs
>     to be realized.  See qdev-core.h.  */
> -DeviceState *qdev_create(BusState *bus, const char *name)
> +DeviceState *qdev_create(BusState *bus, const char *type)
>  {
>      DeviceState *dev;
>  
> -    dev = qdev_try_create(bus, name);
> +    dev = qdev_try_create(bus, type);
>      if (!dev) {
>          if (bus) {
> -            error_report("Unknown device '%s' for bus '%s'", name,
> +            error_report("Unknown device '%s' for bus '%s'", type,
>                           object_get_typename(OBJECT(bus)));
>          } else {
> -            error_report("Unknown device '%s' for default sysbus", name);
> +            error_report("Unknown device '%s' for default sysbus", type);
>          }
>          abort();
>      }

Yes, @name is rather generic.  The sub-par function comment doesn't
really help.

You rename the parameter in the definition, but not in the declaration
(qdev-core.h).  Better keep them consistent.

Note that qdev_create() is just one instance of the "variables
containing type names are confusingly named" pattern.  Let's start with
just qdev-core.h:

* qdev_create() parameter @name.

* qdev_try_create() parameter @name.  The definition in qdev.c calls it
  @type.

* qbus_create_inplace() parameter @typename.

* qbus_create() parameter @typename.  The definition in bus.c calls it
  @name.

Let's pick a single identifier and use it consistently.  Picking
@typename would minimize churn, and be consistent with object_new() &
friends.  Philippe, Paolo, what do you think?
