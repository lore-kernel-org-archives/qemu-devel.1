Received: from eggs.gnu.org ([2001:4830:134:3::10]:38162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tklauser@sym2.noone.org>) id 1cnmvw-0004rR-Qe
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tklauser@sym2.noone.org>) id 1cnmvs-0000qb-OH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:56:16 -0400
Received: from sym2.noone.org ([178.63.92.236]:52594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tklauser@sym2.noone.org>)
	id 1cnmvs-0000pY-IJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:56:12 -0400
Date: Tue, 14 Mar 2017 14:56:05 +0100
From: Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20170314135605.GG4142@distanz.ch>
References: <1486947403-22548-1-git-send-email-juro.bystricky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486947403-22548-1-git-send-email-juro.bystricky@intel.com>
Subject: Re: [Qemu-devel] [PATCH v6] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: qemu-devel@nongnu.org, marex@denx.de, crwulff@gmail.com, jurobystricky@hotmail.com, fred.konrad@greensocs.com

On 2017-02-13 at 01:56:43 +0100, Juro Bystricky <juro.bystricky@intel.com> wrote:
> Add the Altera JTAG UART model.
> 
> Hardware emulation based on:
> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> (Please see "Register Map" on page 65)
> 
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>

After instantiating an Altera UART in nios2_10m50_ghrd_init
(hw/nios2/10m50_devboard.c) using the following:

    altera_juart_create(1, 0xf8001530, irq[7], 64);

and adjusting the use of VMSTATE_VBUFFER_UINT32() to omit the _start argument
(see below), I was able to successfully boot Linux with console on Altera JTAG
UART with "qemu-system-nios2 -M 10m50-ghrd" using this patch.

Feel free to add my

Tested-by: Tobias Klauser <tklauser@distanz.ch>

> diff --git a/hw/char/altera_juart.c b/hw/char/altera_juart.c
[...]
> +static const VMStateDescription vmstate_altera_juart = {
> +    .name = "altera-juart" ,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(jdata, AlteraJUARTState),
> +        VMSTATE_UINT32(jcontrol, AlteraJUARTState),
> +        VMSTATE_VBUFFER_UINT32(rx_fifo, AlteraJUARTState, 1, NULL, 0, rx_fifo_size),

This should now be

        VMSTATE_VBUFFER_UINT32(rx_fifo, AlteraJUARTState, 1, NULL, rx_fifo_size),

due to commit 59046ec29ad4 ("migration: consolidate VMStateField.start")
getting rid of the _start macro argument.
