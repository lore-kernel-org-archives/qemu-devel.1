Received: from eggs.gnu.org ([2001:4830:134:3::10]:47811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX7pq-0003IJ-23
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX7pl-00068T-K5
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:53:38 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eX7pl-00067T-DM
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:53:33 -0500
Received: by mail-wr0-f196.google.com with SMTP id w107so1857065wrb.9
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 07:53:33 -0800 (PST)
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
	<1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
	<cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
	<130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <671681eb-5d03-1797-4b0e-70b6e8b7b257@redhat.com>
Date: Thu, 4 Jan 2018 16:53:29 +0100
MIME-Version: 1.0
In-Reply-To: <130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>, "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 04/01/2018 09:35, Alexandre DERUMIER wrote:
>>> So you need: 
>>> 1.) intel / amd cpu microcode update 
>>> 2.) qemu update to pass the new MSR and CPU flags from the microcode update 
>>> 3.) host kernel update 
>>> 4.) guest kernel update 
> 
> are you sure we need to patch guest kernel if we are able to patch qemu ?

Patching the guest kernel is only required to protect the guest kernel
from guest usermode.

> If I understand, patching the host kernel, should avoid that a vm is reading memory of another vm.
> (the most critical)

Correct.

> patching the guest kernel, to avoid that a process from the vm have access to memory of another process of same vm.

Correct.

The QEMU updates are pretty boring, mostly taking care of new MSR and
CPUID flags (and adding new CPU models).

They are not needed to protect the guest from "Meltdown", only
"Spectre"---the former only needs a guest kernel update.  Also, to have
any effect, the guest kernels must also have "Spectre" patches which
aren't upstream yet for either KVM or the rest of Linux.  So the QEMU
patches are much less important than the kernel side.

>> https://access.redhat.com/solutions/3307851 
>> "Impacts of CVE-2017-5754, CVE-2017-5753, and CVE-2017-5715 to Red Hat Virtualization products" 

It mostly repeats the contents of the RHEL document
https://access.redhat.com/security/vulnerabilities/speculativeexecution,
with some information specific to RHV.

Thanks,

Paolo

> i don't have one but the content might be something like this: 
> https://www.suse.com/de-de/support/kb/doc/?id=7022512 
> 
> So you need: 
> 1.) intel / amd cpu microcode update 
> 2.) qemu update to pass the new MSR and CPU flags from the microcode update 
> 3.) host kernel update 
> 4.) guest kernel update 
> 
> The microcode update and the kernel update is publicly available but i'm 
> missing the qemu one. 
> 
> Greets, 
> Stefan 
> 
>> ----- Mail original ----- 
>> De: "aderumier" <aderumier@odiso.com> 
>> À: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>> Cc: "qemu-devel" <qemu-devel@nongnu.org> 
>> Envoyé: Jeudi 4 Janvier 2018 08:24:34 
>> Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches 
>>
>>>> Can anybody point me to the relevant qemu patches? 
>>
>> I don't have find them yet. 
>>
>> Do you known if a vm using kvm64 cpu model is protected or not ? 
>>
>> ----- Mail original ----- 
>> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>> À: "qemu-devel" <qemu-devel@nongnu.org> 
>> Envoyé: Jeudi 4 Janvier 2018 07:27:01 
>> Objet: [Qemu-devel] CVE-2017-5715: relevant qemu patches 
>>
>> Hello, 
>>
>> i've seen some vendors have updated qemu regarding meltdown / spectre. 
>>
>> f.e.: 
>>
>> CVE-2017-5715: QEMU was updated to allow passing through new MSR and 
>> CPUID flags from the host VM to the CPU, to allow enabling/disabling 
>> branch prediction features in the Intel CPU. (bsc#1068032) 
>>
>> Can anybody point me to the relevant qemu patches? 
>>
>> Thanks! 
>>
>> Greets, 
>> Stefan 
>>
> 
> 
