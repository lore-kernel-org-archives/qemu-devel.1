Received: from eggs.gnu.org ([2001:4830:134:3::10]:56936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpCG8-0005Lp-A7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpCG3-0007yp-5Q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:43:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504605227-5124-1-git-send-email-thuth@redhat.com>
Date: Tue, 05 Sep 2017 13:42:59 +0200
In-Reply-To: <1504605227-5124-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Tue, 5 Sep 2017 11:53:47 +0200")
Message-ID: <871snlwev0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] tests: Add a device_add/del HMP test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Thomas Huth <thuth@redhat.com> writes:

> People tend to forget to mark internal devices with "user_creatable = false
> or hotpluggable = false, and these devices can crash QEMU if added via the
> HMP monitor. So let's add a test to run through all devices and that tries
> to add them blindly (without arguments) to see whether this could crash the
> QEMU instance.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I've marked the patch as RFC since not all of the required device bug
>  fixes have been merged yet (so this patch can not be included yet without
>  breaking "make check"). It's also sad that "macio-oldworld" currently
>  has to be blacklisted - I tried to find a fix for that device,  but I was
>  not able to spot the exact problem so far. So help for fixing that device
>  is very very welcome! The crash can be reproduced like this:
>
>  $ qemu-system-ppc64 -nographic -S -monitor stdio -serial none
>  QEMU 2.10.50 monitor - type 'help' for more information
>  (qemu) device_add macio-oldworld,id=x
>  (qemu) device_del x
>  (qemu) **
>  ERROR:qom/object.c:1611:object_get_canonical_path_component:
>   assertion failed: (obj->parent != NULL)
>  Aborted (core dumped)
>
>  tests/test-hmp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 7a38cdc..e8a25c4 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -28,7 +28,6 @@ static const char *hmp_cmds[] = {
>      "commit all",
>      "cpu-add 1",
>      "cpu 0",
> -    "device_add ?",
>      "device_add usb-mouse,id=mouse1",
>      "mouse_button 7",
>      "mouse_move 10 10",
> @@ -116,6 +115,64 @@ static void test_info_commands(void)
>      g_free(info_buf);
>  }
>  
> +/*
> + * People tend to forget to mark internal devices with "user_creatable = false
> + * and these devices can crash QEMU if added via the HMP monitor. So let's run
> + * through all devices and try to add them blindly (without arguments) to see
> + * whether this could crash the QEMU instance.
> + */
> +static void test_device_add_commands(void)
> +{
> +    char *resp, *devices, *devices_buf, *endp;
> +
> +    devices = devices_buf = hmp("device_add help");
> +
> +    while (*devices) {
> +        /* Ignore header lines etc. */
> +        if (strncmp(devices, "name \"", 6)) {
> +            devices = strchr(devices, '\n');
> +            if (!devices) {
> +                break;
> +            }
> +            devices += 1;
> +            continue;
> +        }
> +        /* Extract the device name, ignore parameters and description */
> +        devices += 6;
> +        endp = strchr(devices, '"');
> +        g_assert(endp != NULL);
> +        *endp = '\0';
> +        /* Check whether it is blacklisted... */
> +        if (g_str_equal("macio-oldworld", devices)) {
> +            devices = strchr(endp + 1, '\n');
> +            if (!devices) {
> +                break;
> +            }
> +            devices += 1;
> +            continue;
> +        }
> +        /* Now run the device_add + device_del commands */
> +        if (verbose) {
> +            fprintf(stderr, "\tdevice_add %s,id=%s\n", devices, devices);
> +        }
> +        resp = hmp("device_add %s,id=%s", devices, devices);
> +        g_free(resp);
> +        if (verbose) {
> +            fprintf(stderr, "\tdevice_del %s\n", devices);
> +        }
> +        resp = hmp("device_del %s", devices);
> +        g_free(resp);
> +        /* And move forward to the next line */
> +        devices = strchr(endp + 1, '\n');
> +        if (!devices) {
> +            break;
> +        }
> +        devices += 1;
> +    }
> +
> +    g_free(devices_buf);
> +}
> +
>  static void test_machine(gconstpointer data)
>  {
>      const char *machine = data;
> @@ -125,6 +182,7 @@ static void test_machine(gconstpointer data)
>      qtest_start(args);
>  
>      test_info_commands();
> +    test_device_add_commands();
>      test_commands();
>  
>      qtest_end();

This finds devices by parsing output of HMP help.  I think you should
use introspection instead, like device-introspect-test does.  You may
want to extract common utility code from there.

The actual device_add and device_del also use HMP.  Failures are
ignored.  A few device_add failures I'd expect:

* There is no suitable bus.

* There are suitable buses, but the default one is full.

* Mandatory parameters are missing, such as device backend.

* The bus doesn't support hot plug (some other bus might).

* The device supports only cold plug with -device, not hot plug with
  device_add.

I'm afraid the test only tests one of these common failure modes for
many devices.

device_del failures I'd expect:

* The device doesn't exist, because it hasn't completed hot plug, yet.
  In some cases such as ACPI PCI hot plug, hot plug may require guest
  cooperation, which may take unbounded time.  device_add merely kicks
  off the hot plug then.  I can't remember how to poll for completion.
  I also can't remember why we don't send a QMP event.

  The hot plug usually completes quickly, but it may take its own sweet
  time, or not complete at all, say because the guest doesn't support
  ACPI, or just doesn't feel like plugging right now.

  The test needs to set up a guest that cooperates.  I guess that
  involves libqos; yet another thing I've forgotten.

* Same for device_del.  You should wait for the DEVICE_DELETED event
  with a suitable timeout.

We could improve device_add to cold plug before the machine starts,
i.e. between start with -S and the first cont.  We could similarly
improve device_del to cold plug.  Together, that would let you sidestep
the hot plug complications.

I guess this test is a case of "if it was easy, we would've done it
already"...
