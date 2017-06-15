Received: from eggs.gnu.org ([2001:4830:134:3::10]:35152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLWx2-0003uE-S4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLWwz-0007U9-Gd
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:44:52 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:33207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLWwz-0007Tm-30
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:44:49 -0400
Received: by mail-lf0-x233.google.com with SMTP id m77so11788505lfe.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:44:48 -0700 (PDT)
Date: Thu, 15 Jun 2017 17:44:46 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170615154446.GG4859@toto>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<1488276185-31168-7-git-send-email-fred.konrad@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488276185-31168-7-git-send-email-fred.konrad@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/10] docs: add qemu-clock documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com, clg@kaod.org

On Tue, Feb 28, 2017 at 11:03:01AM +0100, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This adds the qemu-clock documentation.

Hi Fred



> 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> V1 -> V2:
>   * Fixed in accordance with the changes in the previous patches.
> ---
>  docs/clock.txt | 278 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 278 insertions(+)
>  create mode 100644 docs/clock.txt
> 
> diff --git a/docs/clock.txt b/docs/clock.txt
> new file mode 100644
> index 0000000..010ae50
> --- /dev/null
> +++ b/docs/clock.txt
> @@ -0,0 +1,278 @@
> +
> +What is a QEMU_CLOCK
> +====================
> +
> +A QEMU_CLOCK is a QOM Object developed for the purpose of modeling a clock tree
> +with QEMU.
> +
> +It only simulates the clock by keeping a copy of the current frequency and
> +doesn't model the signal itself such as pin toggle or duty cycle.
> +
> +It allows to model the impact of badly configured PLL, clock source selection
> +or disabled clock on the models.
> +
> +Binding the clock together to create a tree
> +===========================================
> +
> +In order to create a clock tree with QEMU_CLOCK two or more clock must be bound
> +together. Let's say there are two clocks clk_a and clk_b:
> +Using qemu_clk_bind(clk_a, clk_b) will bind clk_a and clk_b.
> +
> +Binding two qemu-clk together creates a unidirectional link which means that
> +changing the rate of clk_a will propagate to clk_b and not the opposite.
> +The binding process automatically refreshes clk_b rate.
> +
> +Clock can be bound and unbound during execution for modeling eg: a clock
> +selector.
> +
> +A clock can drive more than one other clock. eg with this code:
> +qemu_clk_bind(clk_a, clk_b);
> +qemu_clk_bind(clk_a, clk_c);
> +
> +A clock rate change one clk_a will propagate to clk_b and clk_c.
> +
> +Implementing a callback on a rate change
> +========================================
> +
> +The function prototype is the following:
> +typedef uint64_t QEMUClkRateUpdateCallback(void *opaque, uint64_t rate);
> +
> +It's main goal is to modify the rate before it's passed to the next clocks in
> +the tree.
> +
> +eg: for a 4x PLL the function will be:
> +uint64_t qemu_clk_rate_change_cb(void *opaque, uint64_t rate)
> +{
> +    return 4 * rate;
> +}


I was thinking that this would work a little different.

Clocks would notify other objects when rates change by somehow calling
registered callbacks. Devices that derive and propagates new clocks
would:

1. Bind to a clock source by registering a callback.
2. When the callback gets called, they would compute a new
   rate and actively set that new rate to another clock object.
   I.e, a clock_in object does not exist, input clocks are just
   registered callbacks.
   As the new rate gets set, more callbacks are potentially
   triggered across the clock tree.


That would get rid of the need for storing ref_rate in the clock
objects.
rate would perhaps still be useful making it easy to print stuff in
qom-tree, but it would really only be a cache of state that at any
time can be derived by a devices internal state + rate change of
any of the clocks the device has registered to.

Does this make sense?
I think this brings us closer to how gpios/interrupts work and makes
migration simpler. I personally also find it more natural and easier
to understand but that may be subjective.

What do you and others think?

Cheers,
Edgar


