Received: from eggs.gnu.org ([209.51.188.92]:37820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBHZU-0008Cc-5k
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 07:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBHZS-0002U3-EA
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 07:27:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com>
Date: Tue, 02 Apr 2019 13:27:10 +0200
In-Reply-To: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com> (Like
	Xu's message of "Tue, 2 Apr 2019 16:48:20 +0800")
Message-ID: <871s2kejg1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: make current_machine as
 non-global variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Like Xu <like.xu@linux.intel.com> writes:

> This patch makes the remaining dozen or so uses of the global
> current_machine outside vl.c use qdev_get_machine() instead,
> and then make current_machine local to vl.c instead of global.
>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

You effectively replace

    current_machine

by

    MACHINE(qdev_get_machine())

qdev_get_machine() uses container_get(), which has a side effect: any
path component that doesn't exist already gets created as "container"
object.  In case of qdev_get_machine(), that's just "/machine".

Creating "/machine" as "container" is of course wrong.  You therefore
must not use qdev_get_machine() before main() creates "/machine".  It
does like this:

    object_property_add_child(object_get_root(), "machine",
                              OBJECT(current_machine), &error_abort);

I recently had several cases of code rearrangements explode because the
reordered code called qdev_get_machine() too early.  Makes me rather
skeptical about this patch.  To be frank, I consider qdev_get_machine()
a trap for the unwary.  container_get(), too.

If we decide using it to make current_machine static a good idea anyway,
we need to check the new uses carefully to make sure they can't run
before main() creates "/machine".
