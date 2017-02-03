Received: from eggs.gnu.org ([2001:4830:134:3::10]:43825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZa6B-0007jh-51
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZa67-00069g-Tz
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:24:07 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:64349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cZa67-000685-A9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:24:03 -0500
References: <1484134214-32640-1-git-send-email-gerg@uclinux.org>
	<0b4b09bc-30db-0ba0-1796-e7af18fd836b@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <45d98228-7ca7-dc43-50c3-e6110849e989@vivier.eu>
Date: Fri, 3 Feb 2017 10:23:52 +0100
MIME-Version: 1.0
In-Reply-To: <0b4b09bc-30db-0ba0-1796-e7af18fd836b@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2] hw/net: implement MIB counters in
 mcf_fec driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Ungerer <gerg@uclinux.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Le 03/02/2017 à 09:40, Laurent Vivier a écrit :
> Add cc: to Network devices odd fixer.
> 
> Le 11/01/2017 à 12:30, Greg Ungerer a écrit :
>> The FEC ethernet hardware module used on ColdFire SoC parts contains a
>> block of RAM used to maintain hardware counters. This block is accessible
>> via the usual FEC register address space. There is currently no support
>> for this in the QEMU mcf_fec driver.
>>
>> Add support for storing a MIB RAM block, and provide register level
>> access to it. Also implement a basic set of stats collection functions
>> to populate MIB data fields.
>>
>> This support tested running a Linux target and using the net-tools
>> "ethtool -S" option. As of linux-4.9 the kernels FEC driver makes
>> accesses to the MIB counters during its initialization (which it never
>> did before), and so this version of Linux will now fail with the QEMU
>> error:
>>
>>     qemu: hardware error: mcf_fec_read: Bad address 0x200
>>
>> This MIB counter support fixes this problem.
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>> ---
>>
>> v2: fixed formatting problems picked up by checkpatch
>>
>>  hw/net/mcf_fec.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 115 insertions(+)
>>
>> diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
>> index 4025eb3..c74804b 100644
>> --- a/hw/net/mcf_fec.c
>> +++ b/hw/net/mcf_fec.c
>> @@ -25,6 +25,7 @@ do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
>>  
>>  #define FEC_MAX_DESC 1024
>>  #define FEC_MAX_FRAME_SIZE 2032
>> +#define FEC_MIB_SIZE 64
>>  
>>  typedef struct {
>>      MemoryRegion *sysmem;
>> @@ -48,6 +49,7 @@ typedef struct {
>>      uint32_t erdsr;
>>      uint32_t etdsr;
>>      uint32_t emrbr;
>> +    uint32_t mib[FEC_MIB_SIZE];
>>  } mcf_fec_state;
>>  
>>  #define FEC_INT_HB   0x80000000
> ...
>>  static void mcf_fec_do_tx(mcf_fec_state *s)
>>  {
>>      uint32_t addr;
>> @@ -178,6 +262,7 @@ static void mcf_fec_do_tx(mcf_fec_state *s)
>>              /* Last buffer in frame.  */
>>              DPRINTF("Sending packet\n");
>>              qemu_send_packet(qemu_get_queue(s->nic), frame, frame_size);
>> +            mcf_fec_tx_stats(s, frame_size);
>>              ptr = frame;
>>              frame_size = 0;
>>              s->eir |= FEC_INT_TXF;
>> @@ -298,6 +383,7 @@ static uint64_t mcf_fec_read(void *opaque, hwaddr addr,
>>      case 0x180: return s->erdsr;
>>      case 0x184: return s->etdsr;
>>      case 0x188: return s->emrbr;
>> +    case 0x200 ... 0x2e0: return s->mib[(addr & 0x1ff) / 4];
> 
> As FEC_MIB_SIZE is 64 and 0x1ff / 4 is 127, you can have overflow here
> and below.

OK, this is limited by the "case 0x200 ... 0x2e0", so there is no problem.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Laurent
