Received: from eggs.gnu.org ([2001:4830:134:3::10]:59751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eu4Oa-0000DM-8n
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eu4OV-00088P-D8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:52:20 -0500
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com
	([104.47.33.58]:12945
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eu4OU-000889-Ug
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:52:15 -0500
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-27-brijesh.singh@amd.com>
	<20180308170524.GK4718@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9a4886a9-b84e-ac52-76f0-7abcb75fd835@amd.com>
Date: Thu, 8 Mar 2018 16:52:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180308170524.GK4718@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v12 26/28] qmp: add query-sev-capabilities
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>



On 3/8/18 11:05 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 08, 2018 at 06:48:59AM -0600, Brijesh Singh wrote:
>> The command can be used by libvirt to query the SEV capabilities.
>>
>> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  monitor.c             |  7 +++++++
>>  qapi/misc.json        | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  target/i386/monitor.c |  6 ++++++
>>  3 files changed, 55 insertions(+)
>>
>> diff --git a/monitor.c b/monitor.c
>> index d53ecc5ddab3..29ce695a80d5 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -985,6 +985,7 @@ static void qmp_unregister_commands_hack(void)
>>      qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
>>      qmp_unregister_command(&qmp_commands, "query-sev");
>>      qmp_unregister_command(&qmp_commands, "query-sev-launch-measure");
>> +    qmp_unregister_command(&qmp_commands, "query-sev-capabilities");
>>  #endif
>>  #ifndef TARGET_S390X
>>      qmp_unregister_command(&qmp_commands, "dump-skeys");
>> @@ -4117,6 +4118,12 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measur=
e(Error **errp)
>>      error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-launch-measure")=
;
>>      return NULL;
>>  }
>> +
>> +SevCapability *qmp_query_sev_capabilities(Error **errp)
>> +{
>> +    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-capabilities");
>> +    return NULL;
>> +}
>>  #endif
>> =20
>>  #ifndef TARGET_S390X
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index a39c43aa64b1..37c89663d8f4 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -3306,3 +3306,45 @@
>>  #
>>  ##
>>  { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureIn=
fo' }
>> +
>> +##
>> +# @SevCapability:
>> +#
>> +# The struct describes capability for a Secure Encrypted Virtualization
>> +# feature.
>> +#
>> +# @pdh:  Platform Diffie-Hellman key
>> +#
>> +# @cert-chain:  PDH certificate chain
> Are either of these base64 encoded ? If so nice to document that.

Yep, they are base64 encoded, I will update the doc.


>
>> +#
>> +# @cbitpos: C-bit location in page table entry
>> +#
>> +# @reduced-phys-bits: Number of physical Address bit reduction when SEV=
 is
>> +#                     enabled
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'SevCapability',
>> +  'data': { 'pdh': 'str',
>> +            'cert-chain': 'str',
>> +            'cbitpos': 'int',
>> +            'reduced-phys-bits': 'int'} }
> Regardless of answer to above Q,=20
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> Regards,
> Daniel
