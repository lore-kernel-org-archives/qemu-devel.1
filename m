Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g86Fo-0002Bu-OV
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g86Fn-0003Yf-9E
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:13:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g86Fj-0003Gj-Ll
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:13:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so10593125wrs.0
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 09:13:19 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <08d9d1e0-3c37-4b69-bb68-bf993b91289a@redhat.com>
Date: Thu, 4 Oct 2018 18:13:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com

Hi Damien,

On 02/10/2018 16:24, Damien Hedde wrote:
> This series aims to add a way to model clocks in qemu between devices.
> This allows to model the clock tree of a platform allowing us to inspect clock
> configuration and detect problems such as disabled clock or bad configured
> pll.
> 
> This series is a reroll of the v4 sent recently without the reset feature as
> requested by Peter. I also took into account the reviews about migration and
> other suggestions.
> 
> This framework was originally discussed in 2017, here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07218.html
> 
> For the user, the framework is now very similar to the device's gpio API.
> Clocks inputs and outputs can be added in devices during initialization phase.
> Then an input can be connected to an output: it means every time the output
> clock changes, a callback in the input is triggered allowing any action to be
> taken. A difference with gpios is that several inputs can be connected to a
> single output without doing any glue.
> 
> Behind the scene, there is 2 objects: a clock input which is a placeholder for
> a callback, and a clock output which is a list of inputs. The value transferred
> between an output and an input is an integer representing the clock frequency.
> The input clock callback is called every time the clock frequency changes.
> The input side holds a cached value of the frequency (the output does not need
> one). This allows a device to fetch its input clock frequency at any time
> without caching it itself.
> 
> This internal state is added to handle migration in order not to update and
> propagate clocks during it (it adds cross-device and order-specific effects).
> Each device handles its input clock migration by adding the clock frequency in
> its own vmstate description.
> 
> Regarding the migration strategy, discussion started in the v4 patches.
> The problem is that we add some kind of wire between different devices and 
> we face propagation issue.
> The chosen solution allows migration compatibility from a platform version
> with no implemented clocks to a platform with clocks. A migrated device that
> have a new input clock is responsible to initialize its frequency during
> migration. Each input clock having its own state, such initialization will not
> have any side-effect on other input clock connected to the same output.
> Output clocks, having no state, are not set during migration: If a clock output
> frequency changes due to migration (eg: clock computation bug-fix), the effects
> will be delayed. Eventually the clock output will be updated after migration if
> some (software) event trigger a clock update, but it can not be guaranteed.
> 
> There is also the problem of initialization which is very much like the
> migration. Currently, in the zynq example, clocks outputs are initialized in
> the clock controller device_reset. According to Peter, outputs should not be
> set in device_reset, so we need a better way.
> 
> It is not simple, since we can have complicated cases with several propagation
> step.
> We can't initialize outputs (without propagating) during device init and uses
> inputs value in device_reset to complete the initialization.
> Consider the case where we have a device generating a frequency, another device
> doing a clock division, then a device using this clock.
> [DevClockGenerator] -> clk1 -> [DevClockDiv] -> clk2 -> [Dev]
> I don't see how we can handle such initialization without doing some
> propagation phase at some point.
> 
> Regarding clock gating. The 0 frequency value means the clock is gated.
> If need be, a gate device can be built taking an input gpio and clock and
> generating an output clock.
> 
> I've tested this patchset running Xilinx's Linux on the xilinx-zynq-a9 machine.
> Clocks are correctly updated and we ends up with a configured baudrate of 115601
> on the console uart (for a theoretical 115200) which is nice. "cadence_uart*" and
> "clock*" traces can be enabled to see what's going on in this platform.
> 
> We are considering switching to a generic payload evolution of this API.
> For example by specifying the qom carried type when adding an input/output to
> a device. This would allow us, for example, to add a power input port to handle
> power gating or others ports without modifying the device state structure.
> 
> Any comments and suggestion are welcomed.

How would you instanciate devices and connect their clocks from the
command line (with the -device option)?

Should clocked devices have DeviceClass::user_creatable = false by default?

Thanks,

Phil.
