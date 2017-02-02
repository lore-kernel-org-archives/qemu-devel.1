Received: from eggs.gnu.org ([2001:4830:134:3::10]:53046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5wL-0006Gl-VM
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5wI-0002iG-RI
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:11:57 -0500
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170201000817.GO14879@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce8c9cec-e6bc-c9f1-46ab-08d8e241b31f@redhat.com>
Date: Wed, 1 Feb 2017 17:11:46 -0800
MIME-Version: 1.0
In-Reply-To: <20170201000817.GO14879@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>



On 31/01/2017 16:08, David Gibson wrote:
> On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
>> When running with KVM on POWER, we register some CPU types during
>> the initialization function of the ppc64 KVM code (which unfortunately
>> also can not be done via a type_init() like it is done on x86). So to
>> be able to see these updates in the CPU help text, the code that calls
>> list_cpus() has to be run after configure_accelerator(). This move sho=
uld
>> be fine since the "cpu_model" variable is also never used before the c=
all
>> to configure_accelerator(), and thus there should not be any unwanted
>> side effects in the code before configure_accelerator() if the user
>> started QEMU with "-cpu ?" or "-cpu help".
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> This looks fine to me, but it's not within my area to apply.  Paolo,
> if you want to ack I'm happy to take it through my tree if that's
> convenient for you.
>=20
>> ---
>>  vl.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index 0b72b12..315c5c3 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
>>          qemu_set_hw_version(machine_class->hw_version);
>>      }
>> =20
>> -    if (cpu_model && is_help_option(cpu_model)) {
>> -        list_cpus(stdout, &fprintf, cpu_model);
>> -        exit(0);
>> -    }
>> -
>>      if (!trace_init_backends()) {
>>          exit(1);
>>      }
>> @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
>> =20
>>      configure_accelerator(current_machine);
>> =20
>> +    if (cpu_model && is_help_option(cpu_model)) {
>> +        list_cpus(stdout, &fprintf, cpu_model);
>> +        exit(0);
>> +    }
>> +
>>      if (qtest_chrdev) {
>>          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
>>      }
>=20

Eduardo is the one who did most of the accel and CPU definitions work.

Paolo
