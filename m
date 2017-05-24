Received: from eggs.gnu.org ([2001:4830:134:3::10]:57793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDOx0-00046t-Au
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDOwx-0006eO-6g
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dDOwx-0006dQ-0G
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:35:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<87wp97hqi4.fsf@dusky.pond.sub.org>
	<4011bf08-8686-f2ae-474e-004aa603cc0e@amsat.org>
Date: Wed, 24 May 2017 07:35:04 +0200
In-Reply-To: <4011bf08-8686-f2ae-474e-004aa603cc0e@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	24 May 2017 01:43:04 -0300")
Message-ID: <87r2zeu8af.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] net/rocker: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jiri@resnulli.us, jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Markus,
>
> On 05/23/2017 06:27 AM, Markus Armbruster wrote:
> [...]
>> There's one more cleanup opportunity:
>>
> [...]
>>>      if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf,=
 size)) {
>>>          return NULL;
>>>      }
>>
>> None of the pci_dma_read() calls outside rocker check the return value.
>> Just as well, because it always returns 0.  Please clean this up in a
>> separate followup patch.
>
> It may be the correct way to do it but this sounds like we are missing
> something somewhere... pci_dma_read() calls pci_dma_rw() which always
> returns 0. Why not let it returns void? It is inlined and never used
> by address. Else we should document why returning 0 is correct, and
> what is the reason to not use a void prototype.
>
> pci_dma_rw() calls dma_memory_rw() which does return a boolean value,
> false on success (MEMTX_OK) and true on error
> (MEMTX_ERROR/DECODE_ERROR)

PCI question.  Michael, Marcel?
