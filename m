Received: from eggs.gnu.org ([2001:4830:134:3::10]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1Zl-0005Kr-Dm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1Zi-00051H-9S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:16:05 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34905
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV1Zi-00050s-25
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:16:02 -0400
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499803333-9052-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711201059.GA6020@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9feb9505-227e-0af3-1923-4ba6dd8a92cb@ilande.co.uk>
Date: Tue, 11 Jul 2017 21:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170711201059.GA6020@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv8 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 11/07/17 21:10, Eduardo Habkost wrote:

> On Tue, Jul 11, 2017 at 09:02:11PM +0100, Mark Cave-Ayland wrote:
>> This will enable the fw_cfg device to be placed anywhere within the QOM tree
>> regardless of its machine location.
>>
>> Note that we also add a comment to document the behaviour that we return NULL to
>> indicate failure where either no fw_cfg device or multiple fw_cfg devices are
>> found.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/nvram/fw_cfg.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 99bdbc2..8ef889a 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1017,7 +1017,12 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
>>  
>>  FWCfgState *fw_cfg_find(void)
>>  {
>> -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>> +    /* Returns FWCfgState if only one fw_cfg device type exists. If zero or
>> +       more than one fw_cfg device are found then NULL is returned as per the
>> +       object_resolve_path_type() documentation. This behaviour is correct as
>> +       it ensures that we detect both missing fw_cfg devices and multiple
>> +       fw_cfg devices which could result in unpredictable behaviour. */
>> +    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
>>  }
> 
> I believe a one-line "returns NULL unless there is exactly one
> fw_cfg device" (similar to the one at find_vmgenid_dev()) would
> suffice.  :)

I got the impression from the thread that Igor thought the semantics of
fw_cfg_find() weren't clear enough, so wanted to make sure a good
explanation was included in the patch.

I'll wait to see if there's any further feedback before a v9...


ATB,

Mark.
