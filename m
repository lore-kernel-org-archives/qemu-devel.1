Received: from eggs.gnu.org ([2001:4830:134:3::10]:41979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e818T-0005pH-Pq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e818N-0002jV-TJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:41:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1e818N-0002jL-K5
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:40:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77392745
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:40:58 +0000 (UTC)
Date: Fri, 27 Oct 2017 11:40:44 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171027094044.2gixm4upkrjqgsfs@localhost.localdomain>
References: <20171026124425.17957-1-jfreimann@redhat.com>
	<20171026124425.17957-3-jfreimann@redhat.com>
	<20171026173918-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171026173918-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [v3 2/2] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

On Thu, Oct 26, 2017 at 02:53:12PM +0000, Michael S. Tsirkin wrote:
>On Thu, Oct 26, 2017 at 02:44:25PM +0200, Jens Freimann wrote:
>> From: Jens Freimann <jfreiman@redhat.com>
>>
>> Add a PXE testcase tunneling traffic through vhost-user-bridge process.
>> Create a vhost-user-bridge process and connect it to qemu via a socket.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  tests/Makefile.include |   4 +-
>>  tests/pxe-test.c       | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 114 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 70dc711bca..6cdb783753 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -740,7 +740,8 @@ tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
>>  tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
>>  tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
>>  	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
>> -tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
>> +tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o \
>> +    tests/vhost-user-bridge$(EXESUF) $(libqos-obj-y)
>>  tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
>>  tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
>>  tests/m25p80-test$(EXESUF): tests/m25p80-test.o
>> @@ -849,6 +850,7 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu
>>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>>  	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>>  		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
>> +		QTEST_VUBR_BINARY=./tests/vhost-user-bridge$(EXESUF) \
>>  		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
>>  		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
>>  	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
>> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
>> index 937f29e631..d2646ee86d 100644
>> --- a/tests/pxe-test.c
>> +++ b/tests/pxe-test.c
>> @@ -7,6 +7,7 @@
>>   *  Michael S. Tsirkin <mst@redhat.com>,
>>   *  Victor Kaplansky <victork@redhat.com>
>>   *  Thomas Huth <thuth@redhat.com>
>> + *  Jens Freimann <jfreiman@redhat.com>
>>   *
>>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>   * See the COPYING file in the top-level directory.
>> @@ -14,14 +15,123 @@
>>
>>  #include "qemu/osdep.h"
>>  #include <glib/gstdio.h>
>> +#include <glib.h>
>>  #include "qemu-common.h"
>>  #include "libqtest.h"
>>  #include "boot-sector.h"
>>
>> +#define LPORT 5555
>
>Is this used anywhere?
>
>> +#define RPORT 4444
>
>Using a known port is problematic as you can't run
>many instances of the test then. I think you want an option
>to bind in the parent.

ok 

>>  #define NETNAME "net0"
>> +#define QEMU_CMD_MEM    "--enable-kvm -m %d "\
>
>enable-kvm won't work on boxes without kvm.
>Pls use same technique as other tests to only use kvm
>when available.

ok

>> +                        "-object memory-backend-file,id=mem,size=%dM,"\
>> +                        "mem-path=%s,share=on -numa node,memdev=mem -mem-prealloc "
>
>Do we really need prealloc? And why?

We don't need it, I'll remove it.

>> +#define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s"
>> +#define QEMU_CMD_NETDEV " -device virtio-net-pci,netdev=net0 "\
>> +                        " -netdev vhost-user,id=net0,chardev=%s,vhostforce "\
>> +                        " -netdev user,id=n0,tftp=./,bootfile=%s "\
>> +                        " -netdev socket,id=n1,fd=%d"
>> +#define QEMU_CMD_NET    " -device virtio-net-pci,netdev=n0 "\
>> +                        " -device virtio-net-pci,netdev=n1 "
>> +
>> +#define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
>> +                        QEMU_CMD_NETDEV QEMU_CMD_NET
>> +
>> +#define VUBR_SOCK "vubr.sock"
>> +#define MEMSZ 1024
>>
>>  static char disk[] = "tests/pxe-test-disk-XXXXXX";
>>
>> +static int vubr_create_socket(struct sockaddr_in *si_remote, int rport)
>> +{
>> +    int sock;
>> +
>> +    si_remote->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>> +    sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
>> +    if (sock == -1) {
>> +        g_test_message("socket creation failed\n");
>> +        return -1;
>> +    }
>> +    if (connect(sock, (struct sockaddr *) si_remote, sizeof(*si_remote))) {
>> +        g_test_message("connect failed: %s", strerror(errno));
>> +        return -1;
>> +    }
>> +
>> +    return sock;
>> +}
>> +
>> +static void vubr_watch(GPid pid, gint status, gpointer data)
>> +{
>> +    g_assert_cmpint(status, ==, 0);
>> +    g_spawn_close_pid(pid);
>> +}
>> +
>> +static void abrt_handler(void *data)
>> +{
>> +    int *pid = data;
>> +
>> +    g_spawn_close_pid(*pid);
>> +    kill(*pid, SIGTERM);
>> +    waitpid(*pid, NULL, 0);
>> +}
>> +
>> +static void test_pxe_vhost_user(void)
>> +{
>> +    char template[] = "/tmp/vhost-user-bridge-XXXXXX";
>> +    gchar * vubr_args[] = {NULL, NULL, NULL, NULL};
>> +    struct sockaddr_in si_remote = {
>> +        .sin_family = AF_INET,
>> +        .sin_port = htons(RPORT),
>> +    };
>> +    const char *hugefs = NULL;
>> +    const char *tmpfs = NULL;
>> +    GError *error = NULL;
>> +    char *vubr_binary;
>> +    char *qemu_args;
>> +    GPid vubr_pid;
>> +    int sock = -1;
>> +
>> +    qtest_add_abrt_handler(abrt_handler, &vubr_pid);
>> +    tmpfs = mkdtemp(template);
>> +    if (!tmpfs) {
>> +        g_test_message("mkdtemp on path(%s): %s\n",
>> +                       template, strerror(errno));
>> +    }
>
>defer above until we know it's used (no hugetlbfs?)

yes, will do. Thanks for the review!

regards,
Jens 
