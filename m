Received: from eggs.gnu.org ([2001:4830:134:3::10]:54707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eu20O-0005OC-N2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eu20K-0000bq-Mx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:19:12 -0500
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com
	([104.47.32.84]:23584
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eu20K-0000at-Bz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:19:08 -0500
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-29-brijesh.singh@amd.com>
	<20180308170824.GL4718@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e6db1aaa-83c7-ae5c-2311-bc247b301426@amd.com>
Date: Thu, 8 Mar 2018 14:18:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180308170824.GL4718@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v12 28/28] tests/qmp-test: blacklist sev
 specific qmp commands
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



On 3/8/18 11:08 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 08, 2018 at 06:49:01AM -0600, Brijesh Singh wrote:
>> Blacklist the following commands to fix the 'make check' failure.
>>
>> query-sev-launch-measure: it returns meaninful data only when we launch
>> SEV guest otherwise the command returns an error.
>>
>> query-sev: it return an error when SEV is not available on host (e.g non
>> X86 platform or KVM is disabled at the build time)
>>
>> query-sev-capabilities: it returns an error when SEV feature is not
>> available on host machine.
> We generally expect 'make check' to succeed on every single patch
> in a series, so that 'git bisect' doesn't break.
>
> So you should add each command to the blacklist in the same commit
> that introduced the failure in the first place.


Sure, I can quickly send the updated patch series to address your this
concern, but before spamming everyone's inbox I was wondering if I can
get some indication whether this series will make into 2.12 merge.

Paolo, Eduardo and Richard,

Most of the changes are in x86 directory hence any thought if you are
considering this series for 2.12 ? I have been testing the series with
and without SEV support and so far have not ran into any issue. if you
are not planning to pull this series in 2.12 then I will wait a bit
longer to get more feedback before sending the updates to address
Daniel's comment. thanks


=C2=A0
>> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  tests/qmp-test.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> index 22445d9ec258..7470c6b754bc 100644
>> --- a/tests/qmp-test.c
>> +++ b/tests/qmp-test.c
>> @@ -204,6 +204,11 @@ static bool query_is_blacklisted(const char *cmd)
>>          "query-gic-capabilities", /* arm */
>>          /* Success depends on target-specific build configuration: */
>>          "query-pci",              /* CONFIG_PCI */
>> +        /* Success depends on launching SEV guest */
>> +        "query-sev-launch-measure",
>> +        /* Success depends on Host or Hypervisor SEV support */
>> +        "query-sev",
>> +        "query-sev-capabilities",
>>          NULL
>>      };
>>      int i;
>> --=20
>> 2.14.3
>>
> Regards,
> Daniel
