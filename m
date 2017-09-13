Received: from eggs.gnu.org ([2001:4830:134:3::10]:39596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds5LN-0002md-7i
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds5LK-0000Sc-1S
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ds5LJ-0000RN-OU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:56:29 -0400
References: <1502788964-30517-1-git-send-email-thuth@redhat.com>
	<20170913104118.GF3617@pxdev.xzpeter.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8046ee88-1d7e-b34c-e5db-f55c67f98a7e@redhat.com>
Date: Wed, 13 Sep 2017 12:56:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170913104118.GF3617@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11] tests: Introduce generic
 device hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>

On 13.09.2017 12:41, Peter Xu wrote:
> On Tue, Aug 15, 2017 at 11:22:44AM +0200, Thomas Huth wrote:
>> A lot of tests provide code for adding and removing a device via the
>> device_add and device_del QMP commands. Maintaining this code in so
>> many places is cumbersome and error-prone (some of the code parts
>> check the responses in an incorrect way, for example), so let's
>> provide some proper generic qtest functions for adding and removing a
>> device instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  I'm planning to use qtest_hot_plug_device() in a bigger patch series
>>  that I'm currently preparing. But since this clean-up patch is valid on
>>  its own already, I'd like to get some feedback (or even a Reviewed-by)
>>  for this patch here already if possible...
>>
>>  tests/libqos/pci.c         | 19 ++-------------
>>  tests/libqos/usb.c         | 30 +++++------------------
>>  tests/libqtest.c           | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/libqtest.h           | 19 +++++++++++++++
>>  tests/usb-hcd-uhci-test.c  | 26 ++------------------
>>  tests/usb-hcd-xhci-test.c  | 52 ++++------------------------------------
>>  tests/virtio-scsi-test.c   | 24 ++-----------------
>>  tests/virtio-serial-test.c | 25 +++----------------
>>  8 files changed, 98 insertions(+), 157 deletions(-)
>>
>> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
>> index 2dcdead..aada753 100644
>> --- a/tests/libqos/pci.c
>> +++ b/tests/libqos/pci.c
>> @@ -394,21 +394,6 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
>>  void qpci_plug_device_test(const char *driver, const char *id,
>>                             uint8_t slot, const char *opts)
>>  {
>> -    QDict *response;
>> -    char *cmd;
>> -
>> -    cmd = g_strdup_printf("{'execute': 'device_add',"
>> -                          " 'arguments': {"
>> -                          "   'driver': '%s',"
>> -                          "   'addr': '%d',"
>> -                          "   %s%s"
>> -                          "   'id': '%s'"
>> -                          "}}", driver, slot,
>> -                          opts ? opts : "", opts ? "," : "",
>> -                          id);
>> -    response = qmp(cmd);
>> -    g_free(cmd);
>> -    g_assert(response);
>> -    g_assert(!qdict_haskey(response, "error"));
>> -    QDECREF(response);
>> +    qtest_hot_plug_device(driver, id, "'addr': '%d'%s%s", slot,
>> +                          opts ? ", " : "", opts ? opts : "");
>>  }
>> diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
>> index 0cdfaec..f8d0190 100644
>> --- a/tests/libqos/usb.c
>> +++ b/tests/libqos/usb.c
>> @@ -40,34 +40,16 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
>>  void usb_test_hotplug(const char *hcd_id, const int port,
>>                        void (*port_check)(void))
>>  {
>> -    QDict *response;
>> -    char  *cmd;
>> +    char  *id = g_strdup_printf("usbdev%d", port);
>>  
>> -    cmd = g_strdup_printf("{'execute': 'device_add',"
>> -                          " 'arguments': {"
>> -                          "   'driver': 'usb-tablet',"
>> -                          "   'port': '%d',"
>> -                          "   'bus': '%s.0',"
>> -                          "   'id': 'usbdev%d'"
>> -                          "}}", port, hcd_id, port);
>> -    response = qmp(cmd);
>> -    g_free(cmd);
>> -    g_assert(response);
>> -    g_assert(!qdict_haskey(response, "error"));
>> -    QDECREF(response);
>> +    qtest_hot_plug_device("usb-tablet", id, "'port': '%d', 'bus': '%s.0'",
>> +                          port, hcd_id);
>>  
>>      if (port_check) {
>>          port_check();
>>      }
>>  
>> -    cmd = g_strdup_printf("{'execute': 'device_del',"
>> -                           " 'arguments': {"
>> -                           "   'id': 'usbdev%d'"
>> -                           "}}", port);
>> -    response = qmp(cmd);
>> -    g_free(cmd);
>> -    g_assert(response);
>> -    g_assert(qdict_haskey(response, "event"));
>> -    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
>> -    QDECREF(response);
>> +    qtest_hot_unplug_device(id);
>> +
>> +    g_free(id);
>>  }
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index b9a1f18..4339d97 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -987,3 +987,63 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
>>      qtest_end();
>>      QDECREF(response);
>>  }
>> +
>> +/**
>> + * Generic hot-plugging test via the device_add QMP command
>> + */
>> +void qtest_hot_plug_device(const char *driver, const char *id,
>> +                           const char *fmt, ...)
>> +{
>> +    QDict *response;
>> +    char *cmd, *opts = NULL;
>> +    va_list va;
>> +
>> +    if (fmt) {
>> +        va_start(va, fmt);
>> +        opts = g_strdup_vprintf(fmt, va);
>> +        va_end(va);
>> +    }
>> +
>> +    cmd = g_strdup_printf("{'execute': 'device_add',"
>> +                          " 'arguments': { 'driver': '%s', 'id': '%s'%s%s }}",
>> +                          driver, id, opts ? ", " : "", opts ? opts : "");
>> +    g_free(opts);
>> +
>> +    response = qmp(cmd);
>> +    g_free(cmd);
>> +    g_assert(response);
>> +    while (qdict_haskey(response, "event")) {
>> +        /* We can get DEVICE_DELETED events in case something went wrong */
>> +        g_assert_cmpstr(qdict_get_str(response, "event"), !=, "DEVICE_DELETED");
>> +        QDECREF(response);
>> +        response = qmp("");
>> +        g_assert(response);
>> +    }
> 
> I guess we don't need this block for hot plug? :-)

I'm pretty sure I've seen this happening somewhere ... but maybe it was
just a fall-out of the mis-behaving usb test...
I'll replace it with a  g_assert(!qdict_haskey(response, "event"))
instead, since we should not get any events in this case, should we?

>> +    g_assert(!qdict_haskey(response, "error"));
>> +    QDECREF(response);
>> +}
>> +
>> +/**
>> + * Generic hot-unplugging test via the device_del QMP command
>> + */
>> +void qtest_hot_unplug_device(const char *id)
>> +{
>> +    QDict *response;
>> +    char *cmd;
>> +
>> +    cmd = g_strdup_printf("{'execute': 'device_del',"
>> +                          " 'arguments': { 'id': '%s' }}", id);
>> +
>> +    response = qmp(cmd);
>> +    g_free(cmd);
>> +    g_assert(response);
>> +    while (qdict_haskey(response, "event")) {
>> +        /* We should get DEVICE_DELETED event first */
> 
> So here is the mis-order thing: could the "return: {}" arrive earlier?
> IHMO it can.  If so, we'll leave the event in the buffer without
> reading it.
> 
> If you see my patch, I do two reads (assuming we will only get exactly
> one "return: {}" and a DELETED event), and take care of the ordering.
> Would that be better?

Yes, I'll update my patch accordingly...

>> +        g_assert_cmpstr(qdict_get_str(response, "event"), ==, "DEVICE_DELETED");
>> +        QDECREF(response);
>> +        response = qmp("");
>> +        g_assert(response);
>> +    }
>> +    g_assert(!qdict_haskey(response, "error"));
>> +    QDECREF(response);
>> +}
>> diff --git a/tests/libqtest.h b/tests/libqtest.h
>> index 3ae5709..9c1006f 100644
>> --- a/tests/libqtest.h
>> +++ b/tests/libqtest.h
>> @@ -927,4 +927,23 @@ QDict *qmp_fd(int fd, const char *fmt, ...);
>>   */
>>  void qtest_cb_for_every_machine(void (*cb)(const char *machine));
>>  
>> +/**
>> + * qtest_hot_plug_device:
>> + * @driver: Name of the device that should be added
>> + * @id: Identification string
>> + * @fmt: printf-like format string for further options to device_add
>> + *
>> + * Generic hot-plugging test via the device_add QMP command.
>> + */
>> +void qtest_hot_plug_device(const char *driver, const char *id,
>> +                           const char *fmt, ...) GCC_FMT_ATTR(3, 4);
>> +
>> +/**
>> + * qtest_hot_unplug_device:
>> + * @id: Identification string
>> + *
>> + * Generic hot-unplugging test via the device_del QMP command.
>> + */
>> +void qtest_hot_unplug_device(const char *id);
>> +
>>  #endif
>> diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
>> index 5b500fe..7465bfd 100644
>> --- a/tests/usb-hcd-uhci-test.c
>> +++ b/tests/usb-hcd-uhci-test.c
>> @@ -48,31 +48,9 @@ static void test_uhci_hotplug(void)
>>  
>>  static void test_usb_storage_hotplug(void)
>>  {
>> -    QDict *response;
>> +    qtest_hot_plug_device("usb-storage", "usbdev0", "'drive': 'drive0'");
>>  
>> -    response = qmp("{'execute': 'device_add',"
>> -                   " 'arguments': {"
>> -                   "   'driver': 'usb-storage',"
>> -                   "   'drive': 'drive0',"
>> -                   "   'id': 'usbdev0'"
>> -                   "}}");
>> -    g_assert(response);
>> -    g_assert(!qdict_haskey(response, "error"));
>> -    QDECREF(response);
>> -
>> -    response = qmp("{'execute': 'device_del',"
>> -                           " 'arguments': {"
>> -                           "   'id': 'usbdev0'"
>> -                           "}}");
>> -    g_assert(response);
>> -    g_assert(!qdict_haskey(response, "error"));
>> -    QDECREF(response);
>> -
>> -    response = qmp("");
>> -    g_assert(response);
>> -    g_assert(qdict_haskey(response, "event"));
>> -    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
>> -    QDECREF(response);
>> +    qtest_hot_unplug_device("usbdev0");
>>  }
>>  
>>  int main(int argc, char **argv)
>> diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
>> index 031764d..ae89362 100644
>> --- a/tests/usb-hcd-xhci-test.c
>> +++ b/tests/usb-hcd-xhci-test.c
>> @@ -11,7 +11,6 @@
>>  #include "libqtest.h"
>>  #include "libqos/usb.h"
>>  
>> -
> 
> Nit: useless change
> 
> Other than these, it looks quite good to me.  Thanks,

Thanks for the review!

 Thomas
