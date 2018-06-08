Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRDZo-0007Dc-Gz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRDZl-0006LA-87
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:20:56 -0400
Date: Fri, 8 Jun 2018 11:20:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180608085618.GT3344@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806081112180.22949@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<7017cb3e0ed918bc3a9df823175d91a24692e2ef.1528291908.git.balaton@eik.bme.hu>
	<20180608085618.GT3344@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 2/8] ppc4xx_i2c: Move register state to
 private struct and remove unimplemented sdata and intr registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Fri, 8 Jun 2018, David Gibson wrote:
> On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> It's not clear to me why this is preferable to having the registers
> embedded in the state structure.  The latter is pretty standard
> practice for qemu.

Maybe it will be clearer after the next patch in the series. I needed a 
place to store the bitbang_i2c_interface for the directcntl way of 
accessing the i2c bus but I can't include bitbang_i2c.h from the public 
header because it's a local header. So I needed a local extension to the 
state struct. Once I have that then it's a good place to also store 
private registers which are now defined in the same file so I don't have 
to look up them in a different place. This seemed clearer to me and easier 
to work with. Maybe the spliting of the rewrite did not make this clear.

One thing I'm not sure about though:

>> ---
>>  hw/i2c/ppc4xx_i2c.c         | 75 +++++++++++++++++++++++++--------------------
>>  include/hw/i2c/ppc4xx_i2c.h | 19 ++----------
>>  2 files changed, 43 insertions(+), 51 deletions(-)
>>
>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>> index d1936db..a68b5f7 100644
>> --- a/hw/i2c/ppc4xx_i2c.c
>> +++ b/hw/i2c/ppc4xx_i2c.c
[...]
>> @@ -330,7 +335,9 @@ static const MemoryRegionOps ppc4xx_i2c_ops = {
>>  static void ppc4xx_i2c_init(Object *o)
>>  {
>>      PPC4xxI2CState *s = PPC4xx_I2C(o);
>> +    PPC4xxI2CRegs *r = g_malloc0(sizeof(PPC4xxI2CRegs));
>>
>> +    s->regs = r;
>>      memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
>>                            TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
>>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);

I allocate memory here but I'm not sure if it should be g_free'd somewhere 
and if so where? I was not able to detangle QOM object hierarchies and 
there seems to be no good docs available or I haven't found them. (PCI 
devices seem to have unrealize methods but this did not work for I2C 
objects.)
