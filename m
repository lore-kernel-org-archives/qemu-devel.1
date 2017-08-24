Received: from eggs.gnu.org ([2001:4830:134:3::10]:53662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkzuP-0002Ru-SB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkzuK-0002Ob-Tu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:43:25 -0400
Date: Thu, 24 Aug 2017 23:43:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170824025151.GA5379@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708242338140.96438@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
	<20170824025151.GA5379@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/15] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-15?Q?Fran=E7ois_Revol?= <revol@free.fr>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Thu, 24 Aug 2017, David Gibson wrote:
> On Wed, Aug 23, 2017 at 01:43:56PM +0200, Fran=E7ois Revol wrote:
>> Le 23/08/2017 =E0 13:12, BALATON Zoltan a =E9crit :
>>>> What's the connection with mips_malta?
>>>
>>> The board's firmware wants to see SPD EEPROMs of the connected memory
>>> while initialising the memory controller. This is why we need to
>>> implement SDRAM controller, I2C and SPD EEPROMs. MIPS malta board had
>>> already SPD EEPROM implementation so this is based on that. The comme=
nt
>>> just indicates where this code comes from.
>>
>> Indeed, and I copy-pasted from elsewhere for this.
>>
>>>>> +        fprintf(stderr, "qemu: Error registering flash memory.\n")=
;
>>>>
>>>> Use error_report() instead, please.
>>
>> I guess this didn't exist back when I started writing it...
>
> Probably not.
>
>>>>> +/* Create reset TLB entries for BookE, mapping only the flash
>>>>> memory.  */
>>>>> +static void mmubooke_create_initial_mapping_uboot(CPUPPCState *env=
)
>>>>> +{
>>>>> +    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
>>>>> +
>>>>> +    /* on reset the flash is mapped by a shadow TLB,
>>>>> +     * but since we don't implement them we need to use
>>>>> +     * the same values U-Boot will use to avoid a fault.
>>>>> +     */
>>>>
>>>> Usually the reset state of the MMU is handled in the cpu code rather
>>>> than the board code.  Is there a specific reason you need it in the
>>>> board code here?
>>>
>>> I'm not sure, probably lack of a better place. The ppc440_bamboo boar=
d
>>> this is based on has it the same way in the board code. Maybe this co=
uld
>>> be cleaned up when someone wants to QOMify the SoC models sometimes.
>>
>> Thing is, the code allows both booting with U-Boot and with a kernel
>> directly, and the MMU mapping differ in those cases.
>>
>> Maybe the CPU reset should use the U-Boot setup and the kernel boot
>> would just overwrite it?
>
> Yes.  Basically the CPU reset should do what real hardware does - and
> I'd expect u-boot to be written to work with that.  The kernel, on the
> other hand will expect whatever mappings come out of u-boot (or
> another bootloader).  Long term, I think you want to always use the
> hardware setup and actually run the guest firmware to set up the
> mappings the kernel expects.

Maybe we should emulate the nvram for that and then we could patch it to=20
have it boot the kernel with the parameters specified in the command line=
?=20
This would also be needed to avoid the warning from u-boot about bad=20
checksum and always going with the built in defaults and would also allow=
=20
users to store settings like on real hardware but it's not something that=
=20
looks high priority to me at the moment.

>  For early development where it's useful
> to be able to boot into a kernel without firmware, faking the right
> mappings in the board code is perfectly reasonable.

So for now I'd just go with this, because there's much more to clean up=20
and improve before this becomes and issue I think.