> +
> +To set the callback for the clock:
> +void qemu_clk_set_callback(qemu_clk clk, QEMUClkRateUpdateCallback *cb,
> +                           void *opaque);
> +can be called.
> +
> +The rate update process
> +=======================
> +
> +The rate update happen in this way:
> +When a model wants to update a clock frequency (eg: based on a register change
> +or something similar) it will call qemu_clk_update_rate(..) on the clock:
> +  * The callback associated to the clock is called with the new rate.
> +  * qemu_clk_update_rate(..) is then called on all bound clocks with the value
> +    returned by the callback.
> +
> +NOTE: When no callback is attached, the clock qemu_clk_update_rate(..) is called
> +on the next clock in the tree with the rate unmodified.
> +
> +Adding a QEMU_CLOCK to a DeviceState
> +====================================
> +
> +Adding a qemu-clk to a DeviceState is required to be able to get the clock
> +outside the model through qemu_clk_device_get_clock(..).
> +
> +It is also required to be able to print the clock and its rate with info qtree.
> +For example:
> +
> +  type System
> +  dev: xlnx.zynqmp_crf, id ""
> +    gpio-out "sysbus-irq" 1
> +    gpio-out "RST_A9" 4
> +    qemu-clk "dbg_trace" 0
> +    qemu-clk "vpll_to_lpd" 625000000
> +    qemu-clk "dp_stc_ref" 0
> +    qemu-clk "dpll_to_lpd" 12500000
> +    qemu-clk "acpu_clk" 0
> +    qemu-clk "pcie_ref" 0
> +    qemu-clk "topsw_main" 0
> +    qemu-clk "topsw_lsbus" 0
> +    qemu-clk "dp_audio_ref" 0
> +    qemu-clk "sata_ref" 0
> +    qemu-clk "dp_video_ref" 71428568
> +    qemu-clk "vpll_clk" 2500000000
> +    qemu-clk "apll_to_lpd" 12500000
> +    qemu-clk "dpll_clk" 50000000
> +    qemu-clk "gpu_ref" 0
> +    qemu-clk "aux_refclk" 0
> +    qemu-clk "video_clk" 27000000
> +    qemu-clk "gdma_ref" 0
> +    qemu-clk "gt_crx_ref_clk" 0
> +    qemu-clk "dbg_fdp" 0
> +    qemu-clk "apll_clk" 50000000
> +    qemu-clk "pss_alt_ref_clk" 0
> +    qemu-clk "ddr" 0
> +    qemu-clk "pss_ref_clk" 50000000
> +    qemu-clk "dpdma_ref" 0
> +    qemu-clk "dbg_tstmp" 0
> +    mmio 00000000fd1a0000/000000000000010c
> +
> +This way a DeviceState can have multiple clock input or output.
> +
> +Examples
> +========
> +
> +Those are the different way of using the QEMUClock object.
> +
> +Modelling a fixed clock generator
> +=================================
> +
> +Here is a brief example of a device acting as a clock source:
> +
> +typedef struct {
> +    DeviceState parent_obj;
> +
> +    uint32_t rate;
> +    QEMUClock out;
> +} FixedClock;
> +
> +During the initialization the device must initialize its clock object:
> +
> +static void fixed_clock_instance_init(Object *obj)
> +{
> +    FixedClock *s = FIXED_CLOCK(obj);
> +
> +    object_initialize(&s->out, sizeof(s->out), TYPE_CLOCK);
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->out, "clk_out");
> +}
> +
> +As the device acts as a clock source it must refresh the clock tree during the
> +realize phase:
> +
> +static void fixed_clock_realizefn(DeviceState *dev, Error **errp)
> +{
> +    FixedClock *s = FIXED_CLOCK(dev);
> +
> +    qemu_clk_update_rate(&s->out, s->rate);
> +}
> +
> +This means that the clock tree must be finished before realize is called on the
> +fixed clock.
> +
> +Modelling a clock user device
> +=============================
> +
> +Here is a brief example of a clock user:
> +
> +typedef struct {
> +    DeviceState parent_obj;
> +
> +    QEMUClock in;
> +} ClockUser;
> +
> +As before the clock must be initialized through the device initialize function:
> +
> +static void clock_user_instance_init(Object *obj)
> +{
> +    ClockUser *s = CLOCK_USER(obj);
> +
> +    object_initialize(&s->in, sizeof(s->in), TYPE_CLOCK);
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->in, "clk_in");
> +    /*
> +     * Call on_rate_change_cb when something change on clk_in.
> +     */
> +    qemu_clk_set_callback(s->in, on_rate_change_cb, obj);
> +}
> +
> +The callback is in this case used as a notifier when the clock tree which
> +sources the device change:
> +
> +static uint64_t on_rate_change_cb(void *opaque, uint64_t input_rate)
> +{
> +    printf("the new rate is %ld\n", input_rate);
> +
> +    /* The return is ignored if nothing is bound to clk_in. */
> +    return input_rate;
> +}
> +
> +Modelling a clock multiplier
> +============================
> +
> +Here is a brief example of a device acting as a clock modifier:
> +
> +typedef struct {
> +    DeviceState parent_obj;
> +
> +    uint32_t rate;
> +    QEMUClock out;
> +    QEMUClock in;
> +} ClockMultiplier;
> +
> +As before the clocks must be initialized through the device initialize function
> +but they must be bound together so a change on the input will propagate on the
> +output:
> +
> +static void clock_multiplier_instance_init(Object *obj)
> +{
> +    ClockMultiplier *s = CLOCK_MULTIPLIER(obj);
> +
> +    object_initialize(&s->out, sizeof(s->out), TYPE_CLOCK);
> +    object_initialize(&s->in, sizeof(s->in), TYPE_CLOCK);
> +
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->in, "clk_in");
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->out, "clk_out");
> +    /*
> +     * Propagate the change from in to out, this can be done dynamically during
> +     * the simulation but we need to do the initial binding here to get the
> +     * initial refresh happening when the realize function is called on the
> +     * fixed clock.
> +     */
> +    qemu_clk_bind(s->in, s->out);
> +    /*
> +     * But before propagating the rate modify it with multiplier_cb.
> +     */
> +    qemu_clk_set_callback(s->out, multiplier_cb, obj);
> +}
> +
> +In this example when clk_in changes it will trigger a change on clk_out and this
> +callback can modify the rate of clk_out (the return value of this callback)
> +accordingly to clk_in rate (input_rate).
> +
> +static uint64_t multiplier_cb(void *opaque, uint64_t input_rate)
> +{
> +    return input_rate * 4;
> +}
> +
> +This device doesn't refresh the clock tree as it will be done by the clock tree
> +source.
> +
> +Modelling a clock selector
> +==========================
> +
> +Here is a brief example of a device acting as a device which alter the clock
> +topology such as a clock selector:
> +
> +typedef struct {
> +    DeviceState parent_obj;
> +
> +    QEMUClock out;
> +    QEMUClock in_a;
> +    QEMUClock in_b;
> +} ClockSelector;
> +
> +The clocks must be initialized through the device initialize function but they
> +must be bound together like they will be when the device is reset so a change on
> +the input during the realize of the fixed clock will propagate to the output:
> +
> +static void clock_selector_instance_init(Object *obj)
> +{
> +    ClockSelector *s = CLOCK_SELECTOR(obj);
> +
> +    object_initialize(&s->out, sizeof(s->out), TYPE_CLOCK);
> +    object_initialize(&s->in_a, sizeof(s->in_a), TYPE_CLOCK);
> +    object_initialize(&s->in_b, sizeof(s->in_b), TYPE_CLOCK);
> +
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->in_a, "clk_in_a");
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->in_b, "clk_in_b");
> +    qemu_clk_device_add_clock(DEVICE(obj), &s->out, "clk_out");
> +
> +    /* Assuming at the reset that the input_a is connected to output. */
> +    qemu_clk_bind(s->in_a, s->out);
> +}
> +
> +/* This is called for example by a register change or something like that */
> +void update_topology(ClockSelector *s)
> +{
> +    /* Unbind the old clock */
> +    qemu_clk_unbind(s->in_a, s->out);
> +    /* Bind the new one, the rate is automatically refreshed. */
> +    qemu_clk_bind(s->in_b, s->out);
> +}
> -- 
> 1.8.3.1
> 
> 
