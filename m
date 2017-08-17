Received: from eggs.gnu.org ([2001:4830:134:3::10]:41874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGfO-0000mA-9P
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGfK-0001E2-CY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diGfK-0001Bx-3a
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:00:34 -0400
Date: Thu, 17 Aug 2017 11:00:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817110016.15005701.cohuck@redhat.com>
In-Reply-To: <1502951113-4246-5-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] tests: Introduce generic device
 hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 08:25:11 +0200
Thomas Huth <thuth@redhat.com> wrote:

> A lot of tests provide code for adding and removing a device via the
> device_add and device_del QMP commands. Maintaining this code in so
> many places is cumbersome and error-prone (some of the code parts
> check the responses in an incorrect way, for example), so let's
> provide some proper generic qtest functions for adding and removing a
> device instead.

This sounds like a good idea.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqos/pci.c         | 19 ++-------------
>  tests/libqos/usb.c         | 30 +++++------------------
>  tests/libqtest.c           | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.h           | 19 +++++++++++++++
>  tests/usb-hcd-uhci-test.c  | 26 ++------------------
>  tests/usb-hcd-xhci-test.c  | 51 ++++-----------------------------------
>  tests/virtio-scsi-test.c   | 24 ++-----------------
>  tests/virtio-serial-test.c | 25 +++----------------
>  8 files changed, 98 insertions(+), 156 deletions(-)
> 

> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index b9a1f18..4339d97 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -987,3 +987,63 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
>      qtest_end();
>      QDECREF(response);
>  }
> +
> +/**
> + * Generic hot-plugging test via the device_add QMP command
> + */
> +void qtest_hot_plug_device(const char *driver, const char *id,
> +                           const char *fmt, ...)
> +{
> +    QDict *response;
> +    char *cmd, *opts = NULL;
> +    va_list va;
> +
> +    if (fmt) {
> +        va_start(va, fmt);
> +        opts = g_strdup_vprintf(fmt, va);
> +        va_end(va);
> +    }
> +
> +    cmd = g_strdup_printf("{'execute': 'device_add',"
> +                          " 'arguments': { 'driver': '%s', 'id': '%s'%s%s }}",
> +                          driver, id, opts ? ", " : "", opts ? opts : "");
> +    g_free(opts);
> +
> +    response = qmp(cmd);
> +    g_free(cmd);
> +    g_assert(response);
> +    while (qdict_haskey(response, "event")) {
> +        /* We can get DEVICE_DELETED events in case something went wrong */
> +        g_assert_cmpstr(qdict_get_str(response, "event"), !=, "DEVICE_DELETED");

Is there other stuff we should check for?

> +        QDECREF(response);
> +        response = qmp("");
> +        g_assert(response);
> +    }
> +    g_assert(!qdict_haskey(response, "error"));
> +    QDECREF(response);
> +}
> +
> +/**
> + * Generic hot-unplugging test via the device_del QMP command
> + */
> +void qtest_hot_unplug_device(const char *id)
> +{
> +    QDict *response;
> +    char *cmd;
> +
> +    cmd = g_strdup_printf("{'execute': 'device_del',"
> +                          " 'arguments': { 'id': '%s' }}", id);
> +
> +    response = qmp(cmd);
> +    g_free(cmd);
> +    g_assert(response);
> +    while (qdict_haskey(response, "event")) {
> +        /* We should get DEVICE_DELETED event first */
> +        g_assert_cmpstr(qdict_get_str(response, "event"), ==, "DEVICE_DELETED");

'should' does not sound assert-worthy to me :) Is this an expected event?

> +        QDECREF(response);
> +        response = qmp("");
> +        g_assert(response);
> +    }
> +    g_assert(!qdict_haskey(response, "error"));
> +    QDECREF(response);
> +}
