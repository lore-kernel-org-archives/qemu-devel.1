Received: from eggs.gnu.org ([209.51.188.92]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMIFq-0003EX-H2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMIFp-0004qI-Gj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMIFp-0004ju-Ak
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:24:29 -0400
Date: Thu, 2 May 2019 17:24:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190502202425.GO28722@habkost.net>
References: <20190425200051.19906-1-ehabkost@redhat.com>
	<1428e157-aa6d-02fc-94c9-97e948e3654d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428e157-aa6d-02fc-94c9-97e948e3654d@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] Remove some qdev_get_machine() calls
 from CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 26, 2019 at 04:55:17PM +0800, Like Xu wrote:
> On 2019/4/26 4:00, Eduardo Habkost wrote:
> > This series moves some qdev code outside qdev.o, so it can be
> > compiled only in CONFIG_SOFTMMU.
> > 
> > The code being moved includes two qdev_get_machine() calls, so
> > this will make it easier to move qdev_get_machine() to
> > CONFIG_SOFTMMU later.
> > 
> > After this series, there's one remaining qdev_get_machine() call
> > that seems more difficult to remove:
> > 
> >      static void device_set_realized(Object *obj, bool value, Error **errp)
> >      {
> >          /* [...] */
> >          if (!obj->parent) {
> >              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
> > 
> >              object_property_add_child(container_get(qdev_get_machine(),
> >                                                      "/unattached"),
> >                                        name, obj, &error_abort);
> >              unattached_parent = true;
> >              g_free(name);
> >          }
> >          /* [...] */
> >      }
> > 
> 
> I may have an experimental patch to fix device_set_realized issue:
> 
> 1. in qdev_get_machine():
> replace
> 	dev = container_get(object_get_root(), "/machine");
> with
> 	dev = object_resolve_path("/machine", NULL);
> 
> 2. in device_set_realized():
> 
> Using
> 	Object *container = qdev_get_machine() ?
> 		qdev_get_machine() : object_get_root();
> and pass it to
> 	object_property_add_child(
> 		container_get(container, "/unattached"),
> 		name, obj, &error_abort);

I wouldn't like to call qdev_get_machine() here (see below[1]),
but trying "/machine" first and falling back to object_get_root()
sounds good, for two reasons:

* It won't require "/machine" to exist at all, on *-user;
* It will allow machines to create unattached devices on
  instance_init without crashing (which is not possible today).

> 
> With this fix, we could say the qdev_get_machine() does
> return the "/machine" object (or null) not a confused "/container".
> 
> We could continue to use qdev_get_machine() in system emulation mode,
> getting rid of its surprising side effect as Markus said.
> 
> The return value of qdev_get_machine() in user-only mode
> is the same object returned by object_get_root(),
> so no semantic changes.

[1] I wouldn't like to have a different qdev_get_machine()
function in user-only mode.  I would like to simply not call
qdev_get_machine() at all unless we're in system emulation mode.

-- 
Eduardo
