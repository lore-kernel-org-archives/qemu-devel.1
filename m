Received: from eggs.gnu.org ([209.51.188.92]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gOV-0007C7-NF
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2gOU-0004TF-Q1
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:08:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2gOU-0004RZ-GT
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 13:08:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so773735wrw.7
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 10:08:22 -0800 (PST)
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-17-philmd@redhat.com>
	<82e36613-3968-3459-4be7-f0e927faeb5c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <600d88c2-460a-3e59-f25b-f2ccac38ad6c@redhat.com>
Date: Sat, 9 Mar 2019 19:08:18 +0100
MIME-Version: 1.0
In-Reply-To: <82e36613-3968-3459-4be7-f0e927faeb5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/18] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Hi Eric,

On 3/8/19 3:16 AM, Eric Blake wrote:
> On 3/7/19 7:32 PM, Philippe Mathieu-Daudé wrote:
>> The Edk2Crypto object is used to hold configuration values specific
>> to EDK2.
>>
>> The edk2_add_host_crypto_policy() function loads crypto policies
>> from the host, and register them as fw_cfg named file items.
>> So far only the 'https' policy is supported.
>>
>> An usercase example is the 'HTTPS Boof' feature of OVMF [*].
> 
> s/An/A/ since "user" is a pronounced or hard 'u' (English is funny, but
> the rule of thumb is you add the consonant only before a soft u, and not
> a pronounced one; as in "give an umbrella to a unicorn")

I appreciate the correction, thanks :)

>>
>> Usage example:
>>
>>   $ qemu-system-x86_64 \
>>       -object edk2_crypto,id=https,\
> 
> Might as well use --object (both spellings work for qemu, but since
> --object is the only spelling for qemu-img/qemu-nbd, being consistent
> between the lot is useful).

$ git grep -- ' -object ' | wc -l
83

^ cover various subsystems:

$ git grep -l -- ' -object '
docs/amd-memory-encryption.txt
docs/can.txt
docs/memory-hotplug.txt
docs/nvdimm.txt
docs/pr-manager.rst
docs/pvrdma.txt
docs/replay.txt
hw/virtio/vhost-user.c
include/authz/listfile.h
include/authz/pamacct.h
include/authz/simple.h
include/crypto/secret.h
include/crypto/tlscredsanon.h
include/crypto/tlscredsx509.h
qapi/misc.json
qemu-doc.texi
qemu-options.hx
target/i386/sev_i386.h
tests/bios-tables-test.c
tests/qemu-iotests/127
tests/qemu-iotests/200
tests/vhost-user-test.c


$ git grep -- ' --object ' | wc -l
252

^ mostly for the block subsystem:

$ git grep -l -- ' --object '
block/vxhs.c
include/crypto/tlscredspsk.h
qemu-doc.texi
qemu-img.texi
qemu-io.c
qemu-nbd.c
qemu-nbd.texi
tests/qemu-iotests/049
tests/qemu-iotests/049.out
tests/qemu-iotests/087
tests/qemu-iotests/134
tests/qemu-iotests/149.out
tests/qemu-iotests/158
tests/qemu-iotests/178
tests/qemu-iotests/188
tests/qemu-iotests/189
tests/qemu-iotests/198
tests/qemu-iotests/233

I'll change, but I'm not sure what is the default we should enforce...

> 
>>               ciphers=/etc/crypto-policies/back-ends/openssl.config,\
>>               cacerts=/etc/pki/ca-trust/extracted/edk2/cacerts.bin
> 
> (I really should follow through on my threat to teach QemuOpts to ignore
> whitespace after ','; but for this commit message, it's obvious the
> indentation has to be stripped for the command line to be valid)
> 
>>
>> (On Fedora these files are provided by the ca-certificates and
>> crypto-policies packages).
>>
>> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
