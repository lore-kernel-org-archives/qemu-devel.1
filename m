Received: from eggs.gnu.org ([2001:4830:134:3::10]:46430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTEFh-0002gP-35
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTEFe-0004Jx-3U
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:51:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTEFd-0004Jq-TO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:51:38 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00FDE8553D
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 20:51:38 +0000 (UTC)
References: <20170112182446.9600-1-lersek@redhat.com>
	<20170112182446.9600-2-lersek@redhat.com>
	<20170113143433.282c9a81@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9de0640d-fc7f-eb52-9410-77494f29077e@redhat.com>
Date: Mon, 16 Jan 2017 21:51:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170113143433.282c9a81@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 wave 2 1/3] hw/isa/lpc_ich9: add SMI
 feature negotiation via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/13/17 14:34, Igor Mammedov wrote:
> On Thu, 12 Jan 2017 19:24:44 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
> [...]
>> +static void smi_features_ok_callback(void *opaque)
>> +{
>> +    ICH9LPCState *lpc = opaque;
>> +    uint64_t guest_features;
>> +
>> +    if (lpc->smi_features_ok) {
>> +        /* negotiation already complete, features locked */
>> +        return;
>> +    }
>> +
>> +    memcpy(&guest_features, lpc->smi_guest_features_le, sizeof guest_features);
>> +    le64_to_cpus(&guest_features);
>> +    if (guest_features & ~lpc->smi_host_features) {
>> +        /* guest requests invalid features, leave @features_ok at zero */
>> +        return;
>> +    }
>> +
>> +    /* valid feature subset requested, lock it down, report success */
>> +    lpc->smi_negotiated_features = guest_features;
>> +    lpc->smi_features_ok = 1;
>> +}
> [...]
> 
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(smi_guest_features_le, ICH9LPCState,
>> +                            sizeof(uint64_t)),
>> +        VMSTATE_UINT8(smi_features_ok, ICH9LPCState),
>> +        VMSTATE_UINT64(smi_negotiated_features, ICH9LPCState),
> 
> Couldn't smi_negotiated_features be derived from
> smi_guest_features_le on target side?

No, that's something we must expressly not do.

The "guest-features" file remains writeable (and back-readable) to the
guest after feature validation/lockdown (i.e., after selecting
"features-ok"), it just has no effect on QEMU.

And, if the guest rewrites "guest-features" between feature lockdown and
migration, that must have no effect on the target host either. Hence we
must carry forward the negotiated features originally computed on the
source host.

Thanks
Laszlo

> 
> 
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_ich9_lpc = {
>>      .name = "ICH9LPC",
>>      .version_id = 1,
>> @@ -683,6 +761,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
>>      },
>>      .subsections = (const VMStateDescription*[]) {
>>          &vmstate_ich9_rst_cnt,
>> +        &vmstate_ich9_smi_feat,
>>          NULL
>>      }
>>  };
> 
