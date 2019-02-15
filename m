Received: from eggs.gnu.org ([209.51.188.92]:41453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufQg-00026F-G6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufQe-00037s-Hj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:29:30 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-5-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c1dc6703-0f7e-8415-24fe-48dd1d5a7d71@redhat.com>
Date: Fri, 15 Feb 2019 16:29:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190215133005.15955-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/device-plug: Add CCW unplug
 test for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 15/02/2019 14.30, David Hildenbrand wrote:
> As CCW unplugs are surprise removals without asking the guest first,
> we can test this without any guest interaction.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/device-plug-test.c | 41 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
> index 066433ebf5..6f7255552a 100644
> --- a/tests/device-plug-test.c
> +++ b/tests/device-plug-test.c
> @@ -15,17 +15,26 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
>  
> -static void device_del_request(QTestState *qtest, const char *id)
> +static void device_del_start(QTestState *qtest, const char *id)
>  {
> -    QDict *resp;
> +    qtest_qmp_send(qtest,
> +                   "{'execute': 'device_del', 'arguments': { 'id': %s } }", id);
> +}
> +
> +static void device_del_finish(QTestState *qtest)
> +{
> +    QDict *resp = qtest_qmp_receive(qtest);
>  
> -    resp = qtest_qmp(qtest,
> -                     "{'execute': 'device_del', 'arguments': { 'id': %s } }",
> -                     id);
>      g_assert(qdict_haskey(resp, "return"));
>      qobject_unref(resp);
>  }
>  
> +static void device_del_request(QTestState *qtest, const char *id)
> +{
> +    device_del_start(qtest, id);
> +    device_del_finish(qtest);
> +}
> +
>  static void system_reset(QTestState *qtest)
>  {
>      QDict *resp;
> @@ -77,8 +86,25 @@ static void test_pci_unplug_request(void)
>      qtest_quit(qtest);
>  }
>  
> +static void test_ccw_unplug(void)
> +{
> +    QTestState *qtest = qtest_initf("-device virtio-balloon-ccw,id=dev0");
> +
> +    /*
> +     * The DEVICE_DELETED events will be sent before the command
> +     * completes.
> +     */
> +    device_del_start(qtest, "dev0");
> +    wait_device_deleted_event(qtest, "dev0");
> +    device_del_finish(qtest);
> +
> +    qtest_quit(qtest);
> +}
> +
>  int main(int argc, char **argv)
>  {
> +    const char *arch = qtest_get_arch();
> +
>      g_test_init(&argc, &argv, NULL);
>  
>      /*
> @@ -89,5 +115,10 @@ int main(int argc, char **argv)
>      qtest_add_func("/device-plug/pci_unplug_request",
>                     test_pci_unplug_request);
>  
> +    if (!strcmp(arch, "s390x")) {
> +        qtest_add_func("/device-plug/ccw_unplug",
> +                       test_ccw_unplug);
> +    }

Nit: Most of the other qtests rather use "-" instead of "_" in their
names. Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
