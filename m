Received: from eggs.gnu.org ([2001:4830:134:3::10]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSSLK-0007zG-SR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSSLD-0004uP-KC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:14:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47394
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dSSLD-0004uD-CS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:14:27 -0400
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703114200.67a39ecb@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <01715c99-4055-8fc0-8920-05c6183ac5c2@ilande.co.uk>
Date: Tue, 4 Jul 2017 19:14:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170703114200.67a39ecb@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 3/6] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 03/07/17 10:42, Igor Mammedov wrote:
> On Thu, 29 Jun 2017 15:07:17 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
>> This will enable the fw_cfg device to be placed anywhere within the QOM tree
>> regardless of its machine location.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/nvram/fw_cfg.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 99bdbc2..0fe7404 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1017,7 +1017,7 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
>>  
>>  FWCfgState *fw_cfg_find(void)
>>  {
>> -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>> +    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
> I insist on using ambiguous argument
> 
> see why it's needed
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg460692.html

Yes I did take into account your previous comment about the ambiguous
argument, but with the fw_cfg_unattached_at_realize() check added in the
v7 patchset, it is actually impossible to realize more than one fw_cfg
device, and at realize time that device must have been linked as a child
device to a parent device.

Hence it should be impossible for the above situation where more than
one fw_cfg device can exist in the QOM tree to occur. Have I missed
something in the logic which would prevent this from happening?


ATB,

Mark.
