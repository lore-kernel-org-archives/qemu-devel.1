Received: from eggs.gnu.org ([2001:4830:134:3::10]:48580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvnMy-0004xz-Tl
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvnMu-0003e8-O9
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvnMu-0003dS-Fx
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:01:12 -0400
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<575162409.892468.1489242676618.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <758969c5-2fbc-6bb9-33c2-89473e04cd80@redhat.com>
Date: Wed, 5 Apr 2017 18:01:07 +0200
MIME-Version: 1.0
In-Reply-To: <575162409.892468.1489242676618.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/21] WIP: dump: add kaslr support (for
 after 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Anderson <anderson@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com



On 11/03/2017 15:31, Dave Anderson wrote:
> ----- Original Message -----
>> Hi,
>>
>> Latest linux kernel enabled kaslr to randomize phys/virt memory
>> addresses. There has been some effort to support kexec/kdump so that
>> crash utility can still works in case crashed kernel has kaslr
>> enabled.
>>
>> This series aims to provide enough information in qemu dumps so that
>> crash utility can work with kaslr kernel too, with x86_64 guests (it
>> hasn't been tested on other archs, help welcome).
>>
>> Two pieces of informations are necessary: the phys_base (the physical
>> address where the kernel is loaded) and the kaslr offset. Other useful
>> informations for debugging are provided in Linux vmcoreinfo too.
>>
>> There has been discussions to provide those details in early boot,
>> with ACPI, fw_cfg, virtio-pstore etc, but none has reached a consensus
>> yet. A possiblity for now is to provide the information when qemu-ga
>> starts. This has the advantage of working with older guests and may
>> not be incompatible with future methods (in this case it could ignore
>> qga info for example). The drawback is that qemu will have to parse
>> the json stream. For now it stops processing it whem VMDUMP_INFO is
>> received. It would be wise to introduce a QMP welcome message, so that
>> qemu would stop immediately processing the stream if the agent doesn't
>> have the event. Another option is to create a seperate channel...
>> I welcome other ideas and discussion.
>>
>> crash upstream doesn't yet parse NUMBER(phys_base). You may pass it to
>> crash with --machdep phys_base=3D0x.. provided you snooped on qga.
>=20
> FYI: a patch to utilize NUMBER(phys_base) has been checked in upstream:
>=20
>   https://github.com/crash-utility/crash/commit/ed60e97e319a1cfc9e2779a=
a1baac305677393d8
>=20
>   Linux 4.10 commit 401721ecd1dcb0a428aa5d6832ee05ffbdbffbbe finally
>   exports the x86_64 "phys_base" value in the VMCOREINFO note, so
>   utilize it whenever it exists.
>   (anderson@redhat.com)

Marc-Andr=C3=A9, what is the plan here?  Do we still need it (maybe for W=
indows)?

Paolo
