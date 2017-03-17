Received: from eggs.gnu.org ([2001:4830:134:3::10]:33832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1coz6z-0006CG-Qe
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 17:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1coz6y-0007r7-K9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 17:08:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1coz6y-0007q4-DN
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 17:08:36 -0400
References: <1486947403-22548-1-git-send-email-juro.bystricky@intel.com>
	<20170314135605.GG4142@distanz.ch>
From: Marek Vasut <marex@denx.de>
Message-ID: <769ad321-898d-3421-98a7-36b1c64efbaa@denx.de>
Date: Fri, 17 Mar 2017 22:08:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170314135605.GG4142@distanz.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tobias Klauser <tklauser@distanz.ch>, Juro Bystricky <juro.bystricky@intel.com>
Cc: qemu-devel@nongnu.org, crwulff@gmail.com, jurobystricky@hotmail.com, fred.konrad@greensocs.com

On 03/14/2017 02:56 PM, Tobias Klauser wrote:
> On 2017-02-13 at 01:56:43 +0100, Juro Bystricky <juro.bystricky@intel.com> wrote:
>> Add the Altera JTAG UART model.
>>
>> Hardware emulation based on:
>> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
>> (Please see "Register Map" on page 65)
>>
>> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> 
> After instantiating an Altera UART in nios2_10m50_ghrd_init
> (hw/nios2/10m50_devboard.c) using the following:
> 
>     altera_juart_create(1, 0xf8001530, irq[7], 64);
> 
> and adjusting the use of VMSTATE_VBUFFER_UINT32() to omit the _start argument
> (see below), I was able to successfully boot Linux with console on Altera JTAG
> UART with "qemu-system-nios2 -M 10m50-ghrd" using this patch.
> 
> Feel free to add my
> 
> Tested-by: Tobias Klauser <tklauser@distanz.ch>
> 
>> diff --git a/hw/char/altera_juart.c b/hw/char/altera_juart.c
> [...]
>> +static const VMStateDescription vmstate_altera_juart = {
>> +    .name = "altera-juart" ,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(jdata, AlteraJUARTState),
>> +        VMSTATE_UINT32(jcontrol, AlteraJUARTState),
>> +        VMSTATE_VBUFFER_UINT32(rx_fifo, AlteraJUARTState, 1, NULL, 0, rx_fifo_size),
> 
> This should now be
> 
>         VMSTATE_VBUFFER_UINT32(rx_fifo, AlteraJUARTState, 1, NULL, rx_fifo_size),
> 
> due to commit 59046ec29ad4 ("migration: consolidate VMStateField.start")
> getting rid of the _start macro argument.
> 
Cool, thanks for checking. Can we get a V7 ?

-- 
Best regards,
Marek Vasut
