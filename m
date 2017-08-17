Received: from eggs.gnu.org ([2001:4830:134:3::10]:54065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diHUj-0007ED-MW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diHUg-0008CN-Hi
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diHUg-0008C0-8w
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:53:38 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-5-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6454a1a2-e9eb-272f-1380-f514a07c5a20@redhat.com>
Date: Thu, 17 Aug 2017 11:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <1502951113-4246-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On 17.08.2017 08:25, Thomas Huth wrote:
> A lot of tests provide code for adding and removing a device via the
> device_add and device_del QMP commands. Maintaining this code in so
> many places is cumbersome and error-prone (some of the code parts
> check the responses in an incorrect way, for example), so let's
> provide some proper generic qtest functions for adding and removing a
> device instead.
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
> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> index 2dcdead..aada753 100644
> --- a/tests/libqos/pci.c
> +++ b/tests/libqos/pci.c
> @@ -394,21 +394,6 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
>  void qpci_plug_device_test(const char *driver, const char *id,
>                             uint8_t slot, const char *opts)
>  {
> -    QDict *response;
> -    char *cmd;
> -
> -    cmd = g_strdup_printf("{'execute': 'device_add',"
> -                          " 'arguments': {"
> -                          "   'driver': '%s',"
> -                          "   'addr': '%d',"
> -                          "   %s%s"
> -                          "   'id': '%s'"
> -                          "}}", driver, slot,
> -                          opts ? opts : "", opts ? "," : "",
> -                          id);
> -    response = qmp(cmd);
> -    g_free(cmd);
> -    g_assert(response);
> -    g_assert(!qdict_haskey(response, "error"));
> -    QDECREF(response);
> +    qtest_hot_plug_device(driver, id, "'addr': '%d'%s%s", slot,
> +                          opts ? ", " : "", opts ? opts : "");
>  }
> diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
> index 0cdfaec..f8d0190 100644
> --- a/tests/libqos/usb.c
> +++ b/tests/libqos/usb.c
> @@ -40,34 +40,16 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
>  void usb_test_hotplug(const char *hcd_id, const int port,
>                        void (*port_check)(void))
>  {
> -    QDict *response;
> -    char  *cmd;
> +    char  *id = g_strdup_printf("usbdev%d", port);
>  
> -    cmd = g_strdup_printf("{'execute': 'device_add',"
> -                          " 'arguments': {"
> -                          "   'driver': 'usb-tablet',"
> -                          "   'port': '%d',"
> -                          "   'bus': '%s.0',"
> -                          "   'id': 'usbdev%d'"
> -                          "}}", port, hcd_id, port);
> -    response = qmp(cmd);
> -    g_free(cmd);
> -    g_assert(response);
> -    g_assert(!qdict_haskey(response, "error"));
> -    QDECREF(response);
> +    qtest_hot_plug_device("usb-tablet", id, "'port': '%d', 'bus': '%s.0'",
> +                          port, hcd_id);
>  
>      if (port_check) {
>          port_check();
>      }
>  
> -    cmd = g_strdup_printf("{'execute': 'device_del',"
> -                           " 'arguments': {"
> -                           "   'id': 'usbdev%d'"
> -                           "}}", port);
> -    response = qmp(cmd);
> -    g_free(cmd);
> -    g_assert(response);
> -    g_assert(qdict_haskey(response, "event"));
> -    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
> -    QDECREF(response);
> +    qtest_hot_unplug_device(id);
> +
> +    g_free(id);
>  }
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
> +        QDECREF(response);
> +        response = qmp("");
> +        g_assert(response);
> +    }
> +    g_assert(!qdict_haskey(response, "error"));
> +    QDECREF(response);
> +}
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 3ae5709..9c1006f 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -927,4 +927,23 @@ QDict *qmp_fd(int fd, const char *fmt, ...);
>   */
>  void qtest_cb_for_every_machine(void (*cb)(const char *machine));
>  
> +/**
> + * qtest_hot_plug_device:
> + * @driver: Name of the device that should be added
> + * @id: Identification string
> + * @fmt: printf-like format string for further options to device_add
> + *
> + * Generic hot-plugging test via the device_add QMP command.
> + */
> +void qtest_hot_plug_device(const char *driver, const char *id,
> +                           const char *fmt, ...) GCC_FMT_ATTR(3, 4);

Not sure if it would be better to avoid the fmt and provide more
parameters instead. Specifying a parameter as NULL will ifgnore it.

void qtest_hot_plug_device(const char *driver, const char *id,
                           const char *drive, const char *port,
                           const char *bus)

that should cover all cases and callers don't have to build strings in a
special format.


-- 

Thanks,

David
