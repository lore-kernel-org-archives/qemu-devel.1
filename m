Received: from eggs.gnu.org ([2001:4830:134:3::10]:46555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1g7Lmo-0005FG-8b
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1g7LdC-0004QW-MZ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:26:37 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Tue,  2 Oct 2018 16:24:39 +0200
Message-Id: <20181002142443.30976-6-damien.hedde@greensocs.com>
In-Reply-To: <20181002142443.30976-1-damien.hedde@greensocs.com>
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 5/9] docs/clocks: add device's clock
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, alistair@alistair23.me, saipava@xilinx.com, mark.burton@greensocs.com, luc.michel@greensocs.com, konrad@adacore.com, edgar.iglesias@xilinx.com, Damien Hedde <damien.hedde@greensocs.com>

Add the documentation about the clock inputs and outputs in devices.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 docs/devel/clock.txt | 163 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 docs/devel/clock.txt

diff --git a/docs/devel/clock.txt b/docs/devel/clock.txt
new file mode 100644
index 0000000000..6dd8abdee6
--- /dev/null
+++ b/docs/devel/clock.txt
@@ -0,0 +1,163 @@
+
+What are device's clocks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Clocks are ports representing input and output clocks of a device. They =
are QOM
+objects developed for the purpose of modeling the distribution of clocks=
 in
+QEMU.
+
+This allows us to model the clock distribution of a platform and detect
+configuration errors in the clock tree such as badly configured PLL, clo=
ck
+source selection or disabled clock.
+
+The objects are CLOCK_IN for the input and CLOCK_OUT for the output.
+
+The clock value: ClockState
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+The ClockState is the structure carried by the CLOCK_OUT and CLOCK_IN ob=
jects.
+It contains one integer field representing the frequency of the clock in=
 Hertz.
+
+It only simulates the clock by transmitting the frequency value and
+doesn't model the signal itself such as pin toggle or duty cycle.
+The special value 0 as a frequency is legal and represent the clock bein=
g
+inactive or gated.
+
+Adding clocks to a device
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Adding clocks to a device must be done during the init phase of the Devi=
ce
+object.
+
+To add an input clock to a device, the function qdev_init_clock_in must =
be used.
+It takes the name, a callback, and an opaque parameter for the clock.
+Output is more simple, only the name is required. Typically:
+qdev_init_clock_in(DEVICE(dev), "clk-in", clk_in_callback, dev);
+qdev_init_clock_out(DEVICE(dev), "clk-out");
+
+Both functions return the created CLOCK_IN/OUT pointer, which should be =
saved
+in the device's state structure.
+
+Theses objects will be automatically deleted by the qom reference mechan=
ism.
+
+Note that it is possible to create a static array describing clock input=
s and
+outputs. The function qdev_init_clocks must be called with the array as
+parameters to initialize the clocks: it has the same behaviour as callin=
g the
+qdev_init_clock/out for each clock in the array.
+
+Unconnected input clocks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Unconnected input clocks have a default frequency value of 0. It means t=
he
+clock will be considered as disabled. If this is not the wanted behaviou=
r,
+clock_init_frequency should be called on the ClockIn object during devic=
e init.
+For example:
+clk =3D qdev_init_clock_in(DEVICE(dev), "clk-in", clk_in_callback, dev);
+clock_init_frequency(clk, 100 * 1000 * 1000); // init value is 100Mhz
+
+Forwarding clocks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Sometimes, one needs to forward, or inherit, a clock from another device=
.
+Typically, when doing device composition, a device might expose a sub-de=
vice's
+clock without interfering with it.
+The function qdev_pass_clock can be used to achieve this behaviour. Note=
, that
+it is possible to expose the clock under a different name. This works fo=
r both
+inputs or outputs.
+
+For example, if device B is a child of device A, device_a_instance_init =
may
+do something like this:
+void device_a_instance_init(Object *obj)
+{
+    AState *A =3D DEVICE_A(obj);
+    BState *B;
+    [...] /* create B object as child of A */
+    qdev_pass_clock(A, "b_clk", B, "clk");
+    /*
+     * Now A has a clock "b_clk" which forwards to
+     * the "clk" of its child B.
+     */
+}
+
+This function does not returns any clock object. It is not possible to a=
dd
+a callback on a forwarded input clock.
+
+Connecting two clocks together
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Let's say we have 2 devices A and B. A has an output clock named "clkout=
" and B
+has an input clock named "clkin".
+
+The clocks are connected together using the function qdev_connect_clock:
+qdev_connect_clock(B, "clkin", A, "clkout", &error_abort);
+The device which has the input must be the first argument.
+
+It is possible to connect several input clocks to the same output. Every
+input callback will be called when the output changes.
+
+It is not possible to disconnect a clock or to change the clock connecti=
on
+after it is done.
+
+Changing a clock output
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A device can change its outputs using the clock_set function. It will tr=
igger
+updates on any connected inputs.
+
+For example, let's say that we have an output clock "clkout" and we have=
 a
+pointer to it in the device state because we did the following in init p=
hase:
+dev->clkout =3D qdev_init_clock_out(DEVICE(dev), "clkout");
+
+Then at any time, it is possible to change the clock value by doing:
+clock_set_frequency(dev->clkout, 1000 * 1000 * 1000); /* 1Mhz */
+
+Callback on input clock change
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Here is an example of an input callback:
+void clock_callback(void *opaque) {
+    MyDeviceState *s =3D (MyDeviceState *) opaque;
+    /*
+     * opaque may not be the device state pointer, but most probably it =
is.
+     * (It depends on what is given to the qdev_init_clock_in function)
+     */
+
+    /* do something with the new frequency */
+    fprintf(stdout, "device new frequency is %" PRIu64 "Hz\n",
+                    clock_get_frequency(dev->my_clk_input));
+}
+
+The state argument needs only to be copied if the device needs to use th=
e value
+later: the state pointer argument of the pointer will not be valid anymo=
re
+after the end of the function.
+
+Migration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Only the CLOCK_IN object has a state. CLOCK_OUT frequency should not be =
set
+in migration post_load.
+
+In case the frequency of in input clock is needed for a device's migrati=
on,
+this state must be migrated. The VMSTATE_CLOCKIN macro defines an entry =
to
+be added in a vmstate description.
+
+For example, if a device has a clock input and the device state looks li=
ke:
+MyDeviceState {
+    DeviceState parent_obj;
+    ClockIn *clk;
+};
+
+Then, to add the clock frequency to the device's migrated state, the vms=
tate
+description is:
+VMStateDescription my_device_vmstate =3D {
+    .name =3D "my_device",
+    .fields =3D (VMStateField[]) {
+        VMSTATE_CLOCKIN(clk, MyDeviceState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+When adding a input clock support to an existing device, you must care a=
bout
+migration compatibility. To this end, you can use the clock_init_frequen=
cy in
+a pre_load function to setup a default value in case the source vm does =
not
+migrate the frequency.
--=20
2.19.0
