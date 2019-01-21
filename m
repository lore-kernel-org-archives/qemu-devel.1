Received: from eggs.gnu.org ([209.51.188.92]:39642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1glSsb-0001eH-J0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1glSge-0000gu-Kz
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:03:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:14015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1glSge-0000d7-7z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:03:56 -0500
References: <20190111153451.14304-1-tao3.xu@intel.com>
	<20190111153451.14304-5-tao3.xu@intel.com>
	<859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <1c57aaaf-4c12-fb6e-7d59-c113004dc3a8@intel.com>
Date: Mon, 21 Jan 2019 14:03:43 +0800
MIME-Version: 1.0
In-Reply-To: <859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 4/9] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net


On 1/15/2019 3:38 AM, Eric Blake wrote:
> On 1/11/19 9:34 AM, Tao Xu wrote:
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   numa.c          | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   qapi/misc.json  |  92 ++++++++++++++++++++++++++++++++++-
>>   qemu-options.hx |  28 ++++++++++-
>>   3 files changed, 241 insertions(+), 3 deletions(-)
>> +++ b/qapi/misc.json
>> @@ -2746,10 +2746,12 @@
>>   #
>>   # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>>   #
>> +# @hmat-lb: memory latency and bandwidth information (Since: 2.13)
> s/2.13/4.0/ (probably in multiple spots in your series) 
Hi Eric,

Thank you for your comments. The spell mistakes in patches 1/9 to 6/9
have been corrected in patch 7/9. Because patches 1/9 to 6/9 are jingqi's
initial V1 patchesand7/9 to 9/9 are the changes compared withV1.

About s/2.13/4.0/,do you mean ACPI HMAT will not be merged before QEMU
4.0?

In addition, do you have any other comments about these patches?
Thank you very much!

Tao
>> +##
>> +# @HmatLBMemoryHierarchy:
>> +#
>> +# The memory hierarchy in the System Locality Latency
>> +# and Bandwidth Information Structure of HMAT
>> +#
>> +# @memory: the structure represents the memory performance
>> +#
>> +# @last-level: last level memory of memory side cached memory
>> +#
>> +# @1st-level: first level memory of memory side cached memory
>> +#
>> +# @2nd-level: second level memory of memory side cached memory
>> +#
>> +# @3rd-level: third level memory of memory side cached memory
> Let's spell these first-level, second-level, third-level (rather than
> adding even more spots where we have enums with leading digits)
>
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum': 'HmatLBMemoryHierarchy',
>> +  'data': [ 'memory', 'last-level', '1st-level',
>> +            '2nd-level', '3rd-level' ] }
>> +
>> +##
>> +# @HmatLBDataType:
>> +#
>> +# Data type in the System Locality Latency
>> +# and Bandwidth Information Structure of HMAT
>> +#
>> +# @access-latency: access latency
>> +#
>> +# @read-latency: read latency
>> +#
>> +# @write-latency: write latency
>> +#
>> +# @access-bandwidth: access bandwitch
>> +#
> s/bandwitch/bandwidth/
>
>> +# @read-bandwidth: read bandwidth
>> +#
>> +# @write-bandwidth: write bandwidth
> All 6 of these should probably list their units.
>
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum': 'HmatLBDataType',
>> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
>> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
>> +
>> +##
>> +# @NumaHmatLBOptions:
>> +#
>> +# Set the system locality latency and bandwidth information
>> +# between Initiator and Target proximity Domains.
>> +#
>> +# @initiator: the Initiator Proximity Domain.
>> +#
>> +# @target: the Target Proximity Domain.
>> +#
>> +# @hierarchy: the Memory Hierarchy. Indicates the performance
>> +#             of memory or side cache.
>> +#
>> +# @data-type: presents the type of data, access/read/write
>> +#             latency or hit latency.
>> +#
>> +# @base-lat: the base unit for latency in nanoseconds.
>> +#
>> +# @base-bw: the base unit for bandwidth in megabytes per second(MB/s).
>> +#
>> +# @latency: the value of latency based on Base Unit from @initiator
>> +#           to @target proximity domain.
>> +#
>> +# @bandwidth: the value of bandwidth based on Base Unit between
>> +#             @initiator and @target proximity domain.
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'struct': 'NumaHmatLBOptions',
>> +  'data': {
>> +   'initiator': 'uint16',
>> +   'target': 'uint16',
>> +   'hierarchy': 'HmatLBMemoryHierarchy',
>> +   'data-type': 'HmatLBDataType',
>> +   '*base-lat': 'uint64',
>> +   '*base-bw': 'uint64',
>> +   '*latency': 'uint16',
>> +   '*bandwidth': 'uint16' }}
>> +
>>   ##
>>   # @HostMemPolicy:
>>   #
>
