Received: from eggs.gnu.org ([2001:4830:134:3::10]:37605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gAzKq-0006yW-6M
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gAzKp-0004Oz-7V
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:26:40 -0400
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <09e1483c-298e-d41a-f9c9-4f186f530dcb@greensocs.com>
Date: Fri, 12 Oct 2018 17:26:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
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
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, alistair@alistair23.me, saipava@xilinx.com, mark.burton@greensocs.com, luc.michel@greensocs.com, konrad@adacore.com, edgar.iglesias@xilinx.com

Hi Peter,

Sorry to bother you with this, but you said some time ago you would
write something about reset.

On 10/2/18 4:24 PM, Damien Hedde wrote:
> There is also the problem of initialization which is very much like the
> migration. Currently, in the zynq example, clocks outputs are initialized in
> the clock controller device_reset. According to Peter, outputs should not be
> set in device_reset, so we need a better way.

To illustrate the problem, lets take an example with the zynq case in
the patchset. We have a 2-stage clock tree:

+--------+            +----------------+              +------+
| Machine|>>base_clk>>|Clock controller|>>uart_clock>>| UART |
+--------+            +----------------+              +------+

At the end of the tree, the uart uses the clock to setup the backend
baudrate. The problem is that we need the whole clock path initialized
before having the right final frequency.

I've had some thought about it and I see several solutions

1. Set clock outputs in device_reset. But It can trigger side effects in
yet-non-reseted devices.

2. Have some kind of global 2nd stage reset to do all the output
propagation.

3. Try to propagate init values at platform building when doing the
clock connection.

4. (1) and (2) mixed. Have a per device 2nd stage reset "clock_reset"
(or any better name) method called when device_reset has been called and
all clock inputs have been initialized (by other device "clock_reset").
At the end of reset phase everything should have been propagated.

(1) being not-an-option and also (2) I think.

(3) seems complicated at best due to the unknown clock connection order.
And I'm not sure clock connection is the right moment to do this. In the
general case, a clock init value can depend on on some user-set/config
properties which will be applied later on I suppose (But I don't have a
clue at which point this operation -- the "realize" thing -- cab be done
in the platform startup sequence)

Do you think (4) is sensible ? It means any device requiring clock input
value will need to implement this new method. Basically this
"clock_reset" is just a part of the actual device_reset being delayed.
Obviously if there is a clock loop, the method will never be called.

--
Damien
