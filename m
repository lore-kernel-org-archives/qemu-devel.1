Received: from eggs.gnu.org ([2001:4830:134:3::10]:54611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1vr-00071l-DS
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1vo-0005Fg-5V
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:27:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gR1vn-0005Ep-W6
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 16:27:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so16415595wmc.4
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 13:27:07 -0800 (PST)
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
Date: Sun, 25 Nov 2018 22:27:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181123181059.GN18284@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi Eduardo,

On 23/11/18 19:10, Eduardo Habkost wrote:
> Hi,
> 
> Sorry for not reviewing this series earlier.  I just stumbled
> upon this part of the code:
> 
> On Fri, Nov 23, 2018 at 10:17:14AM +0100, Luc Michel wrote:
>> This commit adds the cpu-cluster type. It aims at gathering CPUs from
>> the same cluster in a machine.
>>
>> For now it only has a `cluster-id` property.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> [...]
>> +static void cpu_cluster_init(Object *obj)
>> +{
>> +    static uint32_t cluster_id_auto_increment;
>> +    CPUClusterState *cluster = CPU_CLUSTER(obj);
>> +
>> +    cluster->cluster_id = cluster_id_auto_increment++;
> 
> I see that you implemented this after a suggestion from Philippe,
> but I'm worried about this kind of side-effect on object/device
> code.  I'm afraid this will bite us back in the future.  We were
> bitten by problems caused by automatic cpu_index assignment on
> CPU instance_init, and we took a while to fix that.

Oops, thanks for catching this. I'm not aware of the cpu_index past issue.

> 
> If you really want to do this and assign cluster_id
> automatically, please do it on realize, where it won't have
> unexpected side-effects after a simple `qom-list-properties` QMP
> command.

This looks clean enough to me.
Do you prefer we don't use static auto_increment at all?

> 
> I would also add a huge warning above the cluster_id field
> declaration, mentioning that the field is not supposed to be used
> for anything except debugging.  I think there's a large risk of
> people trying to reuse the field incorrectly, just like cpu_index
> was reused for multiple (conflicting) purposes in the past.
> 
> 
>> +}
>> +
>> +static Property cpu_cluster_properties[] = {
>> +    DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
>> +    DEFINE_PROP_END_OF_LIST()
>> +};
> [...]
> 
