Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff4PZ-0004fa-Et
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff4PY-0007ad-EM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:23:37 -0400
References: <1531415537-26037-1-git-send-email-thuth@redhat.com>
	<87zhyrgt6i.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a158267b-2d07-3830-3f77-222c4f01c598@redhat.com>
Date: Mon, 16 Jul 2018 16:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <87zhyrgt6i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm2836: Mark the bcm2836 / bcm2837
 devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 16.07.2018 16:18, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> These devices are currently causing some problems when a user is trying
>> to hot-plug or introspect them during runtime. Since these devices can
>> not be instantiated by the user at all (they need to be wired up in code
>> instead), we should mark them with user_creatable = false anyway, then we
>> avoid at least the crashes with the hot-plugging. The introspection problem
>> will be handled by a separate patch.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/arm/bcm2836.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>> index 6805a7d..45d9e40 100644
>> --- a/hw/arm/bcm2836.c
>> +++ b/hw/arm/bcm2836.c
>> @@ -185,6 +185,8 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
>>      bc->info = data;
>>      dc->realize = bcm2836_realize;
>>      dc->props = bcm2836_props;
>> +    /* Reason: Must be wired up in code (see raspi_init() function) */
>> +    dc->user_creatable = false;
>>  }
>>  
>>  static const TypeInfo bcm283x_type_info = {
> 
> A more common way to phrase this is
> 
>        /* Reason: needs to be wired-up by raspi_init() */
> 
> If you you expect other functions to wire this one up in the future,
> insert ", e.g." before "by".

$ grep -r Reason.*wire hw/
hw/acpi/piix4.c:     * Reason: part of PIIX4 southbridge, needs to be wired up,
hw/core/or-irq.c:    /* Reason: Needs to be wired up to work, e.g. see stm32f205_soc.c */
hw/core/register.c:    /* Reason: needs to be wired up to work */
hw/core/split-irq.c:    /* Reason: Needs to be wired up to work */
hw/dma/i8257.c:    /* Reason: needs to be wired up by isa_bus_dma() to work */
hw/i2c/smbus_ich9.c:     * Reason: part of ICH9 southbridge, needs to be wired up by
hw/ide/microdrive.c:    /* Reason: Needs to be wired-up in code, see dscm1xxxx_init() */
hw/intc/apic_common.c:     * Reason: APIC and CPU need to be wired up by
hw/intc/nios2_iic.c:    /* Reason: needs to be wired up, e.g. by nios2_10m50_ghrd_init() */
hw/isa/piix4.c:     * Reason: part of PIIX4 southbridge, needs to be wired up,
hw/isa/vt82c686.c:     * Reason: part of VIA VT82C686 southbridge, needs to be wired up,
hw/isa/lpc_ich9.c:     * Reason: part of ICH9 southbridge, needs to be wired up by
hw/pci-host/piix.c:     * Reason: part of PIIX3 southbridge, needs to be wired up by
hw/pci-host/piix.c:    /* Reason: needs to be wired up by pc_init1 */
hw/pci-host/q35.c:    /* Reason: needs to be wired up by pc_q35_init */
hw/timer/mc146818rtc.c:    /* Reason: needs to be wired up by rtc_init() */

... does not look very consistent to me.

But if Peter feels like it should be changed, too, please feel free
to modify the comment when picking up the patch (I won't resend it
again just because of this).

> I like consistency in such things, but it's matter of taste, thus:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

 Thanks,
  Thomas
