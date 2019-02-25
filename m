Received: from eggs.gnu.org ([209.51.188.92]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gyDpr-000320-7e
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gyDpl-00018A-S2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:50:11 -0500
Received: from greensocs.com ([193.104.36.180]:42565)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gyDpl-00013t-95
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:50:05 -0500
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
Date: Mon, 25 Feb 2019 11:49:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Mark Burton <mark.burton@greensocs.com>

Hi,

I had more thought about the reset problem and what we want to achieve
(add power gating and clock support).
Feel free to comment. I'll start to implement this and send a first
version with a reroll of everything when it's ready.

# CONTEXT

We want to model the clock distribution between devices in qemu
(https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00310.html).
To this end, we need to make some changes in the reset procedure because
the current one does not allow to propagate things (like clocks or IOs)
between devices.

In the other hand, we also want to add power gating support. For that we
need state support in devices. This is related to reset because powering
down then up a device is like a reset.

# CURRENT STATE
First here is a current state of reset usage:

* Buses and Devices have a single reset method taking no parameter
  (apart from bus/device object)
* `qdev_reset_all`/`qbus_reset_all` functions call these reset methods
  for a bus/dev subtree
    + theses functions are used in ~20 places (mostly pci and scsi)
* `device_reset` function only do a device local reset (does not walk
  the bus subtree)
    + device_reset is used in ~10 places
* qemu_register_reset is used to register the:
    + `qbus_reset_all` of top-level/orphan buses (2 places)
    + ~100 of other reset functions (a lot of cpu related reset)
* qemu_devices_reset reset everythings that has been registered with
  qemu_register_reset
* Machines may define a reset method that overrides qemu_devices_reset
  global function (few machines do that)

# PROPOSAL OVERVIEW

I propose to add a Resetable interface and a ResetDomain object.

Having an interface simplify things since there is several reset entry
points (at least Buses and Devices).
Device and Bus objects will implement this interface.

The ResetDomain will hold several Resetable objects and implement the
interface too. The ResetDomain is needed to have at least a global/main
ResetDomain to place buses and devices to replace the current
qemu_register_reset system which only allow to register a function.

I also propose to handle the warm/cold reset distinction. This point is
explained below.

# RESETABLE INTERFACE

This Resetable interface describes the methods corresponding to a multi-
phase reset system. This is based on Peter's proposal (see
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03302.html).

Here's the phases (I've tried to find adequate names):

INIT PHASE: (Peter's phase 1)
    Reset the object internal state, put a resetting flag and do the
    same for the reset subtree. No side effect on other devices to
    guarantee that, in a reset domain, everything get initialized first.
    This corresponds mostly to what is currently done in the device/bus
    reset method.

HOLD PHASE: (This phase was not in Peter's proposal)
    This phase allows to control a reset with a IO. When a IO control
    reset procedure based on the IO level (not edge), we may need to
    assert the reset, wait some time, and finally de-assert the reset.
    The consequence is that such a device can stay in a "resetting
    state" and may need to show this state to other devices through
    its outputs. For example, a clock controller will typically shutdown
    its clocks when it is in resetting state.

RELEASE PHASE: (Peter's phase 2, modified)
    This phase sets outputs to state after reset. For a clock controller
    it starts the clocks. It also clears the "resetting" flag (this is
    where is differs from Peter's phase 2). A device should not react to
    inputs until this flag has been cleared. During this phase, outputs
    are propagated in the reset domain (and outside the reset domain).

POST PHASE: (Peter's phase 3)
    This phase is kind of post-reset phase to do things that need the
    guarantee to be after the propagation of outputs inside the reset
    domain.

The interface contains a method per phase:
 void (*reset_init)(Resetable *rst, bool cold);
 void (*reset_hold)(Resetable *rst);
 void (*reset_release)(Resetable *rst);
 void (*reset_post)(Resetable *rst);

# WARM/COLD RESET

Warm/Cold reset differences may exists in devices. We want a cold reset
to handle power gating. (IMO powering off a device is identical to
putting it in a cold reset state).

To handle the difference between warm and cold reset, I propose to have
a parameter to the init phase of Resetable interface.
Other phases do not need the parameter since init phase should
put warm/cold difference in the device state.

# How to do a reset on a Resetable object

There is 3 entry points. The first one is when we do a reset event. I
call it `void resetable_trigger_reset(Resetable *rst, bool cold)`. This
the one used for example at machine startup to initialize everything.
this should do the init, release and postphases in a row. I don't think
hold phase must be done here since release will do the opposite just after.

The 2 other entry points are dedicated to io control.
void resetable_assert_reset(Resetable *rst, bool cold);
void resetable_deassert_reset(Resetable *rst);
assert will do init and hold phases while deassert will release and post
phase.

Obviously to correctly support this assert/de-assert a device must have
special support in order to handle migration in "resetting" state. There
is no migration problem while we only use trigger because there is no
point during the reset were migration could occur.

# DeviceClass impact

4 new methods are added in Device:
+ 3 corresponding to the hold/release/post phases.
+ 1 to handle the cold reset init phase.

The existing `reset` method is now the warm reset init phase. To handle
the cold reset, a new `cold_reset` is added. The default behavior of
this method is to call `reset` so that without any specific support cold
and warm reset are the same.

Instead of adding a cold reset method, we could add a parameter to the
current reset. But there is a lot of places that would need some changes
and I am really not sure we can do it automatically.

# BusClass impact

I don't think we need to add any new method to the bus. Since a bus has
no gpio, there is no propagation so phase hold/release/term are probably
meaningless here. Maybe a cold reset method is useful here ?

# Impact on existing code

There is not much impact. Basically the global qemu_reset should be
changed to handle Resetable objects with a global ResetDomain. Also the
2 occurrences of qemu_register_reset(qbus_reset_all, ...) must be
replaced to add the buses in the global ResetDomain.

qdev/qbus_reset_all/device_reset behavior will be changed to trigger
phase reset (instead of doing one dev/bus walk, there will be a walk per
reset phase). We can add the cold/warm parameter (and modify the places
were the functions are called) or choose a default (anyway until support
is added to devices, both are identical).


Thanks,
Damien
