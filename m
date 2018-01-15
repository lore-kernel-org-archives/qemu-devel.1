Received: from eggs.gnu.org ([2001:4830:134:3::10]:58965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb6Vp-0003yw-SX
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb6Vl-0002GK-N2
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:17:25 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:38463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb6Vl-0002GB-HP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:17:21 -0500
Received: by mail-it0-x22b.google.com with SMTP id w14so573072itc.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 07:17:21 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAFEAcA9zdxMBosPJOg25vUzg6sdsBORkMRwaVqyAGq6wHxE_Dg@mail.gmail.com>
References: <20180113050717.22969-1-f4bug@amsat.org>
	<CAFEAcA9YNOfZW6tY_OWZ+cyF1Gvc9-9Sq81WgdL_JRDUxcfAqw@mail.gmail.com>
	<70091140-1b3e-6000-0add-b4e980db295e@amsat.org>
	<CAFEAcA9zdxMBosPJOg25vUzg6sdsBORkMRwaVqyAGq6wHxE_Dg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 12:17:20 -0300
Message-ID: <CAAdtpL5xbZ3BQjb6Sm9HkeSiqpV-KfT-HDaohD5Xh2MF=Nw2ZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/14] SDHCI: housekeeping (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Jan 15, 2018 at 11:47 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 15 January 2018 at 14:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>> On 01/15/2018 10:51 AM, Peter Maydell wrote:
>>> On 13 January 2018 at 05:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>>> Since v6:
>>>> - addressed Peter reviews
>>>>   - do not use an unique Property[] for both sysbus/pci
>>>>     Peter didn't recommend me to use the qdev_property_add_static() AP=
I since
>>>>     it is only used by the ARM cpus and may be due for removal, howeve=
r I found
>>>>     it cleaner.
>>>
>>> Your cover letter says this but patches 3 and 14 in the v7 you sent
>>> to the list use qdev_property_add_static(). Did you send the wrong
>>> version of the code?
>>
>> The cover is not clear, I'll try to reword it:
>>
>> '''
>> Peter recommended me to NON use the qdev_property_add_static() API since
>> it is only used by the ARM cpus and may be due for removal.
>>
>> However I found using qdev_property_add_static() cleaner, and sent this
>> series with using the not recommended qdev_property_add_static().
>> '''
>
>> Is it possible to share properties without using qdev_property_add_stati=
c()?
>
> Not very neatly. There's the DEFINE_BLOCK_PROPERTIES approach that
> include/hw/block/block.h has.
>
> In this case there aren't very many properties involved so I would
> just leave them as two separate Property arrays.
>
> (The Arm cpu models are odd because they dynamically decide which
> properties they have based on the CPU model. That isn't the case here:
> these devices always have the same set of properties.)

Yes, both sysbus/pci devices share:

static Property sdhci_common_properties[] =3D {
    DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 2),

    /* Timeout clock frequency 1-63, 0 - not defined */
    DEFINE_PROP_UINT8("timeout-freq", SDHCIState, cap.timeout_clk_freq, 0),
    /* Timeout clock unit 0 - kHz, 1 - MHz */
    DEFINE_PROP_BOOL("freq-in-mhz", SDHCIState, cap.timeout_clk_in_mhz, tru=
e),
    /* Maximum base clock frequency for SD clock in MHz (range 10-63 MHz, 0=
) */
    DEFINE_PROP_UINT8("max-frequency", SDHCIState, cap.base_clk_freq_mhz, 0=
),

    /* Maximum host controller R/W buffers size
     * Possible values: 512, 1024, 2048 bytes */
    DEFINE_PROP_UINT16("max-block-length", SDHCIState, cap.max_blk_len, 512=
),
    /* DMA */
    DEFINE_PROP_BOOL("sdma", SDHCIState, cap.sdma, true),
    DEFINE_PROP_BOOL("adma1", SDHCIState, cap.adma1, false),
    DEFINE_PROP_BOOL("adma2", SDHCIState, cap.adma2, true),
    /* Suspend/resume support */
    DEFINE_PROP_BOOL("suspend", SDHCIState, cap.suspend, false),
    /* High speed support */
    DEFINE_PROP_BOOL("high-speed", SDHCIState, cap.high_speed, true),
    /* Voltage support 3.3/3.0/1.8V */
    DEFINE_PROP_BOOL("3v3", SDHCIState, cap.v33, true),
    DEFINE_PROP_BOOL("3v0", SDHCIState, cap.v30, false),
    DEFINE_PROP_BOOL("1v8", SDHCIState, cap.v18, false),
    DEFINE_PROP_UINT8("uhs", SDHCIState, cap.uhs_mode, UHS_NOT_SUPPORTED),

    DEFINE_PROP_BOOL("64bit", SDHCIState, cap.bus64, false),
    DEFINE_PROP_UINT8("slot-type", SDHCIState, cap.slot_type, 0),
    DEFINE_PROP_UINT8("bus-speed", SDHCIState, cap.sdr, 0),
    DEFINE_PROP_UINT8("driver-strength", SDHCIState, cap.strength, 0),

    DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
    DEFINE_PROP_END_OF_LIST(),
};

The only 2 properties specific to sysbus are:

static Property sdhci_sysbus_properties[] =3D {
    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_qui=
rk,
                     false),
    DEFINE_PROP_LINK("dma", SDHCIState, dma_mr,
                     TYPE_MEMORY_REGION, MemoryRegion *),
}

I guess I assumed the Property to be const (being compilation-time
allocated, ended with DEFINE_PROP_END_OF_LIST),
so I couldn't add more properties to it, but it seems each device has
his properties allocated at runtime, so I can use the same
sdhci_common_properties[] array and only use
qdev_property_add_static() for the 2 sysbus specific properties.

Does this sound alright to you?

Thanks,

Phil.
