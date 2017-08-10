Received: from eggs.gnu.org ([2001:4830:134:3::10]:48676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dflHs-00077i-57
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dflHn-0000yt-Cn
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:06:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:4085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dflHn-0000wr-1d
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 07:05:55 -0400
References: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
	<20170810102649.GF12980@redhat.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <00cb01a4-5c27-fc69-d3ae-0653aa54b121@intel.com>
Date: Thu, 10 Aug 2017 19:02:57 +0800
MIME-Version: 1.0
In-Reply-To: <20170810102649.GF12980@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com

On 2017年08月10日 18:26, Daniel P. Berrange wrote:
> On Thu, Aug 10, 2017 at 06:08:07PM +0800, Lan Tianyu wrote:
>> Intel Xeon phi chip will support 352 logical threads. For HPC
>> usage case, it will create a huge VM with vcpus number as same as host
>> cpus. This patch is to increase max vcpu number to 352.
> 
> If we pick arbitray limits based on size of physical CPUs that happen
> to be shipping today, we'll continue the cat+mouse game forever trailing
> latest CPUs that vendors ship.
> 
> IMHO we should pick a higher number influenced by technical constraints
> of the q35 impl instead. eg can we go straight to something like 512 or
> 1024  ?

Sure. 512 should be enough and some arrays is defined according to max
vcpu number.

> 
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  hw/i386/pc_q35.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 169a214..5e93749 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -299,7 +299,7 @@ static void pc_q35_machine_options(MachineClass *m)
>>      m->default_display = "std";
>>      m->no_floppy = 1;
>>      m->has_dynamic_sysbus = true;
>> -    m->max_cpus = 288;
>> +    m->max_cpus = 352;
>>  }
> 
> You'll need to introduce machine type back compat support so that we
> avoid changing the 2.10 q35 machine type - only the 2.11 machine
> type should have the new limit.

How about the following change?

-static void pc_q35_2_10_machine_options(MachineClass *m)
+static void pc_q35_2_11_machine_options(MachineClass *m)
 {
      pc_q35_machine_options(m);
      m->alias = "q35";
+}
+
+static void pc_q35_2_10_machine_options(MachineClass *m)
+{
+    pc_q35_2_11_options(m);
+    m->alias = "q35";
+    m->max_cpus = 288;
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }



> 
> Regards,
> Daniel
> 


-- 
Best regards
Tianyu Lan
