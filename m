Received: from eggs.gnu.org ([209.51.188.92]:48523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gufxX-0001Cs-2d
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gufxV-0001FO-52
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:03:26 -0500
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:37129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gufxU-0001AZ-St
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:03:25 -0500
Received: from player739.ha.ovh.net (unknown [10.109.159.224])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2B6CF52398
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 17:03:20 +0100 (CET)
Date: Fri, 15 Feb 2019 17:03:02 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215170302.5fa10931@bahia.lan>
In-Reply-To: <20190215133005.15955-6-david@redhat.com>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] tests/device-plug: Add CPU core
 unplug request test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 15 Feb 2019 14:30:04 +0100
David Hildenbrand <david@redhat.com> wrote:

> We can easily test this, just like PCI.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/device-plug-test.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
> index 6f7255552a..ec6cb5de7b 100644
> --- a/tests/device-plug-test.c
> +++ b/tests/device-plug-test.c
> @@ -101,6 +101,21 @@ static void test_ccw_unplug(void)
>      qtest_quit(qtest);
>  }
>  
> +static void test_spapr_cpu_unplug_request(void)
> +{
> +    QTestState *qtest;
> +
> +    qtest = qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=2 "
> +                        "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
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
> @@ -120,5 +135,10 @@ int main(int argc, char **argv)
>                         test_ccw_unplug);
>      }
>  
> +    if (!strcmp(arch, "ppc64")) {
> +        qtest_add_func("/device-plug/spapr_cpu_unplug_request",
> +                       test_spapr_cpu_unplug_request);
> +    }
> +
>      return g_test_run();
>  }
