Received: from eggs.gnu.org ([2001:4830:134:3::10]:34702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6CfY-0002wZ-Kz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6CfT-0002R0-OY
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:03:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:63877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d6CfT-0002QA-F0
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:03:23 -0400
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-6-git-send-email-amarnath.valluri@intel.com>
	<0e67268f-46a0-c0c9-4a3b-0957bc387871@redhat.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <8507b0b7-3f20-2d7c-d6a1-9130051b4498@intel.com>
Date: Thu, 4 May 2017 12:05:29 +0300
MIME-Version: 1.0
In-Reply-To: <0e67268f-46a0-c0c9-4a3b-0957bc387871@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com, stefanb@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>



On 05/02/2017 04:35 PM, Eric Blake wrote:
> On 05/02/2017 06:52 AM, Amarnath Valluri wrote:
>> TPM configuration options are backend implementation details and shall not be
>> part of base TPMBackend object, and these shall not be accessed directly outside
>> of the class, hence added a new interface method, get_tpm_options() to
>> TPMDriverOps., which shall be implemented by the derived classes to return
>> configured tpm options.
>>
>> A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_options() to
>> prepare TpmInfo.
>>
>> Made TPMPassthroughOptions type inherited from newly defined TPMOptions base type.
>> The TPMOptions base type is intentionally left empty and supposed to be
>> inherited by all backend implementations to define their tpm configuration
>> options.
>>
>> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>> ---
>> +++ b/qapi-schema.json
>> @@ -5137,6 +5137,16 @@
>>   { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
>>   
>>   ##
>> +# @TPMOptions:
>> +#
>> +# Base type for TPM options
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'TPMOptions',
>> +  'data': { } }
>> +
>> +##
>>   # @TPMPassthroughOptions:
>>   #
>>   # Information about the TPM passthrough type
>> @@ -5148,20 +5158,9 @@
>>   #
>>   # Since: 1.5
>>   ##
>> -{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
>> -                                             '*cancel-path' : 'str'} }
>> +{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
>> +  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
>>   
>> -##
>> -# @TpmTypeOptions:
>> -#
>> -# A union referencing different TPM backend types' configuration options
>> -#
>> -# @type: 'passthrough' The configuration options for the TPM passthrough type
>> -#
>> -# Since: 1.5
>> -##
>> -{ 'union': 'TpmTypeOptions',
>> -   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
> Getting rid of a simple union is nice.  However,
>
>>   
>>   ##
>>   # @TPMInfo:
>> @@ -5170,6 +5169,8 @@
>>   #
>>   # @id: The Id of the TPM
>>   #
>> +# @type: The TPM backend type
>> +#
>>   # @model: The TPM frontend model
>>   #
>>   # @options: The TPM (backend) type configuration options
>> @@ -5178,8 +5179,9 @@
>>   ##
>>   { 'struct': 'TPMInfo',
>>     'data': {'id': 'str',
>> +           'type': 'TpmType',
>>              'model': 'TpmModel',
>> -           'options': 'TpmTypeOptions' } }
>> +           'options': 'TPMOptions' } }
>>   
>>   ##
>>   # @query-tpm:
>> @@ -5196,13 +5198,12 @@
>>   # <- { "return":
>>   #      [
>>   #        { "model": "tpm-tis",
>> +#          "type": "passthrough",
>>   #          "options":
>> -#            { "type": "passthrough",
>> -#              "data":
>> -#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
>> -#                  "path": "/dev/tpm0"
>> -#                }
>> -#            },
>> +#          {
>> +#            "cancel-path": "/sys/class/misc/tpm0/device/cancel",
>> +#            "path": "/dev/tpm0"
>> +#          },
>>   #          "id": "tpm0"
> Doing it in a manner that is NOT backwards-compatible (as evidenced by
> your change to the output text) is NOT good.  It will break any existing
> client that was expecting to parse information in the old layout.
>
> I'm afraid you're going to have to fix this to not break QMP wire
> compatibility.
>
Ok, I will revert the changes touching TpmTypeOptions which breaks the 
existing clients, :(
