Received: from eggs.gnu.org ([2001:4830:134:3::10]:59805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eym4g-0004ve-P0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eym4b-0000sW-OP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:19:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58388
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eym4b-0000rq-Hy
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 18:19:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LMItg9106927
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 18:19:08 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2guybwhffp-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 18:19:08 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 16:19:07 -0600
References: <1521253498-6834-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1521253498-6834-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180321184259.GI3465@work-vm>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 18:19:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180321184259.GI3465@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <290246ea-0fab-9bde-183a-f8b0998efebc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5.2 for 2.13 3/4] docs: tpm: add VM
 save/restore example and troubleshooting guide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

On 03/21/2018 02:42 PM, Dr. David Alan Gilbert wrote:
> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>> Extend the docs related to TPM with specs related to VM save and
>> restore and a troubleshooting guide for TPM migration.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> This seems ok, so:
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> but comments below:
>
>> ---
>>   docs/specs/tpm.txt | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>
>> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
>> index d1d7157..c230c4c 100644
>> --- a/docs/specs/tpm.txt
>> +++ b/docs/specs/tpm.txt
>> @@ -200,3 +200,109 @@ crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
>>   PCR-00: 35 4E 3B CE 23 9F 38 59 ...
>>   ...
>>   PCR-23: 00 00 00 00 00 00 00 00 ...
>> +
>> +
>> +=== Migration with the TPM emulator ===
>> +
>> +The TPM emulator supports the following types of virtual machine migration:
>> +
>> +- VM save / restore (migration into a file)
>> +- Network migration
>> +- Snapshotting (migration into storage like QoW2 or QED)
>> +
>> +The following command sequences can be used to test VM save / restore.
>> +
>> +
>> +In a 1st terminal start an instance of a swtpm using the following command:
>> +
>> +mkdir /tmp/mytpm1
>> +swtpm socket --tpmstate dir=/tmp/mytpm1 \
>> +  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>> +  --log level=20 --tpm2
>> +
>> +In a 2nd terminal start the VM:
>> +
>> +qemu-system-x86_64 -display sdl -enable-kvm \
>> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>> +  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>> +  -tpmdev emulator,id=tpm0,chardev=chrtpm \
>> +  -device tpm-tis,tpmdev=tpm0 \
>> +  -monitor stdio \
>> +  test.img
>> +
>> +Verify that the attached TPM is working as expected using applications inside
>> +the VM.
>> +
>> +To store the state of the VM use the following command in the QEMU monitor in
>> +the 2nd terminal:
>> +
>> +(qemu) migrate "exec:cat > testvm.bin"
>> +(qemu) quit
>> +
>> +At this point a file called 'testvm.bin' should exists and the swtpm and QEMU
>> +processes should have ended.
>> +
>> +To test 'VM restore' you have to start the swtpm with the same parameters
>> +as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now be
>> +passed again on the command line.
>> +
>> +In the 1st terminal restart the swtpm with the same command line as before:
>> +
>> +swtpm socket --tpmstate dir=/tmp/mytpm1 \
>> +  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>> +  --log level=20 --tpm2
>> +
>> +In the 2nd terminal restore the state of the VM using the additonal
>> +'-incoming' option.
>> +
>> +qemu-system-x86_64 -display sdl -enable-kvm \
>> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>> +  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>> +  -tpmdev emulator,id=tpm0,chardev=chrtpm \
>> +  -device tpm-tis,tpmdev=tpm0 \
>> +  -incoming "exec:cat < testvm.bin" \
>> +  test.img
>> +
>> +
>> +Troubleshooting migration:
>> +
>> +There are several reasons why migration may fail. In case of problems,
>> +please ensure that the command lines adhere to the following rules and,
>> +if possible, that identical versions of QEMU and swtpm are used at all
>> +times.
>> +
>> +VM save and restore:
>> + - QEMU command line parameters should be identical apart from the
>> +   '-incoming' option on VM restore
>> + - swtpm command line parameters should be identical
>> +
>> +VM migration to 'localhost':
>> + - QEMU command line parameters should be identical apart from the
>> +   '-incoming' option on the destination side
>> + - swtpm command line parameters should point to two different
>> +   directories on the source and destination swtpm (--tpmstate dir=...)
>> +   (especially if different versions of libtpms were to be used on the
>> +   same machine).
>> +
>> +VM migration across the network:
>> + - QEMU command line parameters should be identical apart from the
>> +   '-incoming' option on the destination side
>> + - swtpm command line parameters should be identical
>> +
>> +VM Snapshotting:
>> + - QEMU command line parameters should be identical
> Well, they don't actually need to be identical; they just need to be
> identically configured as far as the state goes.  For example all the
> paths to storage can be completely different on the two QEMUs.

There is some leeway here in the parameters. For troubleshooting 
purposes it may be the easiest to keep parameters the same and then 
slowly adjust them to where one wants to have them. I don't want to go 
there , though.

>> + - swtpm command line parameters should be identical
>> +
>> +
>> +Besides that, migration failure reasons on the swtpm level may include
>> +the following:
>> +
>> + - the versions of the swtpm on the source and destination sides are
>> +   incompatible
>> +   - downgrading of TPM state may not be supported
>> +   - the source and destination libtpms were compiled with different
>> +     compile-time options and the destination side refuses to accept the
>> +     state
>> + - different migration keys are used on the source and destination side
>> +   and the destination side cannot decrypt the migrated state
>> +   (swtpm ... --migration-key ... )
> Are there particular error messages swtpm will produce in these cases
> to make it easy for people to tell which has happened?

There are some error messages that libtpms will write if for example the 
checksum of the state was incorrect:

Volatile state checksum error: 0x83

Generally, the error code will also propagate back to this part in QEMU 
and at least that error code will be display with the message indicating 
the type of blob that was not accepted:

"tpm-emulator: Setting the stateblob (type %d) failed with a TPM error 0x%x", type, tpm_result


The tpm_result may be one of several error codes that could occur, like 
a hash was tried to be set that the implementation does not support, 
which would result in error code 0x83 (TPM_RC_HASH), or an RSA scheme is 
used by the imported blob that is not supported, which would result in 
error code 0x84 (TPM_RC_VALUE). There are many more. The question is 
what would one do with the additional knowledge of the error code. Under 
normal circumstances these error conditions wouldn't be encountered, 
unless someone deliberately resumed a VM after having compiled libtpms 
with a 'non-standard' set of compile-time options...

    Stefan


>
> Dave
>
>> -- 
>> 2.5.5
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
