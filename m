Received: from eggs.gnu.org ([209.51.188.92]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufsn-0005XX-Am
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gufsm-0003Nz-Fe
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:58:33 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-7-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb1bafc6-a4a5-b6f9-fc96-8df63e958f49@redhat.com>
Date: Fri, 15 Feb 2019 16:58:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190215133005.15955-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] tests/device-plug: Add memory
 unplug request test for spapr
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
> We can easily test this, just like PCI.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/device-plug-test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
> index ec6cb5de7b..4c581319c0 100644
> --- a/tests/device-plug-test.c
> +++ b/tests/device-plug-test.c
> @@ -116,6 +116,22 @@ static void test_spapr_cpu_unplug_request(void)
>      qtest_quit(qtest);
>  }
>  
> +static void test_spapr_memory_unplug_request(void)
> +{
> +    QTestState *qtest;
> +
> +    qtest = qtest_initf("-m 1G,slots=1,maxmem=2G "
> +                        "-object memory-backend-ram,id=mem0,size=1G "
> +                        "-device pc-dimm,id=dev0,memdev=mem0");
> +
> +    /* similar to test_pci_unplug_request */
> +    device_del_request(qtest, "dev0");
> +    system_reset(qtest);
> +    wait_device_deleted_event(qtest, "dev0");
> +
> +    qtest_quit(qtest);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const char *arch = qtest_get_arch();
> @@ -140,5 +156,10 @@ int main(int argc, char **argv)
>                         test_spapr_cpu_unplug_request);
>      }
>  
> +    if (!strcmp(arch, "ppc64")) {
> +        qtest_add_func("/device-plug/spapr_memory_unplug_request",
> +                       test_spapr_memory_unplug_request);
> +    }

By the way, it's maybe nicer to put all ppc-related tests into the same
if-statement?

 Thomas
